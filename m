Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BA74F10AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiDDISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiDDISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:18:50 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90082.outbound.protection.outlook.com [40.107.9.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6593B3E2;
        Mon,  4 Apr 2022 01:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKbOFYT3LmUumMw/fLaDwb+waG/WAMs2UCyuLMheeEu6+QkQ0mBOXLRcsVAH9Tv+O+zxmomi8eFIigFaX/JoQFIHrxCS9xTsCW3d4+j0JnLc4r32rBc8fZDrTituHx2/9DIRK69ZDbjswekPiGWBIs8rZm+KkIKGbEogBJqbacyJLWy5O4+waLrA+8/l9O0CBH7FVpBaOJWZeD//EUXy8dVDgx/DdheqQW8SZaWAH0M8sL4veOmWbKDdjj6Pk16otE16s7XxhSB5RXF03Xr9XlniwJ3XPGarI5BwHY/nxEQhl55lxaBxK6H4liQhwYvT+PzDrJi0TgBOylmXtE5sgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q3jKhbYZvY9iV8pJcG9Woyf7YgAVsyANCpm/poU6kI=;
 b=VBqZZn1i/yg22bNqB6SDiwh3R2OT5uAybmXxtJlh0RZpUDWjmnhX2d31mOIog2Xhlw6VxGVR8pK4K66Ntb1PT6h2xYAlHtSRU9nDPwnhJ7REjwd/0khVmdizQxb6LRNws06S+tYFQndgBOKLoQq2Udu++Zo6JBSKM3lle+VWy8/VGwD0OBvdhXVX/2KCcS8H0/MuMu7Wdg+xuY3SWkf6tZ+k9/S3s1GKq+tD4LdYzEOZY7wH4o7tSWY1NJngJxNf2T6JZGKRcAnpTypf3psu2eaMURb2PRwUffVkNxZSj3Kl0Oka0gN3ve5etvPyjX7OZIJzoeNAFU1uCrQxjSqxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 08:16:48 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%7]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 08:16:48 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: What means "sysfs: cannot create duplicate filename
 '/devices/platform/ff000100.localbus/d0000044.gpio-controller'"
Thread-Topic: What means "sysfs: cannot create duplicate filename
 '/devices/platform/ff000100.localbus/d0000044.gpio-controller'"
Thread-Index: AQHYR/xUyPpICbYGlkyr3dOIDaK7Jw==
Date:   Mon, 4 Apr 2022 08:16:48 +0000
Message-ID: <35ceac23-2841-7def-d963-484d1a489836@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74823217-649d-40e2-6972-08da161376e7
x-ms-traffictypediagnostic: PR1P264MB2245:EE_
x-microsoft-antispam-prvs: <PR1P264MB2245F7343C35E90C00441318EDE59@PR1P264MB2245.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4onuXOnzB5It8vAvnJy3nqQhNhp9nDsLcwekficfdc0fjTS0YVjj9KVTH6tnwdDahC2ao13npfPzM27UAYLXPt5muqxIOmrT160U1odeoAWyWBlZJkHiP9hO+ojYUBmiUKvLTk+w2rhP3VIC+9A8QG7nWgFBnMb5B0y0MPDR51ePccrmQhwCVGuX5m1BXe+1ZRIAHnpKhOuu2ccpKM+gC3IpDg7iLYCl/gkt7rC4Es4/ykAg+k5JqUL2PmP/vUH8MWSMgG0/cT+uRwdue1MNs0do/1YdhiKl7nw3jKjNKr0GqRShnnYr1sNQSl0YpjxPJwM/AXqqovSe0LkWmq0VNJ17QWTQW0fHr4QA8kAt3wOLfny4GTxYww2Aam38GKgYH7mQ8vKrLBGbgj2ARMpcW5XvzwIVhmV9S9oHEDjHjGvXMP8xshIlVOfRxfI2ZJxS6PI5hIo0YMgEvhpF2x/frwZ5dPqbEywkdMxjvV53TIKSH/fpsJBnuTZo203KnFdMGMBkRThG7Jq7Ka0alU/5r9DNdslDqnw8C6r6NeZRKPwYfJXlBz5agSN9Dw3ni/83Ci/Y4QvMGEnbMvwFEriwqKL1uqzzL/4pGZbTiYVPerkJuI5cmSvvpipJXceStM6SzxF6eBtddw1FfeR7Q1aAfZt4a1XDVSTtERRBSIJP+TbZSclXBIyDDg43sJh7CbyVTwtKgwbaKBaOuX/5UGr5+Dz/BY49oeaGHfFfCfBs/JPdIC0Hf2hS8eBD7qiX7RnKpJoUwNgTLBs8GNXYpQ2Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(54906003)(31696002)(44832011)(8936002)(6512007)(2906002)(38100700002)(71200400001)(508600001)(86362001)(316002)(122000001)(2616005)(38070700005)(83380400001)(186003)(31686004)(8676002)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(36756003)(6486002)(4326008)(91956017)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2NxTTdsOURRdXVTWFZzVkpqdkpmQlV3QmNBSWR1NXlKbnNkSkVHNGN1NXRj?=
 =?utf-8?B?LzRhTUllYnQzTWQ0MnB4YzdiREY4TG9KZ3NTYk10U1hTbFVhOEdWMzJ4QjNU?=
 =?utf-8?B?WjJDSWRPY0tLOXlZWWx0TVAxVFhMYlVUNXV4ZTZMTVdybEVKekNSTVoxWlpk?=
 =?utf-8?B?c1g0VW8yOHJZNnh3b0NIem9TdFZGM0MyN3VMbnk4NTNac0Nxd21OWEdWMkIz?=
 =?utf-8?B?MFJoM3d1SDZ4NFBlWEJDejIwdFpXMk5XWDVOMkNBK2I3VTNVUHd1R0VxZkRi?=
 =?utf-8?B?TTZ3QzdVNUdrRWJVUUZ2dDZranFQSUMrZCs4ZXEvMUdBRHI2dzBCYTJINDVU?=
 =?utf-8?B?Rk1PMzJvdnEvbSswbzZtRnEzT2xHc1JhZFdFWStEdExvZFFhU1lYckNxQThV?=
 =?utf-8?B?Z1FJQm12Mjl2Q1F2VUZYZk5uSmxKc05nWFJZMnNreC9hcGFFRTA5dmN4MlFN?=
 =?utf-8?B?S1FtVkVOVDBxZVRPaktteU9iYkV5ZlpQRzVQZFRwc3FWZ0pUM2R6NXJGU0x3?=
 =?utf-8?B?VVJLck1Eek1yMHZzaVFxckZYS1BUOUZHMWZzRVBTbUNVaFlCUXRuc3FZNFRv?=
 =?utf-8?B?bzdYVCtTUmpLZnBwZnYwVlFhL0VKL0dJdjdmS1J5WDVVNU1yeEFyb0NhL2Vq?=
 =?utf-8?B?anNoczNwTjdkc21paUJIaG4rb0lrVCtGczFCZnBOTEwzWUxhWjE5b1pzbTBo?=
 =?utf-8?B?LytobWJocHc2RFIycWVxeitkWGtTbjh5NFk3Wi9WSE10elRvbURVQmlZTlly?=
 =?utf-8?B?OFVUemZlUTR4RnJENmtsZmxMUUEveG96ajNielVxSzNWNHVIRkUxbjhkN2dX?=
 =?utf-8?B?K0E1ejBrVnRrQisyemVTM2lXaTdtWndDVjNoKzg0b05rV2tYNVlJbzNlbi9I?=
 =?utf-8?B?N0ZJVitXN1pSRlFlcU8rZUVSL29HSHhQdHVsSlZwZW1SWnVNY1Rabzl2WURN?=
 =?utf-8?B?VXdaME5UMmVxRHNzYVpaUnJKYXFBMnI1N2dpSFhWdzJWeWwrZThWcXNjM25T?=
 =?utf-8?B?KzJpUGhWbVZQcnJOeWdTVjA1QlpqcGVXRzFLSHJwV3Z1VGJubXNlZnpNMHhn?=
 =?utf-8?B?Yzc3QmFYWUlweU5EU2g3QlpySGxXVnhDYy9zVzJqc2U4N1hOVDFyV3lkRTZh?=
 =?utf-8?B?dmU3WFZhRGN6Q3BHZDk2R28zVnhmTjdURXZyVzJjOTl6aENUQlhkQjQ2bndM?=
 =?utf-8?B?MC9FdjBRaExQNVcrUVdrdDhGbVlxN3pNbC9tb1NXZEtnbTEra2tjUWFsb1l2?=
 =?utf-8?B?TWpMbGZBcVF0NktoS3JIaXNzQlMwcjQxUGVuQk1ESjNtNDRGYmxZemZwRVZC?=
 =?utf-8?B?blVydTA2S3NDbWdRaVh2TVg3ZEpEaWRjbENTUHFWTVRwM2dsaGZQVFlFUXUz?=
 =?utf-8?B?Q1FGWEtEUTRZZ28vekxWaVQ3WjJqVG4rNmlRdTNmMHhsNTc0RlRqbUJJQkZx?=
 =?utf-8?B?K3dtMnFzdldRRWNMaDF5ZnZYSFBDTnpGU21kbTR1V2diLzF6Ui9QWGlvbzBl?=
 =?utf-8?B?UzdoQ3pWTTc0Zi8xcStDcnZSUnJFWFdQVW5CNFRydTM1Mnk2UzNvakNVM2lt?=
 =?utf-8?B?czJaWXVoY1ZEZ1pBdjFIMEJlOThBcWhMWVdWaStzLzFmMVQycmZReURweUZl?=
 =?utf-8?B?dGQxRjdtdzJVS3VET0VpQUFKN3YxOXA0bmd0L0F0cVJzRVNST09VRW9hbGJr?=
 =?utf-8?B?Mks5aWhQMkNQRHdaT1RTTWpxZ0FIclNodDg3cFNscmxjaHcyZVNkQ3N6NzQ3?=
 =?utf-8?B?NWpXcUYxR09aUEJBT2dCUlUrMFJ3Q2FncVpwZ1dudUljR1J3WjNKNDNQV0Zj?=
 =?utf-8?B?UjRsQk0vZWVJMzFWRElHOUxWNkdGSWRKalR1TnhDTVpReE53MTF4Nm1UMWRz?=
 =?utf-8?B?QkJHOEErdCsrK2tDZGdyQ3pBekMvb1FGdVJhb3hnaklJMWlKcU9wb051bjk1?=
 =?utf-8?B?UjFJZUVEWm5kelBQczlyR3RsdzZZcjlPbXpGTk1BSS9hTXFJMS9CUkMwb3Y4?=
 =?utf-8?B?Mmw4ZzFIRDZuTDhXN1F2WHdTeENaSzVWVXNTNTFvdGNRT3BqdzVObXpjQlhj?=
 =?utf-8?B?SStRQ293R0cyRjZ6TWd5T0N3Wlo4bFU3a0FvNWlYYVkvQ1J5OE8zZklVUzNj?=
 =?utf-8?B?TG1ZaVUxOC9aMEJwSE9CZkhEUGNiSlhPZ2VuK2JRdlNhWWlPUU1ReG16eTRW?=
 =?utf-8?B?SUhZbXVRZnU1YVQwdzU5Mkd4bVA5ZGdUOTEramJzV3haYUJGdG44UXlOLzdN?=
 =?utf-8?B?RGVEUzFpclFkZTM0bDVGcmZSL3BaMVR5dVA1V1dWYTJWcHJHdGlRNlJnK3pv?=
 =?utf-8?B?VCtLYi9kdnpxalByc2xnRDFSSXNlR05pRWNiVHNEOTVYM3EybFovcTM3ZWsz?=
 =?utf-8?Q?zDATbpGSQcwx97JSOz4jMT11kwrVN/RCsRPxr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8CB7632F2FC6640A4DB87CBA4FB5270@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74823217-649d-40e2-6972-08da161376e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 08:16:48.0788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3pMJCY5bGI+pbkl8qa1wU6Tq+bHdO58vq/+tmi1HJDPfVlBazsAnWOM8H8K3XU3SjMeYL9mxcftPU/D4TNg/d9ejK7Z8YjRcix7zWMBcSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2245
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkR1cmluZyBib290IEknbSBnZXR0aW5nICJzeXNmczogY2Fubm90IGNyZWF0ZSBkdXBs
aWNhdGUgZmlsZW5hbWUgDQonL2RldmljZXMvcGxhdGZvcm0vZmYwMDAxMDAubG9jYWxidXMvZDAw
MDAwNDQuZ3Bpby1jb250cm9sbGVyJyINCg0KQmVsb3cgaXMgYSBncmVwIG9mICJkMDAwMDA0NC5n
cGlvLWNvbnRyb2xsZXIiIGluIHRoZSBsb2cuDQoNCkFueSBvZiB3aGF0IHRoZSBwcm9ibGVtIGNh
biBiZSBhbmQgd2hhdCBJIGhhdmUgdG8gbG9vayBmb3IgYW5kIGRvIHRvIA0KYXZvaWQgaXQgPw0K
DQoNClsgICAgMi4xNTA5NTRdIGRldmljZTogJ2QwMDAwMDQ0LmdwaW8tY29udHJvbGxlcic6IGRl
dmljZV9hZGQNClsgICAgMi4xNTYzNThdIGJ1czogJ3BsYXRmb3JtJzogYWRkIGRldmljZSBkMDAw
MDA0NC5ncGlvLWNvbnRyb2xsZXINClsgICAgMi4xNjI3MjVdIGJ1czogJ3BsYXRmb3JtJzogX19k
cml2ZXJfcHJvYmVfZGV2aWNlOiBtYXRjaGVkIGRldmljZSANCmQwMDAwMDQ0LmdwaW8tY29udHJv
bGxlciB3aXRoIGRyaXZlciB1MTYtZ3Bpbw0KWyAgICAyLjE3MjgzM10gcGxhdGZvcm0gZDAwMDAw
NDQuZ3Bpby1jb250cm9sbGVyOiBlcnJvciAtRVBST0JFX0RFRkVSOiANCndhaXQgZm9yIHN1cHBs
aWVyIHBpY0AyMg0KWyAgICAyLjE4MTAxOV0gcGxhdGZvcm0gZDAwMDAwNDQuZ3Bpby1jb250cm9s
bGVyOiBBZGRlZCB0byBkZWZlcnJlZCBsaXN0DQpbICAgIDIuNDcxOTgxXSBkZXZpY2U6IA0KJ3Bs
YXRmb3JtOmQwMDAwMDAwLnBpYy0tcGxhdGZvcm06ZDAwMDAwNDQuZ3Bpby1jb250cm9sbGVyJzog
ZGV2aWNlX2FkZA0KWyAgICAyLjQ4MDYzOV0gZGV2aWNlc19rc2V0OiBNb3ZpbmcgZDAwMDAwNDQu
Z3Bpby1jb250cm9sbGVyIHRvIGVuZCBvZiBsaXN0DQpbICAgIDIuNDg3MTQyXSBwbGF0Zm9ybSBk
MDAwMDA0NC5ncGlvLWNvbnRyb2xsZXI6IExpbmtlZCBhcyBhIGNvbnN1bWVyIA0KdG8gZDAwMDAw
MDAucGljDQpbICAgIDIuNTc1Njc3XSBkZXZpY2U6IA0KJ3BsYXRmb3JtOmQwMDAwMDQ0LmdwaW8t
Y29udHJvbGxlci0tcGxhdGZvcm06ZmYwMDAxMDAubG9jYWxidXM6bGVkX3B3cic6IA0KZGV2aWNl
X2FkZA0KWyAgICAyLjU5MTk2NF0gcGxhdGZvcm0gZmYwMDAxMDAubG9jYWxidXM6bGVkX3B3cjog
TGlua2VkIGFzIGEgY29uc3VtZXIgDQp0byBkMDAwMDA0NC5ncGlvLWNvbnRyb2xsZXINClsgICAg
Mi42NDg2NjJdIGRldmljZTogDQoncGxhdGZvcm06ZDAwMDAwNDQuZ3Bpby1jb250cm9sbGVyLS1w
bGF0Zm9ybTpkMDAwMDA0Mi5HUElPJzogZGV2aWNlX2FkZA0KWyAgICAyLjY2Mjg3N10gcGxhdGZv
cm0gZDAwMDAwNDIuR1BJTzogTGlua2VkIGFzIGEgY29uc3VtZXIgdG8gDQpkMDAwMDA0NC5ncGlv
LWNvbnRyb2xsZXINClsgICAgMi43ODU5NDFdIGRldmljZTogJ2QwMDAwMDQ0LmdwaW8tY29udHJv
bGxlcic6IGRldmljZV9hZGQNClsgICAgMi43OTE2MTRdIHN5c2ZzOiBjYW5ub3QgY3JlYXRlIGR1
cGxpY2F0ZSBmaWxlbmFtZSANCicvZGV2aWNlcy9wbGF0Zm9ybS9mZjAwMDEwMC5sb2NhbGJ1cy9k
MDAwMDA0NC5ncGlvLWNvbnRyb2xsZXInDQpbICAgIDIuOTAwMjI4XSBrb2JqZWN0X2FkZF9pbnRl
cm5hbCBmYWlsZWQgZm9yIGQwMDAwMDQ0LmdwaW8tY29udHJvbGxlciANCndpdGggLUVFWElTVCwg
ZG9uJ3QgdHJ5IHRvIHJlZ2lzdGVyIHRoaW5ncyB3aXRoIHRoZSBzYW1lIG5hbWUgaW4gdGhlIA0K
c2FtZSBkaXJlY3RvcnkuDQpbICAgIDkuNzk3NDAyXSBwbGF0Zm9ybSBmZjAwMDEwMC5sb2NhbGJ1
czpsZWRfcHdyOiBlcnJvciAtRVBST0JFX0RFRkVSOiANCnN1cHBsaWVyIGQwMDAwMDQ0LmdwaW8t
Y29udHJvbGxlciBub3QgcmVhZHkNClsgICAxMS4yMjk5MjddIGRldmljZXNfa3NldDogTW92aW5n
IGQwMDAwMDQ0LmdwaW8tY29udHJvbGxlciB0byBlbmQgb2YgbGlzdA0KWyAgIDExLjI0ODc5OV0g
cGxhdGZvcm0gZDAwMDAwNDQuZ3Bpby1jb250cm9sbGVyOiBSZXRyeWluZyBmcm9tIGRlZmVycmVk
IA0KbGlzdA0KWyAgIDExLjI1NTgwNl0gYnVzOiAncGxhdGZvcm0nOiBfX2RyaXZlcl9wcm9iZV9k
ZXZpY2U6IG1hdGNoZWQgZGV2aWNlIA0KZDAwMDAwNDQuZ3Bpby1jb250cm9sbGVyIHdpdGggZHJp
dmVyIHUxNi1ncGlvDQpbICAgMTEuMjY1ODYyXSBidXM6ICdwbGF0Zm9ybSc6IHJlYWxseV9wcm9i
ZTogcHJvYmluZyBkcml2ZXIgdTE2LWdwaW8gDQp3aXRoIGRldmljZSBkMDAwMDA0NC5ncGlvLWNv
bnRyb2xsZXINClsgICAxMS4zMjE0MjJdIGRyaXZlcjogJ3UxNi1ncGlvJzogZHJpdmVyX2JvdW5k
OiBib3VuZCB0byBkZXZpY2UgDQonZDAwMDAwNDQuZ3Bpby1jb250cm9sbGVyJw0KWyAgIDExLjMz
MTczMl0gYnVzOiAncGxhdGZvcm0nOiByZWFsbHlfcHJvYmU6IGJvdW5kIGRldmljZSANCmQwMDAw
MDQ0LmdwaW8tY29udHJvbGxlciB0byBkcml2ZXIgdTE2LWdwaW8NCg0KVGhhbmtzDQpDaHJpc3Rv
cGhl
