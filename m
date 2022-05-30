Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79B45374BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiE3GIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiE3GIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:08:17 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120051.outbound.protection.outlook.com [40.107.12.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5D2F398;
        Sun, 29 May 2022 23:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqH1hNJO6t2yoWAJ9lCOcm/L/b8nCO70kbkgvDs9PqtHR5b7sSTHIygnyfKCMgcsSJK+1ANtM7f79vuhrTLOnpLh/IfuRw3xMjrEWFAMx41aOxC6w0+B5ADKNpLQP7UfTCQXeW+i1vm881vwjK7ND2jtH8uWjQu2XAEyBCTYJOurhYH/etQ7bJt3rRoMqjWv4D9kxJGZBmI5rTY4cZ0BwLPng/bYPrSqADloaSWhPhcidkvs9NExDuwRDOCoYX31PUonqKlLDZuM3DsiZO9202EXNlWv4baznowZpBO6y1w9owqNavF3GaekODCFMpeaaX/fKN+BHJ7iaSTTcroCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0rMFOki+9H+umvS0o9KkCoShTTlqdZU+G0JrYJRE+o=;
 b=bW59GSUhrYGZAgHvKp0et0buDy9eU5q8mOnPXOzTM8zuZ/B1QUOKzjThnLOUMAchFNojVhnzDPCCV5TEYA64HHYqP1nAI5NaBtRGDCp1iZvO6V2PC2ZjE7GAgJteHbU8CagXGZfbf9zTFGVrDUTVCD8hHDLlC/3pdoBKNhyRN/gC2QRdhsRqXa3oEnWv6SmPMw3SMzxHVOfDxhFQMUNPw42Z3HwgDU9HSYu1pI/9IcvFqJl+4LS1vvtxWUrYTBY1gtspMxIl8eDexRhG6c2aLfOc3my+UWUGXEJbPvMDOLTps9fOoxPLJj/OS431QU7PPJc9iZdaElWnhTjCyF5D5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2044.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 06:08:11 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%5]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 06:08:11 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Leslie Rhorer <lesrhorer@att.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: Module failure on new install of Debian Bullseye
Thread-Topic: Module failure on new install of Debian Bullseye
Thread-Index: AQHYc7Y3nWKey7dPKEuAB013uT5mg602hVEAgABqiAA=
Date:   Mon, 30 May 2022 06:08:11 +0000
Message-ID: <13529cf4-a00d-5e59-2e1c-cb1daf24bf71@csgroup.eu>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
 <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
 <3b8f2ed6-11fd-b5a7-5442-7cac90348514@att.net>
 <8de4e4b7-f741-eb4d-9e11-9b23ba65c21a@att.net>
In-Reply-To: <8de4e4b7-f741-eb4d-9e11-9b23ba65c21a@att.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1bf3b13-f9ea-4793-44fb-08da4202c672
x-ms-traffictypediagnostic: PR0P264MB2044:EE_
x-microsoft-antispam-prvs: <PR0P264MB2044F2D7EBA6551D88B8770AEDDD9@PR0P264MB2044.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ec0zsnzsdcgK4y9sMYnN/WQfLO0BlktscAphlC2O8qOAWMxA4u/KkB1Y+/DGSW+Qbl4+A6apPkTbgnnE3AWEzJT169YaZLnQYKFCLj2TVi+GUifyN4BVn2M8bvMZKBo7G6Cp7mY0Zi/m3Yx1jW8A4Vd6imyqDqXzF22d7j/3Pfa+s1e9fvDmwhrlPZMVsSkd5dBznGrYFGaLQeS1V9oDsMScBwXFXe2to4gm1yeHIThSNu9Ie9GFXjaizTP1qnM2doHNAFXq7N3sk1LsYUxBmNB2hLC4geSRIdDshaNHxExwFGM+HPFj6xh4QeGuykGXxEwgcTZh/lrmnT6JmKlb+nv9LauiKX3CSyY5ED4+YWw9SdYsZYiQii3J47A5Kwgxgp1+qeiGE5aA4QXKtjimEk6lpim6b+0JFXGwnRkGXbZ1xGuYsr5GKap7gRC0VPTH/e0QWsnubZx67KKO043JeQHbB7h7ozGPG4HqIXO0yWUFlrZfzeeScKKGHHeigkBqEUH+8PIOdU4VbUCESukQOV8UF468uYJJQQIVuRAdQHlXRX5QA1jFOGhmgKXvLhaGC73ooWwRqFr8m2XwBtzZYmj50yBDoBX58ULi1TxZa37FHLilRsGv9pKRqt/oIh/2ILq0Bk2ix9GOyokT4mfZxJdNRTkBTOeORZM3P5HaxlpgaUN6hvmZfLvOqy3m0PtFhQqxHQa63nHc3xXJZgvlzgeCnGP6ePE80jaswKjkCeDWupQJ0HDc0a0mbkbDppPZ0Epio1gBa0IdNm47L8Hxjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(4744005)(64756008)(44832011)(508600001)(8676002)(66446008)(6506007)(76116006)(66556008)(66476007)(38100700002)(71200400001)(66946007)(36756003)(31686004)(8936002)(91956017)(2616005)(2906002)(186003)(31696002)(316002)(38070700005)(86362001)(26005)(6486002)(6512007)(122000001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anBEWnZUdHZ5VUZJNXk4MGtEK05Bd1QrSDZ1ZFZEUFV3d1E0c1dWUFJPRGdW?=
 =?utf-8?B?NXdZbVFCQnc3eXNDSFBEZFhISTl3SmlleEVsbHA1eUFSN0xzNDY1YU9pZEtH?=
 =?utf-8?B?bk04a2FtbGNKTllFL2ZTb0JYck92blBFU0NkUkpzRVhLeVJLR0lza2g1bXdR?=
 =?utf-8?B?ZGd5OVlzN2lXSXFXSDhMZXd6MGxGN3lpeGVScmRWU0didTRQSFhmcC9lL09x?=
 =?utf-8?B?a2FuTmN3RlJ1cFVhOXJlME5aNHRldjR5YzBRWjFmU0ZaRHVsU0RGVGZsaEN3?=
 =?utf-8?B?Wkx3WG1wQkVKK0FMVDhnNytwenFWMnc2bVMvUVRhaDYxL3R0a2NBSytNd0lq?=
 =?utf-8?B?RFV2a2xLci9rbGc5R2lZU1dSSWtHU1ppY2FKWHhjeXlsTnhRVlpaZkdwOEtP?=
 =?utf-8?B?OFZCY0F2N0tqOTNGSGlWcGJ2WjlrT0dSM3hBMkFRV1NKNFB5UjRuYTB1WTds?=
 =?utf-8?B?V0hJWlZWVldxTE9GQnNhU0t2UjllVlVoTGNBV2FDNEZkU1E5ZlRYMU1OTmE2?=
 =?utf-8?B?VWNobHM4aldKZTdqMTgyK000QTdpRkN0VDYydmo3TStNVDVyWks3TDRPNnNk?=
 =?utf-8?B?RXk4WFgxQktHL214RHRxVGYyWm5NeUk3cUkreFF1YnZzc1BKdWhTd2YyUjZw?=
 =?utf-8?B?SldWNnBhbFgzd1UvSk1jelpXM0dGUytaeUhqUldwMzg0eUwxWldDM2Y3bkhy?=
 =?utf-8?B?Z1IvSm9zdTJ2WHJ0NkRWczk0VGVER0tIVGpCSTk0TGx5QVpkZ2YwTzN6MnJl?=
 =?utf-8?B?OWx3TmczeS9QV0Zsb2xwSmZsUWZLa09pUGNta2pDSTVZTXJUWi9VSXViUi9D?=
 =?utf-8?B?R1IrQnJFNFJ1blh3U2s0QmVZRVdxMHJ4Um52eTdHekhoMWtQUjRyK3NhbHo2?=
 =?utf-8?B?KyswaGVzcTBTdy9wV0lxSlFQYWN1MkVUb3d2ZGRONFdLQ0k0RFgvRmpyR0lw?=
 =?utf-8?B?dXV5cUtJZGpVaFN0Sm9xd1NodmFXQzQyeU00dktUQjAxb3I2WGQvTzA2a1dV?=
 =?utf-8?B?M2VFbjJCVm1Fd0RKS1RQVXdNVFIzU3J1NyswM25OZGc5eCtGeTNLaExXaWZY?=
 =?utf-8?B?Ri9sMnlmR2hDNzBMQjNlUnBlZTZxdnR4djVTYnZZVUtxb3VrKzNqWjBSaUhj?=
 =?utf-8?B?Q0NHTnNtSHVPUnFHVzFISW1adTZvRkJMUlhTWm5YRUpVQVNlTEhoNHRKbXBE?=
 =?utf-8?B?OU5kM2IxeTZ5cmRKVXp2V0ZVVmtZV3FKN3p5Q0FvWU5iTTZUQUVJZ0NjemRr?=
 =?utf-8?B?d1R2ZkFHT3o2WXAvNEYyZy8vcnVsS2hOYm53K1FXV0kzL0xJSWdESXZTZGts?=
 =?utf-8?B?ait0WEtqZ2hjS1lMVkE2cW1MMjJWTEZXYUoyZ0dSWGRNcEk2VnQ0SmUwTUNj?=
 =?utf-8?B?NDVzYWp2Unh0OHlGaHRFczBlaklyUE5OTnlIdTZaa3dhajYzR2YzM3FuWDhz?=
 =?utf-8?B?bDJqL0ExRVIrcXUxNVRnbVI5ajEvbEJqc3dZcUtpUU9ORVRJWXg5enlJR3RZ?=
 =?utf-8?B?Lzd3WXAwR2R3M1FITmdrdzFsTVJYTm9Tejc3TU85UWtsMXExWVJLRnpsM3JS?=
 =?utf-8?B?RUFmdEJUUCsrRWJOWTRHUTdNWDN5cFN3Z3pVNERrbEwreXpqaUc3ZFNMOGhX?=
 =?utf-8?B?WERBV0ZuKzI2cUtXRXc3RUxBVkZ3QWhyYkM4SGNpRGZ1aE5Xc3hKeDZXZFNy?=
 =?utf-8?B?cWR1TThrT2wzdjRTWW1IYmRmZkk1Ymd3YXlyYWplVTR0ZnJ6NVRGcGdTZGpz?=
 =?utf-8?B?YyswNDBPUVFxMGFiRGRLMzNxd08wTWFuWXlSREp6c1JZYWZXYkphSnllZUFj?=
 =?utf-8?B?cEp3UDAvblR3MnVRVnQ4S1VsSEpnKzFmYmgyM0VHUldDVi9CeHZRbEV5RmNw?=
 =?utf-8?B?NklLSElRVjhBY2gwQUxqazF2U3RTY1dtdWlleVNPNHYzbGlKQWJ0VW5BTjBQ?=
 =?utf-8?B?QmlSbk9ha21ZeTRLNkpTUEg5eVpYd210TC9lcW8zUTduYlh2Yng5ZTY1czNm?=
 =?utf-8?B?NHBJTXNaVzRkTE94bnFPdUQzeGRPWjl6dk9uQ1cxNlBGR050RXB1Z2xlc2w3?=
 =?utf-8?B?NENweG1oMjZBaWJPaUI5NHVDUytLVWZnY0VpWnNlV1JRK1R6YUlhSGh4M1Fr?=
 =?utf-8?B?anRmaVBCT1B4OGtSV2xaTDdPc0ZjZXNGNCsyY3pXN1dRQ050QmIwK2xpMG5a?=
 =?utf-8?B?cG56TVVSYW9YMDd0Y0dNYkovTFkzRkJoUXZNWFZGR0ZGUDdpSi9IMUJuRWJM?=
 =?utf-8?B?T0FTVUhoQVg2RUFKdThlNUwxbXRNRnlVMW5pY1hncEo1aTRaY1MzeW5yeEhZ?=
 =?utf-8?B?ZXVoQVFGR29jczBYWXdxRVRXZXk0MjJXZFpYREpkMk92amtGZyt4Z3djMXVG?=
 =?utf-8?Q?atnggM34o5d9wmQ/Hm2jITPavPPhbcMg1cg3B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2321FE5A3C1742429AED9EAA5DA7B402@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bf3b13-f9ea-4793-44fb-08da4202c672
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 06:08:11.2623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOdwOo6R4NW4bSC/6JSwVfTWzHTMmCrSG7as7QJlWjWnqc2kNzwDWBrUae134PHklhvpAFqz3D6ZmZXnbNB1g5B40X6i8m6NpLuo4RlEYBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2044
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDMwLzA1LzIwMjIgw6AgMDE6NDYsIExlc2xpZSBSaG9yZXIgYSDDqWNyaXTCoDoNCj4g
DQo+ICDCoMKgwqAgQmVsb3cgaXMgdGhlIG91dHB1dCBvZiBkbWVzZyBhZnRlciByZW1vdmluZyBx
dWl0ZSBhIGZldyBvZiB3aGF0IEkNCj4gYW0gY2VydGFpbiBhcmUgdW5yZWxhdGVkIGxpbmVzOg0K
PiANCj4gW8KgwqDCoCAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA1LjEwLjAtMTMtYW1kNjQNCj4g
KGRlYmlhbi1rZXJuZWxAbGlzdHMuZGViaWFuLm9yZykgKGdjYy0xMCAoRGViaWFuIDEwLjIuMS02
KSAxMC4yLjENCj4gMjAyMTAxMTAsIEdOVSBsZCAoR05VIEJpbnV0aWxzIGZvciBEZWJpYW4pIDIu
MzUuMikgIzEgU01QIERlYmlhbg0KPiA1LjEwLjEwNi0xICgyMDIyLTAzLTE3KQ0KDQo+IFvCoMKg
wqAgMS40NjU2NzVdIGJueDJ4OiBkaXNhZ3JlZXMgYWJvdXQgdmVyc2lvbiBvZiBzeW1ib2wgbW9k
dWxlX2xheW91dA0KDQo+IFvCoMKgIDEyLjA3NTkwM10gYm54Mng6IGRpc2FncmVlcyBhYm91dCB2
ZXJzaW9uIG9mIHN5bWJvbCBtb2R1bGVfbGF5b3V0DQoNCg0KVGhvc2UgdHdvIG1lc3NhZ2VzIG1l
YW5zIHRoYXQgeW91IGFyZSB0cnlpbmcgdG8gdXNlIG1vZHVsZXMgdGhhdCB3ZXJlIA0KYnVpbHQg
Zm9yIGEgZGlmZmVyZW50IGtlcm5lbCB2ZXJzaW9uLg0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlIHlv
dSBhcmUgdXNpbmcga2VybmVsIDUuMTANCg0KWW91IGhhdmUgdG8gdXNlIGJueDIgbW9kdWxlcyBm
b3IgdGhhdCBleGFjdCBrZXJuZWwuDQoNCg0KQ2hyaXN0b3BoZQ==
