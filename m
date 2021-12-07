Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6F46BAAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhLGMIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:08:52 -0500
Received: from mail-sgaapc01on2130.outbound.protection.outlook.com ([40.107.215.130]:15584
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236039AbhLGMIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:08:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD2bsTwSfDUQbLfPhIxDu0lqHcP2gjUsXkxq3ZBtGTPf//dAhlPkQKqbkfdwKIKH0KZS4H9APH149QZIhXtZ7QjjhfVXQi1Zr6ie3a2y73kAvLjPhPfCTpRavqKjo2s4lIJUeD7S4DP7jOmIwWqE6axYsbHvKg8GK7+GP1fnorVeEsLfw/U1nxvgoej9emjgJGpxR8Nun2P0Vwk4yWrwLpuD00ljPqqEfw4x/n+Gb2uqqlGIQZLz1mkfMlOn7T/0EyyiwC7rowtEelZ8T/LPV9nHrjo496ikl7AGVz07jAQhFnr8b/q2cenVU2fZ7WtjtngqM8YZ32He8/plViZk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng6Uy0jZc3r0iNeKVCesX0JPtFJ59cVJNk0oZ58tZ7w=;
 b=Zw4c65VPk3ajWsrbZ9NggPTUK8E5EpR8KZU1f20SRwBluHz4ywaXGf6ceFHJNjSGRaA76lQWk71D6S+AGydmFtKPtBfIGMfKTq8JehRnXK3cyR00vjG4srqyI6+OeT2BLYAeOxIvViYjqkTUS1QR0olSSKJZxZsJZiEk4wZQUwnLk5bNg2faxZFeLBgUb7iZYPLEFcuf48hg5LpM3XgAIS3eXmcJWEPy11Yvtk66tI6+TrVVWCe/t2DVgt6eWjG2EB3hfJeg/5muCJYXRhL6/tXg//TnMQFusBLPjWLEwPA7yda3fZBnBnBa7CN95jkDkCfu7ODj4DyLOV+cX8c1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng6Uy0jZc3r0iNeKVCesX0JPtFJ59cVJNk0oZ58tZ7w=;
 b=iReHjRWoplNm2BIvv2/AAJABZZz7tKiiPyphkAoJ/0Unt1J+GrPyr0CRjtfy/wIfX2E48YhZLtMUgG3hu9gIpzLJgXF4EWyg2k95OpljmNUURrwpcl7Euv1WUZ/IscSiCR87vgYZt7WILTCe2MFOo8dHK4sQWIszXeFLW2G6SzQ=
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PSAPR06MB4200.apcprd06.prod.outlook.com (2603:1096:301:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 12:05:16 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 12:05:16 +0000
From:   =?utf-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHNlY3VyaXR5L3NlbGludXg6IGZpeCBwb3RlbnRp?=
 =?utf-8?Q?al_memleak?=
Thread-Topic: [PATCH] security/selinux: fix potential memleak
Thread-Index: AQHX5y2UpLPZ1mLEK0WY9KpnB8iyAqwlNWwAgAHA/vA=
Date:   Tue, 7 Dec 2021 12:05:16 +0000
Message-ID: <PSAPR06MB4021F9C68B02C5BE190D0000DF6E9@PSAPR06MB4021.apcprd06.prod.outlook.com>
References: <20211202033447.253596-1-bernard@vivo.com>
 <CAHC9VhR0bu-D2yjGkACMNxg34qA4Y75MjVbJpr8FQc=rfLu=pg@mail.gmail.com>
 <AEwAQQDtE0k2IkAkyRQnyap5.9.1638782159371.Hmail.bernard@vivo.com.@PENBRnFaWE52U2NWVmNvbmZmZHFBdWUtbTVVYjExOVB3K3JkU1oyVFhIdC1CRmVWYS1HUUBtYWlsLmdtYWlsLmNvbT4=>
In-Reply-To: <AEwAQQDtE0k2IkAkyRQnyap5.9.1638782159371.Hmail.bernard@vivo.com.@PENBRnFaWE52U2NWVmNvbmZmZHFBdWUtbTVVYjExOVB3K3JkU1oyVFhIdC1CRmVWYS1HUUBtYWlsLmdtYWlsLmNvbT4=>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87a4773e-63ca-43ac-f4fa-08d9b979d506
x-ms-traffictypediagnostic: PSAPR06MB4200:EE_
x-microsoft-antispam-prvs: <PSAPR06MB420071E29A89E2F680781B29DF6E9@PSAPR06MB4200.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pwjnLpRXHPuT+TeA/R36PIQC+elAC/6znEzJqFDMgsgCpzCZpA5sIYPv+QjqatO+gsaMOmCWqhalq2Bhy1i3umUIROoyRj5kNMz5Rxdj8WoJDOa7Ns80YZn++Losa8skyZG/7tdJ2gr0iBVWBDTyAGcejjCQ8ArsuGfNMz9vyBoUE+/T2RJvyzPVJEVaVNE7nJi8WuTEGQLmy2SOePQHHVh9T1QcLbwaP3ui2kNJ4/R4W+OzcJPlZ5l24Wls5MtIoslXXnLq22ZyeF/hI4Qg6sMNCm3jhIVFLyaoaqeS4lYuGvxG2XFfsx33PaxyQgC35bgeZsbN7HdWwGPCFkwuDXpQsoUDkQjkRCy7chNnUBxg1aZm2wMusexq9zbKB20uAQOCDFfKa8d+DTE/M8gYLC7kN/CqggZtaSemUiOeIK29MZNQrbfIvgAKX9wwmxOS83yPFwM2WhM8xihd82pfYQ+2Lt2xx5u/qCIbQKMK2Msi//SVhIQpYaY3VHFsS2ejx0N7p++Vd3jVORc/eIry91RMuXkCFa8PVO/Twd2kwyedndNHrNu3PXjzjYq4rDsUO/5vKCHQHO0rV27pOV9nMEzH3ylC4u0RoOe2peAEGRuYnTGH2TMx7uABInkAGsdXUX5hXmofGp5AEfVNk/b0hXWtH9JIxgyqKAivVD1nZoD/A1hXLtZHFI9RSjpwtTR3pPcC2w4qRT0dkfHsw8VAMA12Ig0OneLJ5Owf/QY6BB1BNiDDqZBNdMr807OG342hRfjdwe0PT1ZWu1XQIoqeKWLx5Ocn77MxrAnldkp18E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(83380400001)(54906003)(15974865002)(38070700005)(71200400001)(85182001)(52536014)(316002)(26005)(86362001)(15650500001)(7696005)(110136005)(66476007)(33656002)(76116006)(6506007)(8936002)(53546011)(66556008)(64756008)(66946007)(4326008)(2906002)(508600001)(5660300002)(224303003)(122000001)(38100700002)(66446008)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkZzS2xQSzFWTnZnZjYwcHp3bGJ4eWl1ZUtMZHIzVWNjUU5nVFVMeWthWnNy?=
 =?utf-8?B?WlEwUlMvblhUc1ViR3BuOFVhTFhKZUc3SUxPbzFQQStHRDNPTWkzZFBJWWM5?=
 =?utf-8?B?QWp1SVY1ZXVpeis5cCtsNTRTL1VIR0VzVC91NlVLRG00d1Fma3ZhNitPNGs4?=
 =?utf-8?B?eVR2dWRVK2NqVlMyMGRMUllmN1Y3UnNJRDhjZHdqT0dQYlpTdTF4ZFh4S0hK?=
 =?utf-8?B?b1l6ZERPNnBaOWRRRG5UTkE4K2tLVUE2MzNsWVkzVGxiZHc1MEFMVEM2THpS?=
 =?utf-8?B?UjVQKzJTVyt2bDhsOUJtV0h5dWFxc1hrNHdHNGh3Mk95TjhoK3IzN3U1NDBo?=
 =?utf-8?B?d05wUStrS1V6NkdsMUlVZllGRzB1b05paFFiS0NHclV1UjhrSmFMNHdFc3Vh?=
 =?utf-8?B?L3orQzJGT2szRVc3M1pJSGlTbGVQUm5ESU5rWERQSm5lak81d3JOVUEwbWdp?=
 =?utf-8?B?clhaMEV6TzNyWk9kRUFmbzFtME1zZXhjL1V5Rnl3RVpTVzNKSTIyYUxwVkpI?=
 =?utf-8?B?SkR4OWV5QUxUaFBaNWppcHR4b1dyNDBwaHc4OTlsYzBYUXdVRnh4WDlCL01C?=
 =?utf-8?B?cTJwdHRYS01ROUhGNXorK2FWMXUwSHZPc0JLdVlpMy9IbkhoRFBRNWtaaklW?=
 =?utf-8?B?R0lDQm1ITVNoUTlvcVprSHNDMWlDNERsVU81bk9zTkY5dDJMRXp3STFlVHB0?=
 =?utf-8?B?Mnd1cFA0SFkvZDc2SVRYYTh5T1BJb1A5VUdTZ1NjcExWcTRKTHRXaEZuMXNL?=
 =?utf-8?B?YWZTWnZtbkUwWjBJdXVGWTlsNzd5QXQyRHZHZHg2Kyt3NEVkdUoxdW1SSkJr?=
 =?utf-8?B?RUZIdlZhV1YrWTZTb05KaXpuSFFJdnYyYXRpL3huU2dzVUd1NDdROFNrVUFN?=
 =?utf-8?B?bVkzdXQ5SlVORFFFOXRoVWVROVkrc1VoSjN4TkZZTmVTMzV2cWZSQ01oVEVF?=
 =?utf-8?B?NmF2b250Um1Ub3JERG9HNWh2YThYQlo0ckVuamkyQVRmaEVZZHhsWXZWbzVj?=
 =?utf-8?B?d3hjR294ajFYRWNWb25XcEdTNy9DVTM3T1BGTENVNm8wdFo0ayt6Zjk3VnVr?=
 =?utf-8?B?R1VNeEM0NW5mTlVLcGkzUlRJMzdrU0N2bGNNakdNVC9XY21wS3l4SkIwRjRG?=
 =?utf-8?B?UFAvNGJoRnhKdzBtUzdCTDRkaU04ZDFrYllCbFAvOVFCakRIVlJjTmZxSkF3?=
 =?utf-8?B?V3JydTlVQ2hNY3VvYVhjVURtbm5iMFFJN2psMG9JK0dzeDZmbVNwVGtodXEx?=
 =?utf-8?B?dnpqcGNBbEJqSmVidkhOVmxmZWVCRzVDK1ExeGRoRFM3NVlzalloNG1CV2lO?=
 =?utf-8?B?aWphR2tEZmhUU1hzMHFSYytLN0xYWXF5RXdQVmJ6UWlCc3dmdys3ejVKdnIx?=
 =?utf-8?B?RFZqeWlVQU1sQlhnKys3SFBGcE44dWFPYnpBRFNPbzdkc3U5VHc3bHlNY1Nm?=
 =?utf-8?B?aUhiVUxSRi9ONWZHNnArZ0dVdGtQMUdGR0VwZ2c4RmVoenphaTdBZGNiRG1q?=
 =?utf-8?B?dGpjc1VvVTEvVjlLcEJEZTZLRHpKM2ltK0RJWWxSandqQkpIRWRVeVJDUzZD?=
 =?utf-8?B?c1drWEFxT2g1T1VrY3paUWpFM3QySW1xdmtqU1BiSjQxcTZMY3k3S0hIbXdp?=
 =?utf-8?B?bW5KTHMwK3pXb3JhRzRQUC9rRGJrY0I3cVFRck1jSTR0b1dEREJEM3lJVGNB?=
 =?utf-8?B?cUw2dEo2RDl3WmJnWFN0Ukt4d1JaUHBPakdHVTZDbTZ6UnQ0eitrYWVEbTAr?=
 =?utf-8?B?RlpVUnhTQ0RqT2sxVHdVNW1SRm5PV3g3VGxqNTRScjU0WUt1eUdLTyt5a2JE?=
 =?utf-8?B?dGlGWWxYUjhtc2Z3WStMdEU2akpPdURPV3ZoMnN0YVJVakdEMmloN2VBb0xy?=
 =?utf-8?B?cEhrbXNURXZud2k2NFhJbkUvYUVVT080bDlkUis2elhLKzJIMG94enhXRzJk?=
 =?utf-8?B?eXo3WUpHMXdRbjZpWENNVmF4bmlzbnZLSjM1dmE1VHYvU3Z1M3EvSnNzL3lB?=
 =?utf-8?B?bVZneWd4QjA1S054a2crYXdCUTQ1TnIrSXFDZHBpVjJzRG1Pb1FuSjdMWWNM?=
 =?utf-8?B?QWV2K2NZUk5BSjA4VEVhd0ZGNXcwWHlRdzZkR3QxMHRrMGRaMVFESHAvbFdk?=
 =?utf-8?B?aUpGSTg5WW5tRVdDd2hVVVJ2R2V0a2creCtpblJOSm5nQi96ZmxGdjBHbTRE?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a4773e-63ca-43ac-f4fa-08d9b979d506
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 12:05:16.4414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3M7uhEw9qgSKcWA++jubif1PtyU5GRXwBrXwQx2SWlMykXBz3exDpWbduCvGusA9XHt0NKmz3LLoaahKSX9cJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBiZXJuYXJkQHZpdm8uY29tIDxiZXJu
YXJkQHZpdm8uY29tPiDku6PooaggT25kcmVqIE1vc25hY2VrDQrlj5HpgIHml7bpl7Q6IDIwMjHl
ubQxMuaciDbml6UgMTc6MTYNCuaUtuS7tuS6ujogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3Jl
LmNvbT4NCuaKhOmAgTog6LW15Yab5aWOIDxiZXJuYXJkQHZpdm8uY29tPjsgU3RlcGhlbiBTbWFs
bGV5IDxzdGVwaGVuLnNtYWxsZXkud29ya0BnbWFpbC5jb20+OyBFcmljIFBhcmlzIDxlcGFyaXNA
cGFyaXNwbGFjZS5vcmc+OyBTRWxpbnV4IGxpc3QgPHNlbGludXhAdmdlci5rZXJuZWwub3JnPjsg
TGludXgga2VybmVsIG1haWxpbmcgbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4N
CuS4u+mimDogUmU6IFtQQVRDSF0gc2VjdXJpdHkvc2VsaW51eDogZml4IHBvdGVudGlhbCBtZW1s
ZWFrDQoNCk9uIE1vbiwgRGVjIDYsIDIwMjEgYXQgNDoxMiBBTSBQYXVsIE1vb3JlIDxwYXVsQHBh
dWwtbW9vcmUuY29tPiB3cm90ZToNCj4gT24gV2VkLCBEZWMgMSwgMjAyMSBhdCAxMDozNSBQTSBC
ZXJuYXJkIFpoYW8gPGJlcm5hcmRAdml2by5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRj
aCB0cnkgdG8gZml4IHBvdGVudGlhbCBtZW1sZWFrIGluIGZ1bmN0aW9uIA0KPiA+IHNlbGludXhf
ZnNfY29udGV4dF9kdXBgcyBlcnJvciBicmFuY2guDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
ZXJuYXJkIFpoYW8gPGJlcm5hcmRAdml2by5jb20+DQo+ID4gLS0tDQo+ID4gIHNlY3VyaXR5L3Nl
bGludXgvaG9va3MuYyB8IDIyICsrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jIGIvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5j
IA0KPiA+IGluZGV4IDYyZDMwYzBhMzBjMi4uMzZkN2ZjMzczODM5IDEwMDY0NA0KPiA+IC0tLSBh
L3NlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L3NlbGludXgvaG9v
a3MuYw0KPiA+IEBAIC0yODU2LDI0ICsyODU2LDM4IEBAIHN0YXRpYyBpbnQgc2VsaW51eF9mc19j
b250ZXh0X2R1cChzdHJ1Y3QgZnNfY29udGV4dCAqZmMsDQo+ID4gICAgICAgICBpZiAoc3JjLT5m
c2NvbnRleHQpIHsNCj4gPiAgICAgICAgICAgICAgICAgb3B0cy0+ZnNjb250ZXh0ID0ga3N0cmR1
cChzcmMtPmZzY29udGV4dCwgR0ZQX0tFUk5FTCk7DQo+ID4gICAgICAgICAgICAgICAgIGlmICgh
b3B0cy0+ZnNjb250ZXh0KQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5P
TUVNOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZzY29udGV4dDsNCj4g
PiAgICAgICAgIH0NCj4gPiAgICAgICAgIGlmIChzcmMtPmNvbnRleHQpIHsNCj4gPiAgICAgICAg
ICAgICAgICAgb3B0cy0+Y29udGV4dCA9IGtzdHJkdXAoc3JjLT5jb250ZXh0LCBHRlBfS0VSTkVM
KTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKCFvcHRzLT5jb250ZXh0KQ0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZXJyX2NvbnRleHQ7DQo+ID4gICAgICAgICB9DQo+ID4gICAgICAgICBpZiAoc3Jj
LT5yb290Y29udGV4dCkgew0KPiA+ICAgICAgICAgICAgICAgICBvcHRzLT5yb290Y29udGV4dCA9
IGtzdHJkdXAoc3JjLT5yb290Y29udGV4dCwgR0ZQX0tFUk5FTCk7DQo+ID4gICAgICAgICAgICAg
ICAgIGlmICghb3B0cy0+cm9vdGNvbnRleHQpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FTk9NRU07DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfcm9v
dGNvbnRleHQ7DQo+ID4gICAgICAgICB9DQo+ID4gICAgICAgICBpZiAoc3JjLT5kZWZjb250ZXh0
KSB7DQo+ID4gICAgICAgICAgICAgICAgIG9wdHMtPmRlZmNvbnRleHQgPSBrc3RyZHVwKHNyYy0+
ZGVmY29udGV4dCwgR0ZQX0tFUk5FTCk7DQo+ID4gICAgICAgICAgICAgICAgIGlmICghb3B0cy0+
ZGVmY29udGV4dCkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9kZWZjb250ZXh0Ow0KPiA+ICAg
ICAgICAgfQ0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtlcnJfZGVmY29udGV4
dDoNCj4gPiArICAgICAgIGlmIChzcmMtPnJvb3Rjb250ZXh0KQ0KPiA+ICsgICAgICAgICAgICAg
ICBrZnJlZShvcHRzLT5yb290Y29udGV4dCk7DQo+ID4gK2Vycl9yb290Y29udGV4dDoNCj4gPiAr
ICAgICAgIGlmIChzcmMtPmNvbnRleHQpDQo+ID4gKyAgICAgICAgICAgICAgIGtmcmVlKG9wdHMt
PmNvbnRleHQpOw0KPiA+ICtlcnJfY29udGV4dDoNCj4gPiArICAgICAgIGlmIChzcmMtPmZzY29u
dGV4dCkNCj4gPiArICAgICAgICAgICAgICAga2ZyZWUob3B0cy0+ZnNjb250ZXh0KTsNCj4gPiAr
ZXJyX2ZzY29udGV4dDoNCj4gPiArICAgICAgIGtmcmVlKGZjLT5zZWN1cml0eSk7DQoNCj5BbHNv
IGhlcmUgeW91IG5lZWQgdG8gYmUgY2FyZWZ1bCB0byBub3QgZG91YmxlLWZyZWUgZmMtPnNlY3Vy
aXR5Lg0KPihQYXVsJ3MgcHNldWRvY29kZSBiZWxvdyBhbHJlYWR5IGNvcnJlY3RseSByZXNldHMg
aXQgdG8gTlVMTCBhZnRlcg0KPmZyZWVpbmcuKQ0KDQpIaSBPbmRyZWogTW9zbmFjZWs6DQoNClRo
YW5rcyBmb3IgeW91ciBjb21tZW50cyENCkkgd2lsbCBtb2RpZnkgaXQgYW5kIHJlc3VibWl0IG9u
ZSBwYXRjaCwgdGhhbmtzIQ0KDQpCUi8vQmVybmFyZA0KDQo+ID4gKw0KPiA+ICsgICAgICAgcmV0
dXJuIC1FTk9NRU07DQo+ID4gIH0NCj4NCj4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGlzIGEgcHJv
dmlkaW5nIGEgcGF0Y2gsIGhvd2V2ZXIgSSB0aGluayB0aGUgDQo+IG1lbW9yeSBjbGVhbnVwIGNh
biBiZSBtYWRlIHNpbXBsZXIsIHNlZSB0aGUgcHNldWRvIGNvZGUgYmVsb3c6DQo+DQo+IHN0YXRp
YyBpbnQgc2VsaW51eF9mc19jb250ZXh0X2R1cCguLi4pIHsNCj4NCj4gICBmYy0+c2VjdXJpdHkg
PSBremFsbG9jKC4uLik7DQo+ICAgaWYgKCFmYy0+c2VjdXJpdHkpDQo+ICAgICByZXR1cm4gLUVO
T01FTTsNCj4NCj4gICBvcHRzID0gZmMtPnNlY3VyaXR5Ow0KPg0KPiAgIGlmIChzcmMtPmZzY29u
dGV4dCkgew0KPiAgICAgb3B0cy0+ZnNjb250ZXh0ID0ga3N0cmR1cCguLi4pOw0KPiAgICAgaWYg
KCFvcHRzLT5mc2NvbnRleHQpDQo+ICAgICAgIGdvdG8gZXJyOw0KPiAgIH0NCj4NCj4gICAvKiAu
Li4gKi8NCj4NCj4gICByZXR1cm4gMDsNCj4NCj4gICBlcnI6DQo+ICAgICBrZnJlZShvcHRzLT5m
c2NvbnRleHQpOw0KPiAgICAga2ZyZWUob3B0cy0+Y29udGV4dCk7DQo+ICAgICBrZnJlZShvcHRz
LT5yb290Y29udGV4dCk7DQo+ICAgICBrZnJlZShvcHRzLT5kZWZjb250ZXh0KTsNCj4gICAgIGtm
cmVlKG9wdHMpOw0KPiAgICAgZmMtPnNlY3VyaXR5ID0gTlVMTDsNCj4gICAgIHJldHVybiAtRU5P
TUVNOw0KPiB9DQo+DQo+IC0tDQo+IHBhdWwgbW9vcmUNCj4gd3d3LnBhdWwtbW9vcmUuY29tDQo+
DQoNCi0tDQpPbmRyZWogTW9zbmFjZWsNClNvZnR3YXJlIEVuZ2luZWVyLCBMaW51eCBTZWN1cml0
eSAtIFNFTGludXgga2VybmVsIFJlZCBIYXQsIEluYy4NCg0K
