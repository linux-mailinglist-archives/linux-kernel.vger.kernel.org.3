Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1946902C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhLFFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 00:25:02 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59042 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhLFFZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 00:25:01 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 65306C124C;
        Mon,  6 Dec 2021 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1638768093; bh=EbvQHVQWyhsXZPOSMUFQtyzcvqLZKA76Z8F7hHukuWc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YCRAe77o9pfscolYNopf/GxhuQDEwsaO3eRSu6Ugnkl6VG2teBIf1331GxOXbvBnz
         Js84s/YcMSBCtIfhrW+e1XPYIR3fKYVP4bJfiPI1yYwh+WZV8TbO9JmU6sh+jVKe22
         Z+EsUQArWtMOW85wgc2nzGIf6Lk2cauXIUODrul+SdmpHuekq1QDSGue2ik/sane+v
         bNTDXlUYtukbJqjW8xk2yPu7g1n/khn1JzPYq93NwToR8VwWAVOGO+krXfKkqGpCGF
         RNWVZcx3mv5fJE4B31j3kxXGs7QN7SOFsmrekTAWDEfNIjh0YlLEOHX4HUbYwCFcEx
         CiszcBv9ogVBg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8D4DAA0063;
        Mon,  6 Dec 2021 05:21:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7C75E40096;
        Mon,  6 Dec 2021 05:21:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="i047AjJb";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HufsHia7Qg3B/k5VBqXpxPyKZFPRgZYFbG8LoVHHsC0Wx4nI2NE495ckikIACLG4hcZ1g9DmB6FQ2ZNPNXiKTa25I5uIq48aUKyarGDG0+HhVYxKU1ORZ92sx95tzWJj14XQJKnws7J6kvGabJKJXu6E8nwws+5dUpsQ9SyKDwa/cpo/MCRGI4Ks2+5IjVj6oyDS6sDiBsTeE7G2XT7fY32COvh+fjKQuuy2WQ6FBsH8WGKVJ883WmPgDFsJICz1yBIRAfPrWhjYraDjVioZWJUAIPBFkHZn193wJGSdzlpcCpumGp25fN+Ls4oJNhzSIGLiPFLyILgqik9ap0VWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbvQHVQWyhsXZPOSMUFQtyzcvqLZKA76Z8F7hHukuWc=;
 b=Pb5QxiwbDMuhKXaGXK0nUis/Oa7uFCTaTIwZfsIETrWgTMX/eLwNEStuSZluDnBEuErq5MWC7bNWo0TJlneji7+UGS+yEfmDxa2P0X/2y5oQ0aXzbCQ0kMEQOdRwlkwmBIGjF6bYnmbbgq06/hqLyMM2un/R7JyA6UohdomZy3TEA/SThDJiiDL6+Ff3cJq0+uj8Zu9FGBvFNEWSH+hgmtJ2I6EAhby1HMjUuMYgQCH1Rf59EFSk2rObwt/LLc6ZC6Zc0zTXJfXrjIZSsD+9hA4+umztgEWXLIdFkVr9AtApc3+LIq0VPuR8cYfgebf5OvGA9DeWydpJps+QAgBtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbvQHVQWyhsXZPOSMUFQtyzcvqLZKA76Z8F7hHukuWc=;
 b=i047AjJb7rjtVJgRzHFb5L2JDCLiGmEXrdNS5JeyOhQl8GXVMXYumVie59OqBaixLtqLqPWevzwxCoAjxf8bhYx2CwcQs2nbZdm1wPvK1rNzqlH4nAq1jICev+f7pC9zI0Zd5k84vRlzLiZ0Gcq2ztfchjwP0vRxCjqMr4kb7Kw=
Received: from DM6PR12MB3419.namprd12.prod.outlook.com (2603:10b6:5:3c::32) by
 DM5PR12MB2423.namprd12.prod.outlook.com (2603:10b6:4:b3::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Mon, 6 Dec 2021 05:21:29 +0000
Received: from DM6PR12MB3419.namprd12.prod.outlook.com
 ([fe80::bc96:b3ed:1aa5:57b6]) by DM6PR12MB3419.namprd12.prod.outlook.com
 ([fe80::bc96:b3ed:1aa5:57b6%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 05:21:29 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Argishti Aleksanyan <argishti.aleksanyan@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: initialize max_speed from params
Thread-Topic: [PATCH] usb: dwc2: gadget: initialize max_speed from params
Thread-Index: AQHX56CQFWIuKlwH/UKk1NRUnt5+YqwgQ9mAgABg8gCABE4ygA==
Date:   Mon, 6 Dec 2021 05:21:29 +0000
Message-ID: <35819bf8-7653-da00-fb56-8ffd56fa3944@synopsys.com>
References: <20211202171748.3035874-1-john@metanate.com>
 <a2ce248f-79d9-f9a3-f184-e033409fe2b8@synopsys.com> <YaoBQvSeY0RhFgRP@donbot>
In-Reply-To: <YaoBQvSeY0RhFgRP@donbot>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b39e91b-88f6-480e-34d8-08d9b878424a
x-ms-traffictypediagnostic: DM5PR12MB2423:
x-microsoft-antispam-prvs: <DM5PR12MB2423B31F861722BB92C1775CA76D9@DM5PR12MB2423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFji8u3TjzgVSWZc+VESVEowKJ81L8w1nKkR5oKUZd8j9Po8AsYl4n5CB11FPtcza3SNPyy/MLXtFX9nj5vN8AyGmTlDKWK+ZGOHIg3NczdwDPfcY++QiTYwZKTf8+L/AbDSMAuQSdyeBQ8TsecxP+uNQL63IPn66+E6Im8kVjXXRPXM1XSdFjq+yZz6IUuaBGpyyX1ppHMI6qGpC8+yqsfo6I4UdApNRTDgq84oUaene5f1dZDC72iL3pm59MybXuIlm41XTWy6dPqsD3PfjT+7zX9zFBTIP3NMkTqRnlaQ8Z6PUouFTbDAlcGxcWWKhPoaLnnKNuIaI/BwdunZtJkIXCYTat2GEA/F1/eSkFXGnSZCFW1Rsq8ttK1b2veHjXLRjjO7kq9swyeyERULC2m8B6Y+C/jmDM16dNllJByJCXIRyG+lXXb6Q7YjJL4f7S5kDWRP3/NsOo/M3DWNEBSDCtOd5bMNxfYehuumW+eTxyl+0jLE3NpSoDnwaE0HZuG8y0rB2qhidwGXyKj+7gLArQ1xMeAiPpNnWkLUlAnOZYJJGbxtWpKY0Im2wHeO64UyI4LiFl1IiWKUHwfh9iBVU23/9/LxSbPwEjnNnLyj9qCQ+5ah9GxrQdGPpIp7Ck4c+ObWShlOTeGdnxOoOaPaDbeZ59LlhKANzeGNnEe1mUfT/mPf8Qb4Tih+T1vbpcQGDLGaOtYDY0Hx7e1N4TYcOODkvKP3xlylUXgqVbtp8tAheJy1BvKl7IphaVIcONXV7NHD6SHJNJysbHxC9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3419.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(186003)(2616005)(26005)(53546011)(38100700002)(6506007)(122000001)(5660300002)(4326008)(6486002)(83380400001)(54906003)(71200400001)(31696002)(36756003)(31686004)(2906002)(76116006)(508600001)(86362001)(110136005)(91956017)(38070700005)(66946007)(316002)(64756008)(66476007)(66556008)(8936002)(66446008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmxqK056NTVOR3lqMWFrL01ONmE5SVdzMUcwNzZ5MG1NV3p4bDdES3orTm0w?=
 =?utf-8?B?MHk4Nnp5MVlDcThOYU1iSFM1Z3krNmpCakFyYUhhZU1VL0YwNVVJZGlHTUJv?=
 =?utf-8?B?SW5jTFFPUXlUc01uVVlSd252bGJyU1hObEt1RmV2WUtsZ0l0NXJodHJqS2Zv?=
 =?utf-8?B?amJRL1AzeExJdnF0OHg2RXpJbVBNQ0xoclM3cTVFWlNnNkhjWUFmbVJBTGo4?=
 =?utf-8?B?Z0tCMTdRV3NqWm8xVllDYldFQXZuL1c2cnZJL0FpNGRFUmVjcUpBUWtscFhw?=
 =?utf-8?B?TGU5L2V5NU9UVmtjUjNHTnpiOTBMSjF1Nm1YR04rc1A4S09BOHpHeUVtMXlY?=
 =?utf-8?B?cm5keGZUUjNURTJLMlMrNWdqeklTZmpxeHQ0KzNBZ3hFYTFzc015cGV2YmtR?=
 =?utf-8?B?bEljMnprRlk4dVRYbEVpVWNBU0FJU1NKUUovMi9SaDhtRDRpV0M1RjVPZncr?=
 =?utf-8?B?Zng4T0NSekx4bzhMcTM2emdMMkxVcnJxNVNNeDNhVWJzK1ZPd0xickgyaXBL?=
 =?utf-8?B?SDY1RGdCTzBKbVdDQjBTWXNwZnpCRk8wRjRXUm15S2JTV2pneGgyc25aQW9U?=
 =?utf-8?B?TUxnOUlldzdTV1M0elFWbXFBWVpmWVd6ZmplVndwYnFZaUVnMXMyUHVEd2Za?=
 =?utf-8?B?UWM4YzF5QmRwMVlKUWlhdW0xSWhPcmIvK0psa2NrVkNWdnZQdHJEazA1MU9U?=
 =?utf-8?B?NWNMUkhzRGFUV1hROHBSR2c3ZEhyNTRHeVVHakVPYUhPZFQ5aGRtL0QyTmlz?=
 =?utf-8?B?ZHRSSEgwckF0RXRPOEZSVzh2WXZGcy8vMlhPNVRzRE5TeS9QYm9ia1ZoeWNr?=
 =?utf-8?B?OEp5S1FjK1luN0FPMEV5TjJLaG15UHlJOWpDK0UxS3AwMDBNbng2aWZTd1ov?=
 =?utf-8?B?R1pITUlIcUFuam5EK3BKOGFjK3J5eW95bU0vUXEydDlvT2VHd01LSzRWM3Yx?=
 =?utf-8?B?ZGowV05LZUNhc1dVK3J5RnlOb0QveGxyL1JxMHM0N294Rzl4ZjNpS0liNm0y?=
 =?utf-8?B?ZG5YVDFTT1hiZm9nS0NqbWJnT2hRUThzR21aOE1adnV1akZlODZMR3BOY1dz?=
 =?utf-8?B?NXNiRytHQzFDa1l6bUllMkUrM1BmR0M2ZndDMldrK0FZWjhpWFo4bnlObFFx?=
 =?utf-8?B?Nno5K3NxSC92R3JES1YvSDEvaHltUExuTXNrNGk4QUpPdnBYU0VDUytQWTJo?=
 =?utf-8?B?OGZOdkMxRHFVZGlPaWcralNaeTNYdkhndGJMTXFxdVZFd0k2YVZXOG9lUnBY?=
 =?utf-8?B?c0QxWHZlaS91T2tvR09rM3p0akt2VUpETW1XR2VYT055SVF1SFlVbUc1bjl2?=
 =?utf-8?B?UWZodDRsK2dPT1ZBaFJWQ1BwekgwVVRIRXZKQ2YvRlN5MU1IQ3VuSHo1N05L?=
 =?utf-8?B?WFcyaVZiYmVjUFFEM2ZQWTNhZ0JEMXBTUHJHRDBPOW5jK3Vraytkemc4d2tC?=
 =?utf-8?B?WTBoYTlmSVQrdWkwVHR5Z3J6eTRhOUgxWExsVjdHR1V6ZFhkbHlSSU9paVo5?=
 =?utf-8?B?MGhjTWQ2dFVIRmg0ZnpMMGpRUkVYMCtraWk0MWJMQlhxOWV1QXhwMzczOGc2?=
 =?utf-8?B?L1pnOVNpdGNaWHpBN3FCSEkwTStoV2c1RjBFZFlTRUhYcFU3VkFMMTAwUHR4?=
 =?utf-8?B?NkZ4eHFPUVllY1M3eEhGMUJOaDloNngySzE4NGUxMHFnUE8rVWVLaGIxeGtk?=
 =?utf-8?B?eC9kNGRobEdEelZMM2VUYW9nRTJiNkFrdHVibW1OMm9QTXZxaHE2WlJ5QkMy?=
 =?utf-8?B?RXlOYVU3Y1R3K1RSYzlpc2s4cEtmWDhFVW9oN2s5dlNlM3krUXpGUnk1U0VM?=
 =?utf-8?B?dGhCL1BUTkJReXJzbzNaeloyNmxHOU1pZHNzWjNmMzdHdEpUREUvaDdIcGYx?=
 =?utf-8?B?WStodzVuVnpWWkdkSDJZR05wUWNHMjVYekcrKzlGVFdabVNJTEw4cFBwY05S?=
 =?utf-8?B?Q2tzbEc2bHZwTUNHWVpBUm5JbGV6dHdpZVRRS1lERnZJSk5ja3ZqMnp2QUtY?=
 =?utf-8?B?YTM4YjJHL0FzcS9iTFhQbkd4UEROUkZDdERmRnhiWHhRc1dJY3hsd2ovZ0Rw?=
 =?utf-8?B?U1V3ODduSXZnNXZ3eWNQWlIyeDlkTnZmN2FTS1dKaUIyRE00SGpKV3Iva1NV?=
 =?utf-8?B?b21tSHh6VnpRM0VrRm1QK3ZvNWRCUGRjM3B0RkE5LzlITWZXeTZrK2pxdTBy?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA59EE6DAA426B4CBFAFC6A937C1757D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3419.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b39e91b-88f6-480e-34d8-08d9b878424a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 05:21:29.6172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45gcyUwcpf7lahQG/G1trzamtduHmGDv+YnvBmnf6UUc+h8aixDXzwAyOxO03sFcsGud7+pAEdoEQ9e/2NPUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMy8yMDIxIDM6MzYgUE0sIEpvaG4gS2VlcGluZyB3cm90ZToNCj4gSGkgTWluYXMsDQo+
IA0KPiBPbiBGcmksIERlYyAwMywgMjAyMSBhdCAwNTo0OTozNkFNICswMDAwLCBNaW5hcyBIYXJ1
dHl1bnlhbiB3cm90ZToNCj4+IE9uIDEyLzIvMjAyMSA5OjE3IFBNLCBKb2huIEtlZXBpbmcgd3Jv
dGU6DQo+Pj4gRFdDMiBtYXkgYmUgcGFpcmVkIHdpdGggYSBmdWxsLXNwZWVkIFBIWSB3aGljaCBp
cyBub3QgY2FwYWJsZSBvZg0KPj4+IGhpZ2gtc3BlZWQgb3BlcmF0aW9uLiAgUmVwb3J0IHRoaXMg
Y29ycmVjdGx5IHRvIHRoZSBnYWRnZXQgY29yZSBieQ0KPj4+IHNldHRpbmcgbWF4X3NwZWVkIGZy
b20gdGhlIGNvcmUgcGFyYW1ldGVycy4NCj4+Pg0KPj4+IFByaW9yIHRvIGNvbW1pdCA1MzI0YmFk
NjZmMDlmICgidXNiOiBkd2MyOiBnYWRnZXQ6IGltcGxlbWVudA0KPj4+IHVkY19zZXRfc3BlZWQo
KSIpIHRoaXMgZGlkbid0IGNhdXNlIHRoZSBoYXJkd2FyZSB0byBiZSBjb25maWd1cmVkDQo+Pj4g
aW5jb3JyZWN0bHksIGFsdGhvdWdoIHRoZSBzcGVlZCBtYXkgaGF2ZSBiZWVuIHJlcG9ydGVkIGlu
Y29ycmVjdGx5LiAgQnV0DQo+Pj4gYWZ0ZXIgdGhhdCBjb21taXQgcGFyYW1zLnNwZWVkIGlzIHVw
ZGF0ZWQgYmFzZWQgb24gYSB2YWx1ZSBwYXNzZWQgaW4gYnkNCj4+PiB0aGUgZ2FkZ2V0IGNvcmUg
d2hpY2ggbWF5IHNldCBpdCB0byBhIGZhc3RlciBzcGVlZCB0aGFuIGlzIHN1cHBvcnRlZCBieQ0K
Pj4+IHRoZSBoYXJkd2FyZS4gIEluaXRpYWxpc2luZyB0aGUgbWF4X3NwZWVkIHBhcmFtZXRlciBl
bnN1cmVzIHRoZSBzcGVlZA0KPj4+IHBhc3NlZCB0byBkd2MyX2dhZGdldF9zZXRfc3BlZWQoKSB3
aWxsIGJlIG9uZSBzdXBwb3J0ZWQgYnkgdGhlIGhhcmR3YXJlLg0KPj4+DQo+Pj4gRml4ZXM6IDUz
MjRiYWQ2NmYwOWYgKCJ1c2I6IGR3YzI6IGdhZGdldDogaW1wbGVtZW50IHVkY19zZXRfc3BlZWQo
KSIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9obiBLZWVwaW5nIDxqb2huQG1ldGFuYXRlLmNvbT4N
Cg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5
cy5jb20+DQoNCj4+PiAtLS0NCj4+PiAgICBkcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIHwgMTMg
KysrKysrKysrKysrLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4+PiBpbmRleCBiODg0YTgzYjI2YTZl
Li4yYmMwM2Y0MWM3MGFkIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0
LmMNCj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+Pj4gQEAgLTQ5NzQsNyAr
NDk3NCwxOCBAQCBpbnQgZHdjMl9nYWRnZXRfaW5pdChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcp
DQo+Pj4gICAgCQloc290Zy0+cGFyYW1zLmdfbnBfdHhfZmlmb19zaXplKTsNCj4+PiAgICAJZGV2
X2RiZyhkZXYsICJSWEZJRk8gc2l6ZTogJWRcbiIsIGhzb3RnLT5wYXJhbXMuZ19yeF9maWZvX3Np
emUpOw0KPj4+ICAgIA0KPj4+IC0JaHNvdGctPmdhZGdldC5tYXhfc3BlZWQgPSBVU0JfU1BFRURf
SElHSDsNCj4+PiArCXN3aXRjaCAoaHNvdGctPnBhcmFtcy5zcGVlZCkgew0KPj4+ICsJY2FzZSBE
V0MyX1NQRUVEX1BBUkFNX0xPVzoNCj4+PiArCQloc290Zy0+Z2FkZ2V0Lm1heF9zcGVlZCA9IFVT
Ql9TUEVFRF9MT1c7DQo+Pj4gKwkJYnJlYWs7DQo+Pj4gKwljYXNlIERXQzJfU1BFRURfUEFSQU1f
RlVMTDoNCj4+PiArCQloc290Zy0+Z2FkZ2V0Lm1heF9zcGVlZCA9IFVTQl9TUEVFRF9GVUxMOw0K
Pj4+ICsJCWJyZWFrOw0KPj4+ICsJZGVmYXVsdDoNCj4+PiArCQloc290Zy0+Z2FkZ2V0Lm1heF9z
cGVlZCA9IFVTQl9TUEVFRF9ISUdIOw0KPj4+ICsJCWJyZWFrOw0KPj4+ICsJfQ0KPj4+ICsNCj4+
PiAgICAJaHNvdGctPmdhZGdldC5vcHMgPSAmZHdjMl9oc290Z19nYWRnZXRfb3BzOw0KPj4+ICAg
IAloc290Zy0+Z2FkZ2V0Lm5hbWUgPSBkZXZfbmFtZShkZXYpOw0KPj4+ICAgIAloc290Zy0+Z2Fk
Z2V0Lm90Z19jYXBzID0gJmhzb3RnLT5wYXJhbXMub3RnX2NhcHM7DQo+Pj4NCj4+DQo+PiBKdXN0
IHNldHRpbmcgZ2FkZ2V0J3MgbWF4X3NwZWVkIGRvZXNuJ3QgcmVzb2x2ZSBkZXNjcmliZWQgaXNz
dWUuIEFmdGVyDQo+PiBzZXR0aW5nIGdhZGdldCdzIG1heF9zcGVlZCBpbiB5b3VyIHBhdGNoLCBp
dCBkb2Vzbid0IHVzZWQgaW4gZHJpdmVyIGF0DQo+PiBhbGwuIFBlciBtZSwgeW91IG5lZWQgYWxz
byBmaXggZHdjMl9nYWRnZXRfc2V0X3NwZWVkKCkgZnVuY3Rpb24gYnkNCj4+IGNoZWNraW5nIHJl
cXVlc3RlZCBzcGVlZCB3aXRoIG1heF9zcGVlZDogaWYgcmVxdWVzdGVkIHNwZWVkIGhpZ2hlciB0
aGFuDQo+PiBtYXhfc3BlZWQgdGhlbiBzZXQgc3BlZWQgdG8gbWF4X3NwZWVkLg0KPiANCj4gU2V0
dGluZyB0aGUgbWF4X3NwZWVkIGhlcmUgcmVzdHJpY3RzIHdoYXQgdGhlIGdhZGdldCBjb3JlIHdp
bGwgcGFzcyBpbg0KPiB0byB0aGUgLnVkY19zZXRfc3BlZWQgaG9vaywgc2VlIHVzYl9nYWRnZXRf
dWRjX3NldF9zcGVlZCgpOg0KPiANCj4gCXMgPSBtaW4oc3BlZWQsIHVkYy0+Z2FkZ2V0LT5tYXhf
c3BlZWQpOw0KPiAJdWRjLT5nYWRnZXQtPm9wcy0+dWRjX3NldF9zcGVlZCh1ZGMtPmdhZGdldCwg
cyk7DQo+IA0KPiBXZSBjYW4ndCBhZGQgYSBjaGVjayBpbiBkd2MyX2dhZGdldF9zZXRfc3BlZWQo
KSBiZWNhdXNlIHRoZSBvcmlnaW5hbA0KPiBjYXBhYmlsaXR5IG1heSBoYXZlIGJlZW4gbG9zdCwg
Zm9yIGV4YW1wbGUgaWYgYSBoaWdoLXNwZWVkIGNhcGFibGUNCj4gZGV2aWNlIGlzIGNvbmZpZ3Vy
ZWQgZm9yIGZ1bGwtc3BlZWQgb3BlcmF0aW9uIHRoZW4gaHNvdGctPnBhcmFtcy5zcGVlZA0KPiBp
cyBzZXQgdG8gZnVsbC1zcGVlZCBhbmQgdGhlcmUncyBub3RoaW5nIHRoYXQgc2F5cyB0aGUgZGV2
aWNlIGlzIGNhcGFibGUNCj4gb2YgaGlnaC1zcGVlZCB3aGVuIHNldHRpbmcgdGhlIHNwZWVkIGJh
Y2sgYWdhaW4uDQo+IA0KPiBJIGJlbGlldmUgdGhpcyBwYXRjaCBpcyBzdWZmaWNpZW50IGJlY2F1
c2Ugb2YgdGhlIGd1YXJhbnRlZXMgYnkgdGhlDQo+IGdhZGdldCBjb3JlIHRoYXQgd2Ugd2lsbCBu
ZXZlciBiZSBjYWxsZWQgd2l0aCBhIHNwZWVkIHRoYXQgaXMgZmFzdGVyDQo+IHRoYW4gd2Ugc3Vw
cG9ydC4NCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBKb2huDQo+IA0KDQo=
