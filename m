Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C453F41A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiFGCwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiFGCwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:52:15 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84319DD;
        Mon,  6 Jun 2022 19:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMcERooneKFYaawEEUL5hxcIRiB/bomtwrg73rGVVl74MGO2wPf7IRy4d3VY0gtNXkoWc1eFyRmd5jkpmhsmWW7xJNZPuWRn0X9puD/RncFF073IMpoSTUCbaObYxw/p1kM/8iqL3k4pfWTNZe61RYEucN2aY8QUgPaVTi9dP1TBKCWT1PzYBOBtWmqRHogRMQLpIZVmnVQSeby27Xs3Kny8CGVU3n6t6cIXys1JYYdC8/3x0d+uTLDp7ygVHhCXBihI0irhfDeVCtptZ11h5EUWs3P2L51Q7hgMMXRJc3n3n8FmZpPqt4gWmCFw4JsXtw879XJAUwG1LaQ6qIx8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8/NRvh0ePCE+QQxmV15JfoKpjjsQ0fxWV1ZY5Z9Q+M=;
 b=k4eMCtTBNP5fi6WeSm+dpdw3/FytjU2fn/P7QnPPjNuayCzF2frgpwGGOrNwgZC5tgYeSR2+23+MtTfqFFomnmzrn+8itNVWPR8D7NfyuYqzN0B6IjDKG6S4Wg8rbJmhHKiZYAeDoPTPjVZMdHIAISIJ7DnHOnk2jaQ96GetNTaEtCsZwB/rFKQCSnCP4EJpD6SngF87ISGQb0qrxQMr0hS1MqnrwKFM9tTtcVtdG9XjNivwovrar9y/yLZVakasgeIL8gvALnvE34nUbm5H9Tx+qI4VOeNOaPZ6uGYQAQHX6Pa1vnUfZFuOzSht08I94dJwmOTsDeAPwIc+yVgmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8/NRvh0ePCE+QQxmV15JfoKpjjsQ0fxWV1ZY5Z9Q+M=;
 b=OaC7ws0kekS64kv4WaxGUVxQohNZYVGt1HK0UEjFwnA6eQ1b//tHkJbFI59OC6b1ydAV+DWUfGaLNueIC8/FS+Ampc/BK5Da1S3j/M325jiWlr5c4TerTZsOadSItbcPvWOxPTpax2mUa9fdhldguil+cCaMqwL5z+BSX5cxBLe3LXiudLjQPcQAPmVuLoWbEJQQq+kkRKX6T7nk7/nbYP3eXW7KeY7v4k6qYY4mgQNzQJPChKYbnRU/7Owh3qn+BtTSbTQkeewz+UHoicGr6AXM9LQOLeADhxEtYTGOpi1y/24E0xG9jcX+Fwf5CJExdjA/FxmDe7OiQ1/YFOSJqA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SEZPR06MB5390.apcprd06.prod.outlook.com (2603:1096:101:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 02:52:05 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 02:52:05 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2 5/5] crypto: aspeed: add HACE crypto driver
Thread-Topic: [PATCH v2 5/5] crypto: aspeed: add HACE crypto driver
Thread-Index: AQHYeXGi826UrBf260G0Fpbrs6AL+K1CeGuAgADHZ/A=
Date:   Tue, 7 Jun 2022 02:52:04 +0000
Message-ID: <HK0PR06MB3202B0A8DEF448B14A070E6080A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-6-neal_liu@aspeedtech.com>
 <8f4176e7-87b0-1cf9-bcef-6a423d17fd6a@infradead.org>
In-Reply-To: <8f4176e7-87b0-1cf9-bcef-6a423d17fd6a@infradead.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4442a4a-b922-47c3-2fd3-08da4830b479
x-ms-traffictypediagnostic: SEZPR06MB5390:EE_
x-microsoft-antispam-prvs: <SEZPR06MB5390CB5C8B856A32CB5E68D980A59@SEZPR06MB5390.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQEo+sbnPINWUg2vZNMXck2U3ZGC2UJKzJbp3Rc2O8HgbIwlW8GzGr91Lbzku64DM+ttX/YPM7gnllfzshM1SfKqJ/ZteOZo4av8jw41byeKvRAhvdI5m/PaDhW//LTYEERz8K0KeR1uNI18biCPyIE+dNKMoKu0Ri2OK6unV7JAbevbv31YmPFEAOxzC0tSNmGcPXh0AGIDUEyi8dJbfmU+M1S1MUgtbF5k4UCmTs7YF326Shi8C1hexlz4cdYRilcDiaTj+fyREPHhJ2CaIgifizzwPsvMDZzAPD31IIjbC0K2V96LwFyYWEPYGgddkPjhzFKQa0cncBtyAfuyjMqK4Tb7LKGAsXrTzZSLA484W2DlvzdSRWkPZnBns4IHGtIgbs/RRP2HEpRkS9OrWEZHa4G3FDIkPOpy4fMhxpgrBUPQtXVChjJg41PnLkS50Qgh7RqJUAAGHaNU46WzDIDxULu4ASek47hJvverUSHY9+vXJJBDOYMnF45Db8wCt6ZgBraLbbUIrwWdOpY8z4huF29HlScr/zWUsjrzWre5ZHGAKuQDI/nqR6WheY0OrTs0oWPmqd2HJ/JX3HuA/4wb0irT3IROdvd6j7fAA859sFwMW0DTFPYVFVDhCpqYRtTSI7IYOTZbEmIEV4+7zTwBFaZHKYhzswDAv2r9W4/tP9UgYmAUqFZrQfh0BaBzRmsbtdvzTng6oQ0QazfR6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(7416002)(66476007)(66446008)(5660300002)(38100700002)(76116006)(508600001)(52536014)(86362001)(4744005)(122000001)(64756008)(66946007)(4326008)(107886003)(71200400001)(55016003)(38070700005)(66556008)(83380400001)(2906002)(53546011)(186003)(7696005)(6506007)(33656002)(26005)(9686003)(6636002)(54906003)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGFYNGZqWTEvNmlpeU5helJVZmVLRG9FTE9QOHBWdmIwSDhpME92eS9wKzZV?=
 =?utf-8?B?T0FyS3FMN1dlUjZXLzA4aTh1TkdBVmsrWFRicDVXd09rN3RVNENkN3Npcndk?=
 =?utf-8?B?Mkw4OTNHWW9HOEhHWEc0R0x4R1VwZGUwcm5sU0drVVp2N2krZnZmS2Z0RlFj?=
 =?utf-8?B?VDlqUFF0THE2ZXErNDNiL1R2cVM4bmdCeXIzOWxvcmpwMXFUTVllVUdGOEND?=
 =?utf-8?B?OS90VFpZY0RTRHo3eFA2RENXZmVoTEF6WTUzeUdiaWwyNlFxVEwzdWxwL2VV?=
 =?utf-8?B?ZnhNV2tLMWtvZktrK29JMmhzLzBrZXFKSjVtR3RWZm1HOHhDNlBvYURrQlhy?=
 =?utf-8?B?NDJGUEU5NEVsRGdJbUtLdUwyYituV3hrTVozendkWEhQSktPSmhyUGhUYThn?=
 =?utf-8?B?SjJoZW11S0VtS1VQNzU4KzJ5dWVJTnE5TDkvUkUzaU9pMG5ueU4xb3NTVGZQ?=
 =?utf-8?B?aTA0aDErUlY3VG5lODNrTDVFcXhsQk50U0EyUGdrRXVvTUMwN0hmWWpZNU1q?=
 =?utf-8?B?MURpMkJtcEU4VVVoK0VCVVFYNEdLSzNSWTdjcmdBUHg0aG5WSWl0SC9ZdENh?=
 =?utf-8?B?ZzYyMktLRUJ1N0dYOXJUWm41clMyOUQ5R0dOM2hNdU1pNkRndm5Ya3lOVnZG?=
 =?utf-8?B?QzB4WVFvMExySmtzVEViVFkrQ3dzVUNYRDdQMnk3RExLZDhaU0tmTkN3Mm9G?=
 =?utf-8?B?bFdLdklBRlJRazluM3hJVmJNNWtLZFlncnQ4azJsejZJQm9lMkxydjd0QzI2?=
 =?utf-8?B?bFQ1ekw0NVZGNWI4NmVYSUVaQ2t2cVdZekI3ZjlWQ3pKSUhpQUZzMkRUbmxQ?=
 =?utf-8?B?RFkxMThLT044V0M1bUZPQnJUV0VPei9DMzhROTVpL0NiRkxpdVloOWZ1Rkpx?=
 =?utf-8?B?aXAzSW1xWFFGWFhBUHE2cEQ5T0FFQ1NnaEUvbnJ3OU5RVm5Rbk90UTQ0cER5?=
 =?utf-8?B?WTZOM0Nvc21rTGNlVjcxMGlTVXVydDVMdkpYTUE4RWxtV2JabmJEaStHVWlX?=
 =?utf-8?B?UXliS2hqTGd4YUkrQjZ0TlZ2V3hkUWJ0cVZnRHoxc3lXZGtlMmkyZkdKWnBW?=
 =?utf-8?B?QjRMMGdnQzJQeENUdytIZ2Vud3lacGp4VldWeGYxMUdDQkRoUHR2dFoyVit0?=
 =?utf-8?B?Nkp4eVdGVHl5YktCQVNLQVRsV0RkTFRnaWVnODlLQ0sxWVgvWFRmOWRVWHlh?=
 =?utf-8?B?UHFRNFhNcWVrOXRTbWh5WTBiSmtUSlFyZ3lZUnkxZ2xNU1hibmNrcFpjMjNk?=
 =?utf-8?B?amhabkpyRlNGMFJpV0dHUG5uNGVIRWtaMTJCYXF0ZVJKZ0NWZ2RzR1A3c0hk?=
 =?utf-8?B?bkl3UGJRRmJhMmc0SlVBQVMrMWNUMUJUQ2NLaVhna3BwVEtEOFJObnJnQTBJ?=
 =?utf-8?B?MnJTQ1ZBK2V2R0hvMUJUdTR0UjVHMCtkd1JwT3hGZE9qWGhOMTlCUlNtRnRq?=
 =?utf-8?B?QkdLV1Y4N2JhYTR4S3phNlFkeDVlYXZ4SnZXamV4bVlWN0phK0hNK3UvdGZC?=
 =?utf-8?B?bVIvWHhTMVQvTjN0WTZ5YzVGbzZvcHdCN0VxRHJXL0NpVFprZzNMNUFLN3Jh?=
 =?utf-8?B?dDgxdjdKdjZldHU1MExORzhRb0s1WlNDU0xUemZzMzJsTDFYNVNCK1J6Y2ow?=
 =?utf-8?B?RW5OS1NGMEZoakVHZmg1VjE2NkRUVDl6Wnc3dGJydjRNMXI1RnFtOFlKQ3BP?=
 =?utf-8?B?am1ERS96YWs2b3AxTHlnTzJ3c0dSNi9WQytMN2dnd20vaFJnOGlEZ0JFWFg1?=
 =?utf-8?B?NTBXSXhxcGJobkhNUWxRRWpGOWdweTBKR0VScHNJYm1tdHEwb0k1SW1SMzc4?=
 =?utf-8?B?K1BhSkgrS04yNGltZEx0SHYwVytWUnQ5em5BSkg4cit1Yy9vMVZnQzVqVmhQ?=
 =?utf-8?B?eVRiYVUyQlliZGdwYVlBQjZiYU5oWXpvZ1BRT2E0RCtPQXdEVmswY21BNUFX?=
 =?utf-8?B?d1YyaE1IU1JGdDVrREVKeXMwNlBBeFJRNXpTRjBnMW9YaHprdlcwZVZTZ2xq?=
 =?utf-8?B?RnloZ1lmdGR5U05sZEdPM0xJdXpGTXVITzlraHI0ZGVTcFN1MjhNaUNCUytl?=
 =?utf-8?B?d3poWmZCZDA0NHJsRWsvUXRuSWswTUdBNHJjeWVMc2w3YUFZVzVQSnJjYzRx?=
 =?utf-8?B?S21tMFZ0a3FYN0w1NmRoVkF0Ym5pS3FHVVIyandhUk1EdlpSNzQ2M2IvcHJz?=
 =?utf-8?B?dVJLdFk0Q3hKU1h4bzJaaHRmWGs5aWplTGNuWTRRcUc4US8rWXhUTkVaaFVS?=
 =?utf-8?B?MklTVmZ1SHdrNmNSUUliM3JJNU5oTDJpSTZwb1ZVSEthTE4rZDhOV2dweEIr?=
 =?utf-8?B?TS8yVEphUUk4NzBrNEw5WWRQMUJBWVRtZ0M2cERzcGJGakpSUm4vUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4442a4a-b922-47c3-2fd3-08da4830b479
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 02:52:04.9505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBB3IOVGxMibIDmUVtH8Lhv+QDFQ7yh73eH2nH233v7LcO8inRX4QZ4KgNtKiOaVRlGyFZGyFp1onusi413cAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaS0tDQo+IA0KPiBPbiA2LzUvMjIgMjM6NDksIE5lYWwgTGl1IHdyb3RlOg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2NyeXB0by9hc3BlZWQvS2NvbmZpZw0KPiA+IGIvZHJpdmVycy9jcnlw
dG8vYXNwZWVkL0tjb25maWcgaW5kZXggMTdiODAwMjg2YTUxLi41ZTRkMTgyODhiZjENCj4gPiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9hc3BlZWQvS2NvbmZpZw0KPiA+ICsrKyBi
L2RyaXZlcnMvY3J5cHRvL2FzcGVlZC9LY29uZmlnDQo+ID4gQEAgLTIwLDMgKzIwLDE5IEBAIGNv
bmZpZyBDUllQVE9fREVWX0FTUEVFRF9IQUNFX0hBU0gNCj4gPiAgCSAgaGFzaCBkcml2ZXIuDQo+
ID4gIAkgIFN1cHBvcnRzIG11bHRpcGxlIG1lc3NhZ2UgZGlnZXN0IHN0YW5kYXJkcywgaW5jbHVk
aW5nDQo+ID4gIAkgIFNIQS0xLCBTSEEtMjI0LCBTSEEtMjU2LCBTSEEtMzg0LCBTSEEtNTEyLCBh
bmQgc28gb24uDQo+ID4gKw0KPiA+ICtjb25maWcgQ1JZUFRPX0RFVl9BU1BFRURfSEFDRV9DUllQ
VE8NCj4gPiArICAgICAgICBib29sICJFbmFibGUgQVNQRUVEIEhhc2ggJiBDcnlwdG8gRW5naW5l
IChIQUNFKSBjcnlwdG8iDQo+ID4gKyAgICAgICAgZGVwZW5kcyBvbiBDUllQVE9fREVWX0FTUEVF
RA0KPiANCj4gVGhlIDIgbGluZXMgYWJvdmUgc2hvdWxkIGJlIGluZGVudGVkIHdpdGggb25lIHRh
YiBpbnN0ZWFkIG9mIG11bHRpcGxlIHNwYWNlcy4NCg0KVGhhbmtzIGZvciB0aGUgbm90aWNlLiBJ
J2xsIHJldmlzZSBpdCBpbiBuZXh0IHBhdGNoLg0KDQo=
