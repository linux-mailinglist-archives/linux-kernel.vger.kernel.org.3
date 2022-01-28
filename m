Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0093749FDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349936AbiA1QPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:15:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58873 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiA1QP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643386527; x=1674922527;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=grEm5gbxLg47za7tVpI8hSPmQlSQ6vFV5nNHvVhENjM=;
  b=be79jQiGw2U7d6OAhLh5sLq1kR4NOmDuoNTim1q9ZVj6asdVgowHc7hv
   JwLuHSV9Cp/wE274XEytfLzeUFSw6YVGsUVYpByy3oQTHLjBlJgZh+md8
   MgW/dlb0KnbMU5xrUYtzmglwiCtuLLbVoOjIPOAoxBa1HxpXJzjawgAYj
   h56LA+xIQ/9yOhrlIG7r2pXtSy1CA/Bg2ayNt7sHAhgakec+Ko+yh2Xnk
   DTr5Kl5HJwl5ppAhw1qMK4SY4pExihM/rBpTlNhLzaDglw7e6gdwckXI5
   Krxl1K2GpkRVN7QAPhYdGKKx3YCglQumNkmFt5qvfxDetCeMIln7CfhDK
   g==;
X-IronPort-AV: E=Sophos;i="5.88,324,1635177600"; 
   d="scan'208";a="196445491"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2022 00:15:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDoP+sG6zOxls+Je2oRKsZTjvGlkXkHokAkHbtP0WKidGIYVlCPTTsoW3m8KpX5h4pjLOaHi1h4aZ2Ane4Box25zsorCIGIv26f71rRIJKcDvRcFG5TMzLkAw9NYPNgHgtGjA/US7A7CDzvkhQZqAf6Ykm7pcAN2klASHPIbhp+sntGd9Ek1zi+7k09pEyQHNJxWFw92pgq4+G2EtzfP/TDc1/ujkECvYdPmhITM1bl12QMR22Sw4VNOS6L9/j9MGYFQolJBQJ0tYH3r8h88bmfvjdI4Xxw8QfX11rwum8378wgIosmBpOKy/EsoKiqt64i3zzlGNXdI/dBf0ooqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grEm5gbxLg47za7tVpI8hSPmQlSQ6vFV5nNHvVhENjM=;
 b=QTDvC5LlZX2rgOHeKygJRjcg1nfGQLvFfDjg6Kb7dkXthMlHY6ktYHbbpa7hxPxa3efsfOnO5BC1/zWRfCOFx3hKoyzgG3ZByriJ0QKKwhWL3nxP6duZeX1rmHsjkJrnzdM/qN8+8/tX2nUeBfZ78PglQWyfHd016iL/k872Ev5zReIT0o8EOSv7/CbzE1yL9/k4blzkdPfJ4LOUwDu5jdGiauPOQ4k44mojedmTCKhebbN3F9phY8gsUfbsq3OTd3jlUDoJx+iGXlkKeaWuI+hDXC60E8/ifEoAkrA+KFDre2wHlW+Zn+BU70QRjjQk1V+vsWhSNobMlezcXWs06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grEm5gbxLg47za7tVpI8hSPmQlSQ6vFV5nNHvVhENjM=;
 b=SXHEFZmf/IelqI/EuylZOxXfObMXe8xo03OBtrYfSP8pKwrjVCQ472n7wndbq+RuoXdtuzhCGfIrsI+wU23scXRNjfrydWOltpgKSO21HRbp79jv6LDly001eZswWFpXzF8eRNtSYWY1eS5Vyi9t3E6eH8PbnD8s9FJYdJCiRw8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA2PR04MB7513.namprd04.prod.outlook.com (2603:10b6:806:147::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 16:15:26 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7%4]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 16:15:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huobean@gmail.com" <huobean@gmail.com>
Subject: RE: [PATCH RESEND] scsi: ufs: Add checking lifetime attribute for
 WriteBooster
Thread-Topic: [PATCH RESEND] scsi: ufs: Add checking lifetime attribute for
 WriteBooster
Thread-Index: AQHYEyqwJmbaxGMRKkGVAz5XYPgK9Kx4nfiA
Date:   Fri, 28 Jan 2022 16:15:26 +0000
Message-ID: <DM6PR04MB6575179F269B68DE24A43D5CFC229@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220126104125epcms2p50afb250190ffc3f2dc7b16df31757c94@epcms2p3>
 <1891546521.01643252701746.JavaMail.epsvc@epcpadp3>
In-Reply-To: <1891546521.01643252701746.JavaMail.epsvc@epcpadp3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1d1f22a-0b8e-4010-f682-08d9e27964f9
x-ms-traffictypediagnostic: SA2PR04MB7513:EE_
x-microsoft-antispam-prvs: <SA2PR04MB7513EF6F1E17EC0738DC8EC5FC229@SA2PR04MB7513.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: akLqfpd+XHQNStlbiQ0vCR+T2S6B158Frg84H9+XX4WVJNjVD1A3k49cFHwq2XQWEoTW25Grb6Sz6dySpJLzJDUenLrakAFpJyc754kP3PswoXGmd5943PlEMxXUAtJcPax2t/Sd1FrdF/eEQgki6YjvI+aeBC7F5KLe7vtErDf5EFZ/zHsFXe1VRoHzQCwmkmX9FZt/xorf1Im0S6VwTxD5fnTsibG4qXOXJDfkB3WZxJhZu8Da2siH/RSw5MOGbJk6wwyr1F/S90DdrYESyDNS6uiofuMFOXMuyAGJUPTMIC86TXSGnTnDgoK/FfTJy06nQnUeLYK5o56w8uhTQs9bjPMrmPWplTh2Pg9iEd8EsAsenatK73/kSoFvlVAuxIEl9HtvYedmBlr0qYujz0QWeCkV4TfAjiARHiQUXrcs9cC3duFopWpUd5eSx/3fkHS2wCf2wTqQtEIMDCfDuqGp4PuTrD6wamIrf+AX9/3of5gLYMCAJ2h37ON67s48yL8lItn97vuInwP96capFRrOAnFWJPCvhjfv6KUDYPx4aspj7rPh5OB96Rcb43CYVnwjKVJV4+kEOI0YujSdW//VfmeB2UYOpowKLwWydZgLHAeNOOPr5obCTpnCGcwXuUYGt0c3gP83c/2DLEoW+6HvhTy2gVt8qIZ0oJuhSpR41U1/+mF7ebkOFvPd3n+HTfDXtUsNsIVdWPCQPHE4K+mFUIky80km6qNxZYCKzq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(33656002)(508600001)(921005)(82960400001)(110136005)(26005)(316002)(38100700002)(2906002)(55016003)(122000001)(86362001)(186003)(66946007)(66476007)(66556008)(52536014)(83380400001)(71200400001)(76116006)(66446008)(8676002)(64756008)(8936002)(7696005)(9686003)(38070700005)(6506007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFFpUGtqeXNDRmhpTW5BcVNyNEROazRRQnNNbFdkdXlJcFR1TXFBS2JLSEJH?=
 =?utf-8?B?VlkzZU1GcFoxOHI4SVlkdHZzV0NYSUVaSzErKzFYR2ZZNGxYbTdUc3NHdFNT?=
 =?utf-8?B?ZXV4Mi80Rm9WQWlBS0hvRGJpb1ZVRVphTktnN1B2UXR6Z1VkTlR1bjEzUlNm?=
 =?utf-8?B?L3lINk01Q1pOaEdhSWdoSk1BQUdBN2tSajhwVWVyUVR4dmN0UHcrV1dHWGE0?=
 =?utf-8?B?MkNXYUlEdGE2OVhJa3YrY2NNUnVuR3o3MXZ4TXNxcVZLa2xNNUxaZHZtOGtL?=
 =?utf-8?B?dzVLY3dWcXdXK0ozRUFjdmpZSUZFdm1jd2ZCZks5S0hYSTV4bGlTQTQ3MTJi?=
 =?utf-8?B?TGJkamdvcDJ2TmdpaWtmWFRzdmVUZXZ1TjNpZHlnMVJ0eEg4cnZDWFVncmpq?=
 =?utf-8?B?WGIzcXF5Uld5bmZuVWt5TXM1ek44Z2JuK01UUEZQM21IVzg2YjYvbGxvbEsz?=
 =?utf-8?B?YjlNMkRMdWM1ZksrQStJaXFuWGk0by9ydVBFaytkOXREdkNhaEdSRVJDSlpV?=
 =?utf-8?B?RkhKUXNJMlV0SlB1WFVERGY4MEVtczQzOE5rdTdpMzJ4WnAxakJLeTBnS0ZO?=
 =?utf-8?B?b0h5KzlJYm11SkNuQnRyUUw0R1VDeXhlNWd2cjhCL0E2aWtJUU9PVS96WWdn?=
 =?utf-8?B?RWVYM1VqOWtDUVpUa1ljdWlueCtmc2J4SllHSzVxS3AwUDhNR0JGYzBSdEVX?=
 =?utf-8?B?aWRZMnlxNktDSjY5b1ZxR2tMR2FKLzFTTW5GeTdsL1o5ai80T0ttWVJIbGFP?=
 =?utf-8?B?c2JTVTBzZlEvUnMzYTl6TDNpL0FuVk1zZGtsTUZxcUk2aG80QnJGZU9QWGpS?=
 =?utf-8?B?WDhZdVRtRXNzTlIvRlErTW90Tk94SVU1cEtwa3ArNFcvMFNNa1pKemlWT3Bu?=
 =?utf-8?B?ZFhYZ3BGOTI2YVRlMVhUaE1EcTRBUHRnSk5zNWhPRVRjRkVCUnYzYWR4NW5W?=
 =?utf-8?B?TUhrVnJSWUhzYWZDV0R4MGZRbXJPOWRTOFdDeHFSZkdVbGFtY2xEM1hWdVMr?=
 =?utf-8?B?aXkvQkNFdkdBc3NMMXNoQVhsbkNBdlA5NzJ3OVFoM2s0RkV4K0JTcmdmU2c0?=
 =?utf-8?B?M1EycGhVWkNETTVpVFlWQVJDOHdwOSt6bGhtZmVBZVlnTVZSKzZiNWhoWlFh?=
 =?utf-8?B?d0FPTE9HRFJBQWIxK3VzZFhWNlIvSkZoRTlrU3UzR0llMVJQY3JiQ0R1UkdZ?=
 =?utf-8?B?VnhhWlZTRHhLTDc1RkhlcjZHaWo5ZFA2ZUxNQlcyRy9lcEVFeGFCWUJhMUcz?=
 =?utf-8?B?U2VhcjBGMk81anhqYjc4OHloSGxLWDZwYXk5ZWh3OHU4RjliWkMvSEVza0kr?=
 =?utf-8?B?K0Z2RkUxZmRraVZWV3lhLzcwZU5jakI4TnNFYTJFeUVLYU5XRDhKay9qQmkr?=
 =?utf-8?B?SUlrRDNNSGdMYVVJamdVNUdnWkJjUmdHL05QdnRXZUhXeDBoWjBxSzMvQWtG?=
 =?utf-8?B?dkJsZHZXMXowa05XQjhHbkFyR05Mek5xYUV0S1NWWFZybGVJK1NZYjV2TFdS?=
 =?utf-8?B?aytHc2I3YWNXektoUlFuMFl4dGJ2RkFBZXVsejhsWEFMYzg5S1Ezak0vRGpq?=
 =?utf-8?B?RFNKbmhsdVowUVhnUm0rM3Q0cFFtSGljbDA0ZGZCaWNyUnBHQ21yMEM4bUFU?=
 =?utf-8?B?aEVOVURXNGUzY09CU2I1cklDRjFzLzZQUXNvdnNjbTdVUVFwQ056WDVVcjFk?=
 =?utf-8?B?NlZMUGdzTDVrR0lmMStldjBiZk0wUHV4MzROK0lRV2FjUHV0YWdRTXdPcVF0?=
 =?utf-8?B?bWR1TDQrNmVHK3gzYlZWYlppZHd6YW9GS1JlbGpNQXBhWWkxV0hQa3lnZ3Qv?=
 =?utf-8?B?VVhrTUFMbHdjUDV4QzZwQjVvNWQ1d0tQZkRScjBWV0piNHhubEsvREJoKytT?=
 =?utf-8?B?VzIvV2ZhOENpRURhMWhUQlZzUDRHc1dhVWVTMDhXTjh2Yzg5bXN6VWxMK21q?=
 =?utf-8?B?RTZCU29MTVNxYWczem1JY1ZYNzBPQ0twWHM5MFZOQUlPK3h5VGJzOWRYZGRY?=
 =?utf-8?B?czZOTW5xZmZraXZvRFdSOFdlSlVnOGhBaXpzd25Fd1hJRkVmTTlIbFFZcW8v?=
 =?utf-8?B?eHdqTW1PMUhnL2tSQjV3NlVEeXJMdVoxSVV3Y0lhZzRSM2pmNE1KQlZJWTBW?=
 =?utf-8?B?MGFYa3F5RFFMaW5OaFY3S0JyUk92MVZmOGV6c21tOVdJcktPd0xmWDZXZXp4?=
 =?utf-8?Q?4nlLgJd0EtABXHAL4Hxsf3s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d1f22a-0b8e-4010-f682-08d9e27964f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 16:15:26.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xxk9Q0G2XXyvVB5FTdtMxixStb3UGSFZ8y44a1epTipMMwrZ53cyC7s1d2MiarbFAUwm9wpLucvpBIXYQI4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7513
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBCZWNhdXNlIFdCIHBlcmZvcm1zIHdyaXRlIGluIFNMQyBtb2RlLCBpdCBpcyBkaWZmaWN1bHQg
dG8gdXNlIFdCIGluZmluaXRlbHkuDQo+IA0KPiBWZW5kb3JzIGNhbiBzZXQgdGhlIExpZmV0aW1l
IGxpbWl0IHZhbHVlIHRvIHRoZSBkZXZpY2UuDQo+IElmIExpZmV0aW1lIGV4Y2VlZHMgdGhlIGxp
bWl0IHZhbHVlLCB0aGUgZGV2aWNlIGl0c2VsZiBjYW4gZGlzYWJsZSB0aGUgV0IgZmVhdHVyZS4N
Cj4gDQo+IFdCIGZlYXR1cmUgc3VwcG9ydHMgImJXcml0ZUJvb3N0ZXJCdWZmZXJMaWZlVGltZUVz
dCAoSUROID0gMUUpIiBhdHRyaWJ1dGUuDQo+IA0KPiBXaXRoIExpZmV0aW1lIGV4Y2VlZGluZyB0
aGUgbGltaXQgdmFsdWUsIHRoZSBjdXJyZW50IGRyaXZlciBjb250aW51b3VzbHkgcGVyZm9ybXMN
Cj4gdGhlIGZvbGxvd2luZyBxdWVyeS4NCj4gDQo+ICAgICAgICAgLSBXcml0ZSBGbGFnOiBXQl9F
TkFCTEUgLyBESVNBQkxFDQo+ICAgICAgICAgLSBSZWFkIGF0dHI6IEF2YWlsYWJsZSBCdWZmZXIg
U2l6ZQ0KPiAgICAgICAgIC0gUmVhZCBhdHRyOiBDdXJyZW50IEJ1ZmZlciBTaXplDQo+IA0KPiBU
aGlzIHBhdGNoIHJlY29nbml6ZXMgdGhhdCBXcml0ZUJvb3N0ZXIgaXMgbm8gbG9uZ2VyIHN1cHBv
cnRlZCBieSB0aGUgZGV2aWNlLA0KPiBhbmQgcHJldmVudCB1bm5lY2Vzc2FyeSBxdWVyeSBpc3N1
ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaW55b3VuZyBDaG9pIDxqLXlvdW5nLmNob2lAc2Ft
c3VuZy5jb20+DQpBY2tlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQoN
Cj4gLS0tDQo+ICBkcml2ZXJzL3Njc2kvdWZzL3Vmcy5oICAgIHwgIDYgKysrKysNCj4gIGRyaXZl
cnMvc2NzaS91ZnMvdWZzaGNkLmMgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzLmggYi9kcml2ZXJzL3Njc2kvdWZzL3Vmcy5o
IGluZGV4DQo+IDBiZmRjYTNlNjQ4ZS4uNGEwMGMyNGEzMjA5IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3Njc2kvdWZzL3Vmcy5oDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLmgNCj4gQEAg
LTQzLDYgKzQzLDEyIEBADQo+ICAvKiBXcml0ZUJvb3N0ZXIgYnVmZmVyIGlzIGF2YWlsYWJsZSBv
bmx5IGZvciB0aGUgbG9naWNhbCB1bml0IGZyb20gMCB0byA3ICovDQo+ICNkZWZpbmUgVUZTX1VQ
SVVfTUFYX1dCX0xVTl9JRCA4DQo+IA0KPiArLyoNCj4gKyAqIFdyaXRlQm9vc3RlciBidWZmZXIg
bGlmZXRpbWUgaGFzIGEgbGltaXQgc2V0dGVkIGJ5IHZlbmRvci4NCj4gKyAqIElmIGl0IGlzIG92
ZXIgdGhlIGxpbWl0LCBXcml0ZUJvb3N0ZXIgZmVhdHVyZSB3aWxsIGJlIGRpc2FibGVkLg0KPiAr
ICovDQo+ICsjZGVmaW5lIFVGU19XQl9FWENFRURfTElGRVRJTUUgICAgICAgICAweDBCDQo+ICsN
Cj4gIC8qIFdlbGwga25vd24gbG9naWNhbCB1bml0IGlkIGluIExVTiBmaWVsZCBvZiBVUElVICov
ICBlbnVtIHsNCj4gICAgICAgICBVRlNfVVBJVV9SRVBPUlRfTFVOU19XTFVOICAgICAgID0gMHg4
MSwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgYi9kcml2ZXJzL3Nj
c2kvdWZzL3Vmc2hjZC5jIGluZGV4DQo+IDQ2MGQyYjQ0MGQyZS4uNDFkODViNjlmYTUwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5jDQo+ICsrKyBiL2RyaXZlcnMvc2Nz
aS91ZnMvdWZzaGNkLmMNCj4gQEAgLTU3NzgsNiArNTc3OCw0NyBAQCBzdGF0aWMgYm9vbA0KPiB1
ZnNoY2Rfd2JfcHJlc3J2X3VzcnNwY19rZWVwX3ZjY19vbihzdHJ1Y3QgdWZzX2hiYSAqaGJhLA0K
PiAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCB1ZnNoY2Rf
d2JfZm9yY2VfZGlzYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKSB7DQo+ICsgICAgICAgaWYgKCEo
aGJhLT5xdWlya3MgJiBVRlNIQ0lfUVVJUktfU0tJUF9NQU5VQUxfV0JfRkxVU0hfQ1RSTCkpDQo+
ICsgICAgICAgICAgICAgICB1ZnNoY2Rfd2JfdG9nZ2xlX2ZsdXNoKGhiYSwgZmFsc2UpOw0KPiAr
DQo+ICsgICAgICAgdWZzaGNkX3diX3RvZ2dsZV9mbHVzaF9kdXJpbmdfaDgoaGJhLCBmYWxzZSk7
DQo+ICsgICAgICAgdWZzaGNkX3diX3RvZ2dsZShoYmEsIGZhbHNlKTsNCj4gKyAgICAgICBoYmEt
PmNhcHMgJj0gflVGU0hDRF9DQVBfV0JfRU47DQo+ICsNCj4gKyAgICAgICBkZXZfaW5mbyhoYmEt
PmRldiwgIiVzOiBXQiBmb3JjZSBkaXNhYmxlZFxuIiwgX19mdW5jX18pOyB9DQo+ICsNCj4gK3N0
YXRpYyBib29sIHVmc2hjZF9pc193Yl9idWZfbGlmZXRpbWVfYXZhaWxhYmxlKHN0cnVjdCB1ZnNf
aGJhICpoYmEpIHsNCj4gKyAgICAgICB1MzIgbGlmZXRpbWU7DQo+ICsgICAgICAgaW50IHJldDsN
Cj4gKyAgICAgICB1OCBpbmRleDsNCj4gKw0KPiArICAgICAgIGluZGV4ID0gdWZzaGNkX3diX2dl
dF9xdWVyeV9pbmRleChoYmEpOw0KPiArICAgICAgIHJldCA9IHVmc2hjZF9xdWVyeV9hdHRyX3Jl
dHJ5KGhiYSwgVVBJVV9RVUVSWV9PUENPREVfUkVBRF9BVFRSLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFFVRVJZX0FUVFJfSUROX1dCX0JVRkZfTElGRV9USU1FX0VT
VCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmRleCwgMCwgJmxp
ZmV0aW1lKTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfZXJy
KGhiYS0+ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAiJXM6IGJXcml0ZUJvb3N0ZXJC
dWZmZXJMaWZlVGltZUVzdCByZWFkIGZhaWxlZCAlZFxuIiwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgX19mdW5jX18sIHJldCk7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+
ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgaWYgKGxpZmV0aW1lID09IFVGU19XQl9FWENFRURf
TElGRVRJTUUpIHsNCj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoaGJhLT5kZXYsICIlczogV0Ig
YnVmIGxpZmV0aW1lIGlzIGV4aGF1c3RlZCAweCUwMlhcbiIsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIF9fZnVuY19fLCBsaWZldGltZSk7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgZGV2X2RiZyhoYmEtPmRldiwgIiVzOiBX
QiBidWYgbGlmZXRpbWUgaXMgMHglMDJYXG4iLA0KPiArICAgICAgICAgICAgICAgX19mdW5jX18s
IGxpZmV0aW1lKTsNCj4gKw0KPiArICAgICAgIHJldHVybiB0cnVlOw0KPiArfQ0KPiArDQo+ICBz
dGF0aWMgYm9vbCB1ZnNoY2Rfd2JfbmVlZF9mbHVzaChzdHJ1Y3QgdWZzX2hiYSAqaGJhKSAgew0K
PiAgICAgICAgIGludCByZXQ7DQo+IEBAIC01Nzg2LDYgKzU4MjcsMTIgQEAgc3RhdGljIGJvb2wg
dWZzaGNkX3diX25lZWRfZmx1c2goc3RydWN0IHVmc19oYmENCj4gKmhiYSkNCj4gDQo+ICAgICAg
ICAgaWYgKCF1ZnNoY2RfaXNfd2JfYWxsb3dlZChoYmEpKQ0KPiAgICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiArDQo+ICsgICAgICAgaWYgKCF1ZnNoY2RfaXNfd2JfYnVmX2xpZmV0aW1l
X2F2YWlsYWJsZShoYmEpKSB7DQo+ICsgICAgICAgICAgICAgICB1ZnNoY2Rfd2JfZm9yY2VfZGlz
YWJsZShoYmEpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgIH0N
Cj4gKw0KPiAgICAgICAgIC8qDQo+ICAgICAgICAgICogVGhlIHVmcyBkZXZpY2UgbmVlZHMgdGhl
IHZjYyB0byBiZSBPTiB0byBmbHVzaC4NCj4gICAgICAgICAgKiBXaXRoIHVzZXItc3BhY2UgcmVk
dWN0aW9uIGVuYWJsZWQsIGl0J3MgZW5vdWdoIHRvIGVuYWJsZSBmbHVzaCBAQCAtDQo+IDc0ODYs
NiArNzUzMyw3IEBAIHN0YXRpYyB2b2lkIHVmc2hjZF93Yl9wcm9iZShzdHJ1Y3QgdWZzX2hiYSAq
aGJhLCB1OA0KPiAqZGVzY19idWYpDQo+IA0KPiAgICAgICAgIGlmICghdWZzaGNkX2lzX3diX2Fs
bG93ZWQoaGJhKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gKw0KPiAgICAgICAgIC8q
DQo+ICAgICAgICAgICogUHJvYmUgV0Igb25seSBmb3IgVUZTLTIuMiBhbmQgVUZTLTMuMSAoYW5k
IGxhdGVyKSBkZXZpY2VzIG9yDQo+ICAgICAgICAgICogVUZTIGRldmljZXMgd2l0aCBxdWlyaw0K
PiBVRlNfREVWSUNFX1FVSVJLX1NVUFBPUlRfRVhURU5ERURfRkVBVFVSRVMNCj4gQEAgLTc1Mzcs
NiArNzU4NSwxMCBAQCBzdGF0aWMgdm9pZCB1ZnNoY2Rfd2JfcHJvYmUoc3RydWN0IHVmc19oYmEg
KmhiYSwNCj4gdTggKmRlc2NfYnVmKQ0KPiAgICAgICAgICAgICAgICAgaWYgKCFkX2x1X3diX2J1
Zl9hbGxvYykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byB3Yl9kaXNhYmxlZDsNCj4g
ICAgICAgICB9DQo+ICsNCj4gKyAgICAgICBpZiAoIXVmc2hjZF9pc193Yl9idWZfbGlmZXRpbWVf
YXZhaWxhYmxlKGhiYSkpDQo+ICsgICAgICAgICAgICAgICBnb3RvIHdiX2Rpc2FibGVkOw0KPiAr
DQo+ICAgICAgICAgcmV0dXJuOw0KPiANCj4gIHdiX2Rpc2FibGVkOg0KPiAtLQ0KPiAyLjI1LjEN
Cg==
