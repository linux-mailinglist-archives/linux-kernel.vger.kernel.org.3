Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834E353F4C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 06:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiFGEAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 00:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiFGD74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:59:56 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2110.outbound.protection.outlook.com [40.107.215.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6018A320;
        Mon,  6 Jun 2022 20:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brlMuz9Qbh8+1JFAGdx9s+/yLNl0tsE9ZZwCmYDy1pdBA/IxJedblpHt8/+7mqeZdKeud25MWIVHZEhcBH88dPG7ne671V/fjc4zGukyspCvsvK4jyCvWyOOxo5rMMOuNYXzUAh5E7HmTarfaQBAPb8U+Q5dEOKXpND8t/oz/gsnzArPBeqgxX70Ai3B7Y6zc8rEhj658OdjliFPaIg0mFlduKsNcW50NLgSPAzM6cN6zHI7xBpshBw+c5LKutPeW8ZZ/1VVYyUFP6y3dkQBy6d+PlyJ9E9o9h25cR76D7RzTVGIy/UFHLXJZDTHz0SAEh1cjWL+ozeMK/LtZZwEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXs0VmkrIsbr/PMti3wuHRoGywBfwBnCRtMVh3GTNcs=;
 b=YB4ag9RADYtj9GSPXzhEzMwQnrdzP0km5VrY1VfZeLXVCNc0QR7Hs9Ymy1rvyBu/gjeQm3nYm0HXX5YZACfUyD7EE+/PUCzs50HSRj0Qj5bXalyTXVH9fRMCl0A5c845n33lc+KDTESQozWtw8Li6tqhuxJabGnJ1AMKlo0wwvf/LZj7vQ1ktjVO0H/xtzzaOaBEdEqSAsHhSYAWpLiOiAKK2mec+Dj3tVFLncuMBiyDxKv5u0x+/BgQq2NFKRURvzyEqpneqRgrnWnDYHUpLRWps6AuHlLKS9UFQaVu0tE0GmWMuqplAg+we0x4xIyGEb6hqG+7XyrszOK+D1yz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXs0VmkrIsbr/PMti3wuHRoGywBfwBnCRtMVh3GTNcs=;
 b=s1bq4ecgNJDpgQ1QAsjEYIVoVxoew6LR/WujOgfDoa1cFSd0GUEe9z5Z0W/bosRuXHt8IORLSUCTWza35IB80xbL1MtP9+ZD9NeNNS1OiY8AI3C4RmQ4bMMrAZaRSc2Q8CFVNVPUn6F2Bpx+YS6I3M8dtwbb9W84R601EAR0yVOi8MyX5rv3Jp4dZnEG07FlVpzN8vHbdLipLkJfZ4NLujV9Ax+x68+pIWWKhB9V8B3uGoWN8T6uSM/K0IcVYZQPWP9l7csZnbmNFC30zsUWRDSjvHglRSOWsMPXEG+FoL7YEq0a9kSuK+hKJDQTbuZLO2H+t8oB/IpLyfQphLgcOA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by KL1PR0601MB3800.apcprd06.prod.outlook.com (2603:1096:820:19::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Tue, 7 Jun
 2022 03:59:48 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 03:59:48 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 3/5] ARM: dts: aspeed: Add HACE device controller node
Thread-Topic: [PATCH v2 3/5] ARM: dts: aspeed: Add HACE device controller node
Thread-Index: AQHYeXGfdLTB4LTlU0CwQTnacz0tqq1DHlqAgAAzqQA=
Date:   Tue, 7 Jun 2022 03:59:48 +0000
Message-ID: <HK0PR06MB3202698F2E93BE1CF2C9626380A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-4-neal_liu@aspeedtech.com>
 <bba832ec-ea64-71db-385a-ab9816e7239c@linux.microsoft.com>
In-Reply-To: <bba832ec-ea64-71db-385a-ab9816e7239c@linux.microsoft.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d7ad8c2-01a2-48f3-c9d0-08da483a2a88
x-ms-traffictypediagnostic: KL1PR0601MB3800:EE_
x-microsoft-antispam-prvs: <KL1PR0601MB3800149A4AE0F9E37005AF3E80A59@KL1PR0601MB3800.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7YhKwSqPd8JCn0p76QGOqnmn6JhYZUYamCwyJeHrqh8TC2rbGWit8bOTQ84hR9C8/yRGcLiObFw6C2RqsCpHMDmWki2unoIDfPGpcNJafUTvFRp/ZzxCNN+wJcQ4+fUKXTwSQYgG/wpoLTfqSMEZum0Uc5sZYCvhJDpW4MnBHlBK8PZCBCRyF0Ua6GUzY5OosMitQoFWrkbGRgor2hXbmtrcy/VYfQtUzEwafAcrSpkOs6sfgRhPyU+uAA331T1mEAXW0W2G2wLvWBUnDczjB4Kpe4V4Vwgq/iH8xqEonmKLUwR4tPN5jtdvY+HrgLrfKFjobHA89Ce/j8juOogU9fpAMZez5ipVTbMSQ/CLeL5v74Sg98TRB5y0UWWl5TR+lR8N1oJXReYxo1Dpf6Zik3qxnRW5PnQic66TxXuLUF3tY/dNVuDMt+RTb6Gh3jkPJeTQ6WcGSTrFaBLzmNSErsoj+zPXudZd3n+5t/Hjh6uPBSJSZbXUa1KyVGQTqO/mPOOtksJEtwy5mnSNqW+eJ7cWWzxjc9OAFMow4J8pKPKaG0lZGo2ogj4SoHIzqzJy9KiW7RMn5HwaVBRPAo+Yxg9xOmylQGQtuq7CKFYsuVJUMZXvwOAupfH66JkS5r2AAWnMeGrD3j7gMvPYH6Y5SBMGZVQdND3qrD4n9oSt5N0clpIcLejH/jb9nV60ywBIpc0NXLisaM4m9OUKqqygw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4326008)(66446008)(7416002)(66946007)(66556008)(64756008)(76116006)(66476007)(508600001)(8676002)(4744005)(186003)(9686003)(53546011)(6506007)(2906002)(110136005)(54906003)(6636002)(55016003)(26005)(316002)(86362001)(52536014)(7696005)(83380400001)(71200400001)(38100700002)(33656002)(122000001)(8936002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2xFM00wS2F0NW1vaE5CQ2RUeXZBRWVLemtzT3hYcGpvMExEZ0c2RjRhbGpB?=
 =?utf-8?B?d0JoSy9iNEpEMHpxUXJRN3YyRitXczZFR2dyc0xtempiWW1EcVhUQjQ3bjZC?=
 =?utf-8?B?M3ZDNjhoRzk1L21SSy9xZjA1TzVDMW55VnFNckZGam0vd2RBUHVrdDZ5WjAw?=
 =?utf-8?B?Tlo1WGk1NTVHcy9ZUVBZY2Zxc1FYcS8rS3EyR0JuS0hZK1BQMStWZWo4Rmhi?=
 =?utf-8?B?MlZNVUhwYTAveWk1QTYwbG1XSXlYekhxZWhMQlJUWitubUJobkk2bGpWZmx5?=
 =?utf-8?B?RGV3UnYwYUxYWDFnN3hzay9ZZ1E0TDRFYmpORGVYM0ZqKzJFQ1RKeEJ3NjQw?=
 =?utf-8?B?N1NIVFlCU1U5eGtPN3NVdjc0dy85RzlwK2hjNzlXb3o4OXlWSWxCKzFvckNx?=
 =?utf-8?B?T3M0TGhYd3JuNC9KdVlnN2w3d28zNDNWb29zeVBhcndNeHRZNE9UaDlKUVhO?=
 =?utf-8?B?bFg0QzhIcWszQi8wUW0yd0d5Y0V0d2JTQVlsVnhOZ09MYlliY2ludE4vRDVD?=
 =?utf-8?B?NGJTL3JhTER3cTFxcjZaZ1J4T2EwZjFyaEFWRjVCdTFxQy9rUGdtTzAweHZs?=
 =?utf-8?B?a0l4WXNlckl4cXo5Uk5VQU16NUtVK0FUaThhWDV5WWJIY1RaQzQ3N05GMG1Y?=
 =?utf-8?B?eksyaENYbWNvZjZFWFFSeUMrZklRSDZtT1FKQjNZVFdWN1cxZEIyR0hUdEZ2?=
 =?utf-8?B?QkNuNThJTjVaL3A5UllsS0FqdWJ3dUxaUEZidmVlNXd4NDI2QitydVI4cnd0?=
 =?utf-8?B?WFladE9rL3FjT0VqaUtqV0JCR0xlUjhiUjNhbm1OYmxzUTRMSno2NkpTYlZD?=
 =?utf-8?B?ajVoT0o3bDFyV2VTczYwM2lWOWtBbVV3MjVGd3FXZHBWUXZsYkNsRm1YaVo2?=
 =?utf-8?B?SWowSU01MU0vYTdTdmNVQVV6NHZMK3BPZ1pZWldmT3lKb0lMMFhZTU9TZTBh?=
 =?utf-8?B?aDF4eitEQkFXanozeXVlS0c5eEFnZkdoVnBqdzloZkg1UFNHZG9tclJmeXBM?=
 =?utf-8?B?TndJK2ZEbzRRb1NOOENLZTJVS2pGUEhnVHhDTmlHRHNMbHNyWnNYZENjaTB4?=
 =?utf-8?B?dS8rRGlONytEYmpMWXpFOHNqblp4N1NqUk03WUNITFNQbGpFcHN2M0x1VWVy?=
 =?utf-8?B?R3dNdGQ4OFBLU1crVUJlTXZ1WVJhZGRnZDlPMVhpbzk1ZWN0UHNBZ0FhblFw?=
 =?utf-8?B?Und4V2lubkNxUjNKYTU3TVVuOFpab2llN0h4NS9GSHhzU0tvZUNaRUdWR3N3?=
 =?utf-8?B?UndSNTlvakNqOEIxRkxjYTlJcm5aM0Z5MStPTHBDMlU0TmFjOG9scFdETWI0?=
 =?utf-8?B?ci80ODBuQzRsS0pFOS9QektsemhvSXNlMUtRUVFBSCtybmVFQ0trcVJ6azlQ?=
 =?utf-8?B?NnZZL3N5c2RHcXdiZUw2d2NRdjVXV29iaDE2dFJzK3c1SkozbXZpK0g0Tjh4?=
 =?utf-8?B?TE45bi9IdEJ4Wi9jd2ppc2hNY2h2NXZ0bmlFSStsR09jd0Q2eG5xYkRjOUR4?=
 =?utf-8?B?MzRsOGJTMDdDNTQ1RTNpUmczU0Z1aU9RMG91NXgwVEFpR2dYQitCY1AvSUIy?=
 =?utf-8?B?S2ZRYURaajVmUEE5djkrN29YeTdpN2pvYnRLOG1CTDlQVW1QYmNoeGdnQTZJ?=
 =?utf-8?B?blJGRGJJdGJzTXlUTFJQc3QwbWZXTjZUeTUyL3NnMXk0NjN1TTUxb1BJTWNu?=
 =?utf-8?B?NXM1NkFWYzYwSFZORTMyd1FBQXZZZEthN24yYnB2VEhrN3VpM3NvRzlIME5v?=
 =?utf-8?B?cGtaaWNLcXFvb24wT3ZXSFk1eUJ0ZXhwR2R5dENKN1VZaUVSTWhhTDVscitY?=
 =?utf-8?B?MkRIdXg2MlhmUTVveWtkUW1ROHdpY2RKZU8vQm9mZzlqU0FhclplbGxDdmdK?=
 =?utf-8?B?Um5qWE1FeUMxbWR0LzlBeEYzcU9GbVVXRE5pd2ZIbmY1Z1kvcDFubHR4UnYw?=
 =?utf-8?B?Z0hod3pnS2k2Y0lUL2loZnUrUWswanE4WFp5cWNna1owSTZUcGJsZjN5ZTVF?=
 =?utf-8?B?cmNWYTNzaThCQ0hYWVRhV29aNElIdEx0ejNaaWNDZUcxMkdFZkVDRGRHSlND?=
 =?utf-8?B?WW53QUVvdHhBS09valAvRXRtVUZlYVRKWndxSzNWT0o3N1pwNVZoK0FYeGYx?=
 =?utf-8?B?OUZhL0luWHRyVUE5QlJJMTcvN1VHUmN6YzlqTUJpcGR2VXkyVlF3eXhJVzlo?=
 =?utf-8?B?VmFxdVYvTkdLU29Ma29LaC9Za0w5Mk0ySVhLQ2x0Si9SVlFuYnJiWVdIaDlF?=
 =?utf-8?B?TUJsV3RYZnRrN24zaHdGSGlXc05KTXRVVFpaZ2lXVlc1TVF4NjJNa0dXUklq?=
 =?utf-8?B?NG8zcktzNU5KRi9ISUNjZk53OC8vUVhYVHlJLzVDQW10UXlMaWhMZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7ad8c2-01a2-48f3-c9d0-08da483a2a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 03:59:48.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJ8LkhZjoHzqgL86pog76pdB7+F3EyRTchWFBh9+VWqTn7SaS2xOTk4d+Vqjvy/HhNgipl5CBcQqdCNi2OV6eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3800
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA2LzUvMjAyMiAxMTo0OSBQTSwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1nNi5kdHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0
cy9hc3BlZWQtZzYuZHRzaQ0KPiA+IGluZGV4IDNkNWNlOWRhNDJjMy4uMzcxZDJhNmI1NmVmIDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1nNi5kdHNpDQo+ID4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWc2LmR0c2kNCj4gPiBAQCAtMzA0LDYgKzMwNCwx
NCBAQCBhcGIgew0KPiA+ICAgCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gICAJCQlyYW5nZXM7
DQo+ID4NCj4gPiArCQkJaGFjZTogY3J5cHRvQDFlNmQwMDAwIHsNCj4gPiArCQkJCWNvbXBhdGli
bGUgPSAiYXNwZWVkLGFzdDI2MDAtaGFjZSI7DQo+ID4gKwkJCQlyZWcgPSA8MHgxZTZkMDAwMCAw
eDIwMD47DQo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNCBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCj4gPiArCQkJCWNsb2NrcyA9IDwmc3lzY29uIEFTUEVFRF9DTEtfR0FURV9ZQ0xLPjsN
Cj4gPiArCQkJCXJlc2V0cyA9IDwmc3lzY29uIEFTUEVFRF9SRVNFVF9IQUNFPjsNCj4gDQo+IFNo
b3VsZG4ndCB0aGUgbGVmdCBzaWRlIGJlIGFsc28gJ2NyeXB0bycsIHNlZSBleGlzdGluZyBjcnlw
dG8gbm9kZXMgaW4NCj4gYXJjaC9hcm02NC9kdHMgZm9yIGV4YW1wbGUuDQo+IA0KPiAJCQljcnlw
dG86IGNyeXB0b0AxZTZkMDAwMCB7DQo+IAkJCQkuLi4NCj4gDQo+IFJlZ2FyZHMsDQo+IERoYW5h
bmpheQ0KDQpJdCdzIGEgbmFtaW5nIHByZWZlcmVuY2UuICJoYWNlIiBpcyBvdXIgaGFzaCAmIGNy
eXB0byBoYXJkd2FyZSBlbmdpbmUgbmFtaW5nLg0KQW5kIHdlIGFsc28gaGF2ZSBvdGhlciBjcnlw
dG8gZW5naW5lcyB3aWxsIGJlIHVwc3RyZWFtIHNvb24uDQpTbyBJIHByZWZlciB0byBrZWVwIHRo
aXMgcGFydCwgaXMgdGhhdCBva2F5IGZvciB5b3U/DQoNClRoYW5rcw0KDQo=
