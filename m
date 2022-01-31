Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B074A3E19
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357884AbiAaHLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:11:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:6458 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357875AbiAaHLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643613082; x=1675149082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=28D6/WwhC1f7LUnDeETQVtrJxEJQlhfekiMeg8dltgM=;
  b=0+SXgdeuPVhM5tkbb4IrtYxTH1yF7oKX9Xns16S/k2St1avqIaeJIJp6
   9GvU2onh70rW6j5c3nLmxHBItTRjCp6k0iU4GxynLPPh159yQWoO8yC2b
   ABfJuWLnUJgHCGoXXdNw5H5amW9kwuI2p/zHs5rmFVMNfpUnBYw+aSzep
   WnvsDKert3SZe8EHxZMKt6A+LqVajWkJoKjgKvDMRF6YMfM0gFTLB9tZD
   yCfnzdsNp/2KmxI1dKeTQAR774nlNYtobLKeC2tRQyF/7Wp4TgmXVkeXC
   0gehYeeeuIsGWIr/LUfH67gMSPCNaXB2famtBg2eg0BiaO+fcSWfJgX9S
   g==;
IronPort-SDR: fZ0F1MF4oahw3gYltyy2Dn57gl5j8WZMrkRQPjG4q32F3E3T4GHdu1lqJrwgCQdI8HMtWEZrOq
 Wo0GcBJ8946I3lR1W97tj7Y37lwDsFT1bSc8dNoRazWz4fHgq4VBwLySWMWlTe4lb1J4wNfpUX
 Y3a9O6FqQc28slBIGON3zTiDlayg/HOXX7WDo+hsrxobG0wOToT9OBoGBzDLWu4UjiFIONAkjx
 1QcqDgnnNosSINiGdn4bUGyZpvoxw6R3LC1dJTkKOZDN3s2voC2BsF0Pmu4DfKoL3b8kGX5TMB
 hgK27btEZVJ4b/FfvdChRu/2
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="84161889"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2022 00:11:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 31 Jan 2022 00:11:20 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 31 Jan 2022 00:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz2pezIzLh0cL9wiC6hAMrcwrpMhoN8Yed44ncvoRnP7yoyvmxSjweGoutPn1Wm7ky3E8RTXFLtTCItdVzQPV5uKLu3uQOQAfxf4RBykGQPGpFioMkm9Rg2ZD9ah2N1+CwdvI5HKe5hbKcJGQBxWY5tZccKoB8yMWjcE+qADTUDEHUAlE1Fk0WSV5kYtM2o5J5Rros5XLNBds+hgKq0MQAWA4DR8UDptuSExYokLS151pUIXqDk5xia4Qz+gvNBApANXVkaLm3J4/TEkiOPpItlZQ9/QMPJZcjiXyNnItOu/+p1bJe4+F73Ctxvw8S1757YvG0bWoMhPV6llN1kebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28D6/WwhC1f7LUnDeETQVtrJxEJQlhfekiMeg8dltgM=;
 b=PFO2H6cZKdDeEO+wThlg/Vv6Ktv3C30Vgf2/++QmGNFERu3S+pQ47E4psfuSuWWhMB5m1CNVzKpFbiXVyCnsOgqDHh3A5oFldkB1jAc9f3tHfqB796o0rb5D6WnmHqXscaGJVQ1H61Yy2imjUHalCgPSi7lExLfNHx4fpQl8037/3bjwgnV4LtI61zwqddE7F0UMTOQD6Gzq4yviniUB67PBCfjYYIuZeNDmwTcAcIoOPHYiOHXwsOkjV3UVkn4sdkc9Ns07qsvb7CGJ5IDJ6WVqzuzB4GKd5ZNq6fowioNMKv2jUdEbA25itkjPPb1s3QtmpKgd0eM7L6GzSOuzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28D6/WwhC1f7LUnDeETQVtrJxEJQlhfekiMeg8dltgM=;
 b=o8l32nRDY1DxkTBJoNkwXhxk0TS+dEcErZMS6Plz2byHNiTcxA1vWNqkchYBRJYrTZ+y1Mm0FzpBZdPw5QaHtvHFwFP4I7jsmd+1+Upi3px32b6b6bLk7h/rivTZBlu/EPwQG+X7DkvEbT2CYnyJUNV91unRJlmtQ0doVcdhCk0=
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by MN2PR11MB4287.namprd11.prod.outlook.com (2603:10b6:208:189::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 07:11:15 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::a588:b481:2154:c45e]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::a588:b481:2154:c45e%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 07:11:15 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] dt-bindings: ARM: at91: update maintainers entry
Thread-Topic: [PATCH 2/2] dt-bindings: ARM: at91: update maintainers entry
Thread-Index: AQHYFedFAAug4U8NE0+4XvVD0Lai+ax8t6gA
Date:   Mon, 31 Jan 2022 07:11:14 +0000
Message-ID: <eb3f4e8d-cde1-4d1d-ff65-35e046afd13c@microchip.com>
References: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
 <5bf9873eeee3cd49c52a8952a7cd4cb60b61d50a.1643553501.git.nicolas.ferre@microchip.com>
In-Reply-To: <5bf9873eeee3cd49c52a8952a7cd4cb60b61d50a.1643553501.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5031dba2-e9c3-4004-0fb1-08d9e488de94
x-ms-traffictypediagnostic: MN2PR11MB4287:EE_
x-microsoft-antispam-prvs: <MN2PR11MB4287630DC9D241D5A67902F3EF259@MN2PR11MB4287.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kydyjBKNxPerMK7s5ulvBEl8mq2DMK5K2rJXyhfxAu+Aku4TWAwc4URwZbhBvSu9X5jdKK5aSTCpriYu1/r8Xv50bETufozjsYxcpBji5HYIbuBQZuxRI+MRupIVSjurfisxYRvXBPcIIPtdg4gRnizCkMPMofiOj2n7SCjEMUkS07URiWZIGcPg4KIv9VjvLBB56DTBFmypsHIYXuWbwUfCDckqCAi6S0PmV86+DR3NSrOBUtKYdq0iC1d9QCF9LIFCNoGEOCy066dzOaUX1cutviBrEjJXCfmLj5yy2+D4fsHuoUl/mghCCwdfbN8EHCZlaNM0ZIMDByDfr3QS4KEObVV1MoiAPK4CkEH2yRWnQWClu45SSI7SbTy6iKoXkadfP/ASMDXmFNmJPaa44Ja6w/eAHhZLY2/1POp2UOhe50guBu0fmy4toTgoaliCdPtc3t53h3mbpePNw1jU1HU0k1M8GYfewwRaVTqjOofvp0gmjc4R4okEmnpKYRZQ0F9EknzsVjoPQyJ4bRmdn5fWMrNPcjkMijhpMOlWdgkwDY6pvGmrTJI8r6FXnl0XhFOj4pEeW7n4Mwt5hgoPzUCHX+XSixwu8T2aQXP75Q09vFdI0gM67cwmFpAxaMjEqcmyAst+9kQv4667KqqGcHXN59aoTAqK4ciwx3mfX7vFPokfK0tND3af9t3tpIviET7FbN+Zm3/XmI+l72MjLQODYwPOlZ+3CiIau6sYDx/r5t8JQgWbnfLB8X6FwKcTw0nSSsOMgYaI79XvL/iQmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(6486002)(2906002)(4744005)(53546011)(6506007)(6512007)(83380400001)(86362001)(31696002)(122000001)(186003)(26005)(38070700005)(2616005)(71200400001)(38100700002)(76116006)(91956017)(64756008)(66446008)(66476007)(66946007)(15650500001)(66556008)(110136005)(8936002)(36756003)(54906003)(6636002)(4326008)(8676002)(316002)(31686004)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVkzMjJRQWdKY0ZaWTUzY1J3V3ozRXd1NkwvY0V2ZWVkc1Q0dGxCWUVodnFH?=
 =?utf-8?B?MDJPSzNWWlRZd1RYZkV2bWpYb2NZY1k3dCttMy9tdjYvS0pCbk4yRFRlak5s?=
 =?utf-8?B?Y2VqQmQ4V1E5K1dYa0lKcEh2Mk1UZEhEQVQ2NkhmUzNvWmhPajErY1diRnd3?=
 =?utf-8?B?VWF1Q3lTTkpxT2F2UmtRZWdheFFaYUdWT3FCZ0JFejFRcmNlK1ZGemVvSity?=
 =?utf-8?B?TW91STkrWEhzek1qejVwdkdtWXFJNktLanFSK1pPZVlMb1dJWXFQWFdSTlNL?=
 =?utf-8?B?NDJqV1p3RTRqZ2N3eFlSOWF2N0YvTGNXSWNyN0hLTCtleEZ1T3R5QW5lM0RV?=
 =?utf-8?B?N3lzVVhaL1BiVUpLTHRYdnRsVmx3MVFaVUFDZThHRkZEbjdsQVZpOEh0T1l1?=
 =?utf-8?B?aG5vOEpBM09YdkRaNUxYY25yYnF4aVJlcUEzZVFaY0xXZVhtS0FWSXlyeFRP?=
 =?utf-8?B?TzQyLy9uRkJDSFY3K3d6VEgrMVROLzVIL3k0N1dPMnlKZFQ3Ty9GOXVEZEd6?=
 =?utf-8?B?ek5GMU9QR1hTaG9Zc2tDSUVNbVFaWExTOVMxTStsQloyY0NOUnpaM2ZrWHpH?=
 =?utf-8?B?bEp0MjRzMFRnOEhVc0s1SGNZSEdoVHgwbDA2VmRST253TnRIT0haR0NuQXFq?=
 =?utf-8?B?TU4vcFlyZWtxa0dTYVN6WHhyQUwxNGplWGZOeDBtdXRoWVJYbXFtZ1Qxckdk?=
 =?utf-8?B?YkpZeFdGVkxQVFFIaTJlUFY4N2JpdFdhUHcyTGdZTDhCYzZKcjZOQnNXYmhj?=
 =?utf-8?B?bmp3SldwU29iYkY0WU15Z001MEJIbTVQeHR3ZHJ5TFRvMGErYkNqK1JjUy9k?=
 =?utf-8?B?Zm1QcjFpd0RySkdyL2dqVFdXam5NZWJQUG1QWE0xcWVYUXFCWVBBRFZ4ZXZv?=
 =?utf-8?B?UDBoVDBNR0s4eDlPQzRJbHdpT2dHNURwVVdDSEVPdFlSM2d5cnY3Szlxd2I4?=
 =?utf-8?B?Q2JtaDFuNlRIN2VzL3FOcXQ4VnArWlk4Rm03R0pQdTFQMGJIYzlsWU13ZTdF?=
 =?utf-8?B?M0dKaHRQNE81OHZibjk4aVQ2L3ZpaVRsL0JMb3M1cjdFQm93Qkgvb3c0TVZM?=
 =?utf-8?B?UGdtbEtXR1Vza1VoVzk0MStmM2IyTDE2cXMzUE81M1diYnZ4cGZXTGFsOXVX?=
 =?utf-8?B?VkdXK3pmUHdHa2YzWDJDZEl2c1hEbE5QSjVJd29UaklZUWdGUjVBbjUwQnFr?=
 =?utf-8?B?bjlnY0szaWNZaXBBMVdSL0hMZlJDZlkxOTdpSEdXV1crSlVzMVRYdCt6MVhm?=
 =?utf-8?B?am5mVXpmaElzci9sMWRDcm9mU3owb2dDZXo3Z29tQW5sK3pGbEFyT0RPVWUx?=
 =?utf-8?B?N2JFaU14MmRKQWYzWER4RjlaUjY0VU9jU1l6V08yWEIxTFVueHl2RkdMazd1?=
 =?utf-8?B?K255MWRYeWY1K2VFbWpKZFNLaVB2R01RT1M4SjVYMzhwdGlwbkhTcSszSXN0?=
 =?utf-8?B?R1p2MDNPK3FLWnZXWmdRWTNiY3JZTXMwQnF5ck5KY2tqWGR4aVB5ODVTZ2o2?=
 =?utf-8?B?MzUybUhmZWNiV3hscy90eG9XWG1URFVNcWZnUDBlYzh4YmZxelBJa3l0SWk5?=
 =?utf-8?B?THlkd3FTbGZMK3kraTdkZW9NYXhTeFVXeXg4ZTVvMFowYjY1bzBRdFVZZUhR?=
 =?utf-8?B?Mk5MN2t4TDhJR2xBcGI2OHhQZm9iQUVjaXVXRFgwQUM0SUpkT0ZFK1FZQy92?=
 =?utf-8?B?dDBFN1Q0MWUwWCs4YmgvSm5SNEx6NHBpRXBLSVpScVViekNOeExQUmdSa0V3?=
 =?utf-8?B?QndKRGNHUVJRSlh4bUFBRzgydHpYSFU1czBJMW9Pb1hOcndQNVBZcTRjanhu?=
 =?utf-8?B?THBmaHAxa3pmNlphcEVjRzgvY3gvUi82YlN6TU5CRFpGWVI3ZnZEd2JxOFA5?=
 =?utf-8?B?cnRhTVM4eWFhTzFVQ3lsUkZhTTdnTis1WEI4TDhMa3plRThLQnVvb24xSmNK?=
 =?utf-8?B?ejJ0em5KTFhxRnZhUGtKRlRZSWxRYldrSm5rT3FsRnl1Q055TGpNR3JpSkxY?=
 =?utf-8?B?d1hQVzVyRkh5UEZtOTZ1SEVtb0U5NmxPb3A0M2F0T1FucVpDcEpUS2xqWjhr?=
 =?utf-8?B?MVBtcVFiNXErYmtVNVJ3TWEvZ1VDT0owVk0ydVpHMGVDL2FhdVFQZ012ZXdN?=
 =?utf-8?B?eW42d2c3QkluamNUSVYvWEVJRitGclM5UXhVZjA0azFETXpZSC9GUDRrOHpx?=
 =?utf-8?B?ZXU0aWdma3FvVWZQbGp2b2tUK0RTWEI2Ump3UXBZTXpnTXRCSFJnRkZ2aHA3?=
 =?utf-8?B?NGF3MnRSNWpPRDFJTnZJaDhjTWdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA2EACD5F2910C459B0E09363811559A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5031dba2-e9c3-4004-0fb1-08d9e488de94
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 07:11:14.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGw25sVjeDk1rfVAaLHKMyCQj59DUVYhsuPJ5E1RJE376GE2dWnjFfPbr+p3SsADxA+EK+bJi4micS9Bt5clj6kUqrSZ+8CXiFaorlf6hY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4287
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMC8yMDIyIDM6MzkgUE0sIG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4gRnJvbTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gQWxpZ24gdGhlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiB3aXRoIHRoZSBuZXdseSB1cGRhdGVk
IE1BSU5UQUlORVJTDQo+IGVudHJ5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmljb2xhcyBGZXJy
ZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KDQpBY2tlZC1ieTogTHVkb3ZpYyBEZXNy
b2NoZXMgPGx1ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwgfCAzICsr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0
bWVsLWF0OTEueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRt
ZWwtYXQ5MS55YW1sDQo+IGluZGV4IGM2MTJlMWY0OGRiYS4uZmY5MWRmMDRmOWY0IDEwMDY0NA0K
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEu
eWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVs
LWF0OTEueWFtbA0KPiBAQCAtOCw3ICs4LDggQEAgdGl0bGU6IEF0bWVsIEFUOTEgZGV2aWNlIHRy
ZWUgYmluZGluZ3MuDQo+ICAgDQo+ICAgbWFpbnRhaW5lcnM6DQo+ICAgICAtIEFsZXhhbmRyZSBC
ZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4gLSAgLSBMdWRvdmljIERl
c3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4NCj4gKyAgLSBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gKyAgLSBOaWNvbGFzIEZl
cnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+ICAgDQo+ICAgZGVzY3JpcHRpb246
IHwNCj4gICAgIEJvYXJkcyB3aXRoIGEgU29DIG9mIHRoZSBBdG1lbCBBVDkxIG9yIFNNQVJUIGZh
bWlseSBzaGFsbCBoYXZlIHRoZSBmb2xsb3dpbmcNCg0K
