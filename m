Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95B49A166
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845070AbiAXXdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:33:49 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:57206 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1837430AbiAXWoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:44:37 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C45AEC06D5;
        Mon, 24 Jan 2022 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643064269; bh=jteK+v+KYEqURYUtwpT/X+au1DKOoguvmnv+hq1LKGw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=W5X+PyD1ZUqa9/EgO6NJAe7wSLZ+S1PfxPvWjpVgxt4SCf57reEPdW1+Sovk9M1XN
         bGV6A2O227Qx1ePapPOhBLlmBl/EQXIi83clwReIJaCht1TNanTs/AQ251OcDss6Ab
         wWsTVm5dTAR0q18OxSzuO2ILr9QmtQL750bUN7WxIt+/7bmCTQiWoMyYCHwgjXU8o8
         OdGMrn/SvnMX9R01sHRl6+PBSZG1/Ey+Oa+f8jO1HxL1yy0RATF+yb85g7NnB1rFqd
         SSmyitHwQDCDBVAXb06tp06ZbMoNX9vqgwcaMcxkYgDeckxeq0ZOwINk/yCXw+4IDM
         d+NYRfjTE4Teg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3A6ADA0071;
        Mon, 24 Jan 2022 22:44:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AA1C9400FA;
        Mon, 24 Jan 2022 22:44:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="pLhNVo2R";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOfZdUSoiMuBpGqJG6t9gkrOk2mnXpuglk2qFlxsVa0PusPes90VZDSMaDdPBtYSjb6b1XJLv9cy1GNvvb+/6JMUUp3dj+ZpuIPeXTbEXG8zpWT3EyapXsq/xGjTryRoTJPDsKS1rfCcZ45PxQ6731Zy2xoo+O2ygSY3jNRje8LOLW6R9yNObaqMyT9HX3nkACoT2rSKIXzE2QnfneTt1hmuKyHCBILQbLYkiFMhFU39phz2A9UMxOFI+6/bVha+f6W6+5Pd3juNSshbIKhiSLsUfXR2H6eQBeN+fBZ51O/c/jYamGNhFQtLHZPNrJfSZ9JrFgEn43tS0vHowAhCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jteK+v+KYEqURYUtwpT/X+au1DKOoguvmnv+hq1LKGw=;
 b=CqpF/D6oQO/080G85pBukWZfw+IVLYHKQKkDLhBnt1yqt1h+K4zcPtazj1bIdD0wPv35wbsX3UCGYtGRu45Bn7yT0WRN1R6wykDTPJDI+37aHYkhughk/JnwuVD5Blc8q1q6dAchf1wfwxDGmANNeWkzZSaqFthdEafwuha0Xzpdrzmaq89kKKPx8EBjmOZbwy2Sqg7fkx5u557MTUA7Zy4vhDnjA6s9NhJ/yeuzqCS+iP+U42DiWYe40VeS4BIx/gdoblmDUFac74CnacvvTAWHgvBqT2GtFifEIxmyqI4f+BDqiCh1tdv4ShKyw1yfwtP+NI3AykVN+4fDZqfUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jteK+v+KYEqURYUtwpT/X+au1DKOoguvmnv+hq1LKGw=;
 b=pLhNVo2RzVFHOCEiL9nyDVPCxOEhA0ijHfYY1D7GkavOPHWlm60/mGk985hHug3HSSsFwrHoN8B8/uK6PJO1k7FxBifnEGHK7fyd6Rwxh0asaBShDIqEYbSDgarkRt7bwf3VN4TAOA79FXWhfn03Yh3pDg6KbHbzYcewRRLOcxA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 22:44:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 22:44:14 +0000
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
Subject: Re: [PATCH v2 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
Thread-Topic: [PATCH v2 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
Thread-Index: AQHYDMsCXryFLD+72Eq2rM87+o7aVaxyzjwA
Date:   Mon, 24 Jan 2022 22:44:14 +0000
Message-ID: <5275ea80-400e-d1de-f03e-c2ea81f959dc@synopsys.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-6-sean.anderson@seco.com>
In-Reply-To: <20220119002438.106079-6-sean.anderson@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc2d26a4-ed29-48d5-1fc9-08d9df8b0c36
x-ms-traffictypediagnostic: BY5PR12MB4130:EE_
x-microsoft-antispam-prvs: <BY5PR12MB41304DDB82293A409E215633AA5E9@BY5PR12MB4130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ak1eaH/njZfGev+PeMvwAQTJo9A3WoaTJLhmQGGHBPCAW1Gk0nRFNjbUKQ95DlqeTCWbBd+e4BMEtWvwXeaDh4kPSgX6r66eFTdvqfG3HUMsKFBicuaCy2/ekadNm4AVF3zrYWASmrOuXDL43K/xSMT4ug3OBzvBmrJcmd43cTxcof10N+iUwwW7ll5899t6DtiC05pihHW4brswwLOJ4qfHD4gIrwCEAQm71VORDyqPyA8gysigoACa3qno9DT2zpzvbvr0U040c36kfJkQD3qJbx8V48VXAsbS7Yzf81yhFXdKcSt/V/6kbYyBNP16EJ99cGO1gxwts0qEi7mY8ka25gr4aYK2DBwtM9aL5EY+qY9iyqpfRKidvUMf6pNmJKMWCelvVLFeo/hRO886lIiSGj82XWWwZgzUOhyf5SJCTeD3Lb4ifAVdRKI9m0RcMjxpbBTmDM3lsVPIPaVQHw22Fqp6Wo3y8dEaPTI0G+DGRGFq4CKgU3IyzHkjfSZ3iRMZlgAX+8x0sTesvHev1lwS5pBUXnD7h8fwPXDszlmq2Kgh6PeQB8j+xvndYu9yqgLeyz1sZb68WIoj7HJuLFjqJENXO32N92R3fj54b1/tTHIkQx41U3K8qpAJYxJKodHgdwsZiKPrWQObO+8hMm/zANribDsHDhpEgbzvz0+nfzNjarynCKApeo1k7Ci/4Rvbo2fqmGaM6jLsXNg4FsA9dBttImsxCVVwfv9OQJaHarTMR09UZISbFKtqvmDhF41uR7KYXFCNUNYz9zYtxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(2906002)(4326008)(6512007)(38070700005)(38100700002)(66446008)(64756008)(76116006)(66946007)(54906003)(31696002)(110136005)(122000001)(31686004)(66556008)(36756003)(86362001)(83380400001)(8676002)(6486002)(2616005)(508600001)(8936002)(71200400001)(26005)(316002)(6506007)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTRrTFo5ZnZGU0hta1JYRE5KK2txYkZkYmtacnQ2d05GVGNuT1dnZTN2OGk1?=
 =?utf-8?B?YW1sWGhVNmk0REpHUzFibmttZXQvdnU5bnVZU3NpcXhveW9WUHB4VmZ1eXZ0?=
 =?utf-8?B?NGwySFREaXRZK2tjRE1zMnZXZVJIUXdzVmhZOTZ5M3BvbVYyNUp4SkYwWmZT?=
 =?utf-8?B?eU9WSE01NHRnZU9YWlhhb1RRSWdQRjB1QjBYQldmd0c2MUQ3enN3SThoYmE4?=
 =?utf-8?B?VVNMVGx6Rm4wZ0hYR2RzTEhqOWhYNFk5S3NTWHhIZy9xK3FsUmRaVTM1NlIr?=
 =?utf-8?B?c1doRjZxVEdRdlgwc3MrUWdtWjhhQVdNbnNHR0RlenBweU9JVHRPZko5dGw1?=
 =?utf-8?B?ZGNjYlllcXpPaW5kTHE0WUYxSGRMTDF3S09iUE1URE5Ya0d1WUNUUFhMMmRJ?=
 =?utf-8?B?bGRVdUlkNFBta0RBZkdHVkc5ZURvRkVWWDdFVngrTExvMmJoZmdpOTcvbmU1?=
 =?utf-8?B?Zy9Rb1RZaHVyUGVCRk1YejVpZUx4QW1NMzhVUGtEemdkS2IvczdlV0FIK253?=
 =?utf-8?B?THI1dVpnVmYrTWdEUDBzYVB0Vm10UFZBQzVoTlN5bHQycEdtOUhHNHYrMzZp?=
 =?utf-8?B?Q0NNcWN6U2dVUFZiMTVMeEpmdVJHK1BFZ1pQQThha2dETEhoSUhPR2l2bXhk?=
 =?utf-8?B?ZmY1alZWTFhUWWNDcHY2a2VpeHVlREZiY0JqQmNIOWRMdysxdDFvKzVxdzNy?=
 =?utf-8?B?RW80RVBGTUZFU0dzek1SVm5vMEpxTThnTThnQmx5S1E5M3RHejVVbWYxU1E2?=
 =?utf-8?B?WWxNM0Jnc2UzMEtqSGtnLzNrS0tJa296azM5blM5TVR2NXNIU1ZSM3FhVlZ1?=
 =?utf-8?B?U0VtV0RtQXQ2OWhjaE41VDRBK3E1cjRxc0tuWE9FanlZaEhSdEllQ3ZNVW1K?=
 =?utf-8?B?bzNKdlo4bzJHTzJFdVpBR0x4cDkyWmNpSDVpZ3hTY3ZUUytFT3JlQTF2OE1N?=
 =?utf-8?B?UWlhVjd2MHIwMHhWb0ViVTZ5cmx1bzV5dEJ4ejltcHRGMDVjY2sxYmVpWDFL?=
 =?utf-8?B?OUJYR0pOM0QrazFjT0V4QkFMMWlwU1pTMmVwL1ZwaTB6WXpqeGdFb1FDMjNy?=
 =?utf-8?B?NEVSUm5NZm9ubTFyL05KVzhZbkVzdHg3dHcyb0p5V05GYTNxajRkRlljZENM?=
 =?utf-8?B?UkZOTFZoWFBEN1lKM3k0dmJBMk5uUmVSbUxFSFBVRTZ4WDI5RVhMZnpaOGJY?=
 =?utf-8?B?VWhCK003UWFkWEVCaGk0WU5LVWJIVU5XbEZyMng2cGUzclEyWWg3NG1WWjdC?=
 =?utf-8?B?bTFRWVpnTFdyU3pFZXp2bEkwNkhvS2RPK2YwcTBqb0NHOExsZGtweUc2TURt?=
 =?utf-8?B?Z21LZFRlZm5OSStrOFNWT3FBcUlaKzZqNXdqcElKVWNueG5PdktGMW1nUE1R?=
 =?utf-8?B?eTMrVStCUW1OTkNlejhBSnBlUWR4S21MWWpJak9lbzFZRXJwalRHYmZYVkhI?=
 =?utf-8?B?Y1BLVFFlbHh6L2NmN2wzYXpnUUgxbG1hbmRKdDE3aExOdWxFclVyL2xvYkY4?=
 =?utf-8?B?SE5DMzM3c0lIbEtyakxyL1NGV1VHc21XdmFOME95OXlBSE1qRTkyWVpkc3h2?=
 =?utf-8?B?WjdnZjZyM1V3OFEybVM0MDUwcVI1b3VMTmZDRmg2cEVHNE5Bd0Z5aDAyUzJn?=
 =?utf-8?B?RjBQRkZCdFNoeXo1WlB2N01mZExNS2k5R3hlRkp3WndrcWRqNzVsZGZBdHQ2?=
 =?utf-8?B?U3MvWmh5aVlWLzFIMWRRdERMZFBKeEhncTB0VXZuTVVicCsxbXZiSjlHd2dE?=
 =?utf-8?B?S21oN3lKVWhNUUJET3Nla3FQTk5MZXJFTVo5UjM3aXQ1ZjB0YU8wZ2lQVGd2?=
 =?utf-8?B?OTdvZzRUM2xPUFBZMlUxbWRBd3J0UWRpTHNDM2xiMGJ5d0pQQzFDV3g0UlNw?=
 =?utf-8?B?UFRTWE5VVzQxcVdtWEZSSkN0QkNNQm5TUFA1ZTlVQmdadU5lcmsvVWFjOHpm?=
 =?utf-8?B?MXErWmJiV1IvTWxVQUZpUUc4bmsrTHhEWjVQQXRlOWp2RzBTaFZzUy9xRFg0?=
 =?utf-8?B?V0MzeVh0ZmcyY0FsRXM2L0FoR3d2YmxqTnprbHJBQ2hVSXhOZFczZlJsa3Jq?=
 =?utf-8?B?WkNvQ1lvb3BIaGZ1cmIrR1NlRE5qSDJCeW96ZXdpUmUwNERuZjAzT09wQndy?=
 =?utf-8?B?UWNvNlhRdFE2T1pFOFZqeHZKOStQeDJFS0ZRYlY2bnhINktGVGt4d0Zxd1FM?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CF9A0CE4408374DA717E015CE116D4E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2d26a4-ed29-48d5-1fc9-08d9df8b0c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 22:44:14.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAsMawV6sRVryBdyHdTT69+W925JuBu8qAob6UvNQH8m7J50JW5k2bvX/iMpIqQvTG1K2WGFZJOuyJ61H7zfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gVGhpcyBwcm9wZXJ0eSBhbGxvd3Mgc2V0dGluZyB0aGUg
cmVmZXJlbmNlIGNsb2NrIGZyZXF1ZW5jeSBwcm9wZXJseSBmb3INCj4gQUNQSS1iYXNlZCBzeXN0
ZW1zLiBJdCBpcyBub3QgZG9jdW1lbnRlZCB1bmRlciBkdC1iaW5kaW5ncywgc2luY2UgaXQgaXMN
Cj4gbm90IGludGVuZGVkIGZvciB1c2Ugb24gRFQtYmFzZWQgc3lzdGVtcy4gRFQtYmFzZWQgc3lz
dGVtcyBzaG91bGQgdXNlDQo+IHRoZSBjbG9ja3MgcHJvcGVydHkgaW5zdGVhZC4NCj4gDQo+IEZy
ZXF1ZW5jeSBpcyBwcmVmZXJyZWQgb3ZlciBwZXJpb2Qgc2luY2UgaXQgaGFzIGdyZWF0ZXIgcHJl
Y2lzaW9uIHdoZW4NCj4gdXNlZCBpbiBjYWxjdWxhdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQHNlY28uY29tPg0KPiAtLS0NCj4gDQo+IENo
YW5nZXMgaW4gdjI6DQo+IC0gTmV3DQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA2
ICsrKystLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCA0ICsrKy0NCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
aW5kZXggODgzZTExOTM3N2YwLi41ZjNkYzVmNmNiY2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0z
NTAsOCArMzUwLDggQEAgc3RhdGljIHZvaWQgZHdjM19yZWZfY2xrX3BlcmlvZChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiAgCXUzMiByZWc7DQo+ICAJdW5zaWduZWQgbG9uZyBkZWNyLCBmbGFkaiwgcmF0
ZSwgcGVyaW9kOw0KPiAgDQo+IC0JaWYgKGR3Yy0+cmVmX2Nsaykgew0KPiAtCQlyYXRlID0gY2xr
X2dldF9yYXRlKGR3Yy0+cmVmX2Nsayk7DQo+ICsJaWYgKGR3Yy0+cmVmX2NsayB8fCBkd2MtPnJl
Zl9jbGtfZnJlcSkgew0KPiArCQlyYXRlID0gY2xrX2dldF9yYXRlKGR3Yy0+cmVmX2NsaykgPzog
ZHdjLT5yZWZfY2xrX2ZyZXE7DQo+ICAJCWlmICghcmF0ZSkNCj4gIAkJCXJldHVybjsNCj4gIAkJ
cGVyaW9kID0gTlNFQ19QRVJfU0VDIC8gcmF0ZTsNCj4gQEAgLTE0OTIsNiArMTQ5Miw4IEBAIHN0
YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJCQkg
JmR3Yy0+ZmxhZGopOw0KPiAgCWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJzbnBzLHJl
Zi1jbG9jay1wZXJpb2QtbnMiLA0KPiAgCQkJCSAmZHdjLT5yZWZfY2xrX3Blcik7DQo+ICsJZGV2
aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgInNucHMscmVmLWNsb2NrLWZyZXF1ZW5jeS1oeiIs
DQo+ICsJCQkJICZkd2MtPnJlZl9jbGtfZnJlcSk7DQoNClBsZWFzZSBhbHNvIGRvY3VtZW50IGlu
IGR3YzMgRFQgZmlsZSB3aGVuZXZlciB3ZSBhZGQgYSBuZXcgcHJvcGVydHkuDQoNClRoYW5rcywN
ClRoaW5oDQoNCj4gIA0KPiAgCWR3Yy0+ZGlzX21ldGFzdGFiaWxpdHlfcXVpcmsgPSBkZXZpY2Vf
cHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4gIAkJCQkic25wcyxkaXNfbWV0YXN0YWJpbGl0eV9x
dWlyayIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBlYjljMWVmY2VkMDUuLjAwYTc5MjQ1OWZlYyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gQEAgLTk4OCw3ICs5ODgsOCBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFk
X2FycmF5IHsNCj4gICAqIEByZWdzOiBiYXNlIGFkZHJlc3MgZm9yIG91ciByZWdpc3RlcnMNCj4g
ICAqIEByZWdzX3NpemU6IGFkZHJlc3Mgc3BhY2Ugc2l6ZQ0KPiAgICogQGZsYWRqOiBmcmFtZSBs
ZW5ndGggYWRqdXN0bWVudA0KPiAtICogQHJlZl9jbGtfcGVyOiByZWZlcmVuY2UgY2xvY2sgcGVy
aW9kIGNvbmZpZ3VyYXRpb24NCj4gKyAqIEByZWZfY2xrX3BlcjogcmVmZXJlbmNlIGNsb2NrIHBl
cmlvZDsgZGVwcmVjYXRlZCBpbiBmYXZvciBvZiBAcmVmX2Nsa19mcmVxDQo+ICsgKiBAcmVmX2Ns
a19mcmVxOiByZWZlcmVuY2UgY2xvY2sgZnJlcXVlbmN5IHRvIHVzZSBpZiBAcmVmX2NsayBpcyBt
aXNzaW5nDQo+ICAgKiBAaXJxX2dhZGdldDogcGVyaXBoZXJhbCBjb250cm9sbGVyJ3MgSVJRIG51
bWJlcg0KPiAgICogQG90Z19pcnE6IElSUSBudW1iZXIgZm9yIE9URyBJUlFzDQo+ICAgKiBAY3Vy
cmVudF9vdGdfcm9sZTogY3VycmVudCByb2xlIG9mIG9wZXJhdGlvbiB3aGlsZSB1c2luZyB0aGUg
T1RHIGJsb2NrDQo+IEBAIC0xMTcxLDYgKzExNzIsNyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICANCj4g
IAl1MzIJCQlmbGFkajsNCj4gIAl1MzIJCQlyZWZfY2xrX3BlcjsNCj4gKwl1MzIJCQlyZWZfY2xr
X2ZyZXE7DQo+ICAJdTMyCQkJaXJxX2dhZGdldDsNCj4gIAl1MzIJCQlvdGdfaXJxOw0KPiAgCXUz
MgkJCWN1cnJlbnRfb3RnX3JvbGU7DQoNCg==
