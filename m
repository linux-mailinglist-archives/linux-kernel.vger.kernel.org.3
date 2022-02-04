Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A04A972F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357521AbiBDJy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:54:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52299 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbiBDJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643968466; x=1675504466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HOS/mBkKBuFeaJ3ZK3Baf2BugVzaYuwJ59BryHR44hg=;
  b=p7ZNQoxudo0pUlAvdyCGHRA9oVSQTlauyJVthbJ7ANuUWyqw4wYp9hw4
   3cUsHCamWqPaZyQvo0030uwiivFZlM9KU/pd/YiU76NQDJNgjwIrvkO0z
   TlCUY5yBxSd4rFYiZ67F4ItXs5DBN/WJrrYXpZeuMSEEfO8/JI9/lUvZT
   HFLTqY2GtPpB+CVqOPWb8AOK4H6kUzlRAjT7Bb/UDdClya31dBV8ECsYm
   5vc3dVfs9FWRgv3NgWrlevStVCmPp/k8IoNBvKM2V+Es16Ad+EGN0nZXk
   XNE+Pk5kFmlAsttgQ9iaywAgCgW1QIiqFmUa4zBpnOc1TnaZG0fyBPyx+
   g==;
IronPort-SDR: qClr+vrhNgsISFrk9tF+9nbFkg/JGM14lAWKM72wIdMrOsqi7FxWc7uHPWjhwwV68P4Sfs3XcA
 IXfC+4fNLFV0BK1PVs5JhF3+poVHXvzznNMbzF+FW7DVKp+NXXXW/rn5CiFy0+A1HoJOc5GRyb
 5p21sfxR9FQ+/5UURD3KEHgh80paDVvMa41gpncswfdo4EL20ej31iVb9HkFCxYCC0OWZ3XqWp
 IEyfmAKlmXemMizQ2ktNefV5xzeDawW5wggmplpFmFqsuUHDV2lM9RDr/3KHQX3BvpDFNTCg/d
 djx8IsJex00AcHRYsvhN28V+
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="84672587"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 02:54:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 02:54:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 02:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbizD3wWx2JNqM4sD3rGNB3ReLBQKbbEIkfZIbZSZZGWVgZCur6ZVAdWYaxbTzVWzrSYdnGUQfJjLIQ3VAO+EagcXDsvt40J4k4JKA1ILprMeHUjtEWWwLcjqar4bdbE+gb31SfC3kw+erH6jSMAY/SFARY67BTSvxSx7Pr4xlyGnaeGZMSQ9s1vamnI9rrt5sEi3SqrP/NHdvI2j5dAmPvQNXnETdXbjlC3b9tGzAqqraaCjczQCvOdzZk8lSCiMwBNS4pvmVqXrZZVFt7W/vuy4Ci5YoxNNfTG2KWqi0xSUWRUy+fwRzFkwZpKHIn/8cW70zSPU/dLH+o8Dey8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOS/mBkKBuFeaJ3ZK3Baf2BugVzaYuwJ59BryHR44hg=;
 b=nC+6FXGBedt1EBAoZkI5evpwexnEMIdyG3H0MRyzwTwHweZ06ugOdyESBAdpdySuRmhPPEz+6DMrt72bKGsMlLIc4FK4tnTlUPhVpvETUMSlqcwUy98MeXAKa6UzuflW75hpSysYnWk77OmRz6eJzW/F9KYT+JbKtcxIUgLNThJLEKMZNQ4mfbhqg0FQ+tTOz5OcX3iPPyn4fm9+m+0hx58+pxHHYfx69jJHaWynhhGU+vt26araoz0QbwrBGPzvZdRA4xjqDY9zu1O7lUMCKZnGju1jHe2WWyXNb+LSnp8f9/umkBF/lqSOgRDOZ+EHUx43bouOCxsJtQX9V/eljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOS/mBkKBuFeaJ3ZK3Baf2BugVzaYuwJ59BryHR44hg=;
 b=tNZk0muk1sf0FckjN4lPEo4kVM65Gzxh/kf5H0DVJ2m8vHzc7Wj2PfffI3QNErFyU5PNPnF1Fvh+3/offzfgCqJdfY9+O9jGX+6PXcja25q5DB5o0hnXp1YXGkPcVAdb4jWwjw7uqbhw7Km1dbJCn0nYnQcWXFwHR/dbZwVr9u8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3198.namprd11.prod.outlook.com (2603:10b6:805:c3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Fri, 4 Feb
 2022 09:54:20 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%4]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 09:54:20 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <UNGLinuxDriver@microchip.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] crypto: atmel: add support for AES and SHA IPs
 available on lan966x SoC
Thread-Topic: [PATCH v2] crypto: atmel: add support for AES and SHA IPs
 available on lan966x SoC
Thread-Index: AQHYGa0utssKP0pjPUi/Kjxi9EKUFQ==
Date:   Fri, 4 Feb 2022 09:54:19 +0000
Message-ID: <97a76204-520e-2899-2f87-a28396e012b4@microchip.com>
References: <20220128071755.25277-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220128071755.25277-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 827c8774-f688-4294-6eea-08d9e7c450a4
x-ms-traffictypediagnostic: SN6PR11MB3198:EE_
x-microsoft-antispam-prvs: <SN6PR11MB319833585F976E5D0955744AF0299@SN6PR11MB3198.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qElnoBfWH+neOOiPZfC3+dAESnUPFCuMrYwp+gtmwhZZcVIX/gdlbWdmBKBTRzrZsiHwGw1yCbWTo75BTtjlcndBl6V5JTEHBgUk3dvDKUSaW7uWkjAfVONPNeFZ/P4NlJlFSBq2/gRigHOw4FZkAvw4nVmYbLEoDpDyjQkMPuFGibT3GaNiSwrOjA0pxWQn4SaCBUfeNVu7r7wgoVJQvHp/vT6FolY9GtEiWbHZXZuqJw1dAyv2OWkv7+px1qa+ybaKtDVfKRmHIWm5zthGuBDo12DE/JnbTLT0LRM329FV8pZnhDGB9OlYxkpiGLhIysryjxjw7VDCy4LQjZod64srQ2JK9mfOXudI4XzHxLu5jQuaKLHcGEp5A8vg7mcrkeQkZmrdT10jcgxbqe3i5GSiVOM1rgijM6Qfo8IngZ3S+yjOWRl8S0/oIgAYHfmowUPIPc1fqA7WPosnMn4kjf7c98rxHr0IXmMAgiixWkLmLtKvWuPojHWPgzL4kSPHlG6SiogdmGsjotkUghUyyuHRkatnsehL2TaIzaycBODtTUp23dvz6OLV6YqkC2Ay5bsLVW8bCfgliudCdKRm7MVGI9Xc1dL0KRn5GTliRPDq4WpzqgS12WcuDB42ne+TBE5EG6IuSPt6uaP/ttmrni67lQf0r794PCNN91VMgLG0SFXlbO44eFMTWgn89Axyn5X7HaBJ0nlxRG/OmbmyTD2500exMgINACcpnGQQCsc5w/rt5kNKYSz5+dq3QL498ag1ZdsO1QV7hMxOHuJTzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(76116006)(6512007)(4326008)(66946007)(64756008)(316002)(66556008)(66476007)(66446008)(6636002)(110136005)(71200400001)(54906003)(8676002)(8936002)(86362001)(38070700005)(31696002)(36756003)(5660300002)(2616005)(186003)(6486002)(26005)(508600001)(38100700002)(31686004)(6506007)(122000001)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXNUNkdFd28xTktldXNDdDJ4WmdYK0NieG52RG1wRlBaVTc5SXhXcUd5ekxP?=
 =?utf-8?B?RFJ3UDVsQnF1ZitORW5zaVdRRW5RdDVPQzIyS21temd4YXJSdDZJeVFkU0tQ?=
 =?utf-8?B?ZmRrUGJzKzBuWlV1dWFLcWV0cFA5bWx2SlIvandiczBHOXc1b2ZHWU1UM2p0?=
 =?utf-8?B?aWJPQ1VPQXEyMjVjVnJvMUtwYms1ODJXWjRjcm82N1NBTEtNSEc2MEp2YVlu?=
 =?utf-8?B?T1NyY2tjUFFHbXNtdXgyQW5JaHJONjQvUndlaTdidmYxSHlZcEQ3RHNZU0hX?=
 =?utf-8?B?b1ZLMWxJLzYyN0Zmc1IvUm5CMW5MYXRvbURMWktPdENzcFdmcDZjMUYyaHlF?=
 =?utf-8?B?b20wK2V1ckZqOUtBY1NZZklweFg5MEpqL2JVNkEzNk1rTCtlUFFEc3BEZU0z?=
 =?utf-8?B?bGlucS9OMVh4Uk45bldLZ3VEeGVnWEh6Y1VFelZLdktFVXZBWHpYUGVVWUdN?=
 =?utf-8?B?dmZMS1o4ZDNFVk9XV2lrbWZqNXNDUFVxVk5oNGF3U3ovV3BkSXVDYzJIbFBG?=
 =?utf-8?B?YUhIUW92c0hOSGhWNmxLaTVzUUVsc1YwcDBPMzBlUjRrZmRyR2RmZU5LNXMw?=
 =?utf-8?B?QWw5T3ZZT1lpaEJKZW1YaWhWS2wwV3U2UTZFNmtwY2tDZG5QdUJvc2pZY3U4?=
 =?utf-8?B?Q3FmN0N4L0RGNzAyS2svc0YrL09YTW4zdWZzbVd6eWZyNmVvV1pSK1UrUGtk?=
 =?utf-8?B?Y2JFVlVERGt6MS95eFNNbUtyQ1ovbWFjVGZqdFpVMlNkVVl0NmVDSUxaZlJm?=
 =?utf-8?B?SENOejlBTFpXYmZYVm10UjI2WTRZVlRCTDhnY1dqcjRhOUhZWjJiVkhCY29Z?=
 =?utf-8?B?Y29wRXVQaG9lMlVFOHVPY0JUcHFwOWtNRHNNN3VscGNxakNpVlM2Mjh5ZTdz?=
 =?utf-8?B?ZGFqZXhFKytpS2c3T3BjL3htQms2TWl4L2dFSXNPeFJxSE1kWmpJQWVzZEQ0?=
 =?utf-8?B?OFE3M3UyTzJUdWo3T2V1QVVwaERGUk1IdFVHNlRZaVh0dHcwejNXcHJ4RmdF?=
 =?utf-8?B?UVZINWRKak1NK3FRa3pnM24vSG0yekFKRW9GKzdrMThaeFJ6T01mQ0Q5WGNn?=
 =?utf-8?B?cHRkV3gvS0VLcWxPSGhZQnorZjhud1ZzT0tuQ0o4ejlJL2VrSDFabFFIajVY?=
 =?utf-8?B?MzdoN1ZFL1Q5ZXBsd1ZSYkxnUjVBcWVVdllHTHptelJxNDhoK09DanNIcXdJ?=
 =?utf-8?B?bkZENGs0SHZWeEN5aVFoU1lJd015TG5pcWtrVGhiRUlSM3UxQ0l5dk5hdlBL?=
 =?utf-8?B?alR5dUpsRlhHTWlvNW5CQzRwbjlDMUMrYWc3TzI2TTJIUDIzREZ4eWt6S09q?=
 =?utf-8?B?VXVRRUJJTGlQK2U1by8xRWp2QmxVVXhacnR1cVhkbjMyc2IvWXhuVUZUZmFK?=
 =?utf-8?B?cUdTendHN09ZNnE2S1JxRWlJK2xKb3ZoZkgzcEw2NUpjWlJ6K3E0U29SNXlP?=
 =?utf-8?B?UzVBQitmbmZMTVA4Qzl3RXcyUElLKy9sWEFXTE5OM1Rmem1FQlN5ejMrM2xK?=
 =?utf-8?B?WDZPUkhTWnZoK3FRbzFVNWNHYVJ5U0E4QkVMWENyQWdPVjBjRkdQdVM4aXh3?=
 =?utf-8?B?RHJQZmZ3ckYvTk5lQXg3NmRpL2o2eko2UG9ScTBodHh3RmtnSzBNaDVxMkNY?=
 =?utf-8?B?emlVMUpGL2Y4OEg4bm8zTG81a0c3WmxvZFM1WElUcnBXenltY0ZjWDhqRjRX?=
 =?utf-8?B?QXNiYytCUTdrL3FWRTIvbUxxdzFuYTRRdkxuRFpMckRNbkdlckZYd0JoOW42?=
 =?utf-8?B?b0ZnOTZBRG5XY0RhM29ha0l5N3ByajhMOFo0amJFRXAvOFpOTWp2R3ZlU01I?=
 =?utf-8?B?d1BtWGIzYlBiMEM0bU82YThNV0M1bEU4RWt2R2Y4azEyOVZQUlh6SllzTW5V?=
 =?utf-8?B?WU9kTGoxMStVTDM3aVUwM3FGM0FtelZHdFNHbmZrZjd2cmduOFYxT0hqTTg0?=
 =?utf-8?B?OGM2N0dlVkM2N1phaFFabGsxMDZaaSs0RXVEL1h5QU12UjFmb3JFNzhJQ2hJ?=
 =?utf-8?B?Y1cyVjdJbWZYVkhhUkRab1NHN0tqb0dIYVd2UkhHTG1hMkIvTmFWd3Q4a2ov?=
 =?utf-8?B?YUJZaWZNZDAwd0hIV0VuWVBaRXpTeE85NzNsVmFNaE0xNkxOdVpGVEY3M3lU?=
 =?utf-8?B?V1NzbStJN3g4ckJMdjRuRjg3ODFRaEJxZkZVM2V3WmMzZ3pzTExTVzFpUUZm?=
 =?utf-8?B?NGJtbko1Nk5jTTRCVEkyVzlRRDJ1Z2M0TEh5V0dodGlqZmY4R0UrMHNrSWts?=
 =?utf-8?B?TUoyUitDbzJkbEt5NGVYUmNnNTZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7442557CAAE9094196CBF6EC2653BDCF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827c8774-f688-4294-6eea-08d9e7c450a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 09:54:20.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KxJj0zLxwbNH2mif4ZibeKt/C1eCIfAdoFkj2zWariYPSxJWpBufGGmlFoDVvEX4CYfF3e3UyznssaVnCCZHl+IOUpUdfoMDQG3ranxN6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3198
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yOC8yMiAwOToxNywgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBUaGlzIHBhdGNo
IGFkZHMgc3VwcG9ydCBmb3IgaGFyZHdhcmUgdmVyc2lvbiBvZiBBRVMgYW5kIFNIQSBJUHMNCj4g
YXZhaWxhYmxlIG9uIGxhbjk2NnggU29DLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVl
IEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NClRlc3RlZC1i
eTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQp0ZXN0ZWQg
d2l0aCBzYW1hN2c1IHdoaWNoIGhhczoNClsgICAgMC44OTEzMDRdIGF0bWVsX2FlcyBlMTgxMDAw
MC5hZXM6IHZlcnNpb246IDB4NzAyDQpbICAgIDAuODk2MDQyXSBhdG1lbF9zaGEgZTE4MTQwMDAu
c2hhOiB2ZXJzaW9uOiAweDcwMA0KDQo+IC0tLQ0KPiB2MSAtPiB2MjoNCj4gLSBSZW1vdmVkIGZh
bGx0aHJvdWdoIGxpbmUsIGFzIGl0IGlzIG5vdCByZXF1aXJlZC4NCj4gDQo+ICBkcml2ZXJzL2Ny
eXB0by9hdG1lbC1hZXMuYyB8IDEgKw0KPiAgZHJpdmVycy9jcnlwdG8vYXRtZWwtc2hhLmMgfCAx
ICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jcnlwdG8vYXRtZWwtYWVzLmMgYi9kcml2ZXJzL2NyeXB0by9hdG1lbC1hZXMu
Yw0KPiBpbmRleCBmZTA1NTg0MDMxOTEuLmY3MmM2YjNlNGFkOCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9jcnlwdG8vYXRtZWwtYWVzLmMNCj4gKysrIGIvZHJpdmVycy9jcnlwdG8vYXRtZWwtYWVz
LmMNCj4gQEAgLTI1MDksNiArMjUwOSw3IEBAIHN0YXRpYyB2b2lkIGF0bWVsX2Flc19nZXRfY2Fw
KHN0cnVjdCBhdG1lbF9hZXNfZGV2ICpkZCkNCj4gIA0KPiAgCS8qIGtlZXAgb25seSBtYWpvciB2
ZXJzaW9uIG51bWJlciAqLw0KPiAgCXN3aXRjaCAoZGQtPmh3X3ZlcnNpb24gJiAweGZmMCkgew0K
PiArCWNhc2UgMHg3MDA6DQo+ICAJY2FzZSAweDUwMDoNCj4gIAkJZGQtPmNhcHMuaGFzX2R1YWxi
dWZmID0gMTsNCj4gIAkJZGQtPmNhcHMuaGFzX2NmYjY0ID0gMTsNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY3J5cHRvL2F0bWVsLXNoYS5jIGIvZHJpdmVycy9jcnlwdG8vYXRtZWwtc2hhLmMNCj4g
aW5kZXggMWIxM2Y2MDFmZDk1Li5kMTYyODExMmRhY2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Y3J5cHRvL2F0bWVsLXNoYS5jDQo+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2F0bWVsLXNoYS5jDQo+
IEBAIC0yNTA4LDYgKzI1MDgsNyBAQCBzdGF0aWMgdm9pZCBhdG1lbF9zaGFfZ2V0X2NhcChzdHJ1
Y3QgYXRtZWxfc2hhX2RldiAqZGQpDQo+ICANCj4gIAkvKiBrZWVwIG9ubHkgbWFqb3IgdmVyc2lv
biBudW1iZXIgKi8NCj4gIAlzd2l0Y2ggKGRkLT5od192ZXJzaW9uICYgMHhmZjApIHsNCj4gKwlj
YXNlIDB4NzAwOg0KPiAgCWNhc2UgMHg1MTA6DQo+ICAJCWRkLT5jYXBzLmhhc19kbWEgPSAxOw0K
PiAgCQlkZC0+Y2Fwcy5oYXNfZHVhbGJ1ZmYgPSAxOw0KDQo=
