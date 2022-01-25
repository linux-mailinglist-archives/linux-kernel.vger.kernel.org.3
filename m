Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34949BC43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiAYThg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:37:36 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33156 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230325AbiAYTgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:36:14 -0500
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 23B19C0A2B;
        Tue, 25 Jan 2022 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643139372; bh=xZ4fYz1Q/98DYZH8l+83D5ZbG+yFoCf/BYnFszTj1jA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jo3rR7NNhgYQZG5IoCd8HoQMCak1rKO54Tck/8M1Zi/I9ZtXf396NaC42b1S+yKXo
         rME4o10wrdACivudhCGS/nkhPoqnz1k3xaApbt+ziDCVNpOcvZ9McmK0l7go6AJZM8
         6EUFn0S62qqDBJ/eED5qbyDTnfHIWBWN5ym91vgNgIHwvXnnfXelv1R9OcSjAko9bt
         T0ZkF1bp0cdCFifUIfjip1QvGsQUIR4asubkfq0qg7VU8nsoZnLTPVQqV+lK8Nn1YH
         bJEPX2ln5n4rF/T5A23KAq8WWgpVkxUMSEp2KJJWtF/Q/WMgeEvf61H3o8S2Ql6fPg
         ozrBWRRRnWlXQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8AE3BA005C;
        Tue, 25 Jan 2022 19:36:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0204A400CE;
        Tue, 25 Jan 2022 19:36:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Z7fgAPB4";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7PvX9Y2L83Cy9YPJnQWOiqBk6cqB1uASQu6dXJwZ+2aRXyBGGwD0ZaVLyrXRJJapp9nLpHMYiyBvrCT0xCCWOCcZUclntYl6P6CY6AcYw8oyuo5XIwOLqH9xN6cQTdihZpjd+j1HliiZwbiDfWfhqqlhOAdOWG195eh9jSmRtUSWGN64p9BR1gG7dPM+L8u0gM0WJPFVlPbd7A7jIptGBw2XQaltxmO/Y1zL7I4qQZBieyXbs/kI3AfZP68yFOX0SowKfVmWx0N+Sf8Iwo8ZQiOHSMeZlx3jz5dkdbAL6RsQ1177MwO0Qbwzzr+3YbdFtgT7xCQmkqW5qlrM/ginw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ4fYz1Q/98DYZH8l+83D5ZbG+yFoCf/BYnFszTj1jA=;
 b=bNMC+rZBhRcpYJ/M2RE9kzIeE8epbpIGc4mzYpnQRiI01+586jLFYPgB/NBEC4x2ZKhW8/vsCtY/SyPOD+osU6PeUt6mzLV4ZCFN8W+8IAuro5XK9eu4XLk0qSOMIurw+WGdIncVrqkRhqncLzqyYQ8KXjnO9Dxj3q4wVMI2XsfAIKEHVvpOlPovx4w1znPBwBVy4a5MsAQPU3Z0LQ8Wm/PBhB0/RceB6y72JnSoL3dbW3tav5JgQfLL+sZDxWj50ElYmaYB83mDw9pxXg698LBPtCfJ5+5yy9ZuqG7D5CyJILCX10XoCVw6wvUxznzfG7ZMqHQHjvLuC72kNUb1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ4fYz1Q/98DYZH8l+83D5ZbG+yFoCf/BYnFszTj1jA=;
 b=Z7fgAPB4DvgvT27ltniJNy0VT++WDOxCaRcMAweFpD4uav83uO5cjmWKIRgyGhs4fTtFs53q9wc3tEazSlt7g7cmTIWgskkZLbsycnYDTwm9pQK/FcCrWBKeOaEv9sG8RjvUzpClCD+hQDOFhlGCaUPtZM+T9HHjVFYRBy2mr0A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN6PR12MB1347.namprd12.prod.outlook.com (2603:10b6:404:1c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 19:36:05 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 19:36:05 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Topic: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Index: AQHYDMsCIy0SvjCLEk29RiHsv2qI76xyzwGAgAAFUACAADPKAIAA7c+AgAA2FAA=
Date:   Tue, 25 Jan 2022 19:36:04 +0000
Message-ID: <524027b7-1361-7cc2-842f-7c20cd4cb016@synopsys.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
 <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
 <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
 <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
 <2831e216-737f-41b2-1aa0-4af56615e3b7@seco.com>
In-Reply-To: <2831e216-737f-41b2-1aa0-4af56615e3b7@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3729f4fe-0535-4eb6-422d-08d9e039ed69
x-ms-traffictypediagnostic: BN6PR12MB1347:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1347634D5A818E96CE6B50FEAA5F9@BN6PR12MB1347.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kaopf7xNE2kR7K9t1fmhfxq7dgd6VY2lN/A+RFh3RpG2aUOEA16YJGXx3s2qUk5KId3I4R8Udr2kdwSxV8uV4M8yb7B1y5iJBeeVKTHGio+WffrswIeuQ5TTp+nj15y5K/yypoSF4nhEDhwNYQZvG5X4Mm6VJwbMX5gP7G5Xb1C88YNFITFgSNXzSQXE5A2jDCwog/v/Ss/HWMQM5/1BHuF4QBH0Gnolw+GMPGRs4l7zmPpFXE7Htmks4wtR0D5krU727GgwGQDlIIo8KdXoDywQrHMZ4oP8JaeEzRD+C+c48cN1Ejp1xxuLga+iTxTmtbacu4F2beSapguh60mwVO3VlokzJ4k/xcOv3d48jyTGchnLQV3BM8/CIiKyjTFcqaX7CFfi6IUyNh/I83cPXr/emErpMU+G25widDLXgRigsqILDnwBJGaFWr5W2rZO7GmA1TIQX58itPkZXM4wSWkaL+p7AR5Lj2XSpYPNpwlQo5tg1ex1f/FCVxevjbWe5EFIaHSx2BmwHx+hP4GijIGWHCGrvi4Ymorb/9JaUC8vVTIjwBkZWEk23Ju+vuRGRVCgBpb4yj4qGGwJkayFkris7pDnovCA0kvt7HehJXqWV2zzVesFfF1zdClILYpmTXTb04AjmwSjoGijqu6C+r2dH3f7zBlaHK7kQ2bkG3I/dTnixnWTwM45UP/uTJPuaVdQ5GNPAMA06NN4233WVDTfet1oLJXtGKL7tkvH6qJRjkgmGhI8MCzs5O06M2LXzH6hTRiyEsaplNoYA1BiW+IyZi7sMPmxYxydvQZOiv3Lkb3q5X0orwFKkPYCZEoC2518s59b5heJjPz3EeSAWr8rXCXR+wJ2eNPiiqHbpCU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(38100700002)(31696002)(71200400001)(66446008)(31686004)(8936002)(6512007)(966005)(8676002)(2906002)(2616005)(122000001)(76116006)(4326008)(186003)(110136005)(6506007)(38070700005)(66556008)(64756008)(26005)(54906003)(86362001)(508600001)(5660300002)(66476007)(66946007)(36756003)(6486002)(316002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVRoNHRKSlFyMnlZaVV4amdwdktsM0MrNUxueW9JQjluekI5YTdyQTc4STAz?=
 =?utf-8?B?Kzh2bGJVWmtNSHpBejVEMko5eitHb2UxM2R1UDhselpEM1pMdytGem9XUStB?=
 =?utf-8?B?WGVlVHpvbUJuWDQ3V0xJbWpFR29sYlpGSzQ0ekZiTEh6U1VIcGVNZDUzTXpx?=
 =?utf-8?B?bk9YQncyaUxjTmtRbmE3N1BHNDJEUFB0cGJ3R3dKaWM4TUU5MEllajJ4eW1W?=
 =?utf-8?B?NzNBRWhPUHMvTnZ2aERiQk9mVC81VHliam44eEFLRm9tZzdpdHROR29QUjNZ?=
 =?utf-8?B?Y1hTQzk4RUxPYUJLdnd2TlZ6NUF5S0xzN3RwYm9KWGx3anpxc28rVHRZcDF1?=
 =?utf-8?B?dWI4bWc3YkJSYnBVRUg2TUNEbHRmaDhtdkJaeThRMHREZ0RvbkZxSWNFcVpq?=
 =?utf-8?B?TWN5Z0EwbGdodmJpbnkwNFJkR2dmQnVCSVBCL0FBSjg0dkxYcHZIbUxHS2p6?=
 =?utf-8?B?NTZxR2UwSjE5TVhUT2IwOFRBK1JjbWY1bUZmU3FNVDdnektiZFhKRTdISmJk?=
 =?utf-8?B?cjRYQ3lQaHd0MDY1SmN1M3M1aXNyVlVVbTcyZGhuUGdZU2kxcm05ZUFiaFpn?=
 =?utf-8?B?d1poK2dVUkg2NU1CMEpnUGJqcUErRDFacXp0YnNoaTNDdXZhcnIyUnBFWEpX?=
 =?utf-8?B?aWpsaXNTam9rQWFXTVNCT1FJTVk4UnJ1OWxvaEVaTjYzTkp1OFhKR2I0VVA0?=
 =?utf-8?B?OHU4WFFzMFlaeEpmRXczZWIwNmRiWmxWUUxzZnREMXpJZytWYWhlcXh0NWhz?=
 =?utf-8?B?Z3pQSVNLSGR0Y2VKS2RsZ3FXSnZhUnNidk4rSWdoMitGVXh6Qk1Wek94Rjlv?=
 =?utf-8?B?NW9sLzR3dW9PdlFSQlJBc2dRbS8rU2t1dWJjdW0yc0lxZjlXNXZJOER3eXFH?=
 =?utf-8?B?cnFMMGNiWFhWL2xFRW5aSFlURnVSOHZRSTEzLzlHUVUzZ1NSM0JYTjdBRlVH?=
 =?utf-8?B?L3BsWnlkd0xvaHJDMlZRZStQQS82dngybzZseEdqeC94Y2l0cm84ZFlRc29x?=
 =?utf-8?B?REpnVHNFam9NMU1RQWEweldxcUtRcWQ5US9Bem1GZVArblFwZXREYXVxUTNo?=
 =?utf-8?B?RGlZcWZHejRNbUgzZlg1SmpEZUxOc1hxcVZRN0pTRjJKQzhYQTRrc1RHaUhJ?=
 =?utf-8?B?ODZvTDFkUERDY1NxUG95WjdGc3dQM3RPUElxNko1WDI3cFJmNnNKekIyUjRQ?=
 =?utf-8?B?Tk9PMFlTZDU2Z2VBMjNJMGE4UlJEWDdsK0R6VWFjMHNPSWNQUGFCRkU5K3pt?=
 =?utf-8?B?TituaVVSZkFjUmZmcm84SUU4V0ltRlNkMzRERGgrVmZkM2lSaXp2VXg3aTk2?=
 =?utf-8?B?Zm96bGdsRTRVUmNRTVhlc1hlTjNoQUJoQUNXdWdGQmtXVEROU3RwVnRQcWMy?=
 =?utf-8?B?alJBNE92V2NZTE9YUDlpOE13aE1TbktEQmhLZUl2RVBxc2VaVnZrOXczWlph?=
 =?utf-8?B?ODJldGllMDJQN3lycDRZS1p6eTRHeWh5bHREWkxKOE5kYnM1UkJ3Slh5QklK?=
 =?utf-8?B?U0tDeDdBcnNZWWpvcEFzL2F6NHRNQWNOYlFlbmNYNit2cG5Na0dwMXA5alh5?=
 =?utf-8?B?MGlaNEg1UzJ2MHhFTm0zT09DTi83azVhQUs2Ujg1UkFjSUVYMEZwTldIcllm?=
 =?utf-8?B?Y2ZMQjFmUDlhTUhUdnFjcTFIWGZOdHJCRXEvZERvcEg0YjM0d3lKSXpiYzJU?=
 =?utf-8?B?OFdEQkRDdHBEOHpkOGVUNjRqcXZpVThRTHF0M3pPRDAwRncybG1KUXBoWVFZ?=
 =?utf-8?B?dlRvdStSeFkyOVcwNk9KSzN0Y1kydTBnMUhmSTNBVE5MajNjQm9rd0xXaVhG?=
 =?utf-8?B?OUg5NXlyZ2gzdUtvRzRnTnNmblJEaWtlL3JJTVpibkhKQ2ZQT0VmOGszVlpk?=
 =?utf-8?B?Q3owT3d1SW9USmpXZFdQZDJzRS93MDJPR3hQb3RPcmU1eno4OXNTNlo1T2g1?=
 =?utf-8?B?VlJDbWp4MUhySzkyT2pXaG9qbE1YSGIvcGlpVlRDUjZkWElXcjZPaTJvaGht?=
 =?utf-8?B?bmljSy8ySDMxK0t2M1dYdHFaSENEcURUZFhlZFltTFRHeUdmMFczRVUwRWkx?=
 =?utf-8?B?clRXNk8rcGxzM1g5ZGt1VXFCRi9rZEtNWjluTGpkTTdWb1U0RzNTVCtTS3pG?=
 =?utf-8?B?NGdRQzNndFlkQ1prRUh3ay92VllKLzlJWDk5ZUhNQzRrTDJFSGVJOWNSRENF?=
 =?utf-8?Q?UKSSa7EGK11MM5zXasK/0I0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E8B17CB74BD9947B48B3939D8A23EC6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3729f4fe-0535-4eb6-422d-08d9e039ed69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 19:36:04.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnzXb+N8WVtHUMssdjYzTUbFyQ0p8C5oxQRXmrnE8I7/3TSDPdjaO56X9EmWzvTwFLgFKSEGaVlFKKo7aPvZVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1347
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gDQo+IA0KPiBPbiAxLzI0LzIyIDk6MTEgUE0sIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4+IFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9u
IDEvMjQvMjIgNTo0NiBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+PiBTZWFuIEFuZGVyc29u
IHdyb3RlOg0KPj4+Pj4gR1VDVEwuUkVGQ0xLUEVSIGNhbiBvbmx5IGFjY291bnQgZm9yIGNsb2Nr
IGZyZXF1ZW5jaWVzIHdpdGggaW50ZWdlcg0KPj4+Pj4gcGVyaW9kcy4gVG8gYWRkcmVzcyB0aGlz
LCBwcm9ncmFtIFJFRkNMS19GTEFESiB3aXRoIHRoZSByZWxhdGl2ZSBlcnJvcg0KPj4+Pj4gY2F1
c2VkIGJ5IHBlcmlvZCB0cnVuY2F0aW9uLiBUaGUgZm9ybXVsYSBnaXZlbiBpbiB0aGUgcmVnaXN0
ZXIgcmVmZXJlbmNlDQo+Pj4+PiBoYXMgYmVlbiByZWFycmFuZ2VkIHRvIGFsbG93IGNhbGN1bGF0
aW9uIGJhc2VkIG9uIHJhdGUgKGluc3RlYWQgb2YNCj4+Pj4+IHBlcmlvZCksIGFuZCB0byBhbGxv
dyBmb3IgZml4ZWQtcG9pbnQgYXJpdGhtZXRpYy4NCj4+Pj4+DQo+Pj4+PiBBZGRpdGlvbmFsbHks
IGNhbGN1bGF0ZSBhIHZhbHVlIGZvciAyNDBNSFpERUNSLiBUaGlzIGNvbmZpZ3VyZXMgYQ0KPj4+
Pj4gc2ltdWxhdGVkIDI0ME1oeiBjbG9jayB1c2luZyBhIGNvdW50ZXIgd2l0aCBvbmUgZnJhY3Rp
b25hbCBiaXQgKFBMUzEpLg0KPj4+Pj4NCj4+Pj4+IFRoaXMgcmVnaXN0ZXIgaXMgcHJvZ3JhbW1l
ZCBvbmx5IGZvciB2ZXJzaW9ucyA+PSAyLjUwYSwgc2luY2UgdGhpcyBpcw0KPj4+Pj4gdGhlIGNo
ZWNrIGFsc28gdXNlZCBieSBjb21taXQgZGIyYmU0ZTllMzBjICgidXNiOiBkd2MzOiBBZGQgZnJh
bWUgbGVuZ3RoDQo+Pj4+PiBhZGp1c3RtZW50IHF1aXJrIikuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVk
LW9mZi1ieTogU2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBzZWNvLmNvbT4NCj4+Pj4+IC0t
LQ0KPj4+Pj4NCj4+Pj4+IENoYW5nZXMgaW4gdjI6DQo+Pj4+PiAtIEFsc28gcHJvZ3JhbSBHRkxB
REouMjQwTUhaREVDUg0KPj4+Pj4gLSBEb24ndCBwcm9ncmFtIEdGTEFESiBpZiB0aGUgdmVyc2lv
biBpcyA8IDIuNTBhDQo+Pj4+Pg0KPj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMzcg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4+Pj4gIGRyaXZlcnMvdXNi
L2R3YzMvY29yZS5oIHwgIDMgKysrDQo+Pj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+Pj4+PiBpbmRleCA1
MjE0ZGFjZWRhODYuLjg4M2UxMTkzNzdmMCAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPj4+Pj4g
QEAgLTM0OCw3ICszNDgsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2ZyYW1lX2xlbmd0aF9hZGp1c3Rt
ZW50KHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4+PiAgc3RhdGljIHZvaWQgZHdjM19yZWZfY2xrX3Bl
cmlvZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+Pj4gIHsNCj4+Pj4+ICAJdTMyIHJlZzsNCj4+Pj4+
IC0JdW5zaWduZWQgbG9uZyByYXRlLCBwZXJpb2Q7DQo+Pj4+PiArCXVuc2lnbmVkIGxvbmcgZGVj
ciwgZmxhZGosIHJhdGUsIHBlcmlvZDsNCj4+Pj4NCj4+Pj4gTWlub3Igc3R5bGUgbml0OiBGZWxp
cGUgcHJlZmVycyB0byBrZWVwIHRoZSBkZWNsYXJhdGlvbiBvbiBzZXBhcmF0ZQ0KPj4+PiBsaW5l
cywgbGV0J3Mga2VlcCBpdCBjb25zaXN0ZW50IHdpdGggdGhlIHJlc3QgaW4gdGhpcyBkcml2ZXIu
DQo+Pj4NCj4+PiBTbyANCj4+Pg0KPj4+IHVuc2lnbmVkIGludCBkZWNyOw0KPj4+IHVuc2lnbmVk
IGludCBmbGFkajsNCj4+PiB1bnNpZ25lZCBpbnQgcmF0ZTsNCj4+PiB1bnNpZ25lZCBpbnQgcGVy
aW9kOw0KPj4+DQo+Pj4gPw0KPj4+DQo+Pj4gRnJhbmtseSB0aGF0IHNlZW1zIHJhdGhlciB2ZXJi
b3NlLg0KPj4NCj4+IEEgY291cGxlIG9mIHRoZSBiZW5lZml0cyBvZiBoYXZpbmcgaXQgbGlrZSB0
aGlzIGlzIHRvIGhlbHAgd2l0aCB2aWV3aW5nDQo+PiBnaXQtYmxhbWUgaWYgd2UgaW50cm9kdWNl
IG5ldyB2YXJpYWJsZXMgYW5kIGhlbHAgd2l0aCBiYWNrcG9ydGluZyBmaXgNCj4+IHBhdGNoIGEg
Yml0IHNpbXBsZXIuIE1haW5seSBJJ20ganVzdCBmb2xsb3dpbmcgRmVsaXBlJ3Mgc3R5bGUgYW5k
IGtlZXANCj4+IGl0IGNvbnNpc3RlbnQgaW4gdGhpcyBkcml2ZXIsIGJ1dCBJIGRvbid0IHRoaW5r
IGl0J3MgYSBiaWcgZGVhbC4NCj4gDQo+ICpzaHJ1ZyoNCj4gDQo+IElmIGl0J3MgdGhlIHN1YnN5
c3RlbSBzdHlsZSBJIHdpbGwgcmV3cml0ZSBpdC4NCj4gDQoNCkZlbGlwZSBhbHNvIHByZWZlcnMg
UmV2ZXJzZSBDaHJpc3RtYXMgVHJlZSBzdHlsZS4NCg0KPiAoYnR3IGlzIHRoaXMgZG9jdW1lbnRl
ZCBhbnl3aGVyZSBmb3IgZnV0dXJlIGNvbnRyaWJ1dG9ycz8pDQo+IA0KDQpJIGRvbid0IHRoaW5r
IGl0J3MgZG9jdW1lbnRlZCwgYnV0IEZlbGlwZSBOYWsnZWQgcGF0Y2hlcyB0aGF0IGRvbid0DQpm
b2xsb3cgdGhpcyBzdHlsZSBiZWZvcmUuIEkgZG9uJ3Qgd2FudCB0aGlzIHRvIGJlIHRoZSBtYWlu
IGZvY3VzIG9mIHRoZQ0KY29udmVyc2F0aW9uIGZvciB0aGlzIHBhdGNoLCBidXQgSSBkb24ndCB3
YW50IGl0IHRvIGdvIHVubm90aWNlZCBlaXRoZXIuDQoNCllvdXIgY29uY2VybiBpcyBub3QgYWxv
bmUgcmVnYXJkaW5nIGRvY3VtZW50IChvciB0aGUgbGFja2luZyBvZikgZm9yDQpkaWZmZXJlbnQg
c3Vic3lzdGVtLXNwZWNpZmljIHN0eWxlcy4NCg0KKHNlZSBodHRwczovL2x3bi5uZXQvQXJ0aWNs
ZXMvNzU4NTUyLykNCg0KPj4+DQo+Pj4+PiAgDQo+Pj4+PiAgCWlmIChkd2MtPnJlZl9jbGspIHsN
Cj4+Pj4+ICAJCXJhdGUgPSBjbGtfZ2V0X3JhdGUoZHdjLT5yZWZfY2xrKTsNCj4+Pj4+IEBAIC0z
NTcsNiArMzU3LDcgQEAgc3RhdGljIHZvaWQgZHdjM19yZWZfY2xrX3BlcmlvZChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPj4+Pj4gIAkJcGVyaW9kID0gTlNFQ19QRVJfU0VDIC8gcmF0ZTsNCj4+Pj4+ICAJ
fSBlbHNlIGlmIChkd2MtPnJlZl9jbGtfcGVyKSB7DQo+Pj4+PiAgCQlwZXJpb2QgPSBkd2MtPnJl
Zl9jbGtfcGVyOw0KPj4+Pj4gKwkJcmF0ZSA9IE5TRUNfUEVSX1NFQyAvIHBlcmlvZDsNCj4+Pj4+
ICAJfSBlbHNlIHsNCj4+Pj4+ICAJCXJldHVybjsNCj4+Pj4+ICAJfQ0KPj4+Pj4gQEAgLTM2NSw5
ICszNjYsNDEgQEAgc3RhdGljIHZvaWQgZHdjM19yZWZfY2xrX3BlcmlvZChzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPj4+Pj4gIAlyZWcgJj0gfkRXQzNfR1VDVExfUkVGQ0xLUEVSX01BU0s7DQo+Pj4+PiAg
CXJlZyB8PSAgRklFTERfUFJFUChEV0MzX0dVQ1RMX1JFRkNMS1BFUl9NQVNLLCBwZXJpb2QpOw0K
Pj4+Pj4gIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VDVEwsIHJlZyk7DQo+Pj4+PiAr
DQo+Pj4+PiArCWlmIChEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAyNTBBKSkNCj4+Pj4+ICsJCXJl
dHVybjsNCj4+Pj4+ICsNCj4+Pj4+ICsJLyoNCj4+Pj4+ICsJICogVGhlIGNhbGN1bGF0aW9uIGJl
bG93IGlzDQo+Pj4+PiArCSAqDQo+Pj4+PiArCSAqIDEyNTAwMCAqIChOU0VDX1BFUl9TRUMgLyAo
cmF0ZSAqIHBlcmlvZCkgLSAxKQ0KPj4+Pj4gKwkgKg0KPj4+Pj4gKwkgKiBidXQgcmVhcnJhbmdl
ZCBmb3IgZml4ZWQtcG9pbnQgYXJpdGhtZXRpYy4NCj4+Pj4+ICsJICoNCj4+Pj4+ICsJICogTm90
ZSB0aGF0IHJhdGUgKiBwZXJpb2Qgfj0gTlNFQ19QRVJfU0VDT05ELCBtaW51cyB0aGUgbnVtYmVy
IG9mDQo+Pj4+PiArCSAqIG5hbm9zZWNvbmRzIG9mIGVycm9yIGNhdXNlZCBieSB0aGUgdHJ1bmNh
dGlvbiB3aGljaCBoYXBwZW5lZCBkdXJpbmcNCj4+Pj4+ICsJICogdGhlIGRpdmlzaW9uIHdoZW4g
Y2FsY3VsYXRpbmcgcmF0ZSBvciBwZXJpb2QgKHdoaWNoZXZlciBvbmUgd2FzDQo+Pj4+PiArCSAq
IGRlcml2ZWQgZnJvbSB0aGUgb3RoZXIpLiBXZSBmaXJzdCBjYWxjdWxhdGUgdGhlIHJlbGF0aXZl
IGVycm9yLCB0aGVuDQo+Pj4+PiArCSAqIHNjYWxlIGl0IHRvIHVuaXRzIG9mIDAuMDglLg0KPj4+
Pj4gKwkgKi8NCj4+Pj4+ICsJZmxhZGogPSBkaXY2NF91NjQoMTI1MDAwVUxMICogTlNFQ19QRVJf
U0VDLCAodTY0KXJhdGUgKiBwZXJpb2QpOw0KPj4+Pg0KPj4+PiBDYW4gd2UgcmVhcnJhbmdlIHRo
ZSBtYXRoIHNvIHdlIGRvbid0IGhhdmUgdG8gb3BlcmF0ZSBvbiBkaWZmZXJlbnQgZGF0YQ0KPj4+
PiB0eXBlIGFuZCBkZWFsIHdpdGggY29udmVyc2lvbi90cnVuY2F0aW9uPw0KPj4+DQo+Pj4gSSBk
b24ndCB1bmRlcnN0YW5kIHdoYXQgZGF0YSB0eXBlcyB5b3UgYXJlIHJlZmVycmluZyB0by4NCj4+
Pg0KPj4+IFRoZSB0cnVuY2F0aW9uIGFib3ZlIChpbiB0aGUgY2FsY3VsYWlvbiBmb3IgcmF0ZS9w
ZXJpb2QpIGlzIGludGVudGlvbmFsLA0KPj4+IHNvIHdlIGNhbiBkZXRlcm1pbmUgdGhlIGVycm9y
IGludHJvZHVjZWQgYnkgcmVwcmVzZW50aW5nIHBlcmlvZCB1c2luZw0KPj4+IG9ubHkgbnMuDQo+
Pg0KPj4gSSB3YXMgd29uZGVyaW5nIGlmIHdlIHJlYXJyYW5nZSB0aGUgbWF0aCBzbyB3ZSBkb24n
dCBuZWVkIHRvIGNhc3QgYW5kDQo+PiB1c2UgNjQtYml0IGhlcmUsIGJ1dCB0aGF0IG1heSBub3Qg
YmUgcG9zc2libGUuIEp1c3QgY29tcHV0aW5nL3Jldmlld2luZw0KPj4gaW4gbXkgaGVhZCB3aGls
ZSBhY2NvdW50aW5nIGZvciB0cnVuY2F0aW9uIGZyb20gNjQtYml0IHRvIDMyLWJpdCB2YWx1ZQ0K
Pj4gaXMgdGF4aW5nLg0KPiANCj4gV2VsbCB0aGUgcHJpbWFyeSBpc3N1ZSBpcyB0aGF0IGxvZ18y
KDEyNTAwMFVMTCAqIE5TRUNfUEVSX1NFQykgfj0gNDksIHNvDQo+IHdlIGhhdmUgdG8gdXNlIDY0
LWJpdCBpbnRlZ2VycyBpZiB3ZSBkb24ndCB3YW50IHRvIGRvIGFueSBzaGlmdGluZyBvZg0KPiB0
aGUgbnVtZXJhdG9yLiBJdCBtaWdodCBiZSBwb3NzaWJsZSB0byBhbmFseXplIHRoZSBzaWduaWZp
Y2FudCBiaXRzDQo+IHRocm91Z2ggdGhlIGNhbGN1bGF0aW9uIGFuZCBkZXRlcm1pbmUgdGhhdCB3
ZSBjYW4gdXNlIGxlc3MgcHJlY2lzaW9uIGZvcg0KPiBzb21lIG9mIHRoZSBpbnRlcm1lZGlhdGUg
Y2FsY3VsYXRpb25zLCBidXQgSSBoYXZlbid0IGRvbmUgdGhhdCBhbmFseXNpcy4NCj4gSU1PIHRo
YXQgc29ydCBvZiB0cmFuc2Zvcm1hdGlvbiB3b3VsZCBsaWtlbHkgbWFrZSB0aGUgY2FsY3VsYXRp
b25zIG1vcmUNCj4gZGlmZmljdWx0IHRvIHVuZGVyc3RhbmQsIG5vdCBsZXNzLg0KDQpGYWlyIGVu
b3VnaC4NCg0KVGhhbmtzLA0KVGhpbmgNCg0K
