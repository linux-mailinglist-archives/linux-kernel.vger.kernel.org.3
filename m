Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27949BCAB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiAYUDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:03:54 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34518 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231802AbiAYUCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:02:51 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 626E6C0A14;
        Tue, 25 Jan 2022 20:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643140969; bh=5Uce1qk3InLnLPl++fo6LdFxBqDFvQLoKHinPPnpsd8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mCjDLOWPzojSytA14DaKqgxAltTmKgsO1A47xgHxenqEdrKpdm0rz+h6nowRnaWg5
         jvaDUCdMhXAvB4q16aJ5F0hu8PIlRn3dYJ5toaHCbcVGeYm8MS8/AAv2JXjpLl/Xla
         3jC28aNbh/zTnd64REC6mkNfaUZqKYw2FzUqd39pQQa9Mu8pYBFJfVJoL56kdGLxzK
         jk0nE7vVJGoYPlckLNtZqRvZdJKfxUo4GScgb9XRUaKar3X+e8PulqIjonsTd/HymL
         G2bDTVCR7SIch0UWcCdQcFSKWybshccnIrIuWR53kBPU1N1LZMYDn3DdtKnb+/p8NO
         SVaBbYFzOOGyA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 60555A0099;
        Tue, 25 Jan 2022 20:02:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 05A43400CE;
        Tue, 25 Jan 2022 20:02:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="eLXuW2Og";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgHclU0iidQtoIUcoHsaLjdBGH6rmBe5rAQ6Scfp5+JatX00UvZ6FBLVOaqHtNtUwGd8MOqOugnCSXu2N+MHpS79oqQZ2fMmQvfOOigOO8LuwP6g4b+JvDkNtxqQNoqIOfFCccJCpSH7rX19f2l5CoGzJk4f9zSbipNidLCiOqGVdaqUAwuqNUO6QRXl/Cwv4av4fsRAk9eF/OE/YXWldbQZ6LnBr13DCkrKBWnuSlLV4FAPMZRffwAmdDdCwHk7Hv+wZjXJdxqVOuJOMApN+pwfp6KAyolzQiuTkBFoGvLiNWYMq6K5j/KEU3L2WuQJLJLN+wr5GQy/uxuTssjDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Uce1qk3InLnLPl++fo6LdFxBqDFvQLoKHinPPnpsd8=;
 b=cVej1I7e/haz8EgRqulVli2LzNy1t6UZzjwnKa/fdYbv6po3G0l2eMSI2dpv6cEE+HqGU7GiJ+GKHez2CsfLbUHVRcmSvSqxWZeeL9EKcbk39W8n9imiKH7GU+oRh1LQ5iBC5wRIfFT1es95c39viEioJ25Zh7452aWIw+uuUJ3tYfcsrSGIxekzPGZXoFM84CBp3M+zlI53ZLiUx6PedAz7RQEz3CXMMhsbBBfYy3Z+QwWI0VEZmCTm/y7NukgV2Hmc68O0aFPvdXcizoR3HdxUpMof2fjTNA2Jvg7knd+3IiWlE6sCIoHYEDRcqI97bl8hTe8i1NScsFRjzIPD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uce1qk3InLnLPl++fo6LdFxBqDFvQLoKHinPPnpsd8=;
 b=eLXuW2OgzswitpI5dMWUY8c3lSYGUR+lv55TQvDQCzwN/tfrCpyclFXqaQ98jytvVydSdSLWoE3ajqrKFlKWMkWwcmcXxiuC7msk/Abm6Fob9qc5/YedXIOVZ2MyJMLbQNOXIOBpWgepB/9KDY5BdbuRUlj7pKfw6HlWI/PSflI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 20:02:43 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 20:02:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Topic: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Index: AQHYDMsCIy0SvjCLEk29RiHsv2qI76xyzwGAgAAFUACAADPKAIAARM6AgADmhgA=
Date:   Tue, 25 Jan 2022 20:02:43 +0000
Message-ID: <cb9181f6-2920-8a7c-effc-c1cca20b1b44@synopsys.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
 <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
 <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
 <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
 <87r18w72uy.fsf@kernel.org>
In-Reply-To: <87r18w72uy.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48c5ddb5-4e5b-4aad-b45a-08d9e03da633
x-ms-traffictypediagnostic: CH0PR12MB5371:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5371E176DC767D4AB8C04787AA5F9@CH0PR12MB5371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pffdVZTmhD9HEt3pzt0fA+YLyr7496ARISs+HGWVM8dceroyjOQ2ZLipSm+S2UX29EBEA11UDxex3AJfgir0tTlaLwEJFV0XQRmkfDQXTqlseGYjZMru4jhbLinX/pMrxaHaZIGgq660lCZ1fMkFK9KwHlkksaqt4jBvhXZ1uYA0sZQnBESQhJtiRjU80fWQqsgE4c7kXcazVe7z/84pBZsbKsZCEBRkFiqClGoc4bMdVJ/7zKKpReQ6FcGPz/ee+ndyAx3iDMmjXcwknWili2lQ41CnwyV5K+zryDmfXVcS4S8NnhCxmdxkPeIaTk6y/6W/mVxmSYCerPwMQW0zgU404njCG34Rg7+QMZdmiy7yhVpjNZp4f0rjR3oXF1Eo6Rot0TED0hq9jQltV0KJejbe+hd8daz7mbzyHp7tiMCwnrRTQetvXSgWiGYnPzcFF5kPd9KKdnecG447cBj5yAy2HA7QQdZtKWBjG69yfgysoYiM1OsbWdEuITPwQAa6mjh6vqolQ+V7ZVHTczSDqwfp/5YpCUaNu7uPKVbdvAx+tK7HNOQv6n39l8V61s41nRCKLFiEARlLR4FLjEQBGb+ZRm5K4JyTGcCk4/WsCskbW/VcjETjVOMzEqgBxLeML3hAKLTdI9Kq5pq9X6pJxGIUqKrG80ip23riK9poNu/MJDkD/d0oE2JqMyLIDxtAMsicR3VeHxnycrI1NE87omSM/Byk3Y1NtMoUvXbk7HHI3usSTeKXWHxlzG0bA1cb9+gZ8PTKZerVdbi94fznQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(316002)(76116006)(6512007)(2906002)(31696002)(38070700005)(71200400001)(6486002)(54906003)(8936002)(186003)(4326008)(36756003)(508600001)(38100700002)(26005)(5660300002)(66556008)(64756008)(53546011)(66446008)(110136005)(66476007)(66946007)(6506007)(8676002)(122000001)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZURTYUFjeGR6elNwWWZhaCt4M2dxcm9LWFJJYnFSNjQwcXZJdWQvM1gzT0dv?=
 =?utf-8?B?UGRVQVJkNE1Xb2liQjBnN1RrNDNVemkraU5wdGhGNU9ZUkRVdUV1dWRFbHlO?=
 =?utf-8?B?STh2d2dqT3NSakZwMlRqRWI4ZUFzbGxlRG5HS2w1amYvRmZHQVpDOTRhLzB4?=
 =?utf-8?B?VFZNV0xKZklvUkpmd2tyM2JOTzc5dUczUk5IcElsZEc4MmttUUI5NUo5YzVE?=
 =?utf-8?B?cnpqYVh4aVNNZWFmQVdJNVR1SFFpbVJ0ODE5N0dua1JTcXFIY05nNkp4NzVD?=
 =?utf-8?B?WHVteHo1MFM3M2V5K1JWTW14SWMyYzNmQkZVdTVYdndHSXhINDZXUTFxUzd4?=
 =?utf-8?B?c043eHZaOHc1YldYaW9GVjJrR1VDeEJ6U21ocGJvVHJhL09uTStBeHRPRVc1?=
 =?utf-8?B?SHQyZ1AwblJJbmoxeHJZTW5udlBCSGtuWXBLc1dLSHdBODlTY1BNL2ZKSS9q?=
 =?utf-8?B?VFFQa0tCVUs4clIyZDhmOGhlTTMvWTROaWppMTZhVTVNV3ZReDhGM0FSbklU?=
 =?utf-8?B?SlhtZnFkNW9FMHBWMm5NZkt3ZjkvOVgweVdWOERTRUhLZjN1b1RWTWtvaVIv?=
 =?utf-8?B?Vi8rUTd4ZytLbWc2YTE4d0daVExIdTZ5LzRTRUV3dVFVWkgxM21ZUmdOTEcx?=
 =?utf-8?B?aElSaDYwWFRzZ1NGeVVKdUlub2JWT2x2RGRpcUcwbkNvRVJvTmU3MmZTQThN?=
 =?utf-8?B?eGZ1UFBBNEViZDN4M0Rzb0hsbFpqbThoWlFiY3F3REF3UjRxbHFBR0tjUTNa?=
 =?utf-8?B?cy9LSkNnVFVPNWZpdTVIcFRxQW9GcmhHK05QSG40MEtxYVZyWENWcy84M2Vx?=
 =?utf-8?B?bU90dlVldG9MWTNCRktoREQyWG5EbGlpeE9aeXZoa3lwZzFwZU1IbFU4eWZj?=
 =?utf-8?B?QVBQTVZCeFJLdU0rMjNLSEtCRlFQUFpybllLUW5teStoUGtsSU41UjNzb2o4?=
 =?utf-8?B?M1R2RWRLZEZ4L0VqeWpmZmJpYlVtemFVemhLaGZXaG9DQkd1dXRuZXBuMDc5?=
 =?utf-8?B?M2h3Sk1EY3dpSEpwbTRVZCt3TFROTDg0TklZb3JidHVHbXVmcFZ2NHB0R0k5?=
 =?utf-8?B?M2djM1d2NHZkbE5adnFhZ0pyU1hqTUNGRU1IQ3UvTm56dXk4Njd2VEt2NFEw?=
 =?utf-8?B?RFhuZTUzZkhHRkEwMFB4TkdFTllIQkh2ZFoyOGR6S1NnZ083bks2NkJGK3Ay?=
 =?utf-8?B?ejM1YVV4Y2RNSFBVcEdFK3RQeGhHY2hqbHMyOXd5ajJOU252RDA4RHRKMVlK?=
 =?utf-8?B?cUFPOEtBUU52SStyS1BadEJ0YVduSFEwQXo1T0R4UFdHRHdDYThobElGWjBr?=
 =?utf-8?B?MzFraDFZNm04TE5XVVltOEg1ZzVaNG9nTFFYRVlSaGJ3cURWWW1abllzZGFD?=
 =?utf-8?B?U2RRQzdNZk5VTFordW12b0VSczF5cUJlbGRUS0lQTUNlcTlXSkFSY1hhRXQ3?=
 =?utf-8?B?aTZEbHF2Y2tUMVV6OTZhaWoyK3lTSmlMNk5rd1pIOVZpR3hrTUpHUGJtbGZu?=
 =?utf-8?B?L0cvVTl5Tzk5Z3lmdTRreElhN2JrbklJOExsRUhQUjA4RHNyYUpvSE5QRDJn?=
 =?utf-8?B?RGR3am9wa1FmUGYxbTd1TnYza2tNZ2d5b0lEMHVqUm1zU2ZJaWMxQlBXeks5?=
 =?utf-8?B?QUQ4aXk4bzR6MWt5L2E0Y3FzdnZRRG9ZOGpES1BHZW96Yms5dmlNanJISFBs?=
 =?utf-8?B?T1Y3MmFqOFZka1d0VkQ2ejJ1VUlrTTVwd2ltcUEvOStPd292M1UwdGRtcldV?=
 =?utf-8?B?MXNmZVhDRWdIbHlKUjNLdERHNElPZGVUTks1aWwvRENpYnhzcUpFZ3ZSTTVk?=
 =?utf-8?B?QktHSlBxakVkS25DSTc3MDFteC9ENjc0QWJxQzEzZ1RxRmxFNVpadDVUL05t?=
 =?utf-8?B?SVlVaWtOb1BmcDBVY0JZdDFBc2I1c3g4V3M5T2d2alpDL290d09KTDBtb3BO?=
 =?utf-8?B?c3JEQVMrOFVyVXVwZ05TWlpxeC91ekpvS2h0RE52cmR4UzZNb3pROE9KNzJT?=
 =?utf-8?B?dkVJTENkaC9RN1NLYWdlL3BtQTl3M0lwM0NEa2plOGN4Ym5lTnJiTnhCWFlP?=
 =?utf-8?B?RFdxSU1DazhCRG9RV0drdVI1VHJ2NElCTEZhd0dvNzRuUUtUQzEzdWVuUThk?=
 =?utf-8?B?emNjV1NqblR0czhKdGZybDlYNEJVUWVuT0s3WFFnT3kwaDg0R2N6MEM3d1JR?=
 =?utf-8?Q?niwFBFQhLfIiVjZFe9p5MOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B05744E3FA647740ABF73E33A15E5BF1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c5ddb5-4e5b-4aad-b45a-08d9e03da633
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 20:02:43.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdXnvG4GuRPl90uCYKDUSBCr7Ko3ymIHIX8Qh6/pMUodH/FHP5nVyFkACtieIKpzFty/9qbOrbqtKhGgwXAlKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVsaXBlIEJhbGJpIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+IHdyaXRlczoNCj4+PiBPbiAxLzI0LzIyIDU6NDYgUE0sIFRo
aW5oIE5ndXllbiB3cm90ZToNCj4+Pj4gU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+Pj4+PiBpbmRleCA1MjE0ZGFjZWRhODYuLjg4M2UxMTkzNzdmMCAxMDA2NDQNCj4+Pj4+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPj4+Pj4gQEAgLTM0OCw3ICszNDgsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2ZyYW1l
X2xlbmd0aF9hZGp1c3RtZW50KHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4+PiAgc3RhdGljIHZvaWQg
ZHdjM19yZWZfY2xrX3BlcmlvZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+Pj4gIHsNCj4+Pj4+ICAJ
dTMyIHJlZzsNCj4+Pj4+IC0JdW5zaWduZWQgbG9uZyByYXRlLCBwZXJpb2Q7DQo+Pj4+PiArCXVu
c2lnbmVkIGxvbmcgZGVjciwgZmxhZGosIHJhdGUsIHBlcmlvZDsNCj4+Pj4NCj4+Pj4gTWlub3Ig
c3R5bGUgbml0OiBGZWxpcGUgcHJlZmVycyB0byBrZWVwIHRoZSBkZWNsYXJhdGlvbiBvbiBzZXBh
cmF0ZQ0KPj4+PiBsaW5lcywgbGV0J3Mga2VlcCBpdCBjb25zaXN0ZW50IHdpdGggdGhlIHJlc3Qg
aW4gdGhpcyBkcml2ZXIuDQo+Pj4NCj4+PiBTbyANCj4+Pg0KPj4+IHVuc2lnbmVkIGludCBkZWNy
Ow0KPj4+IHVuc2lnbmVkIGludCBmbGFkajsNCj4+PiB1bnNpZ25lZCBpbnQgcmF0ZTsNCj4+PiB1
bnNpZ25lZCBpbnQgcGVyaW9kOw0KPj4+DQo+Pj4gPw0KPj4+DQo+Pj4gRnJhbmtseSB0aGF0IHNl
ZW1zIHJhdGhlciB2ZXJib3NlLg0KPj4NCj4+IEEgY291cGxlIG9mIHRoZSBiZW5lZml0cyBvZiBo
YXZpbmcgaXQgbGlrZSB0aGlzIGlzIHRvIGhlbHAgd2l0aCB2aWV3aW5nDQo+PiBnaXQtYmxhbWUg
aWYgd2UgaW50cm9kdWNlIG5ldyB2YXJpYWJsZXMgYW5kIGhlbHAgd2l0aCBiYWNrcG9ydGluZyBm
aXgNCj4gDQo+IGl0IGFsc28gcHJldmVudHMgc2luZ2xlIGxpbmVzIGZyb20gYmVpbmcgY29uc3Rh
bnRseSBtb2RpZmllZCBqdXN0DQo+IGJlY2F1c2Ugd2UncmUgYWRkaW5nIGEgbmV3IHZhcmlhYmxl
LiBJbiB0aGUgZGlmZiwgYWRkaW5nIGEgbmV3IHZhcmlhYmxlDQo+IHNob3VsZCBsb29rIGxpa2Ug
YSBuZXcgbGluZSBiZWluZyBhZGRlZCwgcmF0aGVyIHRoYW4gbW9kaWZpZWQuDQo+IA0KDQpSaWdo
dC4NCg0KPj4gcGF0Y2ggYSBiaXQgc2ltcGxlci4gTWFpbmx5IEknbSBqdXN0IGZvbGxvd2luZyBG
ZWxpcGUncyBzdHlsZSBhbmQga2VlcA0KPiANCj4gaXQncyBwYXJ0IG9mIHRoZSBrZXJuZWwgY29k
aW5nIHN0eWxlLCBhY3R1YWxseSA6LSkNCj4gDQoNCkdsYWQgdG8gc2VlIHlvdSdyZSBoZXJlIDop
DQoNCkJSLA0KVGhpbmgNCg==
