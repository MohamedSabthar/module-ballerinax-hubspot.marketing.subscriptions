// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    final readonly & ApiKeysConfig? apiKeyConfig;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.hubapi.com") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        if config.auth is ApiKeysConfig {
            self.apiKeyConfig = (<ApiKeysConfig>config.auth).cloneReadOnly();
        } else {
            httpClientConfig.auth = <http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig>config.auth;
            self.apiKeyConfig = ();
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }

    resource isolated function get communication\-preferences/v4/definitions(map<string|string[]> headers = {}, *GetCommunicationPreferencesV4DefinitionsQueries queries) returns ActionResponseWithResultsSubscriptionDefinition|error {
        string resourcePath = string `/communication-preferences/v4/definitions`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.private\-app\-legacy;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    resource isolated function get communication\-preferences/v4/statuses/[string subscriberIdString](map<string|string[]> headers = {}, *GetCommunicationPreferencesV4StatusesSubscriberidstringQueries queries) returns ActionResponseWithResultsPublicStatus|error {
        string resourcePath = string `/communication-preferences/v4/statuses/${getEncodedUri(subscriberIdString)}`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.private\-app\-legacy;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    resource isolated function get communication\-preferences/v4/statuses/[string subscriberIdString]/unsubscribe\-all(map<string|string[]> headers = {}, *GetCommunicationPreferencesV4StatusesSubscriberidstringUnsubscribeAllQueries queries) returns ActionResponseWithResultsPublicWideStatus|error {
        string resourcePath = string `/communication-preferences/v4/statuses/${getEncodedUri(subscriberIdString)}/unsubscribe-all`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.private\-app\-legacy;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    resource isolated function post communication\-preferences/v4/statuses/[string subscriberIdString](PartialPublicStatusRequest payload, map<string|string[]> headers = {}) returns ActionResponseWithResultsPublicStatus|error {
        string resourcePath = string `/communication-preferences/v4/statuses/${getEncodedUri(subscriberIdString)}`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.private\-app\-legacy;
        }
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    resource isolated function post communication\-preferences/v4/statuses/[string subscriberIdString]/unsubscribe\-all(map<string|string[]> headers = {}, *PostCommunicationPreferencesV4StatusesSubscriberidstringUnsubscribeAllQueries queries) returns ActionResponseWithResultsPublicStatus|error {
        string resourcePath = string `/communication-preferences/v4/statuses/${getEncodedUri(subscriberIdString)}/unsubscribe-all`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.private\-app\-legacy;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    resource isolated function post communication\-preferences/v4/statuses/batch/read(BatchInputString payload, map<string|string[]> headers = {}, *PostCommunicationPreferencesV4StatusesBatchReadQueries queries) returns BatchResponsePublicStatusBulkResponse|BatchResponsePublicStatusBulkResponseWithErrors|error {
        string resourcePath = string `/communication-preferences/v4/statuses/batch/read`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.private\-app;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    resource isolated function post communication\-preferences/v4/statuses/batch/unsubscribe\-all(BatchInputString payload, map<string|string[]> headers = {}, *PostCommunicationPreferencesV4StatusesBatchUnsubscribeAllQueries queries) returns BatchResponsePublicBulkOptOutFromAllResponse|error {
        string resourcePath = string `/communication-preferences/v4/statuses/batch/unsubscribe-all`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.private\-app;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    resource isolated function post communication\-preferences/v4/statuses/batch/unsubscribe\-all/read(BatchInputString payload, map<string|string[]> headers = {}, *PostCommunicationPreferencesV4StatusesBatchUnsubscribeAllReadQueries queries) returns BatchResponsePublicWideStatusBulkResponse|BatchResponsePublicWideStatusBulkResponseWithErrors|error {
        string resourcePath = string `/communication-preferences/v4/statuses/batch/unsubscribe-all/read`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.private\-app;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    resource isolated function post communication\-preferences/v4/statuses/batch/write(BatchInputPublicStatusRequest payload, map<string|string[]> headers = {}) returns BatchResponsePublicStatus|error {
        string resourcePath = string `/communication-preferences/v4/statuses/batch/write`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.private\-app;
        }
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }
}
