Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762F550E89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 04:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiFTCQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFTCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 22:16:51 -0400
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6B390;
        Sun, 19 Jun 2022 19:16:47 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 25K2G2Yq021356; Mon, 20 Jun 2022 11:16:03 +0900
X-Iguazu-Qid: 2wHHgvjVoe1UNCNSxW
X-Iguazu-QSIG: v=2; s=0; t=1655691362; q=2wHHgvjVoe1UNCNSxW; m=M2bjyyRkE8grCkrAFxj+LKlpytR716mqLd+jEjbDkrE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1111) id 25K2G0uu018132
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Jun 2022 11:16:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4lSDHQiwSf4mHslqvP0KcCD3y6CMjyaMoCCvXm057hFtUHl4PG2xT626DskfkRFVUi1ugbXbdfvC1HMNOwGBuXtU+xyq3/l/dhrRtpJZRJ/oDFQB5gl0GMd4h9bmk2lbLDx05EQjgwrUQDABiAGZVas70fwRLQWigT8cbPSjWzJBnQYmCZNZdVj6cl5OYuLhBxgIHZO72RNMevYLHKkzmccJCtJXgHAFAAZO/BhVKlc3+fhbKwaiPheGfyxj8ThhA7j/k2jz4tuZJig/OWBMDx8JsPOARC2UX3e/K3L/r7hHhF7uo7gMMOQuP5uZPVLf/eUJ0Z2X7cCzHmnn5/LyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0mpE2y/yNI4peYEPmu4Lq5QZ4jThWgngN8S14GBltk=;
 b=TN85hdfAyJ4MPl3eELSTmp+zh+8x5HwVFxriLpyySHUKKsMujE1Szemoa8tLCDstaqbWjIHqCajIJ7eiZmWg4dBbCxzV2GDotllArRLCmBuHnj24c3nCU0VybBle2WPRzo9oscZvl+Z7+ckfNm/Qu8HVZmx3q4H5x+f5olNEcZ1/Lmqc9NoHr1wFDxRKXqayoygIkwN6htVrB2QXPvlBIiWDU4032DO4tti4ro3ZwTjNlIvpIPXXtwv4t1eEzEfaqtHK7Mp895ky0ydCbWgTMac/SYCrz/HE7vYpiNyuQPMp0UwdLQkd3YXb3oU7Xu5Vq+SoZO3esNU/6b1csHYj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robh+dt@kernel.org>, <jgg@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <yuji2.ishikawa@toshiba.co.jp>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Thread-Topic: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Thread-Index: AQHYb9dH05SFqMkMF0+v2vSGSFgXYa0vIReAgCiUC9A=
Date:   Mon, 20 Jun 2022 02:15:46 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420432737626348118C515F92B09@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
In-Reply-To: <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dc22658-7e46-4553-df38-08da5262c958
x-ms-traffictypediagnostic: TY2PR01MB2249:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2249D5A964E9F7C79BF8B7ED92B09@TY2PR01MB2249.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZW7Bz+VbuxLMgOXhvXLKDBHr0nbSoN/f0c44Tj3TvTcwcMprV35EziZUSp8WSwVNH2Kyh94xXA6NrqMUvwvcrMcd0A0BkatpMnQaNXBTy8CtgpPn5KAZynwKMeyYjGxlGXPkpsAu7frJmZPKIMgh2QIQ7alxoMqyIGe7/c4XTM0v37/4YQhuwxENRUY5AT62bjsocjM45b/MZJzSi3cqHdwO0pXmo9PNZ+p0sgXXxDLeiQSUkbvUR5WWGMF0AucL4KTc50y87aCAwBqv2iTldVHX5dpRLhjC28pN56mH8DzVVxQM8+oO3IQwAYmvoi6OCzmdr0roBHLxTwO9NMdQ28wFoxxKWTyKrYQEO/OE0Oipp11MW4AM/y40jVm9mi58FOH+xZ7Tw9s66lWaHNvwCjnc2fNeEFGffugMlYEQyQCClmRNA/1nDK+Z2J39n6n113BfQ0WsIyRMIgP2pq/vhFa7pBscwuWXNYBm90lOr9sfj8sMMKM+CBg1gzrF029VzqmbvLjDrMiXsqRgBWEEpRkJcUo2a/A+fD9JM1cMb705sUJzvyfIbQbI6H9/f3gBpQvzvtdR8XMLVeR+U7y7wmqtrQIO8kbkDyBT0veRk+7YwUKVB1d4lxfySxYFbIm1QW3EiftGKTTBNw8ltisSRTcbNu5z2c+rVa3abJzuCFkrP7ghv30qbX+BtD76FPNKaAMniYydoJGQARinVMKEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(7696005)(83380400001)(186003)(55016003)(122000001)(6506007)(38100700002)(53546011)(38070700005)(110136005)(54906003)(66476007)(498600001)(2906002)(316002)(71200400001)(9686003)(26005)(76116006)(66446008)(66556008)(64756008)(86362001)(52536014)(8676002)(8936002)(4326008)(66946007)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YktrdWVrVUFDVkdoU3IyckdiNVZ1WlFBL1ZmTHFMRjhuRlJibW9wWmJiTlJH?=
 =?utf-8?B?WkhPeHI1R3MwUUN1bTg5cnFLcjhwTUczWVduNVNFTTJxNU5ES2VqMTJLRnJi?=
 =?utf-8?B?UHpMYmVUYi9RZFZkMC9nUjJmZ04vSWFDcmFjWXZ2MVJNVUVHdzJxL1p0VTlH?=
 =?utf-8?B?YzNqOHVtMFJnTy9sbTVCYURYUUJMM1ZVMHcrS0xkR21PNTZXZy83V1Ara2hT?=
 =?utf-8?B?bGYvNVBDWG9lU0RUSWZqbjhodi80ZzdZN2FOYTJjN0FsVlR6azU1VXFjTE12?=
 =?utf-8?B?cGZPaHNGeGhpOEYxd1dVclp0MzE2YXNDdXZGOG1WUkcxNzU5N0RiYk9ybjdh?=
 =?utf-8?B?eG5scEFnYzBKQzFqT1FUWE9ZamdTY2tPaWVNc3NBVEc3bk5FUVFKZFFFQnlF?=
 =?utf-8?B?clB3OHE5SVd5eWtGSGtFRjhPOFJUMDNoN2xITzVPSUVQbzhwVXZWYUQ1VWJ1?=
 =?utf-8?B?UDM0TWFIM2FLdGJVOEJQYU5WWnJEMEFicExCa2lIOCtxN3Z2QXVwKzQxVlBm?=
 =?utf-8?B?OXZHdGdJM3MzRVNUVFBBUHBqQjVHZ0VIdEcwQjhncGw3RDdMbncxUUxpWTZs?=
 =?utf-8?B?OW40dlFtdnVQdkdidXp0Z3Jiajc4RzFZM3ZkSFlXS1NPalV4TVE1M0t0QTVr?=
 =?utf-8?B?QmpxL0VxV0czaGkyT2pERTFwZmo1QS9nai84RjhMSGNpSm1zTEtHRE5pU2JG?=
 =?utf-8?B?N09RZTRhTDlRRTg0cm42bVVZOURDZ3c4dHFPU0lMR2dXZUtWcllsK0N4T3FQ?=
 =?utf-8?B?Zkk0M204TUZXWE1haERTWnNOQ1poR2lSNHV4d3BtQXFCREZMMTZtUlN5REo5?=
 =?utf-8?B?QjU2Z25zZ2VoWGYxQ3FkcFh5ZjBaRUkzVnJRR2VUbGY4WXozbFAvVDVodkw4?=
 =?utf-8?B?NFNWb2xWOEptK09aS2tEV29oNXFFLzlpdURUcWQ0dC9TeTcyM2tQczJFa2lJ?=
 =?utf-8?B?STVEbitjbEpUTWRGNlhqT3dTSVBzRTVGaDJUVVViOGpOMmJvSnk3NjNZaE44?=
 =?utf-8?B?b0pPZ2JEc1M0UmIraXFUMm05d3I0WUZ6STQ0aC9IZ1QyZGc0cm9td0RyZXlQ?=
 =?utf-8?B?RTBqbUMzWjY4V09BV2p6eVRlZ3U4TXRSSlJrT2thK1FNNkhpc0JLQzYwVC9H?=
 =?utf-8?B?NXlqL0lQWEFZcXhTRE1lMmNtc2k4eExVYnVMdmhDTnQzdWtsTmZLWHVRSGxE?=
 =?utf-8?B?TzEzdGlNN1JSZm9xa2VIWTBZdUxoZ2UzYy9reU8vNUM5dk5rbGxqbzRXaEZt?=
 =?utf-8?B?UjZvSkJ5L3laQThUY0psb1g0MWNMamFpaWk3KzFlbWJ3b3QyZHFEZ3kxYXpw?=
 =?utf-8?B?SDl1a055aThNemxlbGI2T3dQeCtXUEVYQUR4S0NSQWVMY0tVYWhSL3NqSGc2?=
 =?utf-8?B?RWxXRmo4UklISVJVNWhmWW1RU3N1UzhwODk1cFU4TnFOSlVTUjg5Nm1GL3FI?=
 =?utf-8?B?cE1IVnZDWmZpK1R3VHMxQ2hDZkFaeU9aMytGcXNQK2dzQzNLRWRLNEJlYS9n?=
 =?utf-8?B?cEtWOWwrSXlnV3JEazV2WmEwNTMxYlo4ZG04M245SHlmUFgrUEU1MU54V012?=
 =?utf-8?B?ZXI5NDcrK0dmS3YwcVRyQU1tQ0FxWGgxWTRNY09BeTlHVnZpQ0hTMTVhamI2?=
 =?utf-8?B?Q2Y4OHhjYWliNk8ra1hXbEtqMVFMV3U5KzJYOEFtY1ZJdjJiNHRYYjkzcUVN?=
 =?utf-8?B?cHJYMDZoeHM0V2xPUytoMldPNDNUWUpSUVFyZHo2aUxLMVg2dDNNNC9wM3BM?=
 =?utf-8?B?d1gyL01SMTM1T3dmSHJuYXRtdjY0WGdwTXVSdlhkUTNMZzVKL0IyeDRKeW8r?=
 =?utf-8?B?ZnViL3lzYXQyVXVmTnplanhvNXNCQjdnTENzcFZBVFJUdTdGQVBWaS9OMFpx?=
 =?utf-8?B?NWhES1BaeGNHRVZMMmR6VzhaTmhsZ2JsMHl0d3UrTUlWTzZyZ1FSbU5sbDZo?=
 =?utf-8?B?M1NQQW8xa1pVN2xuQVVRYmthWDJ3U0ZUVy94eWM5ZjlFZUlPK3VZMS95d2dj?=
 =?utf-8?B?SkFFZHRaQkdOazY0SW5ZejNmd0RadTZQMm1XTG9zVEhUT0trYmltQkdoMkNM?=
 =?utf-8?B?bFY0U0swQjJURnNMT3BHT3UwOEwxZDNpcVJ2dnRkY2IrMmE1bHUvbXRFaGJU?=
 =?utf-8?B?U1Y3SVNmcDIyYUdjVGw3ZWg0alFENitKS1o1bndpdXJXeHpqcmMzNWNIVnY3?=
 =?utf-8?B?TnZ4WUZvNkswSEZhMksySFFHay9OdkhoS3FJSFNYYTgwbGQ1NXUwMk1MZDhR?=
 =?utf-8?B?SVN6Y3V6ckd2SUxNUnRDTWxCb1I2UXRwSE1ySk5NRlZnNU4rdng5QW1Sbkwv?=
 =?utf-8?B?QWlrUlRRTVVUZ2E4by9XSDNISmtIOUN5Kzd0NGFKa21laUpRTS8zaEVXOUQ2?=
 =?utf-8?Q?bRRC38fF+uGjhFBe9qL+FpXt53F7/3/kCgNRF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc22658-7e46-4553-df38-08da5262c958
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 02:15:46.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGYe1RDcjb/aX80dR4U2OC+zLotGn+DfGaG0TIEDLmYwik+ZgRdNmjfRviDKbhgca4auYR4ydeNHOukQtg5Lbjx2+FWHIb5No56Htc6/m3dV4uAVRYbhVXSFangTTHOS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2249
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUgTHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjUsIDIwMjIg
MzoyNyBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfv
vKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IEpv
ZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsgV2lsbA0KPiBEZWFjb24gPHdpbGxAa2VybmVs
Lm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBKYXNvbg0KPiBHdW50aG9y
cGUgPGpnZ0BudmlkaWEuY29tPg0KPiBDYzogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGlzaGlrYXdhDQo+IHl1amko55+z5bed
IOaCoOWPuCDil4vvvLLvvKTvvKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospDQo+IDx5dWpp
Mi5pc2hpa2F3YUB0b3NoaWJhLmNvLmpwPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBpb21tdTogQWRkIFZpc2NvbnRpNSBJ
T01NVSBkcml2ZXINCj4gDQo+IE9uIDIwMjIvNS8yNSAwOTozMSwgTm9idWhpcm8gSXdhbWF0c3Ug
d3JvdGU6DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaW9tbXVfb3BzIHZpc2NvbnRpX2F0dV9v
cHMgPSB7DQo+ID4gKwkuZG9tYWluX2FsbG9jID0gdmlzY29udGlfYXR1X2RvbWFpbl9hbGxvYywN
Cj4gPiArCS5wcm9iZV9kZXZpY2UgPSB2aXNjb250aV9hdHVfcHJvYmVfZGV2aWNlLA0KPiA+ICsJ
LnJlbGVhc2VfZGV2aWNlID0gdmlzY29udGlfYXR1X3JlbGVhc2VfZGV2aWNlLA0KPiA+ICsJLmRl
dmljZV9ncm91cCA9IGdlbmVyaWNfZGV2aWNlX2dyb3VwLA0KPiA+ICsJLm9mX3hsYXRlID0gdmlz
Y29udGlfYXR1X29mX3hsYXRlLA0KPiA+ICsJLnBnc2l6ZV9iaXRtYXAgPSBBVFVfSU9NTVVfUEdT
SVpFX0JJVE1BUCwNCj4gPiArCS5kZWZhdWx0X2RvbWFpbl9vcHMgPSAmKGNvbnN0IHN0cnVjdCBp
b21tdV9kb21haW5fb3BzKSB7DQo+ID4gKwkJLmF0dGFjaF9kZXYgPSB2aXNjb250aV9hdHVfYXR0
YWNoX2RldmljZSwNCj4gPiArCQkuZGV0YWNoX2RldiA9IHZpc2NvbnRpX2F0dV9kZXRhY2hfZGV2
aWNlLA0KPiANCj4gVGhlIGRldGFjaF9kZXYgY2FsbGJhY2sgaXMgYWJvdXQgdG8gYmUgZGVwcmVj
YXRlZC4gVGhlIG5ldyBkcml2ZXJzIHNob3VsZA0KPiBpbXBsZW1lbnQgdGhlIGRlZmF1bHQgZG9t
YWluIGFuZCBibG9ja2luZyBkb21haW4gaW5zdGVhZC4NCg0KSSBzZWUuIEkgd2lsbCB1cGRhdGUg
dGhpcyB3aXRoIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiArCQkubWFwID0gdmlzY29udGlfYXR1
X21hcCwNCj4gPiArCQkudW5tYXAgPSB2aXNjb250aV9hdHVfdW5tYXAsDQo+ID4gKwkJLmlvdmFf
dG9fcGh5cyA9IHZpc2NvbnRpX2F0dV9pb3ZhX3RvX3BoeXMsDQo+ID4gKwkJLmZyZWUgPSB2aXNj
b250aV9hdHVfZG9tYWluX2ZyZWUsDQo+ID4gKwl9DQo+ID4gK307DQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IGJhb2x1DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==

