Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544ED530791
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiEWCOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiEWCOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:14:22 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2168.outbound.protection.outlook.com [40.92.62.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344A42AC61;
        Sun, 22 May 2022 19:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKU/jVGyXmQA0lDUjT0WlIvbQT/4b6eWOhnyYLhLpI5Khsrl/brpX3hR3sgbdzcjwNGL4+099PZiqiBWHVxPWkHvhkNii/cW7b+bAJDCfrXMtOsogsVyzR931h/6hrixYicHKh4UVpo04JvD2vFg1bNPPAZQsjqJGyyeTPm/NWVqRQatlNspOE2zaaWPnwDe1EzQE/NCY5pYu9ucKS7OPwiXk2Ms2831F+IQcQ4nhaAa7fy6s+ltFRtJGolEZAeDZeoyly84skFnnoclg4WaCPUmgtbQ3rpDlFGG42t0+1xNaV1GZd+b5AJkvBn08l8LbOus0zH86zUmIzJHrzvSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP7mCb2w17MKxGJBc78hpxPn/TYVcv5OKbEmkBKxVN8=;
 b=QxO7YeUP+Wboni9wlQ6wAVva2L/fYpjRSl5014uZX8SYQUwPX3SabOuAxKHIbV/kZTFWMyzpmKPbvdkQK4SEjiWl4PPhx07cO/hh785ugz6g6TsR8groCGnSol9GmgVaFOuOvrTJn26WixuvavrbfccdA97ss1MweK/SswRAjAfHCqAzN4PrNlCJFtCXKkqu+54549ypQTMZzrAXbTvmnBqnZSFF9ghGvcbqywPBko/PDVSvkIxdN7fFNO+YoVie8VTBUPQUj06djLQ8Vy8azI9Qes5MGWNN8/vwGZlKdkak+bjIh4mUO3v0YXSKmnXMjnuVKWvtkfYScwjpgG73qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP7mCb2w17MKxGJBc78hpxPn/TYVcv5OKbEmkBKxVN8=;
 b=DlHpZ9pPzcMstIflM+LdUf5Ui/f4Di0diOOnWWGRpaC0Z1r2R36iVrRBrZrZhSVZ10J2fH8X8Wlezl6hlNTuI1Fsv6AX4cR2L+tHI94f+gg//hIKstTDpcunSzidW7q6+A8OfSekopznEdAJmC/bKZghTvsPou8HwL3I+yAACRmuHznRDtZOOvlJjeoIH2xFINztEuXnIzsh8dqNy4Iqr/8rtx2RQkzPkose9eCFdrFWRgHz7y7IYCS44I43ulDOJmufqqRQ7F9usG9fzpfIs8XZBhozp8T+LzbnjE8StIYs6JD6SmhEYrD3kXeGQA2QBzglJJ+6VJBOqwXikGQGyw==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SY4P282MB2364.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:123::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Mon, 23 May
 2022 02:14:16 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 02:14:16 +0000
From:   =?gb2312?B?zLcg08DB1g==?= <yonglin.tan@outlook.com>
To:     =?gb2312?B?zLcg08DB1g==?= <yonglin.tan@outlook.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhi@lists.linux.dev" <mhi@lists.linux.dev>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBidXM6IG1oaTogaG9zdDogQWRkIHN1cHBvcnQg?=
 =?gb2312?Q?for_Quectel_EM120_FCCL.?=
Thread-Topic: [PATCH v2] bus: mhi: host: Add support for Quectel EM120 FCCL.
Thread-Index: AQHYaO+WFfW+clH/tU2JDoy2Ki03Sa0rw1EQ
Date:   Mon, 23 May 2022 02:14:15 +0000
Message-ID: <MEYP282MB23746F19B1CF42D811D43AFCFDD49@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [c8hVDmmoCMbkZ6UTIzjM9OQS+l7XUmH+]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2fe2cc5-782c-42dd-9cd8-08da3c61efd9
x-ms-exchange-slblob-mailprops: gjx25WM8ZNUBXGJUfoG4f0NDkprHm8XKs7dwC8mQC5Ncrafn2gGa/LzodaaDlH+smp061QXI2y2ifgE8Qw1NL8uBvstx4XJzVO5aLM9XJbom3uPJRI10+aVe+Htanus2cBkf0WEQ5F3xEpcuP6wMT/qd3JfNo26eB3nzKrK0KwEwO2T/oyttaj2ZbV6l/89Qd4aKcyKsdqoK0xoJotOJw2Oh87mTixrI14nrcsA5gvNQNar1bYnNMYmoY+9o/aEaVvbf3RCC64H73fot2WvRlulQRHk+iHuPKg5Uc1flmWgvOgsAienlxHu011zI2QhnhyumOQeypjjTl69qnFAE3WJTQ9mfPMrgbptocyV4BtVs0X1bZzX4+Bdw4geJZ91eMY3ZLme/qpX2U5YiWsfRO65Ql8aE6w4oISS9U9ZIFAApAqKm6BvNG7/AtbGZsGpLvVfYINIzstDVKifSHLyQzzrqGp5kw2E1gQNUxJJP+DQIQ+gXGdtrbcoVoisVIDjvhMNU4qrEWTb77fXOJXVbDVmdRYlloeinuOZV+vF2YCiol85j5p3twSxhgl+urdjRhNMG+S1gEOOwztFYDGZuDMnMeI9pHyVjwuay2fcSGvd6TjNsYF0WlC1SOFmZ94zQq5x7cc4DaEzlWeZ75pWT4gY8ABWppRG8VgoezPmRCTRAN6V7lUgxex3z70LyaPQ9GGbbHusxap0JNHHVgFUJjIYTItyOe6IleLo8HKuw7MA=
x-ms-traffictypediagnostic: SY4P282MB2364:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q23kHeUHwKTJkq6J5RsGFuNkSzsQZuA7MAfg3fMCYLVuBmD+tOkb8X0i1fIPLtWUXBxdPLDIghbv4UuDSyio/5keD5y4PF/8Nn06TS8TVAh6Zambm1Wc30nczdB0GpX1b/go+Qs/aVQ2lVMt3geKxdp3w8ey9sgHBtyorI8gp9ZmHlKVOCX46w2heNTkbFkkiid0Ltf2Yxdse+br6rLMN6681l9ugcDl1yWy524ITmdU0b8uoywbGRiKj4hRgj9veJmjTuYVeNNmBvFG+bQbZEjDxN/GQk5d6MeLz2DkmENdI0WnZpGWjyC2sPNnZ+oYrVQbpccxTRtHjfV394RuHA/ApA4Kq7xZzENiznvCad0zHTe8sHZ4Hg1lJVjFDvk84IE/HysiN50ecxRxnMXQXbN8I5yxdx0Eat0T3VAeix63U4R520tTIui73Sc6hoOTbJhT2UodQgclEqt0nz+/5a75KDX+GdnpFPMPm7CShijFPX3fXGLIAiWK7y6bLbnSZ3S0FV9FpSygsXxsgcvyFWYlcwQU5CNBBgQXbYIZ2rpuD9cHBmVJlBhFYT+hHkOqo3LB3gfynlH3UdAUujTkmw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZDJQSU8wVlVLeVdDZWNITkc5ODJlL2o5V0NxMUZkeVJNZDRjM2o4bWRadXIz?=
 =?gb2312?B?cTMxZzErbGttSnNEcFhVY2NhVWtDSGg5UTNFT21DVUh3L2cyZjJDWG1ob2VB?=
 =?gb2312?B?VVBPSmsxYjh3TUI1a3ZCdWhoYVhxUG5JOERXSkhKeGJ4TVpyTEV4VUgrTjdi?=
 =?gb2312?B?VStwOWgvMVVselpkSHFYWFRldFhiczdUMnh0VGdtN3JaZXVyekUrenAwd2h4?=
 =?gb2312?B?cXh1SHRmNHJOOE13RW1ldVh4UFYyRnRuYmVkM0dIL3g5SzBNeE9qQW1IdTht?=
 =?gb2312?B?anlCRTZ0UUx6UnhLT01RQ2o5eHB1NUcxVGh5cHorSDRyZmFkZFJWaW9ObkI0?=
 =?gb2312?B?WDA2cll4MEhuZVhqWkVsWjFkeFgwalZib0UyOXdNdFNBM09VajFpcVhjemRp?=
 =?gb2312?B?TEoreEZqT3FQbWo4a0NxdXRVNndiVnFpMVlSK1FRYmswY2M4ZFQxK0NYUUdw?=
 =?gb2312?B?WWhIclBSOU9JVHg5TXphL2JaNEV4SXFpRUtXRTd2RWs1ejBVaGkwNTNUVFVV?=
 =?gb2312?B?N3B2UTFNa1N2Tis4ZE90TUhLRzNVa2lCNTZrY3Z2VnBMMU9UVXoycUp0YlQ4?=
 =?gb2312?B?blJhaVJEV2lCby84MDROczJXOVRXdzJCc1NIWkJ5dmp0M2hJd0M1eU40bktZ?=
 =?gb2312?B?QzF4VDhmUEkwbVpOMkkrUzNCV0xHQ3BxQlo2VTF2THF4MXJIWHNDQXdpQ2JR?=
 =?gb2312?B?K0JONWtraVdrYkpKWkJoVUNqT0U0eERCWUNFaFVNbkpsVGd4R1ZNTnNjKzFF?=
 =?gb2312?B?QnhWTVJzZWNhbVVCMGFJWThJaThFTk5qSmRTSEVCT0RLZ2tRc2JVYUNGdjlx?=
 =?gb2312?B?RlNHVDFMS1pTSFlWMlZQZk5meFVBL2ltUTNpcmxXVGp0MmVpUFcwa3dUTWxu?=
 =?gb2312?B?eW1kS1FhSVo5QStOTmlYR1piS1NxQUhheWxkalpGeGpwTFpRYnZWVGFUMkxo?=
 =?gb2312?B?ZXBJOTdteFhsMitaRkt2R281ZUNZbXdyQndaYUh6Z082dFQ2M3owZmpZaFhL?=
 =?gb2312?B?eFc3c1p5dE44M3Jrb3dveWp4MFVxejRlc2xoYTJLcUdMVlBmaG1yK2xLN3l0?=
 =?gb2312?B?bWlCYkIwRzB2SWFXckJ3VU1vUU9lTVc2WVRyZCtKM09XTlV5aEZuVzZOTFdM?=
 =?gb2312?B?UU5NVi9hZGFFSUhjRW1WMTFOK1ZDa3FEWUh1NXUrUnRQYm1EZm9OTWRDZXBD?=
 =?gb2312?B?RCtoaGt0MnUxNXNYUDluMEVhejRGZjF1OVlibFFrSytURVZRdTBwRkt2YWZn?=
 =?gb2312?B?YzFmeGhmaG9CL1BCUUFTMDVOTFZtTy9LaURCendzL2wrTEprQmQwNGpVMHph?=
 =?gb2312?B?V2h3Tk5XUVZJNUxnZFUrb3ZSejhOZWtkaGZwSjlTUjdNcDU1bWh4VE5kalVw?=
 =?gb2312?B?MUtRWUllZmEvZmtBMEpJZlZNU2lyN2FUS210Y3BvQzlWQ1AxelFsQU4rcWkr?=
 =?gb2312?B?d1hSL2JEbFVuZGNXWlJMRnE0WExhUUgxcGFneDNPMk1OaFVZd3BhTWlxcHFH?=
 =?gb2312?B?eC9NY0dBZ2F3NmhnckdOSnBoczlBMWFtVGNBakpYc2NzQU1hY0dtUXNkMUZt?=
 =?gb2312?B?RkFmTEVHMkxTTGlVRmVTWDN0dVYwMkpzUS9SZGE3dlNwVm1yRklpcFI0VHNF?=
 =?gb2312?B?VWFzUWxPeW1VWVNoV1RJaVpKNGROWk9rNE9hMlJhZzVRck5IRE9QVTY5TFZz?=
 =?gb2312?B?L1hvZmFSdzVLWTdEcUhUMng2V29nbzFWenMvNG5qcUMrbC9LUHVnTVRhZU9l?=
 =?gb2312?B?ZGtDVEVrVThuNE9ucEdhZURzandlS29LQ1hqRHk4b2JWTWlTUGlNUWYrQS96?=
 =?gb2312?B?dnpOSjh2aDFxd01kTXA4SGxmbSs4SGt1UzkyWWVDZC91WDB3N1phVExqQ2Rp?=
 =?gb2312?B?TzZLa09lSUNTQnZZYWhoWEc2NkZ3UHVuOTFzL1l6RzY0aWZxVEhqWWZ6MEJP?=
 =?gb2312?Q?KLBHAQ65FL8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fe2cc5-782c-42dd-9cd8-08da3c61efd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 02:14:15.9231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFuaSwNCg0KRG8geW91IGhhdmUgYW55IGNvbmNlcm4gYWJvdXQgdGhpcyBwYXRjaD8gDQoN
Ci0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBZb25nbGluIFRhbiA8eW9uZ2xpbi50YW5Ab3V0
bG9vay5jb20+IA0Kt6LLzcqxvOQ6IDIwMjLE6jXUwjE2yNUgMTQ6MzgNCsrVvP7IyzogbWFuaUBr
ZXJuZWwub3JnOyBsb2ljLnBvdWxhaW5AbGluYXJvLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc7IHF1aWNfaGVtYW50a0BxdWljaW5jLmNvbQ0Ks63LzTogbGludXgtYXJtLW1zbUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1oaUBsaXN0cy5saW51
eC5kZXY7IFlvbmdsaW4gVGFuIDx5b25nbGluLnRhbkBvdXRsb29rLmNvbT4NCtb3zOI6IFtQQVRD
SCB2Ml0gYnVzOiBtaGk6IGhvc3Q6IEFkZCBzdXBwb3J0IGZvciBRdWVjdGVsIEVNMTIwIEZDQ0wu
DQoNClRoZSBwcm9kdWN0J3MgZW51bWVyYXRpb24gYWxpZ24gd2l0aCBwcmV2aW91cyANClF1ZWN0
ZWwgRU0xMjBSLUdMLCBzbyB0aGUgRU0xMjAgRkNDTCB3b3VsZCB1c2UgDQp0aGUgc2FtZSBjb25m
aWcgYXMgUXVlY3RlbCBFTTEyMFItR0wuIA0KDQpTaWduZWQtb2ZmLWJ5OiBZb25nbGluIFRhbiA8
eW9uZ2xpbi50YW5Ab3V0bG9vay5jb20+DQotLS0NCg0KVjI6DQpGaXhlZCB0aGUgZm9ybWF0IGVy
cm9ycyBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQoNCiBkcml2ZXJzL2J1cy9taGkvaG9zdC9w
Y2lfZ2VuZXJpYy5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMgYi9kcml2ZXJz
L2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jDQppbmRleCA4NDE2MjY3Li4wYTY0NjljIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYw0KKysrIGIvZHJpdmVy
cy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYw0KQEAgLTU1Nyw2ICs1NTcsOCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbWhpX3BjaV9pZF90YWJsZVtdID0gew0KIAkJLmRy
aXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX3F1ZWN0ZWxfZW0xeHhfaW5mbyB9LA0K
IAl7IFBDSV9ERVZJQ0UoMHgxZWFjLCAweDEwMDIpLCAvKiBFTTE2MFItR0wgKHNkeDI0KSAqLw0K
IAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX3F1ZWN0ZWxfZW0xeHhfaW5m
byB9LA0KKwl7IFBDSV9ERVZJQ0UoMHgxZWFjLCAweDIwMDEpLCAvKiBFTTEyMFItR0wgZm9yIEZD
Q0wgKHNkeDI0KSAqLw0KKwkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX3F1
ZWN0ZWxfZW0xeHhfaW5mbyB9LA0KIAkvKiBUOTlXMTc1IChzZHg1NSksIEJvdGggZm9yIGVTSU0g
YW5kIE5vbi1lU0lNICovDQogCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0ZPWENPTk4sIDB4
ZTBhYiksDQogCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfZm94Y29ubl9z
ZHg1NV9pbmZvIH0sDQotLSANCjIuNy40DQoNCg==
