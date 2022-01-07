Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08404875F6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiAGK5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:57:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49178 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiAGK5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641553023; x=1673089023;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=bF82XrN/1uqz7KqhLvU+H8QoMEe9hig5VrqmtyyMDQs=;
  b=NkAyHg4cRnxwl1vFWRRyayQc566/QIaPHYJPVWH2dDIKr2aXSuGUcYHL
   6ln7i+rv8gXxRPjBHUPZi9jnlFmBBWIIFi86piAT+EqgsAEJRbyn/GdDN
   tX63vPpXIKHM8LTNjw0AcSp47BG+1m/ltLsXhB8x4wAZuR+Ha3pCahiWF
   Vp2oSQDf95j30aJTGi3c/ghNoIqF7l/vzwNT1WC7JxSSMngO+YuamsRiS
   tc2wHB68G6cIbf3NmY1CFSSxKvner8ptBS8rf2zOd4hwWZthKcaWKoBcv
   L/kAEn3KmhN4sM9TJWOlYoujv2X0i2EvwC83msB5ppP3vG3GXXQtWiQvX
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,269,1635177600"; 
   d="scan'208";a="190943836"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 18:57:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8klDqdHUl6mYdtAdZO/1QO4LzlEEz2xCTbWZThvDfe9oZFOfsFb8sKDFC/WBEOaYBeeQmIa9pXvbwhTkPSpl6cFhOF9ILhojzO6LNT6IItbbODUs8Lezzj6fQ/aUYFVvPqPTzJPGmBZxiy15xFGrf9f5ES55Wr+TyWP6qzkGjDnilZXAfVGph902cVN3pCPSx+UlpJkaMZYCvyC8Z6X2Vr6r0LlP+Fw33/w0CkUAZ5DKOEzMRDIyRekMrkaBgbBx2Q16Ft9duQzxJtk/5RDgwTtsqIU887XeydTek0Pv8CMfffxgcttSOo0QCf8bfgh2GesrzKKgC4ijAoIeqLaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF82XrN/1uqz7KqhLvU+H8QoMEe9hig5VrqmtyyMDQs=;
 b=cOTDXqGMrCviErNpW6s6n4Flo67XJkm22WWVFgQqi11axbJI/33RURR4/oILFaDHhd9ZlVL0qw/SoZfAHl28DvoARxhdA/xkhbiZGOHeKAxrRhLjT+AHTViJ7FBg0azUe+/lBs4jWQ8fqk7jVU69zIr2sudWy3wSly9hz6awPzZTffM3KqPP9Zr0Ro3ptZFWiBKGhKRYRAUJbkq0lZciD79Nda9ZBuUOyKRSb1aZZ2WvlwJelkP6e4/wy9oam87ltMZxAxK6+EqZd2+DIWTjO4PlSiH4/g/n49q1RhZz6UZeqe/Ak/eF+Rgiv7n1gL0BLQ1syaC0vsZ3rUtg64J+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF82XrN/1uqz7KqhLvU+H8QoMEe9hig5VrqmtyyMDQs=;
 b=kHb8FZchWvcdH8pHkIzW3qk45686y4BDh/Qcmrmy+LVggYZdNs6jtk7xGI0aSZagBWlFtxsTBclUSv2dIgOtWMc3o/y9v8d2A7zQnr8VZsE/3zegr0nyliaiRvLjO5GTlTmFsueNFHeBJ5HR602xWrqHKzIGiLV8Q9rFH6NzFs4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6139.namprd04.prod.outlook.com (2603:10b6:5:129::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Fri, 7 Jan 2022 10:56:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed20:7b26:3474:b3e0]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed20:7b26:3474:b3e0%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 10:57:01 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     SEO HOYOUNG <hy50.seo@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: RE: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
Thread-Topic: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
Thread-Index: AQHYA6ykHezHkSj3q0euQmOgUzLo+6xXYlpQ
Date:   Fri, 7 Jan 2022 10:57:00 +0000
Message-ID: <DM6PR04MB657535F7CC817A0E2893F668FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912@epcas2p2.samsung.com>
 <20220106213924.186263-1-hy50.seo@samsung.com>
In-Reply-To: <20220106213924.186263-1-hy50.seo@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7aefe0a1-8b00-4202-2fdd-08d9d1cc6eb8
x-ms-traffictypediagnostic: DM6PR04MB6139:EE_
x-microsoft-antispam-prvs: <DM6PR04MB613929A362CAAA21A30DCA62FC4D9@DM6PR04MB6139.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nKS4rAZHwmzcqj7jiaJI/qAnPiHQVthBLzyMP8vQ9pQaKVVd4IJ5/kIY/pky6dcLen/mBDgCyeUgI4KbG6+kiEb4oabSMgL+czB7ENeLla1T85XKRJUdv6WtiOz/Uo+qzwnPtDckndLLxvfF73ALJLU8LZxqM7DbK1J+CJhVeyWVQfy4aHgeuCqrN0IpIw/Nw/Y14L99YhCXrFhpOKHgmj11aN+EtUsXMlqIg+3o15u5NV3UY0GlSSbjeLgkfMkDgJ+/SqpytL/+/2vqpgO0xqd3jRLwH5KKc57L07h9gumowqnJP4m7KPgVWD/BVaYCKgm2RDncj0De83o4dwwm+3HfUZKOzAGOLFGN22xjaq135JTKZhcu3WQwEuNZqsQ9NHhmP5h9dyNxmLziFxIYx7UNNAt/QtbT/0vzH71Q+DRJRDo75Tf60pFoIasgKo4QSr/0d3J77COIQTrNsBV5URoEuAOuxmVqvNVlfhO9HyuslL7N6PDvk1C1ZUSOLzEET3H6EzMtlqhYr+Lk5G/X7ocz+B3k/xEqyYvgvmYKzjWNNW2d/dxk7Wv8ceQ64uMtbKKlN9fQqfLSA6uph8Z2dRRA035l+mFuZlqTcAanETBjQZ/vbIOkck3N8WieOB3nHTyrG4ZO2qc2Ag3yoQ3dJD9tgKyn1dXCXdi6CVCoEoUoHeiWxvn7MDkH5dsNgSlVudzpZ+rtwoUiitiLeMPJKQEZL4urYH0401ZyNFprb1Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(83380400001)(8676002)(9686003)(7696005)(5660300002)(71200400001)(6506007)(7416002)(82960400001)(26005)(186003)(316002)(508600001)(38070700005)(8936002)(2906002)(55016003)(122000001)(110136005)(33656002)(38100700002)(86362001)(66556008)(66476007)(66446008)(921005)(76116006)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OS9WbDcyR25lSzArdEY2Rm5rM1gwamFqSEdXV3h5a1pBNVJFY2xQSnpaMmEy?=
 =?utf-8?B?ejUzL3RNMzJSNWExV2RPLzNGT2p1cURTeTlBM2hHNldQOXI5RDlxOTd2SS93?=
 =?utf-8?B?OWNLUmdhajBSYVVQZUh5bHFZL0ZrKy9mV2Q1R3FSVm1tbDNQSmF1cE1QSUhv?=
 =?utf-8?B?SEdEcWxpUUpnazNiNmZNVERKSHhzMmhudGtzSk9jeENRdVVpRWluRjl2ZWh4?=
 =?utf-8?B?REhjWng0SS9UajNaSHIwOG9kQmcwMzNSMEhxV0xhZWRxRzhySUZsRllUV3J6?=
 =?utf-8?B?TnlBeUZPZDVCak1SUndoNDU1ZWF0bE5hUmhobU9qWEh5QUcxWHprNVc3bDdu?=
 =?utf-8?B?Z25EQVVaRHJqaWVGd3V2UENzbGZjeDdPazVMTVZVVHVMQmh3L29MRTg4ODFp?=
 =?utf-8?B?dk0zb1gvREJGQW9IVWtmcmZvYWdiV0o3Q016Vng5RmpyMTY1TFJndW0vbndB?=
 =?utf-8?B?UDRUSVRPNU5rNUdBaTVFdDM5TjM4VktsWStwSzJCYVJNeXpVOThNeVdCQjZG?=
 =?utf-8?B?YThrcHhZcHBzd3lUcFIxc2FkOHRuRHJuOTNOZGNIaHpTQXIydHZNcjFJYzlN?=
 =?utf-8?B?dlducUpINDBHaWNBWTEwQ09oR3gzL2x2SmR2MjVOV3dHQXBWK2UvR1hKZlhy?=
 =?utf-8?B?NUlkS29LRHBnQmpPaHFKbWhzdjRlZ1dTdWJJSFVFdldDVWV6MjFSclFvRVpn?=
 =?utf-8?B?c0VZTjA0ejVMN2t6SUNhNkF4MXZwUGMvQ0lLdXhTZXVJbUs5VzBseGRRM1pk?=
 =?utf-8?B?cjB6K0xBeVRhUjRKL1RsMzNpbTZhbThJcFJpbkp6K011M2ZISDBEMERvdFRU?=
 =?utf-8?B?TERiVU1tb2tydFU1cENadE16bVdlU01icHJUUlZFem5SeTVnSXdKdXVQekVI?=
 =?utf-8?B?UHVaVXJjaDkveTIyNjh5M2ovUExoUnc4ajBkYTJRTlA0b3V0V2RQY25xMlNT?=
 =?utf-8?B?VnJmUnNCMmlxWGExQ0FybjQvZThzNTNBWjZxeEc1TkwvOTBMZEFBd2t5T2Yy?=
 =?utf-8?B?dUFDbXgzenhaN0N6R2xaTUwrTk5RM2FuNTdKcjk0L25QNWw5MEMxangzSk9a?=
 =?utf-8?B?Q3c2N0w4R1pPOEthL2dIMVlmUU0yNVZHaHJaK3BLSzhSczBVaTlDMmp2YmVB?=
 =?utf-8?B?eC9aUCthK3NabVYzb2VWUjNwaUlTL1ZOdzI4VU9xc3JWVFlVekw5a1JKaVc5?=
 =?utf-8?B?MTJsVE1NUEVHOEtJcTJVdXBmWHQydDljSHVvNFFvSWZTTm1ZVWphcU9nR2V3?=
 =?utf-8?B?eVFyaC9QYWpud1IySkJ1V2loMGwrWTRyUSsrYjg0b1pKZXZnRFdVakVlK0tF?=
 =?utf-8?B?MFVMUVlWd2dYaUV1czRMdmpabG9pRnZVbFQ1ck51aXk3eXh3QmdRSDBZakJT?=
 =?utf-8?B?UVNjZWt0WGl2VzRHcC9CYWxhTUdtNDVybEFzZ1hjeStzY3VacHJ0dXRQdlRL?=
 =?utf-8?B?aFZOcllqRVhBV2FuZ1dXV2VXVXpwM3hhb0VVNUZUNCtSNzVwbHcrNEU2ZFFR?=
 =?utf-8?B?TjVvZnFWMUJ1MnRHZ09nSmMzUlpIVFh5dEVneWlNak1sNm9PTE1EYkRYbm5r?=
 =?utf-8?B?SGpTS09qRi9MeG1kUmVGaFpZaVZFMWZHT0Z0STM4b0daVFJHQUhZOWJmK1lV?=
 =?utf-8?B?ak9qOTVKdUlZa1BYa0thTThXV0hVRC90RHVxYVdPcUxFWDhHZ2NTQTZFckE1?=
 =?utf-8?B?OG11c1hJM0NXdy9kNXVmV3dZd3EzY2hvWDgzdTBuUGhzZlFmV0NNTng4dkNC?=
 =?utf-8?B?bStFcUl3aE83dGN3amVIdVh3V3dsd2FMM3JyNmN6SThUV2NSVVp2YVVNb3Z2?=
 =?utf-8?B?cDM2S2FhZ0RMcGcyRTdHRGMvLy9QWTBzWlBmU3BONzIxd0M2TkRuUjFFK2Nj?=
 =?utf-8?B?ZFg4Y1AwNC80NFJLTFZUMkxid0hWMnBXYUFocTNHdkxtY0J0T05DZEdsL3hN?=
 =?utf-8?B?M2hUWkQvek9rbzdSUWNUY0x1eTkrYWlhWVJrSURQenp3dXlsQ1JSMFhFNS8y?=
 =?utf-8?B?T0FzUzdHQmxmMHlaT3F3bXROT2FVS0x3cHl4MDZBRDhza1p2UGNYSEwzOFcw?=
 =?utf-8?B?UmIxa2U2bWttUkVLZlk0dS9jLzRiNjBGdFZPMkU3SW9ZTmdFLzBwZW1zOHVC?=
 =?utf-8?B?dk95UnU3UHpBMjlhemlaVUdEVjNIdDBHQnZ2Y3NjRlowK1pXYis2eG1IMXdD?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aefe0a1-8b00-4202-2fdd-08d9d1cc6eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 10:57:00.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnzJXAsmSKIjyULtdkpd2jOSRJkZMTmqkF0FYJ98liLGQGg489n4HnsvXtDEx1yESO5Rm319284SRNoHrYsbIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGUgVGFjdGl2ZSB0aW1lIGRldGVybWluZSB0aGUgd2FpdGluZyB0aW1lIGJlZm9yZSBidXJz
dA0KPiBhdCBoaWJlcm44IGV4aXQgYW5kIGlzIGRldGVybWluZWQgYnkgSC9XIGF0IGxpbmt1cCBz
dGF0ZQ0KPiBIb3dldmVyLCBpbiB0aGUgY2FzZSBvZiBzYW1zdW5nIGRldmljZXMsIGd1aWRlZCBo
b3N0J3MgVGFjdGl2ZSB0aW1lDQo+ICsxMDB1cyBmb3Igc3RhYmlsaXR5Lg0KPiBJZiB0aGUgSENJ
J3MgVGFjdGl2ZSB0aW1lIGlzIGVxdWFsIG9yIGdyZWF0ZXIgdGhhbiB0aGUgZGV2aWNlLA0KPiAr
MTAwdXMgc2hvdWxkIGJlIHNldC4NClRoaXMgd2F5IHlvdSBhcmUgY2hhbmdpbmcgdGhpcyBmb3Ig
ZXZlcnlvbmUgLSBub3QganVzdCBmb3IgU2Ftc3VuZy4NCmUuZy4gUXVhbGNvbW0gYXJlIHVzaW5n
IHRoaXMgcXVpcmsgYXMgd2VsbCBmb3IgV0RDIGRldmljZXMuDQoNClRoYW5rcywNCkF2cmkNCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU0VPIEhPWU9VTkcgPGh5NTAuc2VvQHNhbXN1bmcuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgfCAyICstDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KPiBp
bmRleCAxMDQ5ZTQxYWJkNWIuLjQ2MGQyYjQ0MGQyZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9z
Y3NpL3Vmcy91ZnNoY2QuYw0KPiArKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQo+IEBA
IC03ODE1LDcgKzc4MTUsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF9xdWlya190dW5lX2hvc3RfcGFf
dGFjdGl2YXRlKHN0cnVjdA0KPiB1ZnNfaGJhICpoYmEpDQo+ICAgICAgICAgcGVlcl9wYV90YWN0
aXZhdGVfdXMgPSBwZWVyX3BhX3RhY3RpdmF0ZSAqDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ3Jhbl90b191c190YWJsZVtwZWVyX2dyYW51bGFyaXR5IC0gMV07DQo+IA0KPiAtICAg
ICAgIGlmIChwYV90YWN0aXZhdGVfdXMgPiBwZWVyX3BhX3RhY3RpdmF0ZV91cykgew0KPiArICAg
ICAgIGlmIChwYV90YWN0aXZhdGVfdXMgPj0gcGVlcl9wYV90YWN0aXZhdGVfdXMpIHsNCj4gICAg
ICAgICAgICAgICAgIHUzMiBuZXdfcGVlcl9wYV90YWN0aXZhdGU7DQo+IA0KPiAgICAgICAgICAg
ICAgICAgbmV3X3BlZXJfcGFfdGFjdGl2YXRlID0gcGFfdGFjdGl2YXRlX3VzIC8NCj4gLS0NCj4g
Mi4yNi4wDQoNCg==
