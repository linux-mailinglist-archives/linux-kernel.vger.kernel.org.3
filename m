Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1908C49C656
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiAZJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:31:52 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:5097 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231687AbiAZJbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:31:49 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 04:31:49 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643189510; x=1674725510;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VDKramc6eByq2O9zVU7SCXhBe00kZXXE+RNjfwlVUCE=;
  b=F57POHqEiI//RhqKKbWLiesVUaZ3FViZOljL5L5/GU1x1qnLnfus4DWJ
   v9rP2uu66WrJBKGb+CvvbuhvF6CIUUyJKaSnAgOYvWijo5rxJee4VGE3a
   hIw1BnQYCp9e6NdMnj2aJ8B3Vnz2leQs1YhI+d/fLjFcvTsSGe+DQ3D5z
   cXN8ST2FsbslhUgVXYi5+w893BI+UE6FaiZjxLHEHVpOeFmwGQ6jakfQQ
   Uomh9l3BBlQ3eNVmhPOJWATKzXXrYwBiVi1r9zIG3XmJVOQTFNat1RMaZ
   dD520S0B+Q8n6bRTpckDpxLI7+7Ac/JnOl1gEkBjYuYPXUDIjNKvsmdIS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="48593516"
X-IronPort-AV: E=Sophos;i="5.88,317,1635174000"; 
   d="scan'208";a="48593516"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 18:24:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBuswHHPbHWwMwkghzSVVBxehKK0IHo7TuViq98/Fs8soRGrvQ4iLrM6zUShvs+rt4mrWBxAwLcPbKPqiU1m5PjXGKfW3GI0IaAgcMvKLC1boadQYDXkTsAisaYbTZUNBlpGc7TEuzGKplhC6DkedTsW4CDxDSArZjnCLxE1Yr9MGlPc1OfeIN9z2rBuEwTBj1IH/5VHt5Ss5XIryFQvckfzXjSJ5igLxQeUmJoBVj30FHNYWG6vda5wokAqgjq51hGGdDV1chw6RFaRlrNGMS7MlIFhDBRfI6qcMz83GCd9wglwl1FOXpSatyiYMQJd5PEPofb6HNylbFHD3wo8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDKramc6eByq2O9zVU7SCXhBe00kZXXE+RNjfwlVUCE=;
 b=nTo3KMCNsMtAzQouMw9zfIkc31UwXjlJ+GqqYcXiWKPFtTr9ZmUa5qfwO5em64yq/FNIp1xbgBQxVsTC3oOVZjbhz+pGkWa/ZbnyRwMnD+dTq9PfMENtZaoGWEUofvkNJ1s3khQ2/cLeAtJyy/h9erv4pag+BB7WsM4wZYHAPUgwqSBMwpuQp3Bnhe1yF8UYbpOffKsCQks3dqKQVX5ais8Lnr5D6kvCgCvjKY2LWFm+2KPBNTEjmozsAaVuVvPy28CRIUyBOROLqtPMCw1W9Wpo2oLJK0BHrkYcFmnq+QReOgVRncwnI2GhuZgbgVmjIVTLXN76gwE7SltLzrLzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDKramc6eByq2O9zVU7SCXhBe00kZXXE+RNjfwlVUCE=;
 b=o/h6lUvE6ZXD+6lK2FMagcb6wtyxhkoBgnvyMHDBUnkTLN/8JbdLRgNrOEYGlt4UBmaweSCpYovKhd4fl3peNhtFTHdxlLIRYUlMKxhyaqpb/t70JCT5O8AzfBr6Hs613TYqE89YSsNvZgwAjVRuGvBfvAMVNhRGI+gakXqE6Eo=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYWPR01MB7546.jpnprd01.prod.outlook.com (2603:1096:400:ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 09:24:35 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::b596:877c:caf1:e443]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::b596:877c:caf1:e443%4]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 09:24:35 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/8] Add hardware prefetch control driver for arm64 and
 x86
Thread-Topic: [PATCH 0/8] Add hardware prefetch control driver for arm64 and
 x86
Thread-Index: AQHYEbslRPUwfHir+UGUrxDN/z0Itqxz2JsAgAEo1iA=
Date:   Wed, 26 Jan 2022 09:24:35 +0000
Message-ID: <OSBPR01MB203754574F2AC6281EFA1FDE80209@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
 <931f6d2a-9001-e736-e7e2-7f86f87539cc@intel.com>
In-Reply-To: <931f6d2a-9001-e736-e7e2-7f86f87539cc@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe783306-ebb2-494d-fe96-08d9e0adab2e
x-ms-traffictypediagnostic: TYWPR01MB7546:EE_
x-microsoft-antispam-prvs: <TYWPR01MB7546328874345F251AA8E09380209@TYWPR01MB7546.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWfQHr/0aV7KSRZamyV7RsXtjfsnf05YDmodKLdeQA4jkCKQQn+OJ8g242veM2dDZ8IslIuerX+Fnt65xAqwcXKRzRLXLfznmTPliGrpr9qQR58DNUmjB3Dlr8w3sf57PbRPuD742kJpl7cC8oGfMVyXqFVvQYYpuL+1baaHWZCtT/jr6J6V47co27pVMzaeMsgrtUdCIlEw1WYSfWvrP8i+UcCy93JDHArWK8RPzIlsr6yn2hhpGDy98MFxKKiQahO1RO9zPud9kIOrLQcKtQMgOSOnad0vaMTzqfhrHl8WMgefGS9lmkdU/ahpPvKhgtdttFc+TILMHPpwUjR1G7+94C9/B+hxAl8pf4mr6Xerd337N9vGifTiAUP0Z8Vj+b/zpKR16+UPs0m7oS/IFlTqN29VsQy0MMlSvDYGvrr3szTq2Ees/p1Ey0qUhPzMh+IAmHOgVd8U7v52WTn8mG9w5LoebTpZ9dJwtIAHrYZJyH9qLBZ1CjjEwFmUaAvFCbNjFJXYl66lJxTHS0sl+P5fR2muQy6UpxCmp2kovWp6w+DpDmUPH5or9JTgKFDDLlgiXF7GKJTtiTZHlB0yWdNyOCIJ5sPbBaGY3ZiLfrVPXlZ7hgrEo3sUgu0YbjC136sK1q/wnTSV82Gsi8dyZ/NN2owRIKweuYXtsmN35Yt1xuDmEe6SClay8dWWqR2E5U+R0yFLenhWesTNG6deQfyKDkA2vFN0jdm16cuc+Xc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(9686003)(110136005)(76116006)(66446008)(64756008)(122000001)(33656002)(85182001)(8936002)(4744005)(8676002)(71200400001)(66946007)(66556008)(66476007)(508600001)(5660300002)(55016003)(6506007)(7416002)(52536014)(38070700005)(2906002)(921005)(86362001)(82960400001)(186003)(26005)(7696005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WklCNC96T1ZDUWhkVWN3MXRwcVBRTTJwclZ6R3dPRU9hYUZld2pGaGEyVVVj?=
 =?utf-8?B?OCtDMXA4WEJQeGpQQkRMWWxQaG1pbkR0ZU1YQVVWNHV5YmlETXhxQjdsZ3BD?=
 =?utf-8?B?bWJyMmpqR2xKMzFQazRrVXMrRTd6OEI1Qk42ZS9qc3ErNzN5SnlwbTd2bFFj?=
 =?utf-8?B?ZmNKaUFNRkkvNHpBckJqSUNMOGZ2Mkx4bUN3MGJjZ1c0K0FRRmZsaUh0UjFO?=
 =?utf-8?B?UFIyb28veGVHeUwyWHZTZ0FCUVRtazdaWG1QK0ZCL2ZlU3VoVEYwczNFZWJx?=
 =?utf-8?B?OEUzZy9kTUhwWlp6U0hTVHhEdy9lMVFLcG9vR3ZZZTIvZkg1VUtocWt3QUs3?=
 =?utf-8?B?c04rMjQ3dndJQnVOMnhxNHFZUHFkQ1hYOGtJWGs5MHJYczc4OXN3RTVzaDVw?=
 =?utf-8?B?L3c0dXQzTDU4VVpMU1cxQmdZUWZkSGVEOXZMdHZweUsyMEQrVU9mNkw1QXgv?=
 =?utf-8?B?WEUxczZvREdsTDZXQXA5UGdsVjZ2aVVXNE5jd2JNRUpJME1sVWFoR1BWZzNl?=
 =?utf-8?B?eXB1NVFVVGx2aUZEcW9IT3loM2l4Qi9zNEVrbjRSWTlvTERBSGhmK1Z5Rk1B?=
 =?utf-8?B?ays2NFVSZ2x0K2NVZndFOVo0VkErMHRCOHJiZG1RUENRMyt6WkY2UGw3NnlU?=
 =?utf-8?B?cDJ6c0NGUHUyUm0wZVZHR2RhclFsYUVjaHdneEo2N2R5Uys5VkxIaUFaUXB3?=
 =?utf-8?B?aXhRQjVQaFhqWmd6dFZid1pQVzRhQWZkWmVXMnBXNjlhajBuNnMyQ3VEdDk5?=
 =?utf-8?B?dCtSUFRPQVN4QW1XbmhJSy9BZ01JYURpbVlVTjdoN1NjS3hYQkxGcTRubjY5?=
 =?utf-8?B?dE9INS9ic2hUZlNoOWF4QmxZczF4eWl5NVVLMFBBZENPaS9sWHpOTFBiOVU4?=
 =?utf-8?B?UksyWWNsay9jang3M1J1ZmdlY25WbExoRnpFWDlrc3ljczVUKzV3WlpBMHFP?=
 =?utf-8?B?aVBpejM4NjRSbXZ3bjJoTHYvMnFWNTN5K3JMN2l6d2d1cjYwVjdyeFdsRGtG?=
 =?utf-8?B?alYvTDlMUFExRmxoV3BaaElmaERZanYyUk5lUHpNMGhwd0grTFQ2OGlOTUE0?=
 =?utf-8?B?RGNtcjBIcGpQeVAyL092L0xwbU9vZ1BZNEhBSlB2bjhCeVV1UWJEN1h1RTlr?=
 =?utf-8?B?a3hrWkd4QmxNaExacU9Ceko2VHh2ZG44U3BsS3NhTFNlN0RyM3FxWlhQWjhJ?=
 =?utf-8?B?dEVuS3Zya2trNXByR3JxaXRaQWVCL0x0RHA0dDBGSWlvZ3N3TU85OGpGWnJq?=
 =?utf-8?B?OVAzTnIwcHFnRjA2UzZPQzRTWTBCOHJ4VFNUVkl1VGs1Rzl2alFIU0hIR0I4?=
 =?utf-8?B?UHV5ekliODEyY0pLNEtvR0pCNTUybW4zaG55TnZiK2RpWDg3Qkk1dWZUVnVN?=
 =?utf-8?B?SndwbmdhY3hyTHh0V1dYSnhCWkxXSk00Y0ZIR1RGdHpTMmpnekxKVnBHZllw?=
 =?utf-8?B?ejVKNnByOGhEUmtBcEt6UUtwaTdLRUZoVmxQYi9hV2JoR3ZadWlYS2RNdmx1?=
 =?utf-8?B?NlF6RWxCK0dnQXdpUWlnbmR1VHhQakE2RHZXKzJvMTlEbHI5NW9EbDN4dVNi?=
 =?utf-8?B?OVo4TmVyeVJKbW1DaUFEOElaRVhGNTd2UWs1dnhMcUM4R2lkVVpvdlZReW5k?=
 =?utf-8?B?RTZKbTlEWHUwckhIS1MxclhSZ3RiTUlPVkg4WTI0M3BxaUs3ZHZ3eTVjUWM5?=
 =?utf-8?B?S1c3WGFUZzJxdDM1QWx3cyt4L1RQem1wZ25ua2lHYkQ0YzRyOTVML3BRY1A0?=
 =?utf-8?B?N2luZFhYbVFqYitHdVVENGhrR2phV05TMG41dWNmaXoyVTFzaW5RKzF0aGxP?=
 =?utf-8?B?Y2ZORUhlU1dYMDA5VW0yQU5yM2NHRDVaQnBFOVIzN0VRVDR2encwdGdmaS9V?=
 =?utf-8?B?TVU5aW1HZTVEL0lrTElOUXJ6ZTFHT3ZYRFZWNklUTmxJSzFiY1dqM3Y3UTIx?=
 =?utf-8?B?NnkwbGJTemZCMS9EM1hrZTNqR3VDdnVtTnM3U2VuTjM3MkVyUlBxcnRGODNs?=
 =?utf-8?B?M0ROK0FCcDRZQjFQZWlzbU5aTURudEdFdVhMZ1BXdzdSa0R2K0MyTmxmeGlq?=
 =?utf-8?B?Nm5xbUhXRWNWMmJteUFuc3NMZzNXOStLK1FsQ21iSm5zZzRGNjl3enVDR05w?=
 =?utf-8?B?WFVjNUFFdFM5UnBwYXo0OW44WEJ2RkNtTWdnaTc0S1dORTlIa3JQMElwWU0z?=
 =?utf-8?B?Qk1CT3VRZnhKSlhQMXNLdnM1Z3VJN2cvaU5GYmNnRGpLUldwK0tuNzVZKzJQ?=
 =?utf-8?B?ODRGZ0g1OWNyZFI1RFJEbjhqaVVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe783306-ebb2-494d-fe96-08d9e0adab2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 09:24:35.4646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDZyXpxIIiBOJS9bBYS52CWzxCH3VTNoixQ0+dRPqNjalaPz28t3UXXiFxt7iAbctG8iJ1QkgLp3L4h1Gqy61AAjyWjp+i+YDHdUxUz6MgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBEb2Vzbid0IHRoaXMgYnJlYWsgdGhlIG9uZS12YWx1ZS1wZXItZmlsZSBzeXNmcyBydWxlcz8N
Cg0KU29ycnksIEkgZm9yZ290IHRoZSBzeXNmcyBydWxlcy4NCg0KVGhlIGN1cnJlbnQgaW50ZXJm
YWNlIHNwZWNpZmljYXRpb24gd2FzIGRlY2lkZWQgcmVmZXJyaW5nIHRvIHRoZQ0Kc3BlY2lmaWNh
dGlvbiBvZiAvc3lzL2NsYXNzL3JuYmQtY2xpZW50L2N0bC9tYXBfZGV2aWNlLiBIb3dldmVyLA0K
SSB0aG91Z2h0IHRoYXQgdGhlIGN1cnJlbnQgc3BlY2lmaWNhdGlvbiBvZiBwcmVmdGNoX2NvbnRy
b2wgd2FzDQppbmFwcHJvcHJpYXRlIGJlY2F1c2UgaXQgcmVsZXZhbnQgdG8gIk1peGluZyB0eXBl
cywgZXhwcmVzc2luZw0KbXVsdGlwbGUgbGluZXMgb2YgZGF0YSIgaW4gRG9jdW1lbnRhdGlvbi9m
aWxlc3lzdGVtcy9zeXNmcy5yc3QuDQoNClRoZSBuZXh0IHZlcnNpb24gcGF0Y2ggZGl2aWRlcyB0
aGUgYXR0cmlidXRlIGZpbGUgYnkgb3B0aW9uLCBhcw0KZGVzY3JpYmVkIGJlbG93Lg0KDQoqIEN1
cnJlbnQgdmVyc2lvbiBpbnRlcmZhY2UNCg0KYGBgDQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9j
cHUwL2NhY2hlL2luZGV4MC8NCglwcmVmZXRjaF9jb250cm9sIChhdHRyaWJ1dGUgZmlsZSkNCmBg
YA0KDQoqIE5leHQgdmVyc2lvbiBpbnRlcmZhY2UgbG9vayBsaWtlIHRoaXMNCg0KYGBgDQovc3lz
L2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NhY2hlL2luZGV4MC9wcmVmZXRjaF9jb250cm9sLw0K
CWhhcmR3YXJlX3ByZWZldGNoZXJfZW5hYmxlIChhdHRyaWJ1dGUgZmlsZSkNCglpcF9wcmVmZXRj
aGVyX2VuYWJsZSAoYXR0cmlidXRlIGZpbGUpDQpgYGANCg==
