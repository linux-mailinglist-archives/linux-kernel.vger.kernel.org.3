Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC54911FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiAQWzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:55:46 -0500
Received: from mail-eopbgr660042.outbound.protection.outlook.com ([40.107.66.42]:27374
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229842AbiAQWzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:55:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGUC4SjO7roeK+uKhE9SiVH/nImnE/GQPDE2SspIFhwzWwnWNS0voTeuZecCUaXVCr5HYoZ8rrixKeIfKv6XjgLJUUMj1dS8PmYibWeCuOMKN/aVIt4dSQld7vFOmBnuo67OXuvjccYdFXOEK+7PpP0YdapasdmdrZkBbnAaTT0CIOHiUJ06RBtU3Sb4waxdYy2w9i+2hLRJOTpd8NW/3eOjKm8OJTz8Uwb0trVTkL0epknLMxwy7o4v7IDi6Jrfg2/N9f4OHpYRE/mWhT+nWLKj9SkeJlY18M+j+plILHvlcsFpvhXGpejK0dEbrpwVqPTac1m0VrZO8pkq36hDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTSbVGN6EhsnZ3DqV9USt4bmIfNDeEQ03Z+DLnZMeek=;
 b=j5LaJhT0lcopRpCUhDGwbIH7KcnlSLUu4pa5WTv9S2optap8aojEbQ1aYz1k0hUrbU/bVWkTseOG+oa8KBO05rp0RfNabAt8dFGoyh066miwDL6a3PYvJZGR2ZFhOVx+tXAIc1xfnhDejZsPEupMBt4hndI0MJ4okSuTlPX5e9N8w7tmQLsjLxtz9LWPYQCZDKAX8ScS24wXr3RjHpFi7QJk2TTk+H2TGHXNCr7antzwrbyTTjpSldbi3GEmVTpEzc58PMPMacx+YS6mRJpuih1OS2kOnThpSY0VKkJM/8ZKtiVFVO/GxldWgiEgFXVslhI8EyGO60Di0pFInN3mQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTSbVGN6EhsnZ3DqV9USt4bmIfNDeEQ03Z+DLnZMeek=;
 b=L+8At+ptIaQm5yJjg6ERPMlMkok1h+ptUE/lhxBPRLOJ1HM6PAyDYWufQgPCwUoPDeB0Ir8eTju8tdNSHHryS4mrQNMnyxscf8Q/p7klgRoFn1zS4c78z0eVeSoYZXPy98E8/l/y/DaO6fF45V+xsq1vWFrgQag0K/rGsX3sD+8=
Received: from YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2e::20)
 by YTBPR01MB3120.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 22:55:42 +0000
Received: from YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c1af:9bb:87bc:c1d5]) by YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c1af:9bb:87bc:c1d5%9]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 22:55:42 +0000
From:   Hugo Villeneuve <hvilleneuve@dimonoff.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "hugo@hugovil.com" <hugo@hugovil.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rtc: lp8788: Fix typo in comment
Thread-Topic: [PATCH 1/3] rtc: lp8788: Fix typo in comment
Thread-Index: AQHYC/P50Y/38qn4Zk6NN34nMXKKXaxn0swA
Date:   Mon, 17 Jan 2022 22:55:42 +0000
Message-ID: <60129428c0011b76bc915f89c027ae3925e40bce.camel@dimonoff.com>
References: <20220117224503.1250525-1-hugo@hugovil.com>
In-Reply-To: <20220117224503.1250525-1-hugo@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97667447-c85a-445d-bc21-08d9da0c7d7a
x-ms-traffictypediagnostic: YTBPR01MB3120:EE_
x-microsoft-antispam-prvs: <YTBPR01MB3120116FD4670F1975F8ACF8C4579@YTBPR01MB3120.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhh7u76va39MVl4FzzZm++gc4DRyvR+zz4augqcmI9UvekNcMW1FqKTcXPGdhGMBQLuKMpunsuBaY0NvBXlc8dkahKEUiruSy1t4LwVenTv0dSQRc+5VDR5LUhPpY3knF8rJfxRT6VZVCiX96+JczScx6tfYRyN6ltxGBWEMOiI3PyHAoJOVpyZvOtFxZ2fnaN/qPwIu6EeR68uo2FNWaDYx7nO4dsjz+Yx+lVH1MhKSYBQ8DcjaWS4+DpVvR7aDc2rbs97q1FldvuVxKIKyN5MwdONrasX3ENhlHHqRkHopxYi0Cul7ZsEp1V6apc3/VSnq/aWS+fgZHO0I0w1x7PeE7iKyHYnpdBj2cO65DuUKadTs88WZt7RrI2F4MGC88ksf6tOmFVCYipR3IBAIHpCbU5ZTP+AiryIJDkIsN6RoWh+C7W2t0Q0WfkuSC+0epE2VsfaVvnRXlTYVLxaxuQGdlf9hlA3SaYoKWQMprtIEWGE8snVA9bluqPZFWVJlIpMUUTYvzWzq5STlwg3Soo79EHAknXd2L/FcOaZ2nhTrCWg7mMRrNgMpO+SklV1PnoOr/hC9lB7ivh8Nn/C/eqHr5/JEovVQKMDMPUd1MFotRuBq4nQBBcKOCPu6qiw3qDCl7ErNG/hxN/1Gk9x8JsKtJBX7Cjxr1Ww2mrJAyTZ7WtwZJMKTWQgOLpQgmu5shvKwW2saNpIpMlLFtc2HpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(39840400004)(136003)(5660300002)(122000001)(110136005)(2906002)(66946007)(6512007)(86362001)(6506007)(54906003)(4326008)(36756003)(4744005)(316002)(6486002)(76116006)(508600001)(66476007)(186003)(38100700002)(71200400001)(8676002)(66556008)(2616005)(8936002)(64756008)(66446008)(83380400001)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHRlS1ZjNkppYUY3eS9oNlNXSWlDdW5YbmgzNk5zZkxQYVV4YVVlTytSSHNU?=
 =?utf-8?B?UHdNRlgxNXRMNmk0c0N1VTFLdGxHajF5M0hZQUFxeGpLeGM3TTgzSU04K29a?=
 =?utf-8?B?MGE4VzcyL3ZXb0FTdHdDcGZKMlFkR2lOdWZJT1puOXVjU29WeVBudXBHTTJB?=
 =?utf-8?B?NzQra0RjbUZLMHRCQ3Z0b0pUWjFzYUk2UGptYzdiNEJGTkZ5OWtEV3YxSVRh?=
 =?utf-8?B?aVg4ZCszM3R3QTJyVmEwNkZRSlF0MmdyYkw4a1JFUTF6eEh3WHB3L05UNTdn?=
 =?utf-8?B?WllsbVFXcDJNaDZZQUIzZVVRWDYrcG0zL1Y4Q0VkK1RGTVdmUEY3NTJNR0lV?=
 =?utf-8?B?WWZnSzlQWHk0elNxaWo0TmhSVXBDQ0pjTmxrSFU0bjdyVTB0UEtUVFVHZ2NB?=
 =?utf-8?B?TEV6YW1XejhJT2lYSUduT0ZNNWJuZmxKVlMxalBFa1hwamNwelNXSy9DcCtv?=
 =?utf-8?B?TnJ6WFMwRk9JU3JlMHpjaGl6dlpLZmlEWm5OTTVYSUpTWkxuLzJ5UXREMVU1?=
 =?utf-8?B?TlBCVDVIajNlZUxhQWlZOUVobTRSU3YzRVpLTmhFRldNOTRpdlVkWmoxZW5J?=
 =?utf-8?B?ZTRWbERnOVQrd2ZRVE1TVHF0T0RKQjBna1NOMGxYUXc5VDZJdFBRS1FqaU56?=
 =?utf-8?B?My9ERE8vYkJiYWwzT3lnVUt6blVVb1VqbWg0WWhDclFDZFAvWHhpTFdaWW5J?=
 =?utf-8?B?NndMM3RiNmtsSnNzMFpETEhLMG5oVytkRzRYc1ZPQkQ5MVRDVVQyeXhJVzdi?=
 =?utf-8?B?OEJ3dlB5TXlwVG1OaTgxdGJWaldmL0EwV1F6N2RrdkpuZlByMXJjMGxKSGRY?=
 =?utf-8?B?cmZwVzhSN3hzaExuUnM2ZUVTY1lBczIzKzh0eXgzaTR6Wnhab0dFLzdTMlBs?=
 =?utf-8?B?WGszYnB1azRQUHVENkRQMXVJYVNnUk1xQkFFYmROb2FETEY5WnFKOTQ3VnJP?=
 =?utf-8?B?TU14c0kvcHBMMDIvakNFZ2ZOQW0xTmhuSG0rQWtickFNZlRjS3NyTVUrRmhF?=
 =?utf-8?B?SVZuUTJiWTBLQXh0UFFYMVBpSUh0Wk1hYmJickk5VHhKSWlBc1dyRW5TMjFF?=
 =?utf-8?B?N293czRRUmQvSFM1TXZiSkJuSVhWOVdSTEtoRHE1WXBBbzBtOFAwdUZaQlJl?=
 =?utf-8?B?WXd3WTJQVmpmRWJSekpEV2U1a2FqeUJ5Ynl3RmxQWDdlYUtqdzQ2R092ZUVv?=
 =?utf-8?B?SUhyelk3RHJCQWRyY2d4aXVsZEZEbHd0NW8vTzE4MzgrY1d3RXZlMDFqOEJK?=
 =?utf-8?B?Z0hnWjl4NS9BQ2pyc2hBaTYvNHVtOGxQemJzdCtYZXNHUkx3YjNJUmNDNHc5?=
 =?utf-8?B?MSszV2R5bXBKM2tSYWxxVDVPK3hRYkRoZHh4dHRFZGVHalU4YUNVajUzOWpE?=
 =?utf-8?B?L2hlTmdPczJLcHBPNkdZNmFOK2hKc3V4TFBqd1lDUlMzTEIrenFCTTBWUklW?=
 =?utf-8?B?eXIvcTRwTFdteWxPZjZYZzBzSXh6dTFDc3FCdTQxNEpLMmJTZkx6RFd4UjhZ?=
 =?utf-8?B?cXpJUnoyQzd6UHhDVDBCeitDbkx2TFZYdERnQlFZVWIyNlVSbkhnaUVhUjNw?=
 =?utf-8?B?SzlNQVZwVlBjYm5QalRaa3R4U0IrT1QydnRoQXdBbHRlbE5QVDdCbm1YMjFn?=
 =?utf-8?B?bVNqbnZoYUJ3WkpFektkT3pMWFFGUytCT1lPL2R5dnlpUVM5YmVYVUVpUHAw?=
 =?utf-8?B?RkxuU3Ardk5uR3VFRzE0cFI0THhuTmJ2K2VZSFIyaWpkRS81Ym5yRjZheUxj?=
 =?utf-8?B?cTgyby9maE9TZDF2QzNhYW05MW85bVhRZkxpT2F0WFpiQ1MzWW15Wm9qeXph?=
 =?utf-8?B?UzNNM2tIdTZIM29xRmdwUktYalJvZlJubnVSaXg5OW1JODlneERZUU90UGFK?=
 =?utf-8?B?TC9ITnhXSDVPS01nYVJXa3c0ZVluUHlxNk9LYkdBb0lMelBhTjlJcEtQbkJX?=
 =?utf-8?B?MlhFUVdZdk1WVS9WbzhiUXJLdlBKa3l1aXNBNmJpZ3ZGSHdIRmM5VFkxV2hJ?=
 =?utf-8?B?aXk4QlFpT1NtQkdUdDQ0aytWbkV2TnREVHpzYjVFYWxybEc1RHVDckNrVzRJ?=
 =?utf-8?B?TFVzU2ZoL3E4LzVPUjFEbUdvRFc2TFQ0WUxEU3RGUzdYWndhTkJXUzhUaCtX?=
 =?utf-8?B?UmRENFRueGk5TmNxM2JaaUkvcE1XcVFTS1RXVTI2VkFHcXJpeVJzV1RmTUNP?=
 =?utf-8?B?NHA1Q2NpN3VkcWtmNngzTlNNWTExczNhM3NYYzF5TEl2VllaaFVPZnpxd210?=
 =?utf-8?Q?/reDBXNuBbEKyJjNGcVi7buJH06BE1gr6k/qH+HrUo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C3044102DB951489F7E0DE95F42812B@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB5200.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97667447-c85a-445d-bc21-08d9da0c7d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 22:55:42.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJQ5BAiGZ+TBAsXrNr+JkSBtMvt5ysjLuApjF0WZjbD/fJSpa4gF5ODwN+iv+dLcxtV+vUtBT0DzkWR7KI7H/H9rBmNrcS1zoCbun+HQDxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB3120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTE3IGF0IDE3OjQ1IC0wNTAwLCBIdWdvIFZpbGxlbmV1dmUgd3JvdGU6
DQo+IEZyb206IEh1Z28gVmlsbGVuZXV2ZSA8aHZpbGxlbmV1dmVAZGltb25vZmYuY29tPg0KPiAN
Cj4gQWRkIG1pc3NpbmcgImlmIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEh1Z28gVmlsbGVuZXV2
ZSA8aHZpbGxlbmV1dmVAZGltb25vZmYuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3J0Yy9ydGMt
bHA4Nzg4LmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLWxwODc4OC5jIGIv
ZHJpdmVycy9ydGMvcnRjLWxwODc4OC5jDQo+IGluZGV4IGMwYjhmYmNlMTA4Mi4uM2FhNWQ5ODBl
NTk2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3J0Yy9ydGMtbHA4Nzg4LmMNCj4gKysrIGIvZHJp
dmVycy9ydGMvcnRjLWxwODc4OC5jDQo+IEBAIC0yNjIsNyArMjYyLDcgQEAgc3RhdGljIGludCBs
cDg3ODhfYWxhcm1faXJxX3JlZ2lzdGVyKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYs
DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBydGMtPmlycSA9IDA7DQo+IMKgDQo+IC3CoMKgwqDC
oMKgwqDCoC8qIGV2ZW4gdGhlIGFsYXJtIElSUSBudW1iZXIgaXMgbm90IHNwZWNpZmllZCwgcnRj
IHRpbWUNCj4gc2hvdWxkIHdvcmsgKi8NCj4gK8KgwqDCoMKgwqDCoMKgLyogZXZlbiBpZiB0aGUg
YWxhcm0gSVJRIG51bWJlciBpcyBub3Qgc3BlY2lmaWVkLCBydGMgdGltZQ0KPiBzaG91bGQgd29y
ayAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgciA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUo
cGRldiwgSU9SRVNPVVJDRV9JUlEsDQo+IExQODc4OF9BTE1fSVJRKTsNCj4gwqDCoMKgwqDCoMKg
wqDCoGlmICghcikNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsN
Cg0KVGhpcyBpcyBhIHNpbmdsZSBwYXRjaCwgc3ViamVjdCBsaW5lIHNob3VsZCBiZSBbUEFUQ0hd
IGFuZCBub3QgW1BBVENIDQoxLzNdLg0KDQo=
