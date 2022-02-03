Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46BF4A7F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbiBCGpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:45:02 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50395 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbiBCGo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643870701; x=1675406701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=doLpfpkYW1YGuLOwSI4dKr9c41mgmxRpkkdENy5US1c=;
  b=mULkQ79f4ECgCl3BZCEnsjH3uO/u8bova2jcbXH71b2n02TkeweiqR+h
   NqkmEeST/Vub5Gx4+H19Dqng7zrcFN5kjdI9y+wQV4tqS/aNJBqHHjMzk
   DKBWhNJvRCW6/phcYrVCl2Gso+DeMuJtVlwxQFcX/eA9H0rMKTHLrAUgK
   ySnkBQegqLWPANzgvGSw2ety7XUsJikzwsdI91ggjzG/g2DUIsUzkoMOe
   GhQqJX9H9aHcw2Ke2Nk1kjgpgRdQ0tp6jChVKf7eK545EumepSmHF2uXj
   SY/11V6ELgcd5L87tYivVLEYBqXnkzB9vh8bzQK1VUqOVPLGPEwYwn+Pb
   g==;
X-IronPort-AV: E=Sophos;i="5.88,339,1635177600"; 
   d="scan'208";a="193034094"
Received: from mail-sn1anam02lp2048.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.48])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 14:44:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNA8p6h832kclQCM3tUgm96QRDOjWrgN12gDMFLeRtY7pk34gYoKAZZsmSnrs3EKfFEvCoRUTJHGwbJpt7EyVpBDHL3E9yrXFIxiry6rzes/s3YormuTfZYb0qZmBRhgCSHZQbLQyIKsSAy3JkqJZLSvChac8oEm5g2R16smoyIkk3OTtTdwkL36niMBorR96yIxYQmchNaLUqDyupYwaBNioidrjnZPKhW2TJfijDwLpNktyClv9iRA5CsNXcXPyL16q3dApiXDhV8nTw033+VEuWGbY0lMdgjyHJ+OrtAvGT+kO3DsobQbUW6is92Ju8TBS8jgQtt+mNgoCxpI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doLpfpkYW1YGuLOwSI4dKr9c41mgmxRpkkdENy5US1c=;
 b=h01KVTSx2oiQOokzvXJHYlkZtufyzjDCoCwYagDM1p8v46JHJNxqGW3ODlukD2cJNE2ZOPjp7ATWP+VdGg592RYMdGQ954nOq1ad6kK2JXSLRf3ofMImtaBWkLffmAgwA4mBaYG4YKDaJIKRTam+Iy0X5NSpoA/IJsHbW6unGySOJivQpmMJF8SaOkgp12Kq7RkAelLDaNJEWE2lxbVAgwOfL/W2LZpMeqzyFd9JHw/zs4C5y6NE0NP5oA4ajnW29+/MdGIJdvIKt7+vHljKxruZ52i0mXHc4kJwiuvBRcxuinbjY5bpFrTydqaEyRKMgoFz41J9yEyC2UrP0KEiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doLpfpkYW1YGuLOwSI4dKr9c41mgmxRpkkdENy5US1c=;
 b=dk+rnsdjvv7toSia7Iv/tdZoggtI7g5AG7+PNtDsoIstCjgB7Zgmsi193XnKO6w4CUDgH8aeLdugRW3+XgYxjA5RXyqb4wzCKrCyzMXhqFfh5ruQS8ZLWDa891RyAOUWEr9WRI7e2G3Mfni6P+z7X1zYYNdseI0msBKHuAk6+k0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN4PR0401MB3712.namprd04.prod.outlook.com (2603:10b6:803:49::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Thu, 3 Feb
 2022 06:44:50 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7%4]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 06:44:50 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Hoyoung SEO <hy50.seo@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "bhoon95.kim@samsung.com" <bhoon95.kim@samsung.com>,
        "kwmad.kim@samsung.com" <kwmad.kim@samsung.com>
CC:     'kernel test robot' <lkp@intel.com>
Subject: RE: [PATCH v2] scsi: ufs: disable auto hibern8 while entering suspend
Thread-Topic: [PATCH v2] scsi: ufs: disable auto hibern8 while entering
 suspend
Thread-Index: AQIlzz+JKCbQP4e9lbbSHSqpu8nHvgHyie3oAmFa8EWrtq73AIAMOI6wgABtFVA=
Date:   Thu, 3 Feb 2022 06:44:50 +0000
Message-ID: <DM6PR04MB6575A9D9D81F0195E81282F9FC289@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b@epcas2p1.samsung.com>
        <20220124180637.160524-1-hy50.seo@samsung.com>
        <40986ecb6c81812a1e1ab24d93e46eda75974c4e.camel@mediatek.com>
  <12a201d81892$c8123d40$5836b7c0$@samsung.com>
In-Reply-To: <12a201d81892$c8123d40$5836b7c0$@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd667a4-29cb-4a5e-0ce7-08d9e6e0ad94
x-ms-traffictypediagnostic: SN4PR0401MB3712:EE_
x-microsoft-antispam-prvs: <SN4PR0401MB371215B5094572BE0BF40B50FC289@SN4PR0401MB3712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TW44NyciArfF6F1veA4Vb/hmTfMILcWuvKldCizItNnHoXAhkcmQFH0H8IZg8lcxRiHLLxXx/5ltkrULgIfUbVdWDLd73GrE+GAy2FLP2nNWufZ8GWFQvr/bseJ20FYay4qbcgJA99T7ESxeceg10Xpnf8zVurxQS+XPqcw7KPvuhxCUTfO4NZp+WgSYyMykYPQesJgfubbb5izDc/YImIwTUYrlqxMyk03n5d80MDuPBxoJelMs0NfXJE7HoKgwWTf2MCDp7pGp9YPZa7/zSkotr5Ti5d0nS38G6atKwkRCrdxUdCJZGYlZPTvQ1eGUERVMM3Nuetkl0GuAbMTemWknfMf2tafprS3PshbYnAEG6x5iYdeKXEtpO70JI1EJNO3OzCEEwsbWHQ9wbUdSP/nHD0Vh75s5MzOH9DOPVg5qO1yUlusbZL61Z1k9h5sqbiWhzUSBATpw6yOgO5ifhxheCghydpRbaTF+XFqKngKCeeNl5q29hGga5CVSbkPowQmIYxM1rbDjXgTCbaYm6cB59yAuCAy1r6xQNJ6Z/0GUATgV8/YWA7uN93vGeH6UltX7LclHISZwSQ5FZQy7Sdn5LOMOvY6H7Q5k2JcnHAPm5TdvgTtrZZoMSxwSzYoPMfGAmSZmB6f9/DfwK12kAioMDyPgnncbs0BfjF9c9U+Wwqnt2aS6PZYL/pPONzfXoqdv/xFLZoTAUh0UF1ziAKTyylkkS0+0d99cdyBPwrc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(53546011)(6506007)(82960400001)(7696005)(2906002)(508600001)(15650500001)(71200400001)(66446008)(26005)(122000001)(8676002)(55016003)(64756008)(8936002)(66476007)(66556008)(66946007)(33656002)(921005)(76116006)(38070700005)(316002)(4326008)(186003)(38100700002)(7416002)(52536014)(86362001)(83380400001)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUFaZC82dGVueTFKNUlYR0VIM3pIRUZNQTk2SVJUZXlmKzVRaVI5Nk56dlp0?=
 =?utf-8?B?V2F3RTd6a3MwdVBtYmhRd0IvQnM0WEc0RHlYbUFvbW8ySVVwa1htNkM1TnM0?=
 =?utf-8?B?Ykd1c1BraU0xRU1ESytXbGxlN2hvbU9NWFNYQmJaYnFPeW9MaE1CNHVhZlMv?=
 =?utf-8?B?SkV4YUtjNUY5OThNQjgxUU1GZHZjeWpZVVNrTlFPV0pTQWpaM2hkUDB6UHU1?=
 =?utf-8?B?aThyT0pJeVRkNlh2a0hvaWVqMHVyQURFYWI1enpreWg4WmZ2L2JoRDkvVkZN?=
 =?utf-8?B?c05EejVQUzlCU2hJRjRoV2hzcEtDMjRCc0UzclF0OVRrUGs1bDFyVlFSQmlp?=
 =?utf-8?B?b21FMEcycytqZTRxWkpOZ3lVZTRqZFoyVjhWdGxqSTcvN01hWlY3dlhqVnZt?=
 =?utf-8?B?YTNuR09RTmpCU096QU9sNE5YclJOa01xaFo4Q1EyWGR0ZGloZlZZS3hkbnBj?=
 =?utf-8?B?WFRLM2hXclU2WmJId3pDVlJ4UjNPandYOCs4RHpFVzRSSmVSMEx3M1l5OVdz?=
 =?utf-8?B?TVZDOElpL21YanhHMGFXdk9YVUhKK0tTSmZaNStlMG9YV1NhNEpOeU5jTFdq?=
 =?utf-8?B?UjBqV0ozc2o3UEw5aG9LQXluRHEwcnFJNFVUcjdxb1FqSnZCaWNPVTZqU0ll?=
 =?utf-8?B?Ym4wZkpvenlhOFpJcjVrak56ZHdBVGQ2TXhtNVlPbnpuaTkvZi9wblk3UjQ1?=
 =?utf-8?B?U0ZHVzNzYVM1S21zVnAzbzliTnVhdXh1cEhJUVEwbEhpRnRhc0dNQVN3cFQ2?=
 =?utf-8?B?eHNSZ0liUjdEdVZldFNxYitjc0x6UHA2TnI0aUw3YmdrREdDU1RPVDlDNUJF?=
 =?utf-8?B?TEw5VE92WmZJT1Y0MHJBNHljSFFtNGx4ZE5oMjNxVWJ4ZEJqNldnRFN6YnA0?=
 =?utf-8?B?bkN0UW5hWVpjdlpva0RDM3BRL2plQUwzRjcxZzNYL2oxSmx1aTY5MkZDcnBU?=
 =?utf-8?B?SVNxTC9wdVlTazY4dU42amRQSENad3NGNkc2TUVSS3h2LzBaQXhpSFFLZnpl?=
 =?utf-8?B?MnZyeElVcDZUMUlTMHlPZXNsY21HTzlINlRUTldJU3BObVFidjF1OEx6dDEz?=
 =?utf-8?B?ck1VWlFXL3lBNW9nMm1EZWovQ0VuNDA4TUZmblhFM01DOGw4WFQwZGZiaTVw?=
 =?utf-8?B?TnVPbmNoZ1ZBd2d0eU9NZFBWWkw3eEUvQ2prVjJBbTRySFN6OXd0VWd0NEdk?=
 =?utf-8?B?QVlkOE1wVzh4dkJrU1ZPa25VQm40V3p1OFVxaURVOXJLUTZTcWdUVUVHLzVF?=
 =?utf-8?B?a3Q2aVlpVk1VR2F2U3hqSlJJaXdNT045bFhoNllibTNPMXlHQTN0TmwzdDJi?=
 =?utf-8?B?T1Mxb0oreTBqZitrNnN1cVY2dUNRaEJDeGNzbzZLSm1pNUh4UUp1R2FTTCt0?=
 =?utf-8?B?OHFvZUpZZGgzMFRYMkJhNWpvbzN0OWw0dlRFSDllSmxPV2dXMlowcHNtZEVY?=
 =?utf-8?B?aGp2dnZYdzNJc1o5bEFhTHE4bXoyNmxEeWtoMVp0SXhJYmt0WFk3dEo3Nk10?=
 =?utf-8?B?SGora2lnV0NjUDVBZFRYRjJLKzJHaWdhejdjYkRYSXNVcTgvNjdHZWlPcXpK?=
 =?utf-8?B?Tzl1SHBYVmRRT0xtNW12R2o3V2R5MStlRUt6VlV4dHlVUTlCZ0xTZ2VOS1hp?=
 =?utf-8?B?VWg1bU9jcThSd21jb09QeERlWEx1OElOcnhVeHBRUTMwSTVOODJCdmdOdk44?=
 =?utf-8?B?elgraHVmaC9OWjhEOVFkSkxMRVlINVBlbkhDUnhVVjRmU1k0QWROUmYxNzA2?=
 =?utf-8?B?OWYzZnlORWE0T2JYNGF2elBRNERzK3ZhaGpZbzZEUExWYitSdk9mVzN6SmlB?=
 =?utf-8?B?QjNUVW56blppN1BlSndQMWVJZ0lpUk9WWDU2NDVIWmpIbGEySWpTemFBeDAr?=
 =?utf-8?B?RW0zMTNiNWRNZHhtcURuTWUyS2hMcHRsZ1IwV3FvbXJoaVpaWHAzMko1aWV2?=
 =?utf-8?B?Q0VlMVlEVmJVM1pzVUpIc2FJVTBoL3hWYmpGTnpyZDJtaEJMc0RqMTR2MjMz?=
 =?utf-8?B?L2FzM0FyYW1rZUYrbHk5ejF0K2tYYytSck0yU080MC9ub05wVm1mUGpoL2ov?=
 =?utf-8?B?Qnl4VGltc2ZEdGVHMVpKL0RsOWNXd0c4dnhZU01iNVpkQmpoRWY1Y09vTWdB?=
 =?utf-8?B?bjNCOS85NjZpK0w0VVFKSnlHbkIwWUZNUEh0RUZQYllhUmFXNnJoSEFSalk2?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd667a4-29cb-4a5e-0ce7-08d9e6e0ad94
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 06:44:50.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nMSMjsuLee4A5H9m3fRZgFPBmhNOFG+Tkyu6xRLPprCWk+NH3t8vkDvGs18wVB2NozwzFBg4jhj06eVwe0Qxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3712
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSwNCj4gUGxlYXNlIGNoZWNrIHRoaXMgcGF0Y2guDQo+IElmIHRoZXJlIGlzIGFueSBvdGhl
ciBvcGluaW9uLCBwbGVhc2UgZ2l2ZSBtZSBjb21tZW50cyBUaGFua3MNCj4gDQo+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiDshJztmLjsmIEgW21haWx0bzpoeTUwLnNl
b0BzYW1zdW5nLmNvbV0NCj4gPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjYsIDIwMjIgMjoz
NSBQTQ0KPiA+IFRvOiAnbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmcnOyAnbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZyc7DQo+ID4gJ2FsaW0uYWtodGFyQHNhbXN1bmcuY29tJzsgJ2F2cmku
YWx0bWFuQHdkYy5jb20nOw0KPiA+ICdqZWpiQGxpbnV4LmlibS5jb20nOyAnbWFydGluLnBldGVy
c2VuQG9yYWNsZS5jb20nOw0KPiA+ICdiZWFuaHVvQG1pY3Jvbi5jb20nOyAnYXN1dG9zaGRAY29k
ZWF1cm9yYS5vcmcnOw0KPiA+ICdjYW5nQGNvZGVhdXJvcmEub3JnJzsgJ2J2YW5hc3NjaGVAYWNt
Lm9yZyc7DQo+ICdiaG9vbjk1LmtpbUBzYW1zdW5nLmNvbSc7ICdrd21hZC5raW1Ac2Ftc3VuZy5j
b20nDQo+ID4gQ2M6ICdrZXJuZWwgdGVzdCByb2JvdCcNCj4gPiBTdWJqZWN0OiBSRTogW1BBVENI
IHYyXSBzY3NpOiB1ZnM6IGRpc2FibGUgYXV0byBoaWJlcm44IHdoaWxlIGVudGVyaW5nDQo+ID4g
c3VzcGVuZA0KPiA+DQo+ID4gSGksDQo+ID4gSSB0aGluayBjb250ZW50IGlzIGxhY2tpbmcgaW4g
dGhlIFVGU0hDSSBzcGVjLg0KPiA+IEluIHRoZSBwcm9jZXNzLCBBSDggaXMgaW4gb3BlcmF0aW9u
LCBhbmQgaXQgc2VlbXMgdGhhdCBzZW5kaW5nIHRoZQ0KPiA+IGNvbW1hbmQNCj4gPiBoaWJlcm44
IGJ5IG1hbnVhbCBoYXMgYSBkZWZlYXQuDQo+ID4gSSBkb24ndCBrbm93IHdoYXQgdGhlIGFsbCBo
Y2kgdmVuZG9yJ3MgaGFyZHdhcmUgZGVzaWduIHdpbGwgYmUsIGJ1dA0KPiA+IHRoZXJlIGlzIGEg
cG9zc2liaWxpdHkgdGhhdCBhaDggYW5kIG1hbnVhbCBoaWJlcm44IG1heSBvdmVybGFwLg0KPiA+
IFNvIGlmIGlzIG9wZXJhdGluZyBpbiBhaDgsIGl0IGlzIHRob3VnaHQgdGhhdCBpdCB3aWxsIGJl
IHNhZmVyIHRvDQo+ID4gZGlzYWJsZQ0KPiA+IGFoOCBiZWZvcmUgc2VuZGluZyBoaWJlcm44IGNv
bW1hbmQuDQpIaSwNClRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4NCk1heWJlIGJldHRlciB0byBw
cm9tb3RlIHlvdXIgaWRlYSBpbiBKRURFQyBmaXJzdC4NCg0KVGhhbmtzLA0KQXZyaQ0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogU3RhbmxleSBDaHUg
W21haWx0bzpzdGFubGV5LmNodUBtZWRpYXRlay5jb21dDQo+ID4gPiBTZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMjYsIDIwMjIgMTA6MjIgQU0NCj4gPiA+IFRvOiBTRU8gSE9ZT1VORzsgbGludXgt
c2NzaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBhbGltLmFraHRhckBzYW1zdW5nLmNvbTsNCj4gPiA+IGF2cmkuYWx0bWFuQHdkYy5jb207IGpl
amJAbGludXguaWJtLmNvbTsNCj4gbWFydGluLnBldGVyc2VuQG9yYWNsZS5jb207DQo+ID4gPiBi
ZWFuaHVvQG1pY3Jvbi5jb207IGFzdXRvc2hkQGNvZGVhdXJvcmEub3JnOw0KPiBjYW5nQGNvZGVh
dXJvcmEub3JnOw0KPiA+ID4gYnZhbmFzc2NoZUBhY20ub3JnOyBiaG9vbjk1LmtpbUBzYW1zdW5n
LmNvbTsNCj4ga3dtYWQua2ltQHNhbXN1bmcuY29tDQo+ID4gPiBDYzoga2VybmVsIHRlc3Qgcm9i
b3Q7IHBldGVyLndhbmdAbWVkaWF0ZWsuY29tDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
XSBzY3NpOiB1ZnM6IGRpc2FibGUgYXV0byBoaWJlcm44IHdoaWxlDQo+ID4gPiBlbnRlcmluZyBz
dXNwZW5kDQo+ID4gPg0KPiA+ID4gSGkgSG95b3VuZywNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIDIw
MjItMDEtMjUgYXQgMDM6MDYgKzA5MDAsIFNFTyBIT1lPVU5HIHdyb3RlOg0KPiA+ID4gPiB2MS0+
IHYyOiBmaXhlZCBubyBwcmV2aW91cyBwcm90b3R5cGUgd2FybmluZw0KPiA+ID4gPiBSZXBvcnRl
ZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+
IEFsbCB3YXJuaW5ncyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiA+ID4gPiA+ID4gZHJp
dmVycy9zY3NpL3Vmcy91ZnNoY2QuYzo0MjA3OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzDQo+ID4g
PiA+ID4gPiBwcm90b3R5cGUNCj4gPiA+ID4NCj4gPiA+ID4gZm9yICd1ZnNoY2RfYXV0b19oaWJl
cm44X2Rpc2FibGUnIFstV21pc3NpbmctcHJvdG90eXBlc10NCj4gPiA+ID4gNDIwNyB8IHZvaWQg
dWZzaGNkX2F1dG9faGliZXJuOF9kaXNhYmxlKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ID4gPiA+
DQo+ID4gPiA+IElmIHVzaW5nIGF1dG8gaGliZXJuOCBtb2RlLCBuZWVkIHRvIGRpc2FibGUgYXV0
byBoaWJlcm44IHdoaWxlDQo+ID4gPiA+IGVudGVyaW5nIHN1c3BlbmQuDQo+ID4gPiA+IFdoZW4g
dXNpbmcgYXV0byBoaWJlcm44IG1vZGUsIGl0IGRvZXMgbm90IHNlZW0gcmlnaHQgdG8gc2VuZCBh
IHVpYw0KPiA+ID4gPiBjb21tYW5kDQo+ID4gPg0KPiA+ID4gVGhlIFVGU0hDSSBzcGVjIGRvZXMg
bm90IG1lbnRpb24gdGhlIGFib3ZlIHJ1bGUuDQo+ID4gPiBXaHkgd291bGQgeW91IG5lZWQgdG8g
ZGlzYWJsZSBBSDggYmVmb3JlIHVzaW5nIFVJQyBjb21tYW5kIHRvIGVudGVyDQo+IEg4Pw0KPiA+
ID4NCj4gPiA+ID4gZm9yIGVudHJ5IGludG8gaGliZXJuOCBpbiB0aGUgbmV4dA0KPiA+ID4gPiBs
aW5lKHVmc2hjZF9saWtfc3RhdGVfdHJhbnNpdGlvbiguLikpDQo+ID4gPiA+IEl0IHNlZW0gcmln
aHQgdG8gc2VuZCBhZnRlciBkaXNhYmxlIGF1dG8gaGliZXJuOC4NCj4gPiA+ID4NCj4gPiA+ID4g
SW4gYWRkaXRpb24sIGlmIHRoZSBhdXRvIGhpYmVybjggbW9kZSBzdXBwb3J0ZWQsIGl0IGlzIGVu
YWJsZWQgaW4NCj4gPiA+ID4gcmVzdW1lLg0KPiA+ID4gPiBTbyBpdCBzZWVtcyB0aGF0IGl0IHdp
bGwgYmUgcGFpcmVkIG9ubHkgd2hlbiBhdXRvIGhpYmVybjggaXMNCj4gPiA+ID4gZGlzYWJsZWQg
d2hpbGUgZW50ZXJpbmcgc3VzcGVuZC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
U0VPIEhPWU9VTkcgPGh5NTAuc2VvQHNhbXN1bmcuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4g
IGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgfCAxNCArKysrKysrKysrKysrKw0KPiA+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hj
ZC5jDQo+ID4gPiA+IGluZGV4IDQ2MGQyYjQ0MGQyZS4uYTZlZGJiZDhjYTJjIDEwMDY0NA0KPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvc2NzaS91ZnMvdWZzaGNkLmMNCj4gPiA+ID4gQEAgLTI1NCw2ICsyNTQsNyBAQCBzdGF0aWMg
dm9pZA0KPiA+ID4gPiB1ZnNoY2Rfd2JfdG9nZ2xlX2ZsdXNoX2R1cmluZ19oOChzdHJ1Y3QgdWZz
X2hiYSAqaGJhLCBib29sIHNldCk7DQo+ID4gPiA+IHN0YXRpYyBpbmxpbmUgdm9pZCB1ZnNoY2Rf
d2JfdG9nZ2xlX2ZsdXNoKHN0cnVjdCB1ZnNfaGJhICpoYmEsDQo+ID4gPiA+IGJvb2wgZW5hYmxl
KTsgIHN0YXRpYyB2b2lkIHVmc2hjZF9oYmFfdnJlZ19zZXRfbHBtKHN0cnVjdCB1ZnNfaGJhDQo+
ID4gPiA+ICpoYmEpOyBzdGF0aWMgdm9pZCB1ZnNoY2RfaGJhX3ZyZWdfc2V0X2hwbShzdHJ1Y3Qg
dWZzX2hiYSAqaGJhKTsNCj4gPiA+ID4gK3N0YXRpYyB2b2lkIHVmc2hjZF9hdXRvX2hpYmVybjhf
ZGlzYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKTsNCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyBp
bmxpbmUgdm9pZCB1ZnNoY2RfZW5hYmxlX2lycShzdHJ1Y3QgdWZzX2hiYSAqaGJhKSAgeyBAQA0K
PiA+ID4gPiAtNDIwNCw2ICs0MjA1LDE4IEBAIHZvaWQgdWZzaGNkX2F1dG9faGliZXJuOF91cGRh
dGUoc3RydWN0DQo+IHVmc19oYmENCj4gPiA+ID4gKmhiYSwgdTMyIGFoaXQpICB9DQo+IEVYUE9S
VF9TWU1CT0xfR1BMKHVmc2hjZF9hdXRvX2hpYmVybjhfdXBkYXRlKTsNCj4gPiA+ID4NCj4gPiA+
ID4gK3N0YXRpYyB2b2lkIHVmc2hjZF9hdXRvX2hpYmVybjhfZGlzYWJsZShzdHJ1Y3QgdWZzX2hi
YSAqaGJhKSB7DQo+ID4gPiA+ICt1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ID4gPiArDQo+ID4g
PiA+ICsgaWYgKCF1ZnNoY2RfaXNfYXV0b19oaWJlcm44X3N1cHBvcnRlZChoYmEpKQ0KPiA+ID4g
PiArICAgICAgICAgcmV0dXJuOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgc3Bpbl9sb2NrX2lycXNh
dmUoaGJhLT5ob3N0LT5ob3N0X2xvY2ssIGZsYWdzKTsNCj4gPiA+ID4gKyB1ZnNoY2Rfd3JpdGVs
KGhiYSwgMCwgUkVHX0FVVE9fSElCRVJOQVRFX0lETEVfVElNRVIpOw0KPiA+ID4gPiArIHNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoaGJhLT5ob3N0LT5ob3N0X2xvY2ssIGZsYWdzKTsgfQ0KPiA+ID4g
PiArDQo+ID4gPiA+ICB2b2lkIHVmc2hjZF9hdXRvX2hpYmVybjhfZW5hYmxlKHN0cnVjdCB1ZnNf
aGJhICpoYmEpICB7DQo+ID4gPiA+ICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiA+ID4gQEAg
LTg5MjUsNiArODkzOCw3IEBAIHN0YXRpYyBpbnQgX191ZnNoY2Rfd2xfc3VzcGVuZChzdHJ1Y3QN
Cj4gPiA+ID4gdWZzX2hiYSAqaGJhLCBlbnVtIHVmc19wbV9vcCBwbV9vcCkNCj4gPiA+ID4gICAg
KiB3aXRoIHRoZSBsaW5rIG9mZiwgc28gZG8gbm90IGNoZWNrIGZvciBia29wcy4NCj4gPiA+ID4g
ICAgKi8NCj4gPiA+ID4gICBjaGVja19mb3JfYmtvcHMgPSAhdWZzaGNkX2lzX3Vmc19kZXZfZGVl
cHNsZWVwKGhiYSk7DQo+ID4gPiA+ICsgdWZzaGNkX2F1dG9faGliZXJuOF9kaXNhYmxlKGhiYSk7
DQo+ID4gPiA+ICAgcmV0ID0gdWZzaGNkX2xpbmtfc3RhdGVfdHJhbnNpdGlvbihoYmEsIHJlcV9s
aW5rX3N0YXRlLA0KPiA+ID4gPiBjaGVja19mb3JfYmtvcHMpOw0KPiA+ID4gPiAgIGlmIChyZXQp
DQo+ID4gPiA+ICAgICAgICAgICBnb3RvIHNldF9kZXZfYWN0aXZlOw0KPiANCj4gDQoNCg==
