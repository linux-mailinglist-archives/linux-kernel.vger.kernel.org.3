Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC844A7E93
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 05:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349270AbiBCENw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 23:13:52 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59932 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242888AbiBCENt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 23:13:49 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7DBABC011F;
        Thu,  3 Feb 2022 04:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643861629; bh=t/Llgx6O1lbTMjFvdvMDY0Ucf5SNekUYQ78p6FMYXHE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O0jvOlzDPDkOXawjwLEsCgdCoTJyxtCDBmy/Q3jLftR6yjiSwm9+hNGHefu2AjfBL
         wricyfyn1UqlSGsPsFrXYa7UiuCQUNpKkq4YUt2xt/SIMk/TyFgjRXWlIutBrEA1LL
         ZghyI0C8fuSJveigCbVJYwu52Up6n/6Xc43t1wb6qa+1/hIGswLbD4W8urRGCZmreH
         Na7V3a4ZSwzPdJ/3eeu6oQfQz961sxTREhn306EjIBTDoisaq9rCebzleI51TTSQ1/
         RuZTB//ew7/6jmZ0yW6ttbDEPXnjGphdN4A7ZmXa4sQvdLMLB6XyTlhGbqukX0vkin
         uU2JaFfm/lD1g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3F1CEA00AB;
        Thu,  3 Feb 2022 04:13:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EBD6D40015;
        Thu,  3 Feb 2022 04:13:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="PWbog+dj";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+700PGxKMIXyhscCzE4GvWi8RiZZhKkUzTTsVxoKlIGTKQloZhQg8YnMj6kIXNP+VqsSkELy/o4RNAGEIraki0PusqwJMmrV0HqH9HMBJVC3HUtuuu/uKqdFaY4CKmHecy0DxMJpXZe44AZbQVNp5InhxsC3WazqI8N2RElT+0wZ92Y2bZhwrd3TCc4FMfTx0Wm57u7fRXOHaAo/k4slc9XokqgppYRcBnFquSS0o29nDPlbsakltpWvIP3pNXfV2Dhht49i879AWnIt7l3TfPzSQhyVQLe/acVKlpl+oA6i1IR0FadRynCf/TBHeaJV8Kf3TWOa717iTDgbqqQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/Llgx6O1lbTMjFvdvMDY0Ucf5SNekUYQ78p6FMYXHE=;
 b=jPtU+L8+8XAGWrlHeaRyvXR0WHz3ZSHg4RaFo7IvJhw+H2ixDzuFw0hzLT5QhbJItFXVenLx6MNy20o8C2XYhCMUJEBODZqyEAOgHEtoBHOlG3RQhmfGZlUBvSblU0EVFNt6quvud6yWNk1rNqyu8lOBMC+Ox4dzKqOcXiNmWKABIyUQaznE2KEI6xunXkrQx+v0MotqL30nxxLYzPa6AdgExTuZaFXGqKZ/lABPZ9gk5sdgAlKqmEWtnaSsdMR/TUzb1DqVnaX979bGf0Nv4gBHXBYbfkmA2QmVBu7PQYRW4FlLK+glIcdnisAkk1P0iozK8HsIK8wgbaxElaesHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/Llgx6O1lbTMjFvdvMDY0Ucf5SNekUYQ78p6FMYXHE=;
 b=PWbog+djGxxcyu38H5ltW63uLSjcLstUaLhw8U0WJuVhyNphdOHTG+UMX+XhGe1yrS323tdnUvaJoNOxRsi+Dw372w+VWcQti3YiWzG4SO1G5hSU6UE+JTf+5YKunvyEwc59dRIxGGGKSrHI9Nv2gVuDnGDIyFqUfVhz9kB6xuo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 3 Feb
 2022 04:13:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 04:13:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Prioritize extcon over USB role switching API
Thread-Topic: [PATCH] usb: dwc3: Prioritize extcon over USB role switching API
Thread-Index: AQHYFtfE0uDHnqoRTUCfYSch4bkt3ayBJPaAgAAL7ICAAApEAA==
Date:   Thu, 3 Feb 2022 04:13:39 +0000
Message-ID: <9445cfe4-ce4f-09af-5073-4e06375e2bb3@synopsys.com>
References: <20220131192102.4115473-1-andrew.smirnov@gmail.com>
 <e0e36d42-5479-fd8c-3868-384161031738@synopsys.com>
 <CAHQ1cqHUNtO_S5NnmdBmhba5+S8pOArA00G2eBXeWLo5smjPxQ@mail.gmail.com>
In-Reply-To: <CAHQ1cqHUNtO_S5NnmdBmhba5+S8pOArA00G2eBXeWLo5smjPxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03e807fd-e221-41bd-e103-08d9e6cb8e9c
x-ms-traffictypediagnostic: BYAPR12MB3592:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3592A81BCE0E6CACD06CC679AA289@BYAPR12MB3592.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /joqLmJTmQ25o2J3zhJUTpNacADzzL2abgPUjg/U0MTRzCJ8A/TW8nVy372W/MC/w0ytCkyZo1biuqtFeKwTzoTl2ctC8haS+j7JXn/ut9WC7CmCL91lKCBlSYg5d/jyZpChBfo3EUdC3ZP0CgzXRus05I3qY7PYL2zFGpPc+3yfazg559UeoBWmad4jTNCisA71YkLmZw7/GVAfHIMnORzRLHBK31Bd4uBmrqjfNC9YPEjp+LdFWNduzAyO0WakgqhxQyGdV1Lx3wo//h6yxRYZCJgWQlYReH31F+9gFgSkUyBwiblaw0Zjtu2bN9IEZsu4ncyvWpGr3EUIEu2rBey+2ZktywZSEaHDUsLm9IpBn1ogKaZZoc3iC7DdxOE28zzTh7igPn21FNcOMMrROFhi7dOOr6va/KYqKOC4ExeiJDstsO4pLuMn9chDBJ+2b7W4l61EfGckb5h4XRWjl0+zbZIoZjz+fGrwCb6MFysT67gdQiNnpqUgKSH3c5WKnVz6f7B+Sp6JflkXzyrYvgz4P3kKOiM8SklxmfM0lABG3Bh1BzC53uulhsrFxoFSS/jh9PsD/7FgBGV3NANV6Q3l/xJhO9wUZq1woIVKAUEshIwD6mnjLb3nBt3+TDPhX1iy/5LoJy3RwvPgzYDUR22raed9O/q1WCJzyKuBvuIvohq8wTB02Ub7oReFqR5uj5G/wY6mdxWvbXFaOapy+1Zm0oU0GuAE0s+MCNzyQWUniwccU0OV49O8lIEkfLxWO6OeDUgOn6CfelK/2IjcfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(71200400001)(38100700002)(122000001)(5660300002)(6512007)(316002)(2906002)(53546011)(6506007)(26005)(8676002)(31686004)(83380400001)(31696002)(36756003)(8936002)(4326008)(6486002)(508600001)(54906003)(66446008)(2616005)(186003)(66476007)(66946007)(76116006)(66556008)(110136005)(86362001)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVFsWWUvWmIxVUhpcWFpd0REc1pXbmtsbzdwTldrcEptSC9RYWtFZVdUeGQ5?=
 =?utf-8?B?c0RGbG1BNXMvMEoxbFJVVGwwT3g5eXRDZmlGS3hBOTl4b0kwcTJhSllJa2tw?=
 =?utf-8?B?WmhpelllaFIvb1E2cTBuREJyYzMrazVUL09pV3dWVko0eVhxWnRIWlNEQ0Nh?=
 =?utf-8?B?dmE2SlRadXhlZ1BEVFpESWRGV0xSaThuaC83KzdSL21OeE5YSFhoOXEwRHdZ?=
 =?utf-8?B?ckROTFBtc0FIak1uUlQra0YxL05oOGFmemVDQlFOMzU3RmJJWU5nV0FETCto?=
 =?utf-8?B?Nk9yVzdHY0dXTE55VllnUHFUTFVjU1FiVkdnM3Z1MjZIa3V2a2ttU3VVS3BR?=
 =?utf-8?B?Uit1dkhmZ000YVdkY0t1YXBhbzRjNk84WTJ3N1Q3MlQwa1FmM3pLUlh6OC9S?=
 =?utf-8?B?WEtYLzdha29pSDA1RzZQbE82eTdibkY2ZE8yR0w5MVkxdHpxUXhLZWRDMC9h?=
 =?utf-8?B?akNnUVlZamFaQ0pGSjJMNmZDcVg0bVdwL3ZuZkIyOGliWnR3Z3NFL0FYNHlE?=
 =?utf-8?B?QlJKM3NsTjhJcWtnOXc2T3pPRW1raWU0ekQzVDJKZGVmMXJ6V3ViT0ZxeGha?=
 =?utf-8?B?OUlVY0ZCRmM3YkpjQXZiNXFUMnAyT2NMdmZEd2pSQlVXREhnWkF0V0I2a1Fk?=
 =?utf-8?B?NkltbGRwM0dqS2llaXhrUjZhYllWLy92S29XRzU1bmFad1JTM0hkOU5rUjFo?=
 =?utf-8?B?TmR2WkxweXdLd3ZuYnNZSjNRQ2IzS1VRbWFRL3R3ZlZFZ29Ud3BpVDhXcmdJ?=
 =?utf-8?B?WTI0aDJKTk4vcEgzSTBzWmowOXdzTWZGSFRyUHV0aU5tQ2JaNzd0MG9lUk8z?=
 =?utf-8?B?WlNnR0daSUdMZFMxcnpkZHRHR1BCbE1FOEFyekJocXQ0bkxaR3JwL3RMbmpR?=
 =?utf-8?B?MG9Sa0Fya21rNlQvVHhjaHo1R254enBQOTk4aTZSZGtzdno2eGhrL3BrR3NW?=
 =?utf-8?B?UVNBR2RrSkZCeXVod3N1WWV5dlNDRWRBM1RzWXp6M25EcmRlaTd1bXBDNjI5?=
 =?utf-8?B?SWhWcmRCSC92blFaMHNqZHFGMnlSRTVhUzl0cHNydm1tZGF0RW4wWnkrTlJa?=
 =?utf-8?B?V3M1bXJhb2RQUTNjck9iQkllRVFBdkFiWGlJbEJmSzB2L2dTMlprTURpMEll?=
 =?utf-8?B?eHljeDdoZHFhYnhSdWFubTcrRXNDd1pRaDM3aU03T0ZFVzlhQTUzYlQ3VmhM?=
 =?utf-8?B?MjRGTkRMRWVvQThGVWxSaGNOR1B6ZHEwaW5Mbko0SkRhVDhCTHpUT3FLTE4w?=
 =?utf-8?B?WjJaa2srTE55dmUvQ2pSSlZockM3M2FKWUxXSk1KWTY0M3RST3cwMDFSMmI1?=
 =?utf-8?B?RWxoYTF4YXd5K1gvb2wwUFFORHlrME91Q1BBb1dPZmJMbHpvQXpQWlJBeWNm?=
 =?utf-8?B?T2NvZXRQZmVERDlzWWtKdG5aZ0tzUk84N0wxRGhFTldGK3p5OVNjRGJSQTVH?=
 =?utf-8?B?Snh1RW9tVVN3SXBJeWxnK1JnMklwQlJBenJhamlIc3UxMENmY0lTL2RzaUt1?=
 =?utf-8?B?K29kcUpOVVplV1RZWTBiS0Z5QXV3RGw3Mm0vSkZ2clk3dm96VWdxNTBnc0px?=
 =?utf-8?B?bUF4UytmRWk1RjdqY21hMkNFQUtDOEpaVEdUUXFucjFzWFpZNHBZMk1FM3Rq?=
 =?utf-8?B?UlI5b0NVbjN3bEZZTU82VVl5eFNvOEJWdjh5SHArWGd1MGlXVDRxdEhrL0pL?=
 =?utf-8?B?amQyWWo2alFGVnN2ZFhSUVkxS0dKeStzdXhVR25CckZvWmRVZDNrbXkveFhS?=
 =?utf-8?B?OTY1TVRIL0J4ZCtjTDZaM09uK3BpWWNMbnU5ZG82WDQ5b1pwUlZqckJzNElB?=
 =?utf-8?B?K2JXRlQ5S1AvNHVOcDBaUm55clY5alVkOUVrVWlpZHQ1cEcwZmVCSkdiVFNI?=
 =?utf-8?B?YW5IanlUNGlvTnc1bmZ5am8vN0x0Y1gxUFlSZWRWOWVuWVk5VEVLb0kvb3o3?=
 =?utf-8?B?U1c4TFhjd0tINmNJalRGMGF4cExJWjEzQUM1bG43dDRFYjJZOHkrN2lhUmJp?=
 =?utf-8?B?Z2hEcHhtY1lSYmJOK2lqaXFINVo2MUQwZmM4R1I0a0I3WDlBV3ZMVTJyZnZJ?=
 =?utf-8?B?Zk4zd1cvU2xLN2dYU0QyczFIZG9VREZVUHczcCtMNTFscHVmdDVUMENvL3VX?=
 =?utf-8?B?bU9MbjNyZFFnRkdHeWYrOVN3MHlTSC9SVnpxQkRTMk5BVGZDRHgvTEQ2Qkc2?=
 =?utf-8?Q?BRQArN5xbCBgENURuiZvp/w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4928CF88C3D53141A13048011F5A8CA6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e807fd-e221-41bd-e103-08d9e6cb8e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 04:13:39.1125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ye7BBfgUeQJf4F6viFOzA4G4mWW4GYkUhFjXXUfy0jD0Y6BW88XrGidFiDoWpTLO831o4jFHVXeopZ6zEIogyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3592
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW5kcmV5IFNtaXJub3Ygd3JvdGU6DQo+IE9uIFdlZCwgRmViIDIsIDIwMjIgYXQgNjo1NCBQTSBU
aGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPj4NCj4+IEFu
ZHJleSBTbWlybm92IHdyb3RlOg0KPj4+IEl0IGlzIG5lY2Vzc2FyeSB0aGF0Og0KPj4+DQo+Pj4g
ICAgUk9MRV9TV0lUQ0ggJiYgZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkd2MtPmRldiwgInVz
Yi1yb2xlLXN3aXRjaCIpDQo+Pj4NCj4+PiBpcyB0cnVlIGluIG9yZGVyIGZvciBkd2MzX2dldF9k
cl9tb2RlKCkgdG8gX25vdF8gZm9yY2UgdXMgZnJvbSBPVEcgdG8NCj4+PiBQRVJJUEhFUkFMIG1v
ZGUgaGVyZToNCj4+Pg0KPj4+ICAgIGlmIChtb2RlID09IFVTQl9EUl9NT0RFX09URyAmJg0KPj4+
ICAgICAgICAoIUlTX0VOQUJMRUQoQ09ORklHX1VTQl9ST0xFX1NXSVRDSCkgfHwNCj4+PiAgICAg
ICAgICFkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGR3Yy0+ZGV2LCAidXNiLXJvbGUtc3dpdGNo
IikpICYmDQo+Pj4gICAgICAgIURXQzNfVkVSX0lTX1BSSU9SKERXQzMsIDMzMEEpKQ0KPj4+ICAg
ICAgIG1vZGUgPSBVU0JfRFJfTU9ERV9QRVJJUEhFUkFMOw0KPj4+DQo+Pj4gYW5kIGR3YzNfZHJk
X2luaXQoKSB0byBiZSBjYWxsZWQgbGF0ZXIgaW4gZHdjM19jb3JlX2luaXRfbW9kZSgpLiBTbywN
Cj4+PiB0byBhdm9pZCBhbHdheXMgaWdub3JpbmcgZXh0Y29uIGRldmljZSByZXR1cm5lZCBieSBk
d2MzX2dldF9leHRjb24oKQ0KPj4+IGNoYW5nZSBkd2MzX2RyZF9pbml0KCkgdG8gY2hlY2sgYW5k
IHVzZSBpdCBmaXJzdCwgYmVmb3JlIGNoZWNraW5nIGlmDQo+Pj4gZHdjM19zZXR1cF9yb2xlX3N3
aXRjaCgpIHNob3VsZCBiZSBjYWxsZWQuDQo+Pj4NCj4+PiBDYzogRmVsaXBlIEJhbGJpIDxiYWxi
aUBrZXJuZWwub3JnPg0KPj4+IENjOiBUaGluaCBOZ3V5ZW4gPHRoaW5obkBzeW5vcHN5cy5jb20+
DQo+Pj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4+PiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTbWlybm92IDxhbmRy
ZXcuc21pcm5vdkBnbWFpbC5jb20+DQo+Pj4gLS0tDQo+Pj4NCj4+PiBIb3BlZnVsbHkgSSBkaWRu
J3QgbWlzcyBzb21ldGhpbmcgaW1wb3J0YW50IG1ha2luZyB0aGlzIHBhdGNoDQo+Pj4gdW5uZWNl
c3NhcnkuIERvbid0IGtub3cgaWYgdGhpcyBpcyBhIGdvb2Qgc29sdXRpb24gb3Igbm90LCBwYXJ0
IG9mIG1lDQo+Pj4gdGhpbmtzIHRoYW4gbWF5YmUgY2hhbmdpbmcgdGhlIGFmb3JlbWVudGlvbmVk
IGNvZGUgaW4NCj4+PiBkd2MzX2dldF9kcl9tb2RlKCkgdG8gYWNjb3VudCBmb3IgZXh0Y29uIHdv
cHVsZCBiZQ0KPj4+IHNpbXBsZXIvYmV0dGVyLiBIYXBweSB0byByZXdvcmsgdGhpcy4NCj4+DQo+
PiBUaGUgZHJpdmVyIGVpdGhlciB1c2UgZXh0Y29uIG9yIHVzYi1yb2xlLXN3aXRjaC4gSXQgZG9l
c24ndCBtYWtlIHNlbnNlIHRvDQo+PiBlbmFibGUgdXNiLXJvbGUtc3dpdGNoIGZvciBleHRjb24g
anVzdCBzbyB0aGUgZHJpdmVyIGRvZXNuJ3QgZGVmYXVsdA0KPj4gdGhlIGRyX21vZGUgdG8gcGVy
aXBoZXJhbC4NCj4+DQo+PiBQZXJoYXBzLCB0aGlzIGlzIHdoYXQgeW91J3JlIGxvb2tpbmcgZm9y
PyAoY29kZSBpcyBub3QgdGVzdGVkKQ0KPj4NCj4gDQo+IFllYWggdGhhdCBraW5kIG9mIHdoYXQg
SSBtZWFudCBieSAibWF5YmUgY2hhbmdpbmcgdGhlIGFmb3JlbWVudGlvbmVkIGNvZGUgaW4NCj4g
ZHdjM19nZXRfZHJfbW9kZSgpIHRvIGFjY291bnQgZm9yIGV4dGNvbiB3b3B1bGQgYmUNCj4gc2lt
cGxlci9iZXR0ZXIuIiBPSyBsZXQgbWUgcmV3b3JrIHRoZSBwYXRjaCB0byBkbyB0aGF0Lg0KPiAN
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+PiBpbmRleCBiZmZkNzE5YjhiNTIuLmE1MjMzMWVhN2EwZCAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPj4gQEAgLTg2LDcgKzg2LDcgQEAgc3RhdGljIGludCBkd2MzX2dldF9kcl9tb2Rl
KHN0cnVjdCBkd2MzICpkd2MpDQo+PiAgICAgICAgICAgICAgICAgICogbW9kZS4gSWYgdGhlIGNv
bnRyb2xsZXIgc3VwcG9ydHMgRFJEIGJ1dCB0aGUgZHJfbW9kZSBpcyBub3QNCj4+ICAgICAgICAg
ICAgICAgICAgKiBzcGVjaWZpZWQgb3Igc2V0IHRvIE9URywgdGhlbiBzZXQgdGhlIG1vZGUgdG8g
cGVyaXBoZXJhbC4NCj4+ICAgICAgICAgICAgICAgICAgKi8NCj4+IC0gICAgICAgICAgICAgICBp
ZiAobW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcgJiYNCj4+ICsgICAgICAgICAgICAgICBpZiAobW9k
ZSA9PSBVU0JfRFJfTU9ERV9PVEcgJiYgIWR3Yy0+ZWRldiAmJg0KPj4gICAgICAgICAgICAgICAg
ICAgICAoIUlTX0VOQUJMRUQoQ09ORklHX1VTQl9ST0xFX1NXSVRDSCkgfHwNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICFkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGR3Yy0+ZGV2LCAidXNiLXJv
bGUtc3dpdGNoIikpICYmDQo+PiAgICAgICAgICAgICAgICAgICAgICFEV0MzX1ZFUl9JU19QUklP
UihEV0MzLCAzMzBBKSkNCj4+IEBAIC0xNzE1LDYgKzE3MTUsMTMgQEAgc3RhdGljIGludCBkd2Mz
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgICAgICAgICAgICAgICAg
Z290byBlcnIyOw0KPj4gICAgICAgICB9DQo+Pg0KPj4gKyAgICAgICBkd2MtPmVkZXYgPSBkd2Mz
X2dldF9leHRjb24oZHdjKTsNCj4+ICsgICAgICAgaWYgKElTX0VSUihkd2MtPmVkZXYpKSB7DQo+
PiArICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihkd2MtPmVkZXYpOw0KPj4gKyAgICAgICAg
ICAgICAgIGRldl9lcnIoZHdjLT5kZXYsICJmYWlsZWQgdG8gZ2V0IGV4dGNvbiAlZFxuIiwgcmV0
KTsNCj4+ICsgICAgICAgICAgICAgICBnb3RvIGVycjM7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+
ICAgICAgICAgcmV0ID0gZHdjM19nZXRfZHJfbW9kZShkd2MpOw0KPj4gICAgICAgICBpZiAocmV0
KQ0KPj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyMzsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2RyZC5jIGIvZHJpdmVycy91c2IvZHdjMy9kcmQuYw0KPj4gaW5kZXggNjMwODlj
N2ZiNTMwLi5kMDJmY2ZkYzc0ZGIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2Ry
ZC5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2RyZC5jDQo+PiBAQCAtNTg1LDE2ICs1ODUs
NyBAQCBpbnQgZHdjM19kcmRfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4gIHsNCj4+ICAgICAg
ICAgaW50IHJldCwgaXJxOw0KPj4NCj4+IC0gICAgICAgZHdjLT5lZGV2ID0gZHdjM19nZXRfZXh0
Y29uKGR3Yyk7DQo+PiAtICAgICAgIGlmIChJU19FUlIoZHdjLT5lZGV2KSkNCj4+IC0gICAgICAg
ICAgICAgICByZXR1cm4gUFRSX0VSUihkd2MtPmVkZXYpOw0KPj4gLQ0KPj4gLSAgICAgICBpZiAo
Uk9MRV9TV0lUQ0ggJiYNCj4+IC0gICAgICAgICAgIGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2wo
ZHdjLT5kZXYsICJ1c2Itcm9sZS1zd2l0Y2giKSkgew0KPj4gLSAgICAgICAgICAgICAgIHJldCA9
IGR3YzNfc2V0dXBfcm9sZV9zd2l0Y2goZHdjKTsNCj4+IC0gICAgICAgICAgICAgICBpZiAocmV0
IDwgMCkNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiAtICAgICAg
IH0gZWxzZSBpZiAoZHdjLT5lZGV2KSB7DQo+IA0KPiBXZSBwcm9iYWJseSBkb24ndCBldmVuIG5l
ZWQgdG8gbW92ZSB0aGlzIGFyb3VuZC4gSWYgInVzYi1yb2xlLXN3aXRjaCINCj4gaXNuJ3QgZ29p
bmcgdG8gYmUgc2V0IHRoZW4gdGhhdCAiaWYiIGNvdWxkIGdvIGZpcnN0IGFuZCBub3QgaW50ZXJm
ZXJlLg0KPiANCg0KWWVhaCwgdGhpcyBpcyB1bm5lY2Vzc2FyeS4NCg0KPj4gKyAgICAgICBpZiAo
ZHdjLT5lZGV2KSB7DQo+PiAgICAgICAgICAgICAgICAgZHdjLT5lZGV2X25iLm5vdGlmaWVyX2Nh
bGwgPSBkd2MzX2RyZF9ub3RpZmllcjsNCj4+ICAgICAgICAgICAgICAgICByZXQgPSBleHRjb25f
cmVnaXN0ZXJfbm90aWZpZXIoZHdjLT5lZGV2LCBFWFRDT05fVVNCX0hPU1QsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZkd2MtPmVkZXZfbmIpOw0K
Pj4gQEAgLTYwNCw2ICs1OTUsMTEgQEAgaW50IGR3YzNfZHJkX2luaXQoc3RydWN0IGR3YzMgKmR3
YykNCj4+ICAgICAgICAgICAgICAgICB9DQo+Pg0KPj4gICAgICAgICAgICAgICAgIGR3YzNfZHJk
X3VwZGF0ZShkd2MpOw0KPj4gKyAgICAgICB9IGVsc2UgaWYgKFJPTEVfU1dJVENIICYmDQo+PiAr
ICAgICAgICAgICAgICAgICAgZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkd2MtPmRldiwgInVz
Yi1yb2xlLXN3aXRjaCIpKSB7DQo+PiArICAgICAgICAgICAgICAgcmV0ID0gZHdjM19zZXR1cF9y
b2xlX3N3aXRjaChkd2MpOw0KPj4gKyAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgICAgICAgfSBlbHNlIHsNCj4+
ICAgICAgICAgICAgICAgICBkd2MzX3NldF9wcnRjYXAoZHdjLCBEV0MzX0dDVExfUFJUQ0FQX09U
Ryk7DQo+Pg0KPj4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
