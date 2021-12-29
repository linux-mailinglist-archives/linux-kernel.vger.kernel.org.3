Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9112B4813BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhL2OBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:01:16 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:27184 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbhL2OBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640786471; x=1672322471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zGmutZ1HLhZ/6yUDS7226pLlZZ5o8YXEU5yuctlBb5Q=;
  b=0LVArppm6Ga6/xhlkpV4/Iuj2H1L1t3eBbb7T6R+rXQrZFU+z7lMpA/T
   xt7grb2s8/FO+u7N42oPcJhPBCja13Hyg7MT3Uow2gyxor4ZmC4tuoAS6
   ouj7V70c/KFoHkBD0yv3mNq84U/1xVQUSoIu7X30P6Xy4Q7C2OJ7d6oRr
   d/LuHgSn/oWU/G5Ua1oRcaqOgePsqivRlK4dxL9lQ5LXmxa0xgbHmrAvl
   vR+gjxD0VehbXbFy+kV0A15LmlUSKnIApwNK3PUJGqe5nR9h7BgznNlw7
   FErrwkwaWF9SjmfUyhQqhhXVhWughKyzEDZNBi1MQTAow5pQKDHRDoZ+C
   w==;
IronPort-SDR: ZWM8zYzI88GMdoZctyw1v3EWg1PUT/1wG/4I6vPRxp4Id26C9pIknlP0TFLDmYGc+lvhcsEH/g
 hW+f00nevGbYKJmZ4smxRlTM4DgmOS3cQvjo7YMWIClDvs+w+X/5LUdXalixAZCeUb87OSqNa2
 ysPzSmderuEW3hkpjZdTt/iFsfjzGO1W9PbfJxKHAXWazYUVIFJAXZIT+ZWeMqazFA7Q11OBzS
 gKbAI0RcnBgpLM6YPoWFUzlXMguH+PI2PYTsPRrqZmM3SXyVQ4HqytysV9/w80Y6OLQy8JXKSy
 He2AslEJlJj13EVDBMcQmItx
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="156976137"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Dec 2021 07:01:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Dec 2021 07:01:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Dec 2021 07:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOD9ETHnzkoWpha6WKDA5tBQt400/cJjVLt9+U+i/UPmHLb9vBNl3A5fu3+lv6jCWwz44TI/B44k6wObWuE2QP296rVNoprGeQvTb9n4ojt1bea/9ZKYDgP5wbyi6J60HRHzR5ZBMwfBxGGut+Dows42baWq4VPFhodVdpVbI+CDkaNO6NzDI60cTDelwppBS30m4ghBXURNHpLvhKHzySaW5Ulr0du/h+3RcRIhsRIUylQ3ZqAqPwfrz2aLzmRaXcRRpJlHDXyGwayKRP+dX7DBuU7ZVkc1dXYOaJbuDzwmQGj5zdtF4sFjKrVQIp/JZFSg/iMj0j/dOTlhODExaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGmutZ1HLhZ/6yUDS7226pLlZZ5o8YXEU5yuctlBb5Q=;
 b=aR+e1lXwLvT2TvpoiGZuFP00xNCS30GAkYUokXhaRJa+vJpKo0nFa8KUGXCUP5iIKuqcdTGEMtm8w+bDaADoJKD9XRwFECaXpO3dE0Ndiq974qoNEPIKOUgkydniG+YafHuOoWWxB6qxmOo+e/1uzMw2pVBtzJYMvYXHqc+kpEqh358mjQ631sKPj4CssbCjfHNHwQvLMLTqwmB6L8Brf/oQ0WpsCngi9b74RyEM6kzwQzRsckZD0zAOhzYplN562lNqHEbTd/hz1ENBY2Y8WIjSD+TZ+EbvSIYNIgIBtVKpqSwK1cTc9+oseVoAcF/IPhRDOiGyCdEajJHCD5EtEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGmutZ1HLhZ/6yUDS7226pLlZZ5o8YXEU5yuctlBb5Q=;
 b=WAGcvCsuTu8KosB96ld9WJNQDbUCzmfd0HEi5zEbGrDK1Dx32zVeC1zaoppXs99TZJCSMSiSof5gm+5Sa1VoWKslJMLJCpdIz2OZsXj3l+kOwms5izFh6Z8Bs73XUu0vXRhj4xx3SO/bJ5KOTQoUP8xgf65eqm7PfCL0iWMSNiw=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 14:01:04 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 14:01:03 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <potin.lai@quantatw.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <patrick@stwcx.xyz>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
Thread-Topic: [PATCH 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
Thread-Index: AQHX/LyEIkCH90d5Bk+ax6PUO1fbzA==
Date:   Wed, 29 Dec 2021 14:01:03 +0000
Message-ID: <43c0c326-7ab7-5791-30f5-a36de9f6950d@microchip.com>
References: <20211224104522.24615-1-potin.lai@quantatw.com>
 <20211227090149.k53bhq3h3giuz2h2@ti.com>
In-Reply-To: <20211227090149.k53bhq3h3giuz2h2@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d79ccb9e-a39e-4865-70d7-08d9cad3a712
x-ms-traffictypediagnostic: SA2PR11MB4874:EE_
x-microsoft-antispam-prvs: <SA2PR11MB4874F567722B288599B47E4CF0449@SA2PR11MB4874.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+BT1oIHpXBIk5ubl2dHAaRatraZ6vJeeVHGXvu4Ca36l7zcfIQbEz88+Lz1wjD39kakut6sgXu7a9k8UD7kdlGX65xsvQ9GGUbcFV9S/G0RKL0HYSNVCViHTkuhJJG2ww2w5yrMolbwAg+GdVDV0REHawKIkHgCuC0xRkXg4tcNMgfWQFreO1qSTcF9j4Rm/RNu1po6A1kAdF9qCfHZW0Xn5iV5gg6dnZ2JQtdHWwIHoqEPMgRuU8xaBiAVrax5/XLGudgDXvfmj0Epq+UQd3BZu+H0mbNKFdNfIQoQBgFDzjNpsIZ28kJvmWrL4kecA+FynVQhVpBDbgyxRiCMnmb7a3DHvF6GvkM9om7JBQahyfL3eVeuBiWRogX+jWgpuarSlzs58jbIawA9xobVczyPVEf0a8jy0mcWqtRgQSbQOan837gP08+WvdAJZTnNAtOP8UiV6TZ2rLjruaEwlcY7fp571OlwW0Gyq0YfwKUnzVvTYr41KeexgAJLUAIbFaXagpddQ7DZhqY62rNsrCYhE0GZDEOVRhfYKptqvTo2ppSBcCH2pqTapgNvRgq9ShB98Piq94FFo+PsD2NzTiDzCNluTW7o+/hFoWBD7BwyK4zOlOJjTlonBjqTUAsFw0RYa1v/aVQA0gOkI62vzG1RW6/2S5mIbZVrfwyFAFWrLjYmaIdupzZMSC2KDDLoGAR3cb0/l9vhgkk1ItOd+nZZ5f0dK1fo+qWbjiiqq+lmIAchC9CbvyFi6U7kbsHIPQsVMk7p8ZqOJKgIeyPD7r2e+j0IU5ju52Xtt5jjb4zbeu212aNAEnfxuGFBRZMG9BFFbU7/yvI0y2hN824zLM9kv/4ltkVPwjcn2T921EluOCpJxvWqK1GTy34C67zo2plBrJwnteqIgKQ0j+gHlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(8676002)(8936002)(66476007)(6512007)(53546011)(6506007)(38100700002)(83380400001)(122000001)(36756003)(5660300002)(6486002)(966005)(31696002)(316002)(91956017)(76116006)(4326008)(26005)(54906003)(71200400001)(31686004)(38070700005)(64756008)(86362001)(110136005)(2906002)(66446008)(66946007)(66556008)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTJIcmhNNTZMVUdGTlFMMHFWTmRYdUNMRzc0dVBkcjVkRmpNU0tTcVRrQ0tw?=
 =?utf-8?B?VHdoT1M3TzhyUWlkVUtWc3NocndzY3VDdytydG9VM0xTTThVNjlQRUhLUEFV?=
 =?utf-8?B?Q2ZoQzRESlAra25yUW9pU0krRlRPNVBsTWtQQnhzKzA1R0FWQXRScytyN2NX?=
 =?utf-8?B?NU8vOTMzdmpMcFZUUUpQc2xnNkJxbDBEU3UyRURONXFSNXQxTjI3OHJubThU?=
 =?utf-8?B?cDZ6WlJFTENXamZuMm4rNkxqQUlTRmR4Q0xCWXpTakR2UjRxQmJXYml3ZE5H?=
 =?utf-8?B?SElGYjh3R1pzNWdhaTRxR1UzUVREaTBJaXRsTkhoUUhiYVg2MmxvNUFkMTFC?=
 =?utf-8?B?bjduN3d3ellrRkFnaldFbXBkU1FMU3VsVDUvUUU0VWZEc0JiYUFkS1JGUS83?=
 =?utf-8?B?YW1oMzhvdmVSdE9WaU5SL2MraHl3WHBLV0w4aTExaDJoQXcvaDhHWS9OcDcv?=
 =?utf-8?B?UFFzbTBNeFlCM3FWK2JqVkh1U09XNHd4NHZxSjR3KzlObytHNGN5ZXJIcWta?=
 =?utf-8?B?aVRoQ3ZmU0JZcGxiMFZLK2k5cCtGVUZkYzVtdHMvaCtmSTNES1VQcUNOSWkw?=
 =?utf-8?B?TzB2QU9OWTE1YzZhdXhobXd3VjJJZWl6azZiS0Nyd2QxVThMOWIwN1IxZS9a?=
 =?utf-8?B?aEIzK0IycVM3YWlJTlJEUi9XcnI2ajFQdjZ1eEtrWHI3aWE3VVpRdllTYS9W?=
 =?utf-8?B?QnJ6a0x3NERPQTRrV2VDSGhrR2lGV0ZKSkE5SzdVdlppWXpESlVscURxTUdF?=
 =?utf-8?B?TDgxTWd0NkFDN3RXTnJhc3pEQzZpMlRjRGMzYWNVVU9aL05XU0RYYSs4T0tN?=
 =?utf-8?B?Q3haNERpcit6bGFScy9hUzZpQnpsdGdyWURLTWhlb2pyVGN0RXhGMVh4djVH?=
 =?utf-8?B?cFRlMk1YZlhGN0VRSlhqeVdTTytaRHl3S014YkFZWjlpTkNxR0RpakVsVE5Z?=
 =?utf-8?B?SCs4MExEc2xOT3YrRUFZT3FwWkI1bkFQdldLa2RnbGd0TkEybXNDQ1ZzN21w?=
 =?utf-8?B?cm9nRE9tUlV3MWZwNExpd1NzSWZMMnl2d3p1ejhVRm9JREk5QVhMT056RlNv?=
 =?utf-8?B?Ni9ZYUtPU0JkWFNtcmk5ZFNRSm93RnR3L1JOVmRwY1Jwc2pLLzJqTC80WVlY?=
 =?utf-8?B?TTlhVi9JYUhHT3BGSHBRSGhJLy9sSUI5Tzh2STkySCsrQzk3ZGZxdXBRMm5H?=
 =?utf-8?B?VWNaeGxTelgzZHJ0aHk0U0ZaeFVObndHRjlqTUR1djhPc1RCc2p2MWlsZHNV?=
 =?utf-8?B?b211elVQY1FGT0YyMmQ5Q2hpVXd0SHk2Ti9IRVpNcGxQZHVYdzB4QXBWWXRQ?=
 =?utf-8?B?MzhUSlFPczYrZFkxaFVSMEdSemdFSXhnK3dLdGY0R21ubnJsQVpaUG1NM0RN?=
 =?utf-8?B?OW8xQ2wzVEV0K1FIQWtzeG5kRnphdE5jZk5TajFQbTVHQkV3ZE5ybmw2QU9i?=
 =?utf-8?B?SGI2VFNCYjJxazhWVG9aNTdlZWVuSWJBRFZoVHF4cHFySFB6Sk5NcnFOS05J?=
 =?utf-8?B?ZDR4dFkvRmkwK09PT2drNmU5S0dMNExaVTJQajVNdXFWcW56b2U4NHpIS1Nl?=
 =?utf-8?B?TVhOK2RkaWI5WTdFaDNsNlBiKyt1TllwbXFwcmUxNzR3eW9EV1piUHZ2Y0Ni?=
 =?utf-8?B?RmFOTUQwYnlPbDVnN2RwZDk4aEJTbUtNQk5xdHJ0OXhrVkloYml6TDVOdFpB?=
 =?utf-8?B?dUxrWE96TGM3UUk3UWhWYjBudTI0S3Z2Mmxtd2x4ekc0b2VrZFpGSzd0UnFi?=
 =?utf-8?B?djRnVHR4bWdhMHJlRTlqNHhNbE9LcnF1MkdvMmhZdlkwNjZIOFVEMUc4SjY1?=
 =?utf-8?B?RFJJY1ZCNXRkRFhqT3N5MmYxZ0dJNDU2anZWN2srcUxZZnlyYUV6RkJzbGla?=
 =?utf-8?B?djJHUldIaGpEQWZYSGRRVjgrR0ZVVytPaUUwVndkb2wrdGJXOHF1eEhCdXZr?=
 =?utf-8?B?aDRuUkFmZmY0alBFcnNPcFhIcktpSlZ4dUZEZmF1WFRpVU1ubzIzL1RSVHdk?=
 =?utf-8?B?Qzh6Y1YxMzFkdDlORkxKQ0s4NkRJM1hsSWFjRTArcE5jRkc0Z0tmTU9uK2Qy?=
 =?utf-8?B?cnlETmNvU1JUUHh0YVlTSTMyUS9ncTFkaEt3aGJyVU9GUWxSRGcyYklzTjBJ?=
 =?utf-8?B?ZTA4aDdJTUlvNTBxelpySzRaRnN0U1FVaWIzMnBvckZxTDdxVjhuaDlsTmkz?=
 =?utf-8?B?YzA4a01QaWZoRTJjdHFhbXlxMzhlTXFxbWhKY09NRnVvdDdURFhGSUhjZ2Vo?=
 =?utf-8?B?aGZtUzJjdEZod2pNT1FZZTBEOU5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE6BF263B0F3C841A87C030D42F714F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79ccb9e-a39e-4865-70d7-08d9cad3a712
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 14:01:03.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2mmcyR6dhbn5sd6t92IKKhtkeuPyEt/3nD8E1vf7tedULhaPydIyBqLqjL0J0bWT7JmS5BPRvyrroI8KA5nFnTk2IZJbrzFn3R3pDLWwgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4874
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjcvMjEgMTE6MDEgQU0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDI0LzEyLzIxIDA2OjQ1UE0sIFBvdGlu
IExhaSB3cm90ZToNCj4+IEFkZCBzdXBwb3J0IGZvciB3aW5ib25kIHcyNXEwMWp2LWlxIGNoaXAN
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQb3RpbiBMYWkgPHBvdGluLmxhaUBxdWFudGF0dy5jb20+
DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyB8IDIgKysNCj4+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMN
Cj4+IGluZGV4IGM3ODNhYjRiYTFlNC4uYTJhNzJkMDVmYzI4IDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
d2luYm9uZC5jDQo+PiBAQCAtMTA0LDYgKzEwNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxh
c2hfaW5mbyB3aW5ib25kX3BhcnRzW10gPSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
IFNFQ1RfNEsgfCBTUElfTk9SX1FVQURfUkVBRCB8IFNQSV9OT1JfRFVBTF9SRUFEKSB9LA0KPj4g
ICAgICAgeyAidzI1cTUxMmp2cSIsIElORk8oMHhlZjQwMjAsIDAsIDY0ICogMTAyNCwgMTAyNCwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVB
RCB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPj4gKyAgICAgeyAidzI1cTAxanYtaXEiLCBJTkZP
KDB4ZWY0MDIxLCAwLCA2NCAqIDEwMjQsIDIwNDgsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkg
fSwNCj4gDQo+IFdlIHJlY2VudGx5IHJld29ya2VkIGhvdyBmbGFncyBhcmUgc2V0LiBQbGVhc2Ug
dXNlIHRoZSBuZXcgZmxhZ3MNCj4gdmFyaWFudHMuIFNlZSBbMF0gSWYgdGhlIGZsYXNoIHN1cHBv
cnRzIFNGRFAgdGhlbiB3ZSBwcmVmZXIgeW91IG9ubHkgc2V0DQo+IHRoZSBQQVJTRV9TRkRQIGZs
YWcuIFNlZSBbMV0uDQo+IA0KPiBZb3UgYWxzbyBuZWVkIHRvIHNob3cgdGhlIGR1bXBzIG9mIHRo
ZSBTRkRQIGFuZCBvdGhlciBmbGFzaCBwYXJhbWV0ZXJzLg0KPiBTZWUgWzJdLg0KPiANCj4gWzBd
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L210ZC9saW51
eC5naXQvY29tbWl0Lz9oPXNwaS1ub3IvbmV4dCZpZD1lYzFjMGU5OTYwMzVjOGY5M2VjYTdiYjY0
Y2NmMDQxMWI1N2ZkZGVhDQo+IFsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9tdGQvbGludXguZ2l0L2NvbW1pdC8/aD1zcGktbm9yL25leHQmaWQ9MWM1
MTNjOTg2YjBhNGM3MTUxY2I0NTcxZTU2ODEzNmYxNmM5ZGM1OA0KPiBbMl0gaHR0cHM6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LW10ZC9wYXRjaC8yMDIxMTIwOTE5MDQzNi40
MDE5NDYtMi10dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20vDQoNClRoYW5rcyBmb3IgdGhlIGd1
aWRhbmNlLCBQcmF0eXVzaCwgeW91ciBoaW50cyBhcmUgY29ycmVjdC4NCkknbSBpbiB0aGUgcHJv
Y2VzcyBvZiB1cGRhdGluZyB0aGUgZG9jdW1lbnRhdGlvbiB3aGVyZSBJJ20gYWRkaW5nIHNvbWUN
Cmd1aWRlbGluZXMgb24gaG93IHRvIHN1Ym1pdCBhIG5ldyBmbGFzaCBwcm9wb3NhbCBvciBob3cg
dG8gdXBkYXRlIGFuDQpleGlzdGluZyBmbGFzaF9pbmZvIGVudHJ5LiBXZSdsbCBiZSBhYmxlIHRv
IGd1aWRlIGNvbnRyaWJ1dG9ycyB0byB0aGUgU1BJIE5PUg0KZG9jdW1lbnRhdGlvbiBzb29uLg0K
DQpDaGVlcnMsDQp0YQ0K
