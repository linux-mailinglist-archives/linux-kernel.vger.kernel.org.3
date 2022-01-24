Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22BC49A16F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359986AbiAXXff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:35:35 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:57338 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1838669AbiAXWrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:47:05 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 083BEC0164;
        Mon, 24 Jan 2022 22:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643064425; bh=6cq9XCvpH5YiiVlXL4uU8TKbmMG+7KivPSLE1cQbAXI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hVQxXBABgOusKJ3uwoUjQX5wXPIoVhhffGHiQHMk8PwFzX+mUWy2L2+zzemCz7aN5
         THGQymrm86vjliNBJOdBMKp1+ZVmTGOxKY6vfaaouShZno8sJjZuc8xkWzlrCmKuud
         icWlYnODGaVSob4kwB+sO5dGOzOt0vki0gnHqqMykwDUZpgh75IIbAq0RClCnWBWkv
         2HoP4Ljgwjffgulg43xzE0B7lz+bU0Z7p5uVw3SvQX2+FiPo4k2iAQME4j44ru9TCb
         pUAX/4H1KpNiuaObXpRHd0FYIOKHmes0y8s3Caj3usFmbyHS+CQJWJP4uSXE9MG14W
         4bAaWvouJMkEA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 23B83A0063;
        Mon, 24 Jan 2022 22:47:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DC6F0400FA;
        Mon, 24 Jan 2022 22:47:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="mlxv6qKy";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1FygUunX3xXtR9+bZMIGi7Y+/1sNyYlWVx5p+RRPR0fFERVU5sWtiO82QCMm1ChRL7t9C0T2SwwNk9pmBPinZ0++kaY78+ODQb13Z7Wt5KvjfJQu7SxDq+nHXBlBHSCub4s09VipznkbChbpr+AbPDvmN+AHQAsSloK8W4GrsRxJH3o9DG97jGn4jI1HlQ8CFSSsGVDPx40fWoF82wyXYPKCW/jlPF4cbvePzbOaKVfUeVp5kOXyj3DZDZIEEm8pVJYaPotIZvN2teGyvTZs52UJNVYmcVwRald/SpR8ofn//2CcIsTBE7XCtGoBuBKVPyVYsGfejLmXLK1Q4Vu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cq9XCvpH5YiiVlXL4uU8TKbmMG+7KivPSLE1cQbAXI=;
 b=jkQm86A3R/eNTntGyFeKfPm7+XXZJVKpshiv7k23mmm6ErY8lOdP3atCwbelymkAlMDzmwyHt+muwIHelGppPUw2YMbMncoSxytxROa1W1dEolWBDoaXy+J0/M2hDTPtE9VPx+gkgfc7KImUuu87C/AebwJmgMIMeD3bHe9Iv/7cN5kym1umBFynO/sg4y4D/v+BpcS5kc7slTrH3+7R3RjlSqkHtlfGLJtn2FW4wtS5dKoG8PaYtVsoLu8nR5shGgBlLAkCuJV2eD01gqLZJLlHLfmVwAjjDtlrc810WeuM2kTSH0HbvucL+dfn0BakP3QRVNWABYnZwz9l//3M6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cq9XCvpH5YiiVlXL4uU8TKbmMG+7KivPSLE1cQbAXI=;
 b=mlxv6qKyqZqll7CjY/aomlBNQCxSPZILnTMljODaAqYt7YPO9s0ZDNU51MZ0oMH4/Rx9l9P81w+3iIrCuzC2VMtJQdy2B+6p1fjT25WG8Xi93Psl8iLqoKA1rrQFN0qjBQUSr+oZ7Kd8FHUcBg18i+DrtPRSuPdnR2Z/wBecv/Y=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 22:46:59 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 22:46:59 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Topic: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Index: AQHYDMsCIy0SvjCLEk29RiHsv2qI76xyzwGA
Date:   Mon, 24 Jan 2022 22:46:59 +0000
Message-ID: <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
In-Reply-To: <20220119002438.106079-5-sean.anderson@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18a291dd-c094-46f6-d7c5-08d9df8b6e8f
x-ms-traffictypediagnostic: BY5PR12MB4130:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4130716121DF85252C99D8A5AA5E9@BY5PR12MB4130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: brxqYK+nP2fNQFGRYVuRF/1MkNj5MwH0plIEsQy1xUeKtk3IUM6uk0r+JwxaBuL/7WCrGrw69L8akKkEYD8fwYvH5Eke+f7VNVDYVinqYVvS2+Z0eH4nbsoLMa5u812mjOlsq7Y5rCCCLolGf9War740Bf522n7Hc6HhofSvPu7jWx6VuMulUKrxugaacixKqrGAoYkfBsaX3hnyTqxPl62zhAJhLOuGUmN1JXysCM0xcqvfFjA90jFfVY4R91hYf336LpAi2zz6sTaD/v9uWWSHNcR53YGJgU1DX59iIQ/onKmTtaDYCmfa3HKWJqVC+zlC2NPJppTL5xba39bz38aSiiE3bisxjdpPsvjT5MG6QA6spuiu3YZts+xEePL7DrBCyxaRSIVLfGwuzNWNzTOBki9cqDKANUtB5DBH8L0yMG+2/DrxKQ/M4xLSgHZVFSJ/VGkQkd+TiTWSBRqDtGu29Y05GCTm1gn+ty/F3hrldg7kd1OPnkjYbRuRL9vbMVLg9bJI03kuMTF+tXmZedybDAQss01s57XhkVHC3e2nhMaYFpSsxaXVFca9WhiBhO/6thEhdjVr76+DaAERCfIvAQY3XVozfLRDJKhYAmvVRlEnkV/vYVGtA7YfEOPHMdVADylPHnFUrk2M2NMIvRYh3biKFbQRDCiuJSDltWDqc7YX4000i1oEFd2FZzg1Do+MiHk+17sX1XpGqyFFpxyHBsWpo2Q051X5I6JcxtqLckP52KsD/NhP7OOU5upbmL5QylIET0s3ucCs31vbPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(2906002)(4326008)(6512007)(38070700005)(38100700002)(66446008)(64756008)(76116006)(66946007)(54906003)(31696002)(110136005)(122000001)(31686004)(66556008)(36756003)(86362001)(83380400001)(8676002)(6486002)(2616005)(508600001)(8936002)(71200400001)(26005)(316002)(6506007)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXEzYkQzSEpMZ3J1S1FVSTc5ZEVsd2huS09KRk1iOStaaWJ6MlJuTGR3Snh5?=
 =?utf-8?B?N0hEelZVSk1xU2Z4ZmJZdEtFZVFBcTVCYko4WWpmY3BCK2ZoSW5Ec09ybmts?=
 =?utf-8?B?dVhzQmR2NEpDYnpmd0R5QmZlcHlRMXRnV0w5MldvRVBuRndxNkRWUitpb0l1?=
 =?utf-8?B?Tm5WU0JZdXhZejU5NmVlVDNxUGpzQ1crZnY0NERhY1h5WUc4REYvZ1p0OGcw?=
 =?utf-8?B?bU9sRzBGZ04waEtvR1ZRMXA5Tlh4SnpkMDBBSWl4RlFFMzRLNGpVT1RIdUpz?=
 =?utf-8?B?TE9QeVM3YzZnT0s5TUIvNjI3ZENScmdNdTBVMzNXblpYS1Eyd3orcWhXWmo0?=
 =?utf-8?B?dHEzMmd0WGpiVXRzNkZFSmRWa1RKSmYrbGxWU2ZpREIwUWFQL2N2WWpUSzNN?=
 =?utf-8?B?MWR3dy83YXljR1V0TU9McFFjbEVKR3dZQVdtdVlydlBrSnZReVZ0d2NSL2lJ?=
 =?utf-8?B?Z1RUbThNYk1icE1PQVdnd1ZNaWEyUE83aW1LNEliNC9iUkJTTEhqRUlNa0hT?=
 =?utf-8?B?K3BtU0lENkdFRjdGNkpwMlg0VUdpYXFpWTJTeVNRSm9jUmpHRFlNM3Y4VTZB?=
 =?utf-8?B?S0htMUNNUmhIWWJvRktqMlZUa2Z4QkxMRTBrbkNnTXdycDRZMlFZL2NPUjZU?=
 =?utf-8?B?YmNlL1l3YnJlblV5akNCUm5IZERXM1ZYekpKUFBiUS9MOFh3Z0xlenRuQWdN?=
 =?utf-8?B?TGtWdlhZWTdrUTlRaXd5N01uMW5VbGdSWnhmcUxSZ3hsZGdlSERDOEdiRHN6?=
 =?utf-8?B?WlJES3NaeU5WM0FPUnhzcmZyRFBoMEZNL2lGK2ROQkl2aVNQV0NldjdhWnVo?=
 =?utf-8?B?dEE5Ynp6Z3I3QktqTWgvemM1U2svMGVuN1JhN1l6NDBJaWZHdVBYdWROMlNJ?=
 =?utf-8?B?MWwzU3JMNCtBSGpSVGhROERUZVlxOXdaN3poRjh1V0lYcnI1a0lpNWFoYm9h?=
 =?utf-8?B?ZDNpbHBnT1A0Sk5mTGI3akVMODJOK2Q1Y3BRTU8wSVp0YmtZS1dhSkk1V2l5?=
 =?utf-8?B?cUx5V01YV0VsZDVUYkpaYURKQlRCSHFjWDFuMkx3M045T2tkaXNRTFZUdkNT?=
 =?utf-8?B?ZVFKVG1oZmExaG8vdTB5SlpPcVhLYTdrRWsxeGdpVnVaWG00MEtMUTJzVzU0?=
 =?utf-8?B?dnhUemVaTzZPamtnUXIyQ3VmVEJITHlRVEpUbHBOY2VVbEtHWElSNER6YTNL?=
 =?utf-8?B?TlFqRmJuNG5CMkVCYkVDaXI5OVhHYXIva21vKzE1MFpPdEhFaWREWkJibm5Y?=
 =?utf-8?B?WngwS0FLRnZIajZBaXNFUlNnbWFYM0RhVGlTaEJtTkprQ2FhUjI4UHNJTWJo?=
 =?utf-8?B?R3dmVm9LZCs1WmFnTGZDY2pZRzJhTEdzc3NoU2RHV1pKSFVQcGFzQ3NpL0x0?=
 =?utf-8?B?U0VNOXVWaFhzdXBUb3hWSmt6RksvdVRhNXZxbEtVaXZrdnZlM3hSb2xHK2E4?=
 =?utf-8?B?MzVBZnV4cWlwYVVDcjZ3c1ZtUHhNdUdGdVhMTjhVbW5yM05kc3V1SVA0Z0o3?=
 =?utf-8?B?WHdSS2dvQ1lJTHdGdWVPZ2YvR3V3YituL0tsc2crSDZXOTVtV25BM1dZckVL?=
 =?utf-8?B?ZDY3d0daVDVVbVR1UnJMcDN1c0dNbS9mKzAxWm0wRTN6RWF1d1pyUzZ4RklX?=
 =?utf-8?B?MjZTQW50cGk4bW9VMjJFeEFsTGRqdUgwQW93WnpyT05zeEJObkovTWhnUEs0?=
 =?utf-8?B?U0tzTmljTHUwWWVBdmtJL0ZFWVhuRDJBZ1Avd1MrT0FBcmx4VENmUURtRGpW?=
 =?utf-8?B?eXllZDR2N09OVFdsOWVFb2tlbkZIajJ6cHRoNWJoWERtaFQvSHhFNnJQOFRp?=
 =?utf-8?B?RW9Ud2E5UUtkeFdVZlMvRElCNjZ5WUVQQndUY1Q2dHRrSFpEaC9yUkV3bkNj?=
 =?utf-8?B?Y2pKcnY4WEF4bmFMN3V0QmxNUEltaVZjSURIUURkcUMvZWRlL1l6cEg0M3U5?=
 =?utf-8?B?QlJVZTRFYWlTUnBteUVzUkVXTE9ESXVySE50T3VSU1NmbVhDVGlWVWl6UWVS?=
 =?utf-8?B?cE5rd3NaOTdqVXNOelkvSmV4bllUZFZVaFo2QkdXYnV3cFlQRWJZZDZDVGtm?=
 =?utf-8?B?ZHBDc2t3MkhQYitiQUNoNnZ6MnRpMjVBcTcvMURIOVovY3dIeEZIWEVhUzRr?=
 =?utf-8?B?amRwUkp3RnR5ZXJaNHdmTFZ3UGs4NXRqZmNlN0dWVTk2YjNEbXZrNGlPUllW?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF04E6518CEE324DA91F87A3D763822D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a291dd-c094-46f6-d7c5-08d9df8b6e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 22:46:59.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXhbT4i/fMKR0Zc7+ziyjutQ9rxSR5H9xaBwZAhtYSgxA3NO1wzKg2lfnETXZpoYkKkKM4EOa4HMzZ8tev2wSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gR1VDVEwuUkVGQ0xLUEVSIGNhbiBvbmx5IGFjY291bnQg
Zm9yIGNsb2NrIGZyZXF1ZW5jaWVzIHdpdGggaW50ZWdlcg0KPiBwZXJpb2RzLiBUbyBhZGRyZXNz
IHRoaXMsIHByb2dyYW0gUkVGQ0xLX0ZMQURKIHdpdGggdGhlIHJlbGF0aXZlIGVycm9yDQo+IGNh
dXNlZCBieSBwZXJpb2QgdHJ1bmNhdGlvbi4gVGhlIGZvcm11bGEgZ2l2ZW4gaW4gdGhlIHJlZ2lz
dGVyIHJlZmVyZW5jZQ0KPiBoYXMgYmVlbiByZWFycmFuZ2VkIHRvIGFsbG93IGNhbGN1bGF0aW9u
IGJhc2VkIG9uIHJhdGUgKGluc3RlYWQgb2YNCj4gcGVyaW9kKSwgYW5kIHRvIGFsbG93IGZvciBm
aXhlZC1wb2ludCBhcml0aG1ldGljLg0KPiANCj4gQWRkaXRpb25hbGx5LCBjYWxjdWxhdGUgYSB2
YWx1ZSBmb3IgMjQwTUhaREVDUi4gVGhpcyBjb25maWd1cmVzIGENCj4gc2ltdWxhdGVkIDI0ME1o
eiBjbG9jayB1c2luZyBhIGNvdW50ZXIgd2l0aCBvbmUgZnJhY3Rpb25hbCBiaXQgKFBMUzEpLg0K
PiANCj4gVGhpcyByZWdpc3RlciBpcyBwcm9ncmFtbWVkIG9ubHkgZm9yIHZlcnNpb25zID49IDIu
NTBhLCBzaW5jZSB0aGlzIGlzDQo+IHRoZSBjaGVjayBhbHNvIHVzZWQgYnkgY29tbWl0IGRiMmJl
NGU5ZTMwYyAoInVzYjogZHdjMzogQWRkIGZyYW1lIGxlbmd0aA0KPiBhZGp1c3RtZW50IHF1aXJr
IikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQHNl
Y28uY29tPg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gQWxzbyBwcm9ncmFtIEdG
TEFESi4yNDBNSFpERUNSDQo+IC0gRG9uJ3QgcHJvZ3JhbSBHRkxBREogaWYgdGhlIHZlcnNpb24g
aXMgPCAyLjUwYQ0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMzcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmgg
fCAgMyArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDUyMTRkYWNlZGE4Ni4uODgzZTExOTM3N2YwIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiBAQCAtMzQ4LDcgKzM0OCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZnJh
bWVfbGVuZ3RoX2FkanVzdG1lbnQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHN0YXRpYyB2b2lkIGR3
YzNfcmVmX2Nsa19wZXJpb2Qoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAl1MzIgcmVnOw0K
PiAtCXVuc2lnbmVkIGxvbmcgcmF0ZSwgcGVyaW9kOw0KPiArCXVuc2lnbmVkIGxvbmcgZGVjciwg
ZmxhZGosIHJhdGUsIHBlcmlvZDsNCg0KTWlub3Igc3R5bGUgbml0OiBGZWxpcGUgcHJlZmVycyB0
byBrZWVwIHRoZSBkZWNsYXJhdGlvbiBvbiBzZXBhcmF0ZQ0KbGluZXMsIGxldCdzIGtlZXAgaXQg
Y29uc2lzdGVudCB3aXRoIHRoZSByZXN0IGluIHRoaXMgZHJpdmVyLg0KDQo+ICANCj4gIAlpZiAo
ZHdjLT5yZWZfY2xrKSB7DQo+ICAJCXJhdGUgPSBjbGtfZ2V0X3JhdGUoZHdjLT5yZWZfY2xrKTsN
Cj4gQEAgLTM1Nyw2ICszNTcsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX3JlZl9jbGtfcGVyaW9kKHN0
cnVjdCBkd2MzICpkd2MpDQo+ICAJCXBlcmlvZCA9IE5TRUNfUEVSX1NFQyAvIHJhdGU7DQo+ICAJ
fSBlbHNlIGlmIChkd2MtPnJlZl9jbGtfcGVyKSB7DQo+ICAJCXBlcmlvZCA9IGR3Yy0+cmVmX2Ns
a19wZXI7DQo+ICsJCXJhdGUgPSBOU0VDX1BFUl9TRUMgLyBwZXJpb2Q7DQo+ICAJfSBlbHNlIHsN
Cj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gQEAgLTM2NSw5ICszNjYsNDEgQEAgc3RhdGljIHZvaWQg
ZHdjM19yZWZfY2xrX3BlcmlvZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXJlZyAmPSB+RFdDM19H
VUNUTF9SRUZDTEtQRVJfTUFTSzsNCj4gIAlyZWcgfD0gIEZJRUxEX1BSRVAoRFdDM19HVUNUTF9S
RUZDTEtQRVJfTUFTSywgcGVyaW9kKTsNCj4gIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNf
R1VDVEwsIHJlZyk7DQo+ICsNCj4gKwlpZiAoRFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMjUwQSkp
DQo+ICsJCXJldHVybjsNCj4gKw0KPiArCS8qDQo+ICsJICogVGhlIGNhbGN1bGF0aW9uIGJlbG93
IGlzDQo+ICsJICoNCj4gKwkgKiAxMjUwMDAgKiAoTlNFQ19QRVJfU0VDIC8gKHJhdGUgKiBwZXJp
b2QpIC0gMSkNCj4gKwkgKg0KPiArCSAqIGJ1dCByZWFycmFuZ2VkIGZvciBmaXhlZC1wb2ludCBh
cml0aG1ldGljLg0KPiArCSAqDQo+ICsJICogTm90ZSB0aGF0IHJhdGUgKiBwZXJpb2Qgfj0gTlNF
Q19QRVJfU0VDT05ELCBtaW51cyB0aGUgbnVtYmVyIG9mDQo+ICsJICogbmFub3NlY29uZHMgb2Yg
ZXJyb3IgY2F1c2VkIGJ5IHRoZSB0cnVuY2F0aW9uIHdoaWNoIGhhcHBlbmVkIGR1cmluZw0KPiAr
CSAqIHRoZSBkaXZpc2lvbiB3aGVuIGNhbGN1bGF0aW5nIHJhdGUgb3IgcGVyaW9kICh3aGljaGV2
ZXIgb25lIHdhcw0KPiArCSAqIGRlcml2ZWQgZnJvbSB0aGUgb3RoZXIpLiBXZSBmaXJzdCBjYWxj
dWxhdGUgdGhlIHJlbGF0aXZlIGVycm9yLCB0aGVuDQo+ICsJICogc2NhbGUgaXQgdG8gdW5pdHMg
b2YgMC4wOCUuDQo+ICsJICovDQo+ICsJZmxhZGogPSBkaXY2NF91NjQoMTI1MDAwVUxMICogTlNF
Q19QRVJfU0VDLCAodTY0KXJhdGUgKiBwZXJpb2QpOw0KDQpDYW4gd2UgcmVhcnJhbmdlIHRoZSBt
YXRoIHNvIHdlIGRvbid0IGhhdmUgdG8gb3BlcmF0ZSBvbiBkaWZmZXJlbnQgZGF0YQ0KdHlwZSBh
bmQgZGVhbCB3aXRoIGNvbnZlcnNpb24vdHJ1bmNhdGlvbj8NCg0KPiArCWZsYWRqIC09IDEyNTAw
MDsNCj4gKw0KPiArCS8qDQo+ICsJICogVGhlIGRvY3VtZW50ZWQgMjQwTUh6IGNvbnN0YW50IGlz
IHNjYWxlZCBieSAyIHRvIGdldCBQTFMxIGFzIHdlbGwuDQo+ICsJICovDQo+ICsJZGVjciA9IDQ4
MDAwMDAwMCAvIHJhdGU7DQo+ICsNCj4gKwlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdD
M19HRkxBREopOw0KPiArCXJlZyAmPSB+RFdDM19HRkxBREpfUkVGQ0xLX0ZMQURKX01BU0sNCj4g
KwkgICAgJiAgfkRXQzNfR0ZMQURKXzI0ME1IWkRFQ1INCj4gKwkgICAgJiAgfkRXQzNfR0ZMQURK
XzI0ME1IWkRFQ1JfUExTMTsNCj4gKwlyZWcgfD0gRklFTERfUFJFUChEV0MzX0dGTEFESl9SRUZD
TEtfRkxBREpfTUFTSywgZmxhZGopDQo+ICsJICAgIHwgIEZJRUxEX1BSRVAoRFdDM19HRkxBREpf
MjQwTUhaREVDUiwgZGVjciA+PiAxKQ0KPiArCSAgICB8ICBGSUVMRF9QUkVQKERXQzNfR0ZMQURK
XzI0ME1IWkRFQ1JfUExTMSwgZGVjciAmIDEpOw0KDQpEb2VzIHRoaXMgcGFzcyBjaGVja3BhdGNo
Pw0KDQo+ICsJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dGTEFESiwgcmVnKTsNCj4gIH0N
Cj4gIA0KPiAtDQo+ICAvKioNCj4gICAqIGR3YzNfZnJlZV9vbmVfZXZlbnRfYnVmZmVyIC0gRnJl
ZXMgb25lIGV2ZW50IGJ1ZmZlcg0KPiAgICogQGR3YzogUG9pbnRlciB0byBvdXIgY29udHJvbGxl
ciBjb250ZXh0IHN0cnVjdHVyZQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCA0NWNmYTdkOWYyN2EuLmViOWMx
ZWZjZWQwNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTM4OCw2ICszODgsOSBAQA0KPiAgLyogR2xv
YmFsIEZyYW1lIExlbmd0aCBBZGp1c3RtZW50IFJlZ2lzdGVyICovDQo+ICAjZGVmaW5lIERXQzNf
R0ZMQURKXzMwTUhaX1NEQk5EX1NFTAkJQklUKDcpDQo+ICAjZGVmaW5lIERXQzNfR0ZMQURKXzMw
TUhaX01BU0sJCQkweDNmDQo+ICsjZGVmaW5lIERXQzNfR0ZMQURKX1JFRkNMS19GTEFESl9NQVNL
CQlHRU5NQVNLKDIxLCA4KQ0KPiArI2RlZmluZSBEV0MzX0dGTEFESl8yNDBNSFpERUNSCQkJR0VO
TUFTSygzMCwgMjQpDQo+ICsjZGVmaW5lIERXQzNfR0ZMQURKXzI0ME1IWkRFQ1JfUExTMQkJQklU
KDMxKQ0KPiAgDQo+ICAvKiBHbG9iYWwgVXNlciBDb250cm9sIFJlZ2lzdGVyKi8NCj4gICNkZWZp
bmUgRFdDM19HVUNUTF9SRUZDTEtQRVJfTUFTSwkJMHhmZmMwMDAwMA0KVGhhbmtzLA0KVGhpbmgN
Cg==
