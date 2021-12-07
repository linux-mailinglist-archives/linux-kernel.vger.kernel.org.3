Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346C646B31F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhLGGqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:46:09 -0500
Received: from mail-sgaapc01on2122.outbound.protection.outlook.com ([40.107.215.122]:52065
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhLGGqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:46:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9KLq/jNMO2JoVNEfZThzLERhH0L5kqEbejDLEayA08GGsMptoG9/GUlR7z+NmPurAFS1OBANbUb5lp0Qt9YrhLjNtoMvaH52IoQVPnRVnQFWevSxheBPm7rhPgMrEL6S0Xwsz22RGZ/hFSqJnLUm+kbB5YczWAQi9EW30VoS60kSramsOKqfXYDvqDz4BIJ2bUHZj0aGzXm/il+h7ogb2+m9LNKVbNH+DCQxSuhn1+jrjjlhs4mRzCMilaUbRT0fOviYIAkG4e7F8SUfwASTYh7SLP2+mFg5AsqGtsEGGkwyi1fiadiLSekFwxvSJIVyzRBwtFv8esBFe64A8/DZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QFAJ1lbLn/7Sxqg0acNofJvz1RmIfH9EnLmg920sgk=;
 b=Xs6NceZM76x46WTRXE7UnDOaeAQIqj697mxYv1wIznZp9OmRIk9Pk5eeGDU5f21U9zCdT/x8m3DvY7Q3dZI7kWstMGgtq+nDpvJ23PwYZSI+q1yuvQg3C+6luBwtFiYspKIUK7t171+Jh8809yw65Yau8pNrNnk0hkINVDo/9h/1/CsC7rqpoBpl6FoI28QYTt3VerkrhNN0FNKoQ3HkEie9no7Vh207vR1SPHzQqjpPfw8WSLVAUq6Wz/1asv94lppDS4yAt0dOKiyr1hqJ6zN8mwQT8eGa2ayPZN5jgE+JRdgIAmP02BdnM8ZCju/dVTDPqmGwXdQFQrpdIG/XRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QFAJ1lbLn/7Sxqg0acNofJvz1RmIfH9EnLmg920sgk=;
 b=khtBwuJbWOvNX97iomZG3KC5kmgccuq8qAya975MebRGNgU30+34V75Yb9qhi1Dc/rD+V6BmE3H9EEL/o4VRDZpDAOaeuOYId5BOjeTMMrsCZ93BDAxNN0+xdurlIQP/Ll4p4HLAirgEmUnadm5ijrB1gDStEHxsUBDiEiTvYoc=
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com (2603:1096:203:df::11)
 by HK0PR04MB2769.apcprd04.prod.outlook.com (2603:1096:203:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 06:42:33 +0000
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::50ac:5788:d373:7194]) by HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::50ac:5788:d373:7194%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 06:42:33 +0000
From:   =?utf-8?B?SG93YXJkIENoaXUgKOmCseWGoOedvyk=?= 
        <Howard.Chiu@quantatw.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Patrick Williams <patrick@stwcx.xyz>,
        Howard Chiu <howard10703049@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Topic: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Index: AQHX6vPlDf93t8kSvkG92vOctn4vNawmU+qQgAALh4CAAC/pcIAABHOAgAAAbxA=
Date:   Tue, 7 Dec 2021 06:42:33 +0000
Message-ID: <HKAPR04MB4003F9B004832D65286DC40E966E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
References: <20211201033738.121846-1-howard.chiu@quantatw.com>
 <Ya5/v+VhOM9o9BtQ@heinlein>
 <CACPK8XdCjqB+HZ_g9O=gjnSne3=iV44i6jKP5M8yWcsjnttaog@mail.gmail.com>
 <HKAPR04MB40033D58E2C1F96DDF16C13C966E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
 <CACPK8Xd93Kmvh7kT+4tbMO0+6LWa-2ORmt_KNB_hpqMYhso46A@mail.gmail.com>
 <HKAPR04MB4003DBD7D21B59723CDC5718966E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
 <CACPK8XduCFo-LdvL7ung8QksCsuyQypaXC_E-i5obC3SZ00AYg@mail.gmail.com>
In-Reply-To: <CACPK8XduCFo-LdvL7ung8QksCsuyQypaXC_E-i5obC3SZ00AYg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dedfc12e-9f9e-4f73-0dd3-08d9b94cbfcd
x-ms-traffictypediagnostic: HK0PR04MB2769:EE_
x-microsoft-antispam-prvs: <HK0PR04MB27698E32DD11964944E91E6B966E9@HK0PR04MB2769.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FySdYDVZnbzvrIAZgwd2iA0NH5vKo+ytsBB/XbhSot9rDGV+yZHUYDrc4paB+ua9JXQ0vljbaT91PYzpHZUCWETLZWI0q1DpAC9MbJpx4J7abcPDaZsMgJxtG6VsOVfg+DQQwevcEnnVke/CQzaLEuLqAasZgiMqeXNMNfptFWjPvbW/wQB2O7S+S3PxbxCjV8hpT3/ScXC54vqwpYJHMTofboypsztH+cLUeBtBb65kaUl1wqtOVaV1zDe5CGeQ+2/jjsBvu862iSHR+yVqXxi70SnGkWrjnb61iC8VXgPitLhweEOfgirloQDHnSweeEgeBPEOtCK3+oGwEIt/Kr6lSZgzoqceE5vt65p6XU7H8wt4R404cKK7kW9jjPqzNCDM+t7cY+0GhcDdkw5kB7SalHQhp6T4BWpsM5fnj8MOboKeWWn4egW8IXHhvPyheeWWVAOopMFPYpRdMVgLxj+fLh1u+79aPbNmKQJukEWRiTROA5VAHZtti3JlK3ZhMeHoZWorqxjXWPca8eiASqcb4ny4aHQDlXFBrnBqHVUo+bimQ4nvzI9pUx/G9c3yzNuTYtmwwxUppvd+RetylZZIIDu7cYfdA0LO4DOId48orCxnum6uRVYtp25Cjs8tiDD8qMNppFNPpZtPDJHknV3YBPrhvBptbMosBGQM1VbVHbE5yFujn+7dC/XQvqa9+gyGD8LgyguqCByW2T1bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR04MB4003.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47680400002)(508600001)(55016003)(8936002)(7416002)(6916009)(54906003)(316002)(2906002)(86362001)(52536014)(83380400001)(7696005)(122000001)(9686003)(38070700005)(5660300002)(71200400001)(6506007)(38100700002)(186003)(26005)(53546011)(66946007)(66476007)(33656002)(66556008)(76116006)(4326008)(64756008)(66446008)(85182001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG50aWxhMlU0MThnRkxXMDdJaEc1WHdUUmsxK08xUFZWRDNHZWNjWXVqVUlW?=
 =?utf-8?B?YUFNTUN1bThFY2tFN3c5UUdNTFY5cFBQbkJVdW9aZHBNMTdkMnJtdGczNi9W?=
 =?utf-8?B?NmdDU2NDSnZ6aUdHUnNFeXdqWHZjZ2JvSU8xNGl4d1dlK0wxWkgvaXlBS2lD?=
 =?utf-8?B?MmViU0c1SkRtNGQ1NDJBaGVaQzkvclcvL3FLc0JqRG1JLzNoSTUwck1wRi9y?=
 =?utf-8?B?UGZHTUJQT3dSN3BkWnUxak1tK05TcWZTdnY5dFBOR1RSaklNRXp1Y1BIVTAr?=
 =?utf-8?B?SkdXVitlZHY2UndSbDVTYVE3dEVLUHVMZE9nTGM5KytENkhMRGpxUzlucm82?=
 =?utf-8?B?ajF4VktMbW5DNTA0aFU1QjRKdXFmQnVpV2x1OFdwbjZwRy9yNkNMOHBFMksr?=
 =?utf-8?B?T3ZjUjlTTlJzenVUcW9TMmNBdkpWZW1lZzE2Ym9pUE9KdXJaMCtwQUo4OVZz?=
 =?utf-8?B?QktnSENvWllFSk9ndytuYTd0c2EzVVVBbnhubmNhSWt2dlpnbkRYQWkwMFlw?=
 =?utf-8?B?WER5bmVOZ2sxbVpKckYycXhMcWloa3llZ2twR0VWZ3JCSXEyVTVDVGQ4MGFZ?=
 =?utf-8?B?M25GRUhHYnFNZnR4TjdTVmxqNnFTYUxraGVlbkt5eXMxUGpLL1ZoVzlXbG9z?=
 =?utf-8?B?b2F1blRmbGZHY1J4aEdLZysvL1dkY1FPVmxVYU1zUW5CK0VsMmhpMGYrM3Vn?=
 =?utf-8?B?ZkNBMXA1Qnl3dmw5dllwRVlYazV4VHlFaXgvV2EraTladlhRT0RxZUt4OHUx?=
 =?utf-8?B?TEIyRnY2RjNNbzlzb1dFTXBsY2djQUt2QWZReE1kRkMySytlTDVJcklRU1Jm?=
 =?utf-8?B?TEx1dGk5M2o4RE5JcEFQTnlZall0MjY2MlR5SERPWGcyNDZLbXBad2FIcWY4?=
 =?utf-8?B?SDFHOG9hNS9iMFhma0wraE9wMjVvRk1lQnVxRHBJdzNhZWFOTThiOVRiaFRP?=
 =?utf-8?B?bWU5NFJLV2pvQTA1VVVlNkZlWUxqT2J1SW9yZjZCQ2RuYWZHaTRzSDJsdGkx?=
 =?utf-8?B?OVc4dmRtV3I4V2JCNHR3Sk8zbS9pRHFzR0VoTlpYbFRTKy9BT0N2eGlDWjNQ?=
 =?utf-8?B?RExBbzdwOVJ6aDNNQVNicTRrMVZ3ZzNtd3pEay9KWWFDNXppVE5qeGVwbUlN?=
 =?utf-8?B?VDkwTHk3R2NLczJvOVpzWVNxS3d1Uys4UHBvdUppdDZ2MnhkWkF6ajlsYkVr?=
 =?utf-8?B?R2NsemtLaEVMOVRQT01nbDliOVZWbXBQRGx4a1hPZitMcnFXeHJGNkJjWTho?=
 =?utf-8?B?WG5jTmF1TDFDNklWajR0TnBNR1FPZHpVdjVhbmdsSDl0YnhTeHYzRG9wVklV?=
 =?utf-8?B?UVNnSHF5QTQ5R0FZZEI0ck5PZTlCZ2g5WEtyV3RmWmFqeTlZVHhDMlowOGZB?=
 =?utf-8?B?bExDQ1pVdVFCSjBpK3lIeHpveDRFbW9ESXdNeDRHa0VOY3lOaXA4a3hSNXkr?=
 =?utf-8?B?YmQ3TVcrZzVnTEZaZGRZbjFMY2xHRzJpalRGbFlvRU5nNTYwblhWZFR4andY?=
 =?utf-8?B?VU0rMU9YOGt5VDgzMWFGVklnN3JyMVRDLytHMit1eGthSVgrRHpqa04rSThX?=
 =?utf-8?B?N2hFT3N2MnptdHhTSnpEakhGN2hjSXU0c2E0Q3VMZFZIR0xkRzRCNUp1bFl5?=
 =?utf-8?B?R094RVpiY0tzNzJoSmxWeDd3YUxaTmQrNnZaR0lhK29vdXFCekphTkNaWm9t?=
 =?utf-8?B?YmlWVFRnc3NtR25Oc3cveTZ2bE1MK1F0UDBCTEdHdkZ5c21ZSEUvWG94bkFC?=
 =?utf-8?B?NFJ6ZXZqT2IwSmIvSU02VWlFU1VDY3JuR2ZEcVhxVXh0V0MrWVpYdDUycVZC?=
 =?utf-8?B?eStWYnhOY0owQnBJZEhMVVNub0VLdnJGdkRVdlVUdEw1WGNQblk3eGN5VUYz?=
 =?utf-8?B?STdlWVFEZWZKakUxcVRkWmVlQlllZkJ5M1FGT3JySjg2SDVHcFZXY2xQWVJq?=
 =?utf-8?B?RzhlSUlwQzZLb3J4UnFqZUprb1lQN205MUdVUXNBUldhZ1hkYXh1ZkYwVjhW?=
 =?utf-8?B?ZXM3SlZ6a3JJZ0J2NkIyYmpJMERhWkRqSVRlUjNqV3RkYTZ3RDIrcWZLendF?=
 =?utf-8?B?NmNZWkJlbjlDcEh3RVIwRmd1L0w2eXpvT244RzZybjF3bTQyY0RFdkNySThO?=
 =?utf-8?B?OE1yRG1GKysrVlIvU2d5Q3BIV1Q4RFkrblQrMFNuL2g1WW82WlNqRTFtMDRX?=
 =?utf-8?B?OUpWQmJtQThDSHlsclZWZHdXd0NhemxoMTV5STc0Zzc5Qk5kMlBmMkM2UmxV?=
 =?utf-8?B?bXhlWmd4RXh0TjZId2NmY2MyaXdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR04MB4003.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedfc12e-9f9e-4f73-0dd3-08d9b94cbfcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 06:42:33.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cl3dBqZvillspKyAVkN1YEpchJYxDUs6qhLmKEOsn+DuVMmH4wlXjpacQtdVlNCNcXKpdYNaBAfBE+dFl8FWWJ17eH5akB3vq8/gRrWTDS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2769
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lbA0KDQo+IE9uY2Ugd2UndmUgZml4ZWQgdGhlIGlzc3VlcyB3aXRoIHRoZSBiaW5kaW5n
cywgd2UgY2FuIHB1dCB0aGUgZHJpdmVyDQo+IGluIHRoZSBvcGVuYm1jIHRyZWUuIExldCdzIHNw
ZW5kIG91ciBlZmZvcnQgZml4aW5nIHRoYXQuDQpJdCBtZWFucyBJIGNhbiBjb21taXQgQmxldGNo
bGV5IERUUyB3aXRoIGZhbiBzdXBwb3J0IHRvIE9wZW5CTUMgdHJlZSBvbmNlIEJpbGx5J3MgZHJp
dmVyIGdvdCBhcHByb3ZlZCwgcmlnaHQ/DQoNCkhvd2FyZA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+DQo+IFNlbnQ6
IFR1ZXNkYXksIERlY2VtYmVyIDcsIDIwMjEgMjozNyBQTQ0KPiBUbzogSG93YXJkIENoaXUgKOmC
seWGoOedvykgPEhvd2FyZC5DaGl1QHF1YW50YXR3LmNvbT4NCj4gQ2M6IFBhdHJpY2sgV2lsbGlh
bXMgPHBhdHJpY2tAc3R3Y3gueHl6PjsgSG93YXJkIENoaXUNCj4gPGhvd2FyZDEwNzAzMDQ5QGdt
YWlsLmNvbT47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBPbG9mDQo+IEpvaGFuc3Nv
biA8b2xvZkBsaXhvbS5uZXQ+OyBTb0MgVGVhbSA8c29jQGtlcm5lbC5vcmc+OyBSb2IgSGVycmlu
Zw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5h
dT47IExpbnV4IEFSTQ0KPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsg
ZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwg
TWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtYXNw
ZWVkIDxsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2Nl0gQVJNOiBkdHM6IGFzcGVlZDogQWRkaW5nIEZhY2Vib29rIEJsZXRjaGxleSBCTUMNCj4g
DQo+IE9uIFR1ZSwgNyBEZWMgMjAyMSBhdCAwNjozNCwgSG93YXJkIENoaXUgKOmCseWGoOedvykN
Cj4gPEhvd2FyZC5DaGl1QHF1YW50YXR3LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBKb2VsDQo+
ID4NCj4gPiA+IEknZCBzdWdnZXN0IG5vLCBvbWl0IHRob3NlIGZlYXR1cmVzIGZvciBub3csIGFu
ZCB5b3UgY2FuIGFkZCB0aGVtIGluDQo+ID4gPiBvbmNlIHdlIGhhdmUgYSBkcml2ZXIuIFRoZSBk
ZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgdGhlIHRhY2gvcHdtIG5lZWQNCj4gPiA+IHNvbWUgd29y
ayBiZWZvcmUgdGhleSBjYW4gYmUgYXBwcm92ZWQuDQo+ID4NCj4gPiBUaGUgZHJpdmVyIHlvdSBt
ZW50aW9uZWQgaXMgZm9yIE9wZW5CTUMgTGludXggb3IgdXBzdHJlYW0/DQo+ID4gSWYgaXQgaXMg
Zm9yIE9wZW5CTUMsIHRoZSB1cHN0cmVhbSByb2JvdCB3aWxsIHJlamVjdCBteSBEVFMgYmVjYXVz
ZSB0aGUNCj4gYXNwZWVkLWc2LmR0c2kgZGlkIG5vdCBjb250YWluIHB3bS90YWNoIG5vZGUuDQo+
ID4NCj4gPiBJZiBpdCBpcyBmb3IgdXBzdHJlYW0sIGl0IHdpbGwgYmUgYSBsb25nIHRpbWUgdGhh
dCBPcGVuQk1DIExpbnV4IHdvbid0IGhhdmUNCj4gdGFjaCBkcml2ZXIgZm9yIGFzdDI2MDAgc2Vy
aWVzLCBhbmQgbXkgcGF0Y2ggdG8gY29tbWl0IHdpdGggQmlsbHkncyBlYXJseSBkcml2ZXINCj4g
Zm9yIE9wZW5CTUMgTGludXggaXMgYWxzbyBtZWFuaW5nbGVzcy4NCj4gDQo+IE9uY2Ugd2UndmUg
Zml4ZWQgdGhlIGlzc3VlcyB3aXRoIHRoZSBiaW5kaW5ncywgd2UgY2FuIHB1dCB0aGUgZHJpdmVy
DQo+IGluIHRoZSBvcGVuYm1jIHRyZWUuIExldCdzIHNwZW5kIG91ciBlZmZvcnQgZml4aW5nIHRo
YXQuDQo+IA0KPiA+DQo+ID4gPiBXaGVuIEkgYXNrZWQgeW91IHRvIGZpeCB0aGUgcGF0Y2gsIEkg
d2FzIHJlZmVycmluZyB0byB0aGUgdXNiLWMNCj4gPiA+IHdhcm5pbmdzIHRoYXQgSSBwb3N0ZWQg
YWJvdXQgdGhlIG90aGVyIHdlZWsuDQo+ID4gSSB3aWxsIGZpeCBpdCBhbmQgb3RoZXJzIHlvdSBt
ZW50aW9uZWQgaW4gdGhlIHY3IHBhdGNoLg0KPiA+DQo+ID4gSG93YXJkDQo+ID4NCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxA
am1zLmlkLmF1Pg0KPiA+ID4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgNywgMjAyMSAxMTozMCBB
TQ0KPiA+ID4gVG86IEhvd2FyZCBDaGl1ICjpgrHlhqDnnb8pIDxIb3dhcmQuQ2hpdUBxdWFudGF0
dy5jb20+DQo+ID4gPiBDYzogUGF0cmljayBXaWxsaWFtcyA8cGF0cmlja0BzdHdjeC54eXo+OyBI
b3dhcmQgQ2hpdQ0KPiA+ID4gPGhvd2FyZDEwNzAzMDQ5QGdtYWlsLmNvbT47IEFybmQgQmVyZ21h
bm4gPGFybmRAYXJuZGIuZGU+OyBPbG9mDQo+ID4gPiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0
PjsgU29DIFRlYW0gPHNvY0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcNCj4gPiA+IDxyb2JoK2R0
QGtlcm5lbC5vcmc+OyBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGFqLmlkLmF1PjsgTGludXggQVJN
DQo+ID4gPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgZGV2aWNldHJl
ZQ0KPiA+ID4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxp
bmcgTGlzdA0KPiA+ID4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1hc3Bl
ZWQNCj4gPGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnPg0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2Nl0gQVJNOiBkdHM6IGFzcGVlZDogQWRkaW5nIEZhY2Vib29rIEJsZXRjaGxleSBC
TUMNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIDcgRGVjIDIwMjEgYXQgMDI6NTMsIEhvd2FyZCBDaGl1
ICjpgrHlhqDnnb8pDQo+ID4gPiA8SG93YXJkLkNoaXVAcXVhbnRhdHcuY29tPiB3cm90ZToNCj4g
PiA+ID4NCj4gPiA+ID4gSGkgSm9lbA0KPiA+ID4gPg0KPiA+ID4gPiBCbGV0Y2hsZXkgcGxhdGZv
cm0gbmVlZHMgdG8gc3VwcG9ydCBmYW4gY29udHJvbC4NCj4gPiA+ID4gU2luY2UgQmlsbHkncyBw
YXRjaCBmb3IgdXBzdHJlYW0gaXMgc3RpbGwgdW5kZXIgcmV2aWV3LCBJIGNhbid0IGFkZCBwd20v
dGFjaA0KPiA+ID4gbm9kZSBpbnRvIGR0cyBvciB0aGUgYnVpbGQgd291bGQgZmFpbC4NCj4gPiA+
ID4NCj4gPiA+ID4gQXMgeW91IGtub3csIEkgaGFkIGNvbW1pdHRlZCB0aGUgcHdtL3RhY2ggZHJp
dmVyIGZvciBhc3QyNnh4IHRvDQo+IE9wZW5CTUMNCj4gPiA+IGxpbnV4LCBjb3VsZCBJIGNvbW1p
dCB0aGUgZHRzIHRvIE9wZW5CTUMgbGludXggaW5zdGVhZCBvZiB1cHN0cmVhbSBmb3INCj4gZWFy
bHkNCj4gPiA+IGJ1aWxkPw0KPiA+ID4NCj4gPiA+IEknZCBzdWdnZXN0IG5vLCBvbWl0IHRob3Nl
IGZlYXR1cmVzIGZvciBub3csIGFuZCB5b3UgY2FuIGFkZCB0aGVtIGluDQo+ID4gPiBvbmNlIHdl
IGhhdmUgYSBkcml2ZXIuIFRoZSBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgdGhlIHRhY2gvcHdt
IG5lZWQNCj4gPiA+IHNvbWUgd29yayBiZWZvcmUgdGhleSBjYW4gYmUgYXBwcm92ZWQuDQo+ID4g
Pg0KPiA+ID4gV2hlbiBJIGFza2VkIHlvdSB0byBmaXggdGhlIHBhdGNoLCBJIHdhcyByZWZlcnJp
bmcgdG8gdGhlIHVzYi1jDQo+ID4gPiB3YXJuaW5ncyB0aGF0IEkgcG9zdGVkIGFib3V0IHRoZSBv
dGhlciB3ZWVrLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSG93YXJkDQo+ID4gPiA+DQo+ID4g
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBKb2VsIFN0
YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVy
IDcsIDIwMjEgNjo1MiBBTQ0KPiA+ID4gPiA+IFRvOiBQYXRyaWNrIFdpbGxpYW1zIDxwYXRyaWNr
QHN0d2N4Lnh5ej4NCj4gPiA+ID4gPiBDYzogSG93YXJkIENoaXUgPGhvd2FyZDEwNzAzMDQ5QGdt
YWlsLmNvbT47IEFybmQgQmVyZ21hbm4NCj4gPiA+ID4gPiA8YXJuZEBhcm5kYi5kZT47IE9sb2Yg
Sm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD47IFNvQyBUZWFtDQo+ID4gPiA+ID4gPHNvY0BrZXJu
ZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEFuZHJldyBKZWZmZXJ5
DQo+ID4gPiA+ID4gPGFuZHJld0Bhai5pZC5hdT47IExpbnV4IEFSTQ0KPiA8bGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsNCj4gPiA+ID4gPiBkZXZpY2V0cmVlIDxkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPiA+ID4g
PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWFzcGVlZA0KPiA+ID4gPGxp
bnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnPjsNCj4gPiA+ID4gPiBIb3dhcmQgQ2hpdSAo6YKx
5Yag552/KSA8SG93YXJkLkNoaXVAcXVhbnRhdHcuY29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjZdIEFSTTogZHRzOiBhc3BlZWQ6IEFkZGluZyBGYWNlYm9vayBCbGV0Y2hsZXkN
Cj4gQk1DDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBNb24sIDYgRGVjIDIwMjEgYXQgMjE6MjUs
IFBhdHJpY2sgV2lsbGlhbXMgPHBhdHJpY2tAc3R3Y3gueHl6Pg0KPiB3cm90ZToNCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBPbiBXZWQsIERlYyAwMSwgMjAyMSBhdCAxMTozNzozOEFNICswODAw
LCBIb3dhcmQgQ2hpdSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gSW5pdGlhbCBpbnRyb2R1Y3Rpb24g
b2YgRmFjZWJvb2sgQmxldGNobGV5IGVxdWlwcGVkIHdpdGgNCj4gPiA+ID4gPiA+ID4gQXNwZWVk
IDI2MDAgQk1DIFNvQy4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogSG93YXJkIENoaXUgPGhvd2FyZC5jaGl1QHF1YW50YXR3LmNvbT4NCj4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAuLi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
IENoYW5nZSBzaW5jZSB2MjoNCj4gPiA+ID4gPiA+ID4gLSBSZW1vdmUgdWFydDUgd29ya2Fyb3Vu
ZA0KPiA+ID4gPiA+ID4gPiAtIFJlbW92ZSBncGlvIG5vZGVzIG9mIHBjYTk1NTIvcGNhOTUzOQ0K
PiA+ID4gPiA+ID4gPiAtIE1vZGlmeSBncGlvLWxpbmUtbmFtZSBvZiBsZWQvcG93ZXIvcHJlc2Vu
Y2UgcGlucyB3aXRoIG9wZW5ibWMNCj4gPiA+ID4gPiBwYXR0ZXJuDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gQSBudW1iZXIgb2YgdGhlIEdQSU9zIGRvIG5vdCBoYXZlIGRlZmluZWQgb3BlbmJt
YyBwYXR0ZXJucyBmb3INCj4gdGhlbQ0KPiA+ID4geWV0Lg0KPiA+ID4gPiA+IFRoZQ0KPiA+ID4g
PiA+ID4gbmFtZXMgeW91IGhhdmUgY2hvc2VuIGFyZSBvayBmb3Igbm93LCBidXQgd2Ugd2lsbCBi
ZSBjaGFuZ2luZyB0aGVtDQo+IGFzDQo+ID4gPiB3ZQ0KPiA+ID4gPiA+IHJlZmluZQ0KPiA+ID4g
PiA+ID4gZGV2ZWxvcG1lbnQgb2YgdGhpcyBtYWNoaW5lIGZ1cnRoZXIuDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgIGdwaW8tbGluZS1uYW1lcyA9DQo+ID4gPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPg0KPiA+ID4NCj4gIlNMRUQwX01TX0RFVEVDVDEiLCJTTEVEMF9WQlVT
X0JNQ19FTiIsIlNMRUQwX0lOQTIzMF9BTEVSVCIsIlNMRQ0KPiA+ID4gPiA+IEQwX1AxMlZfU1RC
WV9BTEVSVCIsDQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPg0KPiA+ID4NCj4gIlNMRUQwX1NT
RF9BTEVSVCIsIlNMRUQwX01TX0RFVEVDVDAiLCJTTEVEMF9SU1RfQ0NHNSIsIlNMRUQwX0ZVU0IN
Cj4gPiA+ID4gPiAzMDJfSU5UIiwNCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+DQo+ID4gPg0K
PiAiU0xFRDBfTURfU1RCWV9SRVNFVCIsIlNMRUQwX01EX0lPRVhQX0VOX0ZBVUxUIiwiU0xFRDBf
TURfRElSIiwiDQo+ID4gPiA+ID4gU0xFRDBfTURfREVDQVkiLA0KPiA+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4NCj4gPiA+DQo+ICJTTEVEMF9NRF9NT0RFMSIsIlNMRUQwX01EX01PREUyIiwiU0xF
RDBfTURfTU9ERTMiLCJwb3dlci1obw0KPiA+ID4gPiA+IHN0MCI7DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gU3VjaCBhcyB0aGVzZS4uLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gLS0N
Cj4gPiA+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gT3RoZXJ3aXNlLA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBQ
YXRyaWNrIFdpbGxpYW1zIDxwYXRyaWNrQHN0d2N4Lnh5ej4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IFRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSG93YXJkLCBJJ20g
bWVyZ2luZyBwYXRjaGVzIGZvciB2NS4xNyBidXQgSSBjYW4ndCBhcHBseSB0aGlzIHVudGlsIHlv
dQ0KPiA+ID4gPiA+IGZpeCB0aGUgd2FybmluZ3MgSSBtZW50aW9uZWQuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBDaGVlcnMsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBKZW9sDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+IFBhdHJpY2sgV2lsbGlhbXMNCg==
