Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD397483D12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiADHkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:40:00 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:35202 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233743AbiADHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:39:43 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 73F3EC569D;
        Tue,  4 Jan 2022 07:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1641281982; bh=5ek6FBgVLiJIR90IVvhbTC9FACJZTuGPleJk8KprTeE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XyaYqxQ0QZ87S2SN9eobmLppBiC75wVP7IAqhIrUzZtDBXcv7o/N2dU5sGIwh2grO
         eJtgb8g+41AF/KoJBu9fsQqhsQ7lUISrxeuwtrDon9LZrNEbcMCc9Mtm6YWm5MpwkP
         G9Oa+1OsoDY73wui8Jf1kHB3G4Qck5hVjsWXEOb7U3olgSp8BNfLpr6+b/ybT0kqMX
         99POaJX5zZX5P+Sj7FBhs7PgAT/kqoSgRIWSkVsYfpwXT8+q5NtR5+8HgYYy19rA2d
         v0J/jApRynMMROSeQWADfNA08BOIqnQuXH+u0a24Aq141DOVjuhsta40cNWo1BoOwZ
         kMsHs2Lh6Y4Xg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 602D3A0063;
        Tue,  4 Jan 2022 07:39:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C72CE400EE;
        Tue,  4 Jan 2022 07:39:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="jqSDpEPW";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwOWL+rvuWcf1QZCc0wa3+lCWfdr3Z0tsBsYtaoxlKGAGeJYM4sxDQQOtzy9yB/1DT3TqZaDQdWG9wyZw8X3QgaAwXOIbNX1tnNYmNxUG4CvDidTNCFGgU7hA5ZthbEEY0UQqTfWwhTrt+7+7K1iV1b+w8+zFwtj6tR7ImnyKtnn+Hnw6/ZYA02MngXLGxt5Eha7WQ8Mujhi3Pa9tNc7OTj9F2uU0Fjt5NhNs2IrkUKQwdJ21EhAw6YlUNiqgjGhA25SAhKR7fEDE7u0kQt0q3JTyg57wOg/NdDPOEdVhtzWMh9O+ThPiu/NwFBqK8azOKVafWyHXN/V/fMMqObA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ek6FBgVLiJIR90IVvhbTC9FACJZTuGPleJk8KprTeE=;
 b=aWCq5foIXkEWYWh3DC89X5oMXqkrCJ7fFDnaFpX3xiM3sq269NEmqGnNgdgQ8k7GEg+W2XekV9lHqjFGxGrNGIwrWMJJgTmO8n6jLIBwAiIJ5U4g+8r/XilBLW4Qn3lhV9WKiHjNwku+TjrsvUdaBKh958r0Fi1M3h56hQJzhtlmMku9W2j3PGnj9NEau4SvwySSwoIUYNsYKykAOKL9ihn2hgNiJ/vrjZMjC2APrNypC+8OBp5Ep1TjGFVeNFrZGAmR59b+vvu1EmvPa/X5F93FEXM+NsOrXtbNv2iUQU0Cln9HQa6iY5T7khgD+ZVbW5JoHirXc2U+uIIPKoixpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ek6FBgVLiJIR90IVvhbTC9FACJZTuGPleJk8KprTeE=;
 b=jqSDpEPWbdZGbm+X2XKqIhYPx9h+xtVpdqj0G/dvfZEbNkjS2Pma8s2P6lHX494NETeol5aa6Bzt/F6yDu2UhV1feB7VLQHdA9CWjDR/CMRy2Z3Cp3TdqJt0S82CYlOKAp8tRFfyH9M2CS1NR8ToGfSbYG18cchwY3KzKodyNU8=
Received: from CY4PR12MB1176.namprd12.prod.outlook.com (2603:10b6:903:38::16)
 by CY4PR12MB1544.namprd12.prod.outlook.com (2603:10b6:910:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 07:39:37 +0000
Received: from CY4PR12MB1176.namprd12.prod.outlook.com
 ([fe80::e969:768a:bcd2:dcc2]) by CY4PR12MB1176.namprd12.prod.outlook.com
 ([fe80::e969:768a:bcd2:dcc2%9]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 07:39:36 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Simplify a bitmap declaration
Thread-Topic: [PATCH] usb: dwc2: Simplify a bitmap declaration
Thread-Index: AQHX99BoK/pAvt2fXEiM0XZA8lGnl6xSjNAA
Date:   Tue, 4 Jan 2022 07:39:36 +0000
Message-ID: <5b85b365-aa75-03d0-ff24-f70d19a8d60b@synopsys.com>
References: <a2bf604d26dbe9816fdaae0faf4b4837ecacc6d3.1640245180.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a2bf604d26dbe9816fdaae0faf4b4837ecacc6d3.1640245180.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21072fd0-b6bf-4391-697b-08d9cf555bd4
x-ms-traffictypediagnostic: CY4PR12MB1544:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1544AF38DAC5627E982430F0A74A9@CY4PR12MB1544.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:73;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IV3bIM3rxzSNlSMQfcp7l+jPRYirxgPN7+xrMxBHJZj9xfM/Z9ECDAfTJOHvT5ruV+XJ0cLmJmB1DOurH2jIkctRNSqgNxJ09C9oF0nfSd4Tm1bwURDkvRYKqKlrU6q6Cd5T/T6d9Fs7VkprmzdfV0rf5tpnJSLVMF7qY8yyare7gbBFEab02FsLxHFgSX965sOEERHRe6qulH7wTHq4tYbjZKqXcXAzdw3zce7MtyNXP8SAOdDFIFXzx/AhEmFs8cQjsIwlLcQY4HVi3SP6bU9tUhqUqIsEGOxbjV6eC/YWwPdKe6LUMG+5rNI5YqrUOK2VrunXZOtV1gKxcy7EUUSTJoWch+hZwC0Z8LHull5W5D7HzLumjmRrxog+VLpYfbbOw6UBzFI5UlIzsSkeCE1/+BJ2LYtoutFko8KIg7XKmeHCXE+K6ONeyvlMDMKSf7ko2bJrK63+fwDu1aCeEgwAzSznEZKw+e9pzN2apfJqqMp/qKSHcS61EEoujTi1WjpGv3Yj9nzqs4jQ4niwJy8dj6MHIMgE6EeIQu5G72NeWjFVa8IZHWDq5Qo6aMCCn/gRlN8GnlF4YGSSLqVuSfttCHo+DiermeMgXZrkjFGcLlCYB5IeONRdydPea/yEunLxpLWKNfqVxeW/lDGJ4pPy+tP47xoJh9mbKWb2z8w86HtoQNMieaPnxTl/O5nEcCBomcFnjOJwVjLZb1ah5FPWrL0W6d5uT5dGM29wEJE1lKEeFo+sOQEnszSKr+uAUYVM4On37dVoUHipaooofA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(71200400001)(66556008)(6506007)(8936002)(38070700005)(54906003)(508600001)(8676002)(4326008)(316002)(76116006)(2906002)(6486002)(110136005)(66476007)(38100700002)(53546011)(66946007)(122000001)(64756008)(66446008)(83380400001)(31686004)(26005)(6512007)(31696002)(5660300002)(36756003)(4744005)(86362001)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFk0a1VDejFGWlJuZXhxYXRGbGRNemREYU5leTYxbjVnbllWYjRmQ2VicGh5?=
 =?utf-8?B?NDA5SlV1Z2tNSlVENVgxQ29GL1FKYTZzNUVPQTdTU1phZHJ1bnpaeU1zTDVK?=
 =?utf-8?B?V2RqSGFvWWRlam5ISjA0aE9RR1lhaGZHQXpNTlVBZkhPdXY2L21Sd2lkRytk?=
 =?utf-8?B?K2pqL1FlV2g4TXEyazNPRFp0YlF0YnJBTGRVYS9UTkZSYWtmZFRpWFBWbXhE?=
 =?utf-8?B?T2lRVDByMTRTQ29XM2MxT0VFL1pZb1I5ZS9KRUJ3WGhsdU9jMGhDUlRGbllL?=
 =?utf-8?B?c3hRSU9reTNxQm9tbThWMCtOcWtHTWs5eU9Od0R0SzZwYkZIRUdzbElEb0d0?=
 =?utf-8?B?MXZoN1o3MDRFaG9EanZic2xrWnl2UFdFczljNDIrbWkxaExxWS9sM25ud29m?=
 =?utf-8?B?aU5wbFJ6U3Judm9hdmtubDFtbUo3NldPR285U1h0Wk1USS9vSlZrNlZuNFBU?=
 =?utf-8?B?NGNUQVdXRkNEWHhlUG54a3RvWUJBT1FROXhtWTlyTEwvNW1uVFk4ZHRYRzdO?=
 =?utf-8?B?THhZZmhlTElZYW1ZeFYxNmxyVVFSNFVKMU15WkhiRnhheEFiKzMrOWxRR3Fh?=
 =?utf-8?B?Nnc1ZDlBZTRsL2EvZmZRYU5SaktrQVJoM05mZzVPd0tYUFVFUjVoUkpiU1Y0?=
 =?utf-8?B?V2kzbUVaRC9aZDJJOFJ1QUNxUEEwc0NJODJDYmg0Z1hqREEzYWlpQXN6bksv?=
 =?utf-8?B?KzRkcVV0OHV6c05jTHg5MTFxSEdHSFJlNlBUaExjaXkrWEQrL2lLalZMOWRk?=
 =?utf-8?B?UHlWZWtpdHk0Y0xEYjdxRFNqSWdITlpYdEtlTXFlR2p5c3JZL2hyMm0zM1Bn?=
 =?utf-8?B?U1pIY0FMNExod1JPYXcxeXZFTmM2cU94QlZKNHJsQ3pZUmNSMVRlWUl1Z1E0?=
 =?utf-8?B?NStFcW96UFhDWklYWDJzOGFqQUI3NnAyZWlzRjlHc21XRE5aenBUSzc0UXlQ?=
 =?utf-8?B?cS9ZT3dGNjJwS000YmcyRlJHL1BJQnBpY2JIcHM3L01uSWNCQkQ3YmJoUnZQ?=
 =?utf-8?B?dk5GRUZydkphTGg0N1o3dXZqMm16YUY4anNQSWVEaFdJU0pxdmRlRGJUSXRn?=
 =?utf-8?B?UmxhWTJuOUxRbE5GcGtSRWQzU05ic25Ib0hhZlJ6QlBaYWRkaVBJK05Da2tj?=
 =?utf-8?B?Z1FEdkR0Q1NKU2NobjN6UkVSUEV4QWEzK2NoNW1xaXhLQ0FhVkc3WWFGS2RD?=
 =?utf-8?B?UHJrRUxSMDdSbXpJT1FRUHc2VDVVbDNTYVFkaDFCZkFGT0x0MlpTc1A2TjIz?=
 =?utf-8?B?cmFuNWN4eXVuVXZ2R3hWUnpMdkFuUWVhQ3VyZlZGYUNMeFR1Z2tsRjNzL3U5?=
 =?utf-8?B?Ui9FK3JiWEVZYWY1aTJ4L1hKb0d3TDFFNEtVcU1kL1poK3JuN2kwckxqQ2hU?=
 =?utf-8?B?TWU2SitBWGdBT1VENGtIUHNMTmRaazVlOGVRMnllR2dVdVR2WDI3Ymh1dE95?=
 =?utf-8?B?OWIrRHlpUm1hT0p2bHljOC9SVE8rWFpZNkJCeU85QytiN09PaUdoU0ViWC9t?=
 =?utf-8?B?MnVxRlRvcU9HSVdtWGNseEtEUFE5bjVkVk16RDNjWGt2eUNLRGRhc2JycFE0?=
 =?utf-8?B?WlYyT1c3dkl0VVgraWZHZXpHTzA4UGpVUVB0R2RsTlA5djVraTFycXJBaFNi?=
 =?utf-8?B?SzBkZ1MzcE1tUi9ZTi9Pek1acnVSV3FxNDJRT0N5Z0FTZFBTU0xvQnlJc0FD?=
 =?utf-8?B?a0lLYkxmU0F3RjNvQW9qVVdJMk5LeCtmb3YwQ2pBaW5Ebm91K2MvVHU2QW91?=
 =?utf-8?B?WjdMczFQL2pEdmxqMTQzQ0JZeTZrN0ZhTnZMTHNZUlRhMHBGVzI3MVB1YVp4?=
 =?utf-8?B?aEZ1dkRLeTk5VFNRL3RZVFNkM0hsR0E1a2hJZnAxMFpvbDdldUg4ZmoyeFVY?=
 =?utf-8?B?cENSOHlrc3pxODFQV1pxSTl6VElBZnJMMnQ0ODBuMVgvMWNWWFFIcFVEbHZX?=
 =?utf-8?B?d29tTXNzelp5UFdudGx5cG4vRkU3cERIa3AwNWl2cGxINGY0NmdYWlpmSlJo?=
 =?utf-8?B?enZuaVpnT3BqcDNsMldOVGhscDU2Sm9EVkV5T3dJelVxbHg4VVBiNkNVQnNE?=
 =?utf-8?B?cTBSbUpmaGxTU3ZKOGxpaFBmU2xyZmZISWNiS3dINmZlTTIrbXhNZWJWd2Zj?=
 =?utf-8?B?ZUNZLzVGMEtGY2p0ajVQQ2doK0N3SFdpb2UrNGl1UTgvYzFsek9rZXRIcjNy?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F18A4952A96B8F40AEF312BD659F866E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21072fd0-b6bf-4391-697b-08d9cf555bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 07:39:36.5734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6YadF9tKbTUippUrAYEY1YUqo+WAj1YSQzwH8Ywud28sXJ0nGIpPVYPXLQGftV3gI/VFmkh2sa3N7DKo1+XcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1544
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjMvMjAyMSAxMTo0MCBBTSwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBVc2Ug
REVDTEFSRV9CSVRNQVAoKSBpbnN0ZWFkIG9mIGhhbmQgd3JpdGluZyBpdC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28u
ZnI+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5Ac3lu
b3BzeXMuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvY29yZS5oIHwgMyArLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2My
L2NvcmUuaA0KPiBpbmRleCBlMmZlNjQyMzkzMjguLjhhNjNkYTNhYjM5ZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMi9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9jb3Jl
LmgNCj4gQEAgLTExNTQsOCArMTE1NCw3IEBAIHN0cnVjdCBkd2MyX2hzb3RnIHsNCj4gICAJc3Ry
dWN0IGxpc3RfaGVhZCBwZXJpb2RpY19zY2hlZF9xdWV1ZWQ7DQo+ICAgCXN0cnVjdCBsaXN0X2hl
YWQgc3BsaXRfb3JkZXI7DQo+ICAgCXUxNiBwZXJpb2RpY191c2VjczsNCj4gLQl1bnNpZ25lZCBs
b25nIGhzX3BlcmlvZGljX2JpdG1hcFsNCj4gLQkJRElWX1JPVU5EX1VQKERXQzJfSFNfU0NIRURV
TEVfVVMsIEJJVFNfUEVSX0xPTkcpXTsNCj4gKwlERUNMQVJFX0JJVE1BUChoc19wZXJpb2RpY19i
aXRtYXAsIERXQzJfSFNfU0NIRURVTEVfVVMpOw0KPiAgIAl1MTYgcGVyaW9kaWNfcWhfY291bnQ7
DQo+ICAgCWJvb2wgbmV3X2Nvbm5lY3Rpb247DQo+ICAgDQoNCg==
