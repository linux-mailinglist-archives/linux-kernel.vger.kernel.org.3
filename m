Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B794493489
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351311AbiASFeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:34:09 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:9594 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiASFeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1642570447; x=1643175247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F8b59EQmHBwDdrj/NRqTFVXK6Q6A0e1XsODWReyKDwo=;
  b=vAlHrM1OhwF3gmahfgMTIDTSRLmJCszCvqrCLmLdzbWc/iKRwcBu+Jw/
   AtxtxkI4g7vcoHbMlZDbVehh4iijOl3P5NrK28bAfG7m6y9+SCEu4yrR2
   GxsJZBTiAww7DhQJEopw5TnvW8aTE8kd8qVGxKFGss0sf/GlDMeLwtS1o
   E=;
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 05:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3qzRlFkBrIK9oOi4kDxb0DCEC6kn1x2yXtPbkJXtIJzz81L04Dx8r/x0/CO3HiY7ImwyGpJPtoXLk4bJ3JyrGgVofllemA8LDiz2dXN6QSAGVQqXr/pxSnl33A5UFeOwbyy2SV6qKm/tDaEDlpfncpyF8SNHfISQ6SxEJyQND6BcD4rGqEocEXejxdsAiXF91J0ipwbqTxZ5PuhUQhMYeDGeYV9PKinDxDUT2v0Jk86L/AigDG68HDLwNGYJcuI6Wdlp8wXZWk0UPxmYsXGSq0oha8svwcRfE4jVBCjqrnmbW4VXYo8QCUyM1WUOTX3ru6l2AdBESHpyoOk5h/Umw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8b59EQmHBwDdrj/NRqTFVXK6Q6A0e1XsODWReyKDwo=;
 b=mlQMf3TJErs8s5U+a1xarUSmnZcD+mXJ81Yj+4RL5Gv/0qQLcUw4OHNUQmI7HHbz6YftSGnGGWYJkRkrHdA6T+wIFu5Cmdx1rLROqrkB8mEMyRQielGlnehaDJpgCntYBvghy3/V69xHxBmwPvicadl2mP1ES6UmdwwdZyyZ2Z3okm9bwiObAXaXhlqrMejricKeW3BOp/l994kD/fUceh/Q3Zrnq+hHOzpXNt5n821j9zBv7sGn1/y4n5Zp3V0LJ+L/wsIx8x+Omx/E7Ai5YVwhGiYEeRTyccgvDZGMC3JHNhcgSTcp20pwMZKoJPrHOWsZ8LaCIfgRVouR6G6NBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from PH0PR02MB8455.namprd02.prod.outlook.com (2603:10b6:510:df::9)
 by SN6PR02MB4368.namprd02.prod.outlook.com (2603:10b6:805:b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 05:34:04 +0000
Received: from PH0PR02MB8455.namprd02.prod.outlook.com
 ([fe80::8564:d7d6:85e7:5934]) by PH0PR02MB8455.namprd02.prod.outlook.com
 ([fe80::8564:d7d6:85e7:5934%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 05:34:04 +0000
From:   "Sajida Bhanu (Temp)" <c_sbhanu@qti.qualcomm.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>
Subject: RE: [PATCH V3] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Topic: [PATCH V3] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Index: AQHX8NO+WlpZqE5WH0ySDSUiuNAdtawx1mGAgDgzhrA=
Date:   Wed, 19 Jan 2022 05:34:04 +0000
Message-ID: <PH0PR02MB84557EA76BD8DDD35A99B915CD599@PH0PR02MB8455.namprd02.prod.outlook.com>
References: <1639476991-25676-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <488aafc3-2fa9-198b-c448-d1ca7ef52f35@microchip.com>
In-Reply-To: <488aafc3-2fa9-198b-c448-d1ca7ef52f35@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb3605af-e9e7-4809-50af-08d9db0d4e45
x-ms-traffictypediagnostic: SN6PR02MB4368:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB43687BBB0128F4648DD3B849CD599@SN6PR02MB4368.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLadWOEZlikJws4UBEOyfD5VMewf5w1rX50h9OpgRmTaWHaotdKuPO9762JqN1S8L4g46Ur7Qe8v2SueTgkHTYKzFUHBBXnLoo3GR9wxO1VF8cU4USvj+V7krvVCX0mKyqt3+BlwVgjluxgfpWeq92RqpsauHungIcAypqPRVXI2JhbsUOJLD2hsG4F56LuY0gM48G8duJDBB4tLCPv2m5VnEQ3EzrZ1O+K1TyFYVlAtA5L3vqf4WYln2a+1jp9fwPQE9/SzFqBk4pbyvOrx2p9XcKcSwlqw9CDIi/VqyYHdzPbEtc0Rqt8Elju/e8pKEHnQBJrdH32/y9JUq9OVyDwgncZyh5HCMvU3yyW+8qAbMCeHZHVtiXo89K8Cr/FDI4AgrGAWArdtL+iQy/4mb4I5o3/DLbwSu79xpBU96u+JyeN6hYm5Pv3pKSroGFBqTHjYqdzblNigAHE9bBDQGaNF7xyXDiOk+dv54htlNOC1icBDmKzhQQYVSf/+q5Qqfr+ZW/1w99sVgFbgPPblRzh0FO88/pYrm8rL9klaU8kvwKqYQ3YxWJuleoT2OHELQt843BBm9/aig5PxYz1lYh9tfA3FXc5Ct7uYC9rdQuD63n/hlULKHp9Ynbg8wQAXN7Uqpd0K8MzLb/de4jXXAaQ5FGut82aXJySw6udwbvjgJMbQIyNYyAwPSAdNshirDIAsYPFzDE2y9//O8vqEKKOA32T2wjcAKqU6TM7LqJY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB8455.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(7416002)(83380400001)(54906003)(8676002)(122000001)(110136005)(66446008)(921005)(66476007)(8936002)(55016003)(38070700005)(71200400001)(508600001)(5660300002)(6506007)(7696005)(38100700002)(33656002)(66946007)(66556008)(52536014)(2906002)(76116006)(64756008)(4326008)(53546011)(9686003)(86362001)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEZSRnUzZGQ1ZGN4aHJjUXZsMUV6ZnZZak5iQTZkalpXNEEreitib29MMDBG?=
 =?utf-8?B?STlPYmVnR2wzWWEwdnJydWpWdjhtdVpIYU5hcTFxMGo5Qk1zTFg1MTBaQStz?=
 =?utf-8?B?WXpVT05aSzduVytFSkRkWHBBSnpGc3JOYUd4RmhLV3RETHBGMGI5aXoyT2Ri?=
 =?utf-8?B?TzJ4UG9ISjREUlI5Ly8yU1NRb3ZneXpPMWlFNjBFZVl0N1pMbm8vdFZGRzFR?=
 =?utf-8?B?ZWtCMjVvL3BVeE5wNmlVSHh2ckZ1RitsMTRVUEFtQzY5WEQwZnRteVhiaHBL?=
 =?utf-8?B?aVk3UEVHait5SG5iZ250MFlRcjBlS2hqSXlkWU5UbFMxSUIwazArSzJNZExI?=
 =?utf-8?B?WkE2bE05VERzN0xjcUhTM1RhUnZjZVR2bTBKQzFKaUdWcllNOFFCNFZLVmtv?=
 =?utf-8?B?N1Z5TDVKeFgvNUFtZTczdU52cHdDSWdoVlBLNFhabUp0b2FyNmoydXlITGxu?=
 =?utf-8?B?b2xId2UxS3R2dE5pZFhIODcrU2FCVy9hWEhyS0VlRnZFT0V5MC9SYStKNUVy?=
 =?utf-8?B?c3hYeGtKK2k1MCtVZ3VlanJKMDdjZm9RbUFpejdnVHF4d1pBV09pZWtGQW5I?=
 =?utf-8?B?RjFPY1ZDeG9oQzhYY1V3MUZBODFoaExPby85N1BtN2JoeEVZWHNaVVkxU1dN?=
 =?utf-8?B?VWNqeGh4RXVYbk1CK0JaS1Q5d3hlbjlOSGIyb0hFV1l6UjhwVDVRalprRFJH?=
 =?utf-8?B?OXB6akdVNE9za3VKWURRdUtKVUpyMFdmRzZ5ZWRRUHVmM0svUEplZHVJK09n?=
 =?utf-8?B?SXVZS01ZTWpEN01WNVVHd0FhS0ZTTm84ZU9Fck1jVkF5eW1oL2JpK2IyR2pH?=
 =?utf-8?B?KzF6UVQ3aitDQngrbG50M0txbHN6VjBWaWc5MzdzQ1RCUC9wWUd4SEQxWmpl?=
 =?utf-8?B?UHdLWFNpWEQrNy95L3JncUNjMzBQTlRLNFNVNFllUUdXWWw3d1F2Y1YrY21h?=
 =?utf-8?B?V0tpWVltMDl5bVNHclRhakJ6a2psNThEQjlEbHhKYlBWenljSDV2eGE2R1Nx?=
 =?utf-8?B?MjR0OThCQTdRWTNYZXZSaU5YNlZPcnJiYW16WERYdW5wMW9QTUtXL2plRVlJ?=
 =?utf-8?B?bGlWU0xPaStJdnlUcjc3Q21SbGNXVU13bGtzYWVqVGhrY3VvMnk0SUJOcjRZ?=
 =?utf-8?B?Z1AyVzZiRzFrc1M1NEU2U3NQNXdQU2RQYlRNbG5Jb1NtNi8wVnJTbDVPUjhv?=
 =?utf-8?B?WFhaS1dNTG85bnlQQkFJWFVBbStLS2U1d2Y1d3NKU1VPeTB2VUFsQVQ0WjND?=
 =?utf-8?B?ZHJxbXUxT1gzcGdkdDFqTkRzYzFaek5KYS84RHVySkJPakxBVytlN3g2WWFP?=
 =?utf-8?B?bk9NY2lGVDdXajBTc1NSbCtyN1d2VS9VbDdSTW1pbjdndmJuam9jSjE0VU1v?=
 =?utf-8?B?ZDZibG41Z1dwNDdkeVRoa2RQRVp2MDM1c0xUYWdlR2JoalRpY3FXNThlSE5k?=
 =?utf-8?B?YkNBdjZYWTJGY2hWbjI3bkdBb2ordE5wQUFkZy8xcW12M0ZMeVZMTW5tekVH?=
 =?utf-8?B?dHc4SUJMc1BRUTArL0FSbWtEMGVhU20ydEtBU28wK3pHMGZzTnppT0hjVHl0?=
 =?utf-8?B?bXE3bW9Ra04yRXBaSllQZm1Nd0pIMHJCUXVYSnI5OEpVd1dHQUFnZmp2MlFI?=
 =?utf-8?B?ekd2SWhUb252OHJwcjNnQ3VNRVBQZG83U2paYlI4QXBsSnpCY3ovaXNVSkNv?=
 =?utf-8?B?YVZxZ1R5aFBoUTR5R0RPUHU3V0JrZGxyRUk1bERYQWdQS0hsWVczTUFNcXVH?=
 =?utf-8?B?MW9FQ2U5cTUwZ211S2oreXprOHdLUE1yQzlVRGFJN3BFaUpZNHIxdStrK0wy?=
 =?utf-8?B?VUtmb21EbThxblVGMVphK0U3c0srdnlRUkg5WEZ2QzVzOGw5YU9TS0FWb2Rz?=
 =?utf-8?B?YU81SGpQUk9RV2lPaHFUZFgrZzBkTTd5cGxCQllMNi9pRVpLaG1BeGZ3UHph?=
 =?utf-8?B?bFNyVmtMZGNPMm1HcGVjODc0YzFVWEl0QWhMV0VHMDlGT3lmSnR6Y3JUYitO?=
 =?utf-8?B?bXJFVGZCYTBNdXhxUm5xZE1Ka1FRQlk2Qmw1aXJScU9GYXFpdnZRSFRyQnJK?=
 =?utf-8?B?NnlLdVFTUG96NmZrcUgrVmxXZWpHZUk1ZTRtTEZ5VkpwYTVURmNuLzBNRHUv?=
 =?utf-8?B?UHlNM1czWnZqdjNaT1MvallYZVBqekczVU54c1ZzRnN5Nks1c3A3Tjh6VGx6?=
 =?utf-8?B?dW8xZnV6ODdZL1ZNTzNSRlFjYVJqd2VYdVZHSTd0QmRITFNRRzQ4WjhlVXc2?=
 =?utf-8?B?a3l2WUNPVXRaenRvamd2aWVFcThBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB8455.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3605af-e9e7-4809-50af-08d9db0d4e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 05:34:04.2608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1rMqus4iE2DDfJoTlR5/Oj0lN89apzX8yvc9xbwJBZuw01rKGP7IHD8LnoTyLFrYJtGKnsSGkgdCI0p8LVfS6yh3SaWW9NMEaOPqe0Ko9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4368
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkdlbnRsZSBSZW1pbmRlci4NCg0KVGhhbmtzLA0KU2FqaWRhDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIDxUdWRvci5B
bWJhcnVzQG1pY3JvY2hpcC5jb20+IA0KU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTQsIDIwMjEg
NDo0NiBQTQ0KVG86IFNhamlkYSBCaGFudSAoVGVtcCkgKFFVSUMpIDxxdWljX2Nfc2JoYW51QHF1
aWNpbmMuY29tPjsgZGlhbmRlcnNAY2hyb21pdW0ub3JnOyBtaWNoYWVsQHdhbGxlLmNjOyBwLnlh
ZGF2QHRpLmNvbTsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsgcmljaGFyZEBub2QuYXQ7IHZp
Z25lc2hyQHRpLmNvbTsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBzdHVtbWFsYUBjb2RlYXVyb3JhLm9yZzsgdmJhZGlnYW5A
Y29kZWF1cm9yYS5vcmc7IFJhbSBQcmFrYXNoIEd1cHRhIChRVUlDKSA8cXVpY19yYW1wcmFrYUBx
dWljaW5jLmNvbT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpIChRVUlDKSA8cXVpY19wcmFnYWxsYUBx
dWljaW5jLmNvbT47IHNhcnRnYXJnQGNvZGVhdXJvcmEub3JnDQpTdWJqZWN0OiBSZTogW1BBVENI
IFYzXSBtdGQ6IHNwaS1ub3I6IHdpbmJvbmQ6IEFkZCBzdXBwb3J0IGZvciB3aW5ib25kIGNoaXAN
Cg0KV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29t
bS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90
IGVuYWJsZSBtYWNyb3MuDQoNCk9uIDEyLzE0LzIxIDEyOjE2IFBNLCBTaGFpayBTYWppZGEgQmhh
bnUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgDQo+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4g
QWRkIHN1cHBvcnQgZm9yIHdpbmJvbmQgVzI1UTUxMk5XLUlNIGNoaXAuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNoYWlrIFNhamlkYSBCaGFudSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IERvdWcgQW5kZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4NCj4gLS0t
DQo+IENoYW5nZXMgc2luY2UgVjE6DQo+ICAgICAgICAgQWRkZWQgc3BhY2UgYmVmb3JlIG5hbWUg
b2YgdGhlIGZsYXNoIHBhcnQgYXMgc3VnZ2VzdGVkIGJ5IERvdWcuDQo+DQo+IENoYW5nZXMgc2lu
Y2UgVjI6DQo+ICAgICAgICAgVXBkYXRlZCBjaGlwIG5hbWUgYXMgdzI1cTUxMm53bSBhcyBzdWdn
ZXN0ZWQgYnkgRG91Zy4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyB8
IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyANCj4gYi9kcml2ZXJzL210ZC9zcGkt
bm9yL3dpbmJvbmQuYyBpbmRleCA5NjU3M2Y2Li40MmQ1ODAwIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3dp
bmJvbmQuYw0KPiBAQCAtMTAwLDYgKzEwMCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hf
aW5mbyB3aW5ib25kX3BhcnRzW10gPSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
U0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ICAg
ICAgICAgeyAidzI1bTUxMmp2IiwgSU5GTygweGVmNzExOSwgMCwgNjQgKiAxMDI0LCAxMDI0LA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfUVVBRF9SRUFE
IHwgDQo+IFNQSV9OT1JfRFVBTF9SRUFEKSB9LA0KDQpUaGlzIGRvZXMgbm90IGFwcGx5IG9uIGN1
cnJlbnQgc3BpLW5vci9uZXh0LiBXZSd2ZSBjaGFuZ2VkIGhvdyB0aGUgZmxhc2hfaW5mbyBmbGFn
cyBhcmUgaGFuZGxlZC4gV2UgYWxzbyByZXF1aXJlIHRvIGR1bXAgdGhlIFNQSSBOT1Igc3lzZnMg
ZW50cmllcyB1bmRlciB0aGUgY29tbWVudCBzZWN0aW9uIC0tLS4gSSdsbCB1cGRhdGUgdGhlIGRv
Y3VtZW50YXRpb24gdG8gYWRkIHNvbWUgZ3VpZGVsaW5lcyBvbiBob3cgbmV3IGZsYXNoIGFkZGl0
aW9ucyBvciBmbGFzaCB1cGRhdGVzIHNob3VsZCBiZSBwcm9wb3NlZC4gU29tZXRpbWUgdGhpcyB3
ZWVrLCBvciBtYXliZSBuZXh0Lg0KDQpDaGVlcnMsDQp0YQ0K
