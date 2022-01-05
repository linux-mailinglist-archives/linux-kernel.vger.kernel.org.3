Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD0484DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiAEGEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:04:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59100 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiAEGEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641362659; x=1672898659;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DZlnUNCarf+qAzIqlNZ7Ik+eXbSLtDsSZATRj7SIx30=;
  b=ngCIeXFC1PSJhVJIcWGsZY7b5+Tefl7eYqWL5TLXOeC5p4xEJ2f/g1Kl
   UaIdwTdC0GXSnS/i91u5X181C09e+ylEe/CpmPZfRDD+gZS/E30qonk/e
   ocO3Pad0pdB7gieV5/9Rxx3O79BpytMerjzNGjVtOu9cTKn5F8GnAUVXL
   3W1aUati4wSMI2mIr4UJam8qjYb9YH0ka0tqXjgkH2r/bSZ0IWdwilDfs
   tGrmDFBqrxwQ2Ar4iNxADbKqIbGpvNa7s8V6TLHpzfSSMi/l/WfXEWcW4
   rVHVzJCKV7wOHcEnL8s0cCjmU6HA/d0z1LtCFO+EgK8NCzriycm1cGiqu
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,262,1635177600"; 
   d="scan'208";a="194523599"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2022 14:04:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUubo7Gk3TxX5vdPu55935UO2raFLcS36LpcXcy+lbcKyPrTUEXn5TWeR/8ClcOR3HzsaobbjsPj3X90w0g8wyY/f0a+rrTcjuM3Z3ITJVjH9ueGqOhbTFYhCL7q3JUSFvEaiAhbqpPpu3d455WY4+3D1VTCxQuFZIfCnfXTve1MR3ZGH32CH2/6EbKEjkC4vDHc2rOvANfelTiUU9AzduFprqGbnaT2Zz/LmFNhggXfnd4D7SDttwu1aDzYWOvrp667WmjNEIc4SF/CZxymBHF1yu4WlQAySKkRlRf7YWON95WeUYg7sQLSCwWOp0VOMDRiFqXzNfvAUYrokun8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZlnUNCarf+qAzIqlNZ7Ik+eXbSLtDsSZATRj7SIx30=;
 b=QZwhUHQKMin6MWaaaXVMrwBzqhSGDDmGzQo1athTGePEifhrqqeLsfr+ToE88cmLidp/eLldBwOXRd1zavAV1SC8UDzW9I+sncQyQYij29ZR15HUf7TZq79qKbWlMfVhlSEQSQhcNW1IxqdQ/gumotKn9Ql1Z2n+XZbNS8VIXsXv3dcCPzCBljzdmm+n8Zgy449M+PGZqoZhmDL1z+72IiH3+H53EjEUOs4KnYOBqaQXkwTeyPQvWdibv05nT8Vu5A7J29x6ExlnXx/WHVMnkkj5JWBjaWnjRNEECas3MFYOwlhSfO/Re7CfN5ljCs9KETr5qkBjjIQ7uNU/7fc5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZlnUNCarf+qAzIqlNZ7Ik+eXbSLtDsSZATRj7SIx30=;
 b=AF1qF1rWmT8vg2ngDz20XSAEGIqEUgZibjYcYkVKdqeH2l2XW49VziSJH3Fwuqckk+dFd31bUi4bHDdgf7swz3/IsetGW7ybnhNJ0u7t1VEILso+I98uT+hxGkXdQh9YfF4hHy+0vVRFMNcSv+zKsjOaIBVVaDnFz1/fu16Dxb8=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB1242.namprd04.prod.outlook.com (2603:10b6:4:46::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Wed, 5 Jan
 2022 06:04:20 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e58a:8ae5:2f73:35ea]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e58a:8ae5:2f73:35ea%9]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 06:04:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "haowenchao@huawei.com" <haowenchao@huawei.com>
CC:     "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH demo] ata_scsi_queuecmd: Make input parameters check more
 clearly
Thread-Topic: [PATCH demo] ata_scsi_queuecmd: Make input parameters check more
 clearly
Thread-Index: AQHYAWwKXcNUd2vYRE6Tz2TuzRbC/KxT8U0A
Date:   Wed, 5 Jan 2022 06:04:19 +0000
Message-ID: <c40f2d6e11cfd428fc59e89b8d7b536d5808af2f.camel@wdc.com>
References: <20220105021704.1679067-1-haowenchao@huawei.com>
In-Reply-To: <20220105021704.1679067-1-haowenchao@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2 (3.42.2-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72666d75-af18-48f4-7bac-08d9d01136ae
x-ms-traffictypediagnostic: DM5PR04MB1242:EE_
x-microsoft-antispam-prvs: <DM5PR04MB1242167C085406CFB70839BFE74B9@DM5PR04MB1242.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PVLUC4ZBGubWQvP57CZsAmG84b/yLZsUEIc7Nakz0Wvffbngt6LJ6uUHlvSY47nbOUtFAeFFCcNOmAWH0Qu5HrLVTz0zlgx80HpnWkRIDL3CnJKFB2Bfhi1IHpX23xzvaCCi959Qg4iXlElAVeOCDH5an3JBxBH93t/HBTMKNbhxGnAiamOyMDlQMDBEXxsLlfYlI6TEXCUS5+z8t0eXcUQ3uzg/KkkQ3k18IwGzSKhl7k5+A++ws5kuE/vuAA0EEzxtwTKYxIPkvbHrABGJpBRjOrHV6UkRwryC6pwCHwSLS7+NeSDazDSe1XRUsrPy1wi5MvjzosVSpVL9VFECmTv4nIUGQtwNN6zYJf05nBdFGYxmJNxCD/Vt86YYJ7DxGlGdYx6b/i9HcDMDYJ+gd6J6ZWVgOStEtVUIFVjohR1o0HoIOpvpXhfNIu08rvSSy4GFusl3JsCpq1zxVSK0ct6gxXoUhE0IGjo7++HRt/EDGTmJHyIAZ6F1/zARUkVY9U38JpVgqyKP1P5qYff3t61lVFKoAPykmDpYSE8LHGdOsG1GZWiGjrAy87BsHohAzefW/+Hl5v2JwrsOjXEIth15TwC+WOa9wyRcOFWkJ7Enf9wwPOORsZsCZDIvIkWvuDtJxbMWgVmL40K9HqoiItk/YFfkq3Dn9BiRFzkJJw7+YmqwJXZH1jvA0aM0TnOeOJLfg/rUyz1IvYHaW8d4XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66446008)(71200400001)(91956017)(508600001)(66556008)(66476007)(76116006)(64756008)(38100700002)(122000001)(6486002)(86362001)(316002)(5660300002)(6512007)(82960400001)(4326008)(36756003)(6506007)(2616005)(2906002)(110136005)(8676002)(26005)(83380400001)(186003)(38070700005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVVDeUl4VU1DczBBVzM4TWNxVXFYQXVQMDExUmZuRFcrQm04WTJXM2FIV3Fh?=
 =?utf-8?B?R0hPdm95NThoZmFkNkxQWDJwZlA1L05UL0ZUSUc3cHZPR2xkVnZpRU1LekRo?=
 =?utf-8?B?K0JGd1hScmhFcWxEUnp5RytDYXA2bHdaODF6SVJoeVBIczlnZnlaNXExdXox?=
 =?utf-8?B?K3ROanltRk5sMjB4ckQvUnBRd2VpVUpqYzdob0JGZENHNjlOMlRVN1ZFeXp3?=
 =?utf-8?B?UWVrSWQvODJXYWh4RjZZZCthWk4xK1ZkcWpCeEtRRVVIUHNVRFNMMWRCbE1O?=
 =?utf-8?B?R0ptMVUwSUttRjIyOU9GcVMzUk9USW5haEpFdmZ6N0ZBdTVSK21hR0tnUWdD?=
 =?utf-8?B?amplVUcvOHA0Wk8zWmw3UTBFZTBmMHVsZHZ5b0lkc0N6cWE2aVZyS2Rvd0I2?=
 =?utf-8?B?UDNFQXJ3UnFQUjhRQ28vNVBYSVpsYTZUQUZJbElIWVZoa2ZFVVg2UHJNNUI1?=
 =?utf-8?B?YXZoQzFnZXZnRk9JUXBESnRlbUtRNklQMzFZUE9TaUFwdVkwMDF6ZXE4NjZV?=
 =?utf-8?B?ZEcyZXRVdFR6QXhyTzdHVGtWQzN1czhHWnQxaGlNamNZYktpK3dCbGpTL3Zx?=
 =?utf-8?B?UzEvWkgvY1hkeTRWK3BJRWlVVTQ4SzNtZER6S3hTZU1wa0J4TDBRbFhYRXV0?=
 =?utf-8?B?aTVQa2hXTnlmRDZNRkFxNjFudUVjZkR4RlRwcEFLSUtQZWRnSHRvL09CdVFM?=
 =?utf-8?B?WkRSajNXcWxMN2xzZkNqM010SFNNVHBuMU9mUXNPVmd1UDY4ZDdOMFNvVkhQ?=
 =?utf-8?B?ZHdXNC9NdXpFS1piRU1VTEFXemhsMmVkc3NvZnJsVjZoU1h3VVdHKzY1SzEv?=
 =?utf-8?B?WVZValM2YWFwZG4vWVRNZWVvTXA1U3hINmovYUhucDNWeFg1eUEvcFUwdWVk?=
 =?utf-8?B?VWt1a1Y4QXZvOWJNWUtWS25wWFJFVVhKaStZZXpkdkc3dndmSExHdll5TlFP?=
 =?utf-8?B?cWVTcUJ3T2xRaElmY3pDQm56NmNPSGF3TlF2REpoR0M1U1FUSFVpdjVWSHRm?=
 =?utf-8?B?NXJ3Wkw1ODNRTHlTTUh0cjlkNkpWZUlyNWs4NWprUzRWQWx1b3hPYTRsNEFY?=
 =?utf-8?B?RCt6TWdiRlN6a2IwT2lIYmh4cDZGcituWDl2ekJBYUJLc2lzZ3hLejhFdkxv?=
 =?utf-8?B?dGs3L2pwbDlHNVlOc3FvUjdVL1BWWnh2Z2FZaXhTUXlTMHFORm1OU01lcW5D?=
 =?utf-8?B?MThDcDZMODJzb3czVXgrVFA2SjhndDcvK0pWY0l5OHF5VDlnVGVnL3pJZFN5?=
 =?utf-8?B?eUJGV2dRUE51N2tBVEM2NW56YWVFcWpkc1B0Z08xWlJhV3p2R3p5bmt6M0Fh?=
 =?utf-8?B?bGMrWWc3WTZ2L0c5NXZ0VitacGRBTWJQTm9tc21NZk5MWWtBYzNkUUE4Q21x?=
 =?utf-8?B?UlhoajFaODF3MjBlMXBwQXVsNktDNHRRVndHRUpqVjdKaDBxSWVjS24xNTho?=
 =?utf-8?B?Y0xSd3lsdHhhNEZFZkJKUVkvVHIyb0VFNEpOcGxOVVQvcDRVWUdsK1NMV0tI?=
 =?utf-8?B?OXZwUU1LRWRJWEdtT2QxUVBMUU54SmFCaklFWUNRMU1jUkhYdjFlcXZrcmpp?=
 =?utf-8?B?dFJBK1BQT3J6QTZ1OUl5dE43VXRoaW51bFVSSmZEWEUxM2pSaXBxRzlkVkdw?=
 =?utf-8?B?NnRXcy9KWkR0S2xWWWUyWmpxdHI5QlRBV2tHL0RQTy9tU1EraGtYZlBHbEFN?=
 =?utf-8?B?elhzdEFKem1OeWVSaW1yZUNPTy8xbVcrUFU4M0NOQjBVU3NXdjVDM2hGOGZO?=
 =?utf-8?B?QlhrMzdpN2loZ0VJazIzSHIyVmk2K3BnY2lNS1ZWSHN0Um9IMzRGdGF4cUcz?=
 =?utf-8?B?Q2orWVQ5TzlvOWxLbzF2b3pneWdGM2RjZ28zQjAyZHNwbmc3ZSs3Mm9ld1JE?=
 =?utf-8?B?dFU2YkovSDJGQWFNcE1zdnNDSTVVUU1KdGVkNmxaOHBYQW8xR1VsWkJUaG5k?=
 =?utf-8?B?eTVHYmZrdDBYMXRidTBWMUhtUTJtQmNwZmRMeWFvV1dwSFVzRGVZdE1HZEJs?=
 =?utf-8?B?Yi9rL0ZCTmVyUzF1S3VRVk9nbkxrMGROWGRtZzdqZStJVXJ6U2N4RHV4UTZs?=
 =?utf-8?B?Zm0zVWFUZ25OZER2QUUyZXFFVFdHeEliQWxzQVhjanRyRGEraGdtMEY0aElP?=
 =?utf-8?B?QmdyQUNKVll1Mi9hUWtPNDdKYy9TYTBzcmNodDJNdzVQOWtoYktXS3JQWlNS?=
 =?utf-8?Q?CfjA0SByNSo7DRr38cD5Gtva/a1N+8laZSltko3/IZZU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8F913230D57DD4BB7D0775C3981A7BF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72666d75-af18-48f4-7bac-08d9d01136ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 06:04:19.8655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nakq3NgrntjEmRZxkp47sKzUk3O70S34vxQ+TqIl2zG4z+cM+C1s9nhSeIWGYVjEIay2LZjCfm2dtAYMGACxFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVzZW5kaW5nIG15IHJlcGx5IGFzIHRoZSBzZXJ2ZXIgbXg1Lmh1YXdlaS5jb20gYm91bmNlcyBi
YWNrIHRvIG1lIGFsbCBteQ0KZW1haWxzIGZyb20gQG9wZW5zb3VyY2Uud2RjLmNvbS4uLiAoZXJy
b3IgNTU0LCBidXQgU1BGIHJlY29yZCBpcyBjb3JyZWN0ICEpDQoNCg0KT24gVHVlLCAyMDIyLTAx
LTA0IGF0IDIxOjE3IC0wNTAwLCBXZW5jaGFvIEhhbyB3cm90ZToNCj4gVGhpcyBpcyBqdXN0IGEg
Y2xlYW4gY29kZS4gU2luY2UgZWFjaCBicmFuY2ggb2YgImlmIiBzdGF0ZSB3b3VsZCBjaGVjaw0K
PiBzY21kLT5jbWRfbGVuLCBzbyBtb3ZlIHRoZSBjaGVjayBvZiBzY21kLT5jbWRfbGVuIG91dCBv
ZiAiaWYiIHN0YXRlIHRvDQo+IHNpbXBsaWZ5IHRoZSBsb2dpYyBvZiBpbnB1dCBwYXJhbWV0ZXJz
IGNoZWNrLg0KPiANCj4gVGhlIHBhdGNoIGRvIG5vdCBjaGFuZ2Ugb3JpZ2luIGZ1bmN0aW9uIGxv
Z2ljLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VuY2hhbyBIYW8gPGhhb3dlbmNoYW9AaHVhd2Vp
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2F0YS9saWJhdGEtc2NzaS5jIHwgMTEgKysrKystLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYXRhLXNjc2kuYyBiL2RyaXZlcnMvYXRh
L2xpYmF0YS1zY3NpLmMNCj4gaW5kZXggMzEzZTk0NzU1MDdiLi4xYzY1M2I1MzI3ZGIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMNCj4gKysrIGIvZHJpdmVycy9hdGEv
bGliYXRhLXNjc2kuYw0KPiBAQCAtNDAyMCwxOSArNDAyMCwxOCBAQCB2b2lkIGF0YV9zY3NpX2R1
bXBfY2RiKHN0cnVjdCBhdGFfcG9ydCAqYXAsIHN0cnVjdCBzY3NpX2NtbmQgKmNtZCkNCj4gIGlu
dCBfX2F0YV9zY3NpX3F1ZXVlY21kKHN0cnVjdCBzY3NpX2NtbmQgKnNjbWQsIHN0cnVjdCBhdGFf
ZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJdTggc2NzaV9vcCA9IHNjbWQtPmNtbmRbMF07DQo+IC0J
YXRhX3hsYXRfZnVuY190IHhsYXRfZnVuYzsNCj4gKwlhdGFfeGxhdF9mdW5jX3QgeGxhdF9mdW5j
ID0gTlVMTDsNCg0KTm90IG5lZWRlZC4geGxhdF9mdW5jIGlzIGFsd2F5cyBzZXQgZm9yIHRoZSBu
b24tZXJyb3IgY2FzZXMuDQoNCj4gIAlpbnQgcmMgPSAwOw0KPiAgDQo+ICsJaWYgKHVubGlrZWx5
KCFzY21kLT5jbWRfbGVuKSkNCj4gKwkJZ290byBiYWRfY2RiX2xlbjsNCj4gKw0KPiAgCWlmIChk
ZXYtPmNsYXNzID09IEFUQV9ERVZfQVRBIHx8IGRldi0+Y2xhc3MgPT0gQVRBX0RFVl9aQUMpIHsN
Cj4gLQkJaWYgKHVubGlrZWx5KCFzY21kLT5jbWRfbGVuIHx8IHNjbWQtPmNtZF9sZW4gPiBkZXYt
PmNkYl9sZW4pKQ0KPiArCQlpZiAodW5saWtlbHkoc2NtZC0+Y21kX2xlbiA+IGRldi0+Y2RiX2xl
bikpDQo+ICAJCQlnb3RvIGJhZF9jZGJfbGVuOw0KPiAgDQo+ICAJCXhsYXRfZnVuYyA9IGF0YV9n
ZXRfeGxhdF9mdW5jKGRldiwgc2NzaV9vcCk7DQo+ICAJfSBlbHNlIHsNCj4gLQkJaWYgKHVubGlr
ZWx5KCFzY21kLT5jbWRfbGVuKSkNCj4gLQkJCWdvdG8gYmFkX2NkYl9sZW47DQo+IC0NCj4gLQkJ
eGxhdF9mdW5jID0gTlVMTDsNCj4gIAkJaWYgKGxpa2VseSgoc2NzaV9vcCAhPSBBVEFfMTYpIHx8
ICFhdGFwaV9wYXNzdGhydTE2KSkgew0KPiAgCQkJLyogcmVsYXkgU0NTSSBjb21tYW5kIHRvIEFU
QVBJIGRldmljZSAqLw0KPiAgCQkJaW50IGxlbiA9IENPTU1BTkRfU0laRShzY3NpX29wKTsNCg0K
SSB3b3VsZCBnbyBmdXJ0aGVyIGFuZCBjbGVhbnVwIHRoZSBpZiBlbHNlIHsgaWYgZWxzZSB9IHNl
cXVlbmNlIHRvby4NClNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2F0YS9saWJhdGEtc2NzaS5jIGIvZHJpdmVycy9hdGEvbGliYXRhLXNjc2kuYw0KaW5kZXggYTE2
ZWYwMDMwNjY3Li5lZDhiZTU4NWE5OGYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2F0YS9saWJhdGEt
c2NzaS5jDQorKysgYi9kcml2ZXJzL2F0YS9saWJhdGEtc2NzaS5jDQpAQCAtMzk1OCw0MiArMzk1
OCwzOSBAQCBpbnQgX19hdGFfc2NzaV9xdWV1ZWNtZChzdHJ1Y3Qgc2NzaV9jbW5kICpzY21kLA0K
c3RydWN0IGF0YV9kZXZpY2UgKmRldikNCiB7DQogCXU4IHNjc2lfb3AgPSBzY21kLT5jbW5kWzBd
Ow0KIAlhdGFfeGxhdF9mdW5jX3QgeGxhdF9mdW5jOw0KLQlpbnQgcmMgPSAwOw0KKw0KKwlpZiAo
dW5saWtlbHkoIXNjbWQtPmNtZF9sZW4pKQ0KKwkJZ290byBiYWRfY2RiX2xlbjsNCg0KIAlpZiAo
ZGV2LT5jbGFzcyA9PSBBVEFfREVWX0FUQSB8fCBkZXYtPmNsYXNzID09IEFUQV9ERVZfWkFDKSB7
DQotCQlpZiAodW5saWtlbHkoIXNjbWQtPmNtZF9sZW4gfHwgc2NtZC0+Y21kX2xlbiA+IGRldi0+
Y2RiX2xlbikpDQorCQlpZiAodW5saWtlbHkoc2NtZC0+Y21kX2xlbiA+IGRldi0+Y2RiX2xlbikp
DQogCQkJZ290byBiYWRfY2RiX2xlbjsNCg0KIAkJeGxhdF9mdW5jID0gYXRhX2dldF94bGF0X2Z1
bmMoZGV2LCBzY3NpX29wKTsNCi0JfSBlbHNlIHsNCi0JCWlmICh1bmxpa2VseSghc2NtZC0+Y21k
X2xlbikpDQotCQkJZ290byBiYWRfY2RiX2xlbjsNCisJfSBlbHNlIGlmIChsaWtlbHkoKHNjc2lf
b3AgIT0gQVRBXzE2KSB8fCAhYXRhcGlfcGFzc3RocnUxNikpIHsNCisJCS8qIHJlbGF5IFNDU0kg
Y29tbWFuZCB0byBBVEFQSSBkZXZpY2UgKi8NCisJCWludCBsZW4gPSBDT01NQU5EX1NJWkUoc2Nz
aV9vcCk7DQoNCi0JCXhsYXRfZnVuYyA9IE5VTEw7DQotCQlpZiAobGlrZWx5KChzY3NpX29wICE9
IEFUQV8xNikgfHwgIWF0YXBpX3Bhc3N0aHJ1MTYpKSB7DQotCQkJLyogcmVsYXkgU0NTSSBjb21t
YW5kIHRvIEFUQVBJIGRldmljZSAqLw0KLQkJCWludCBsZW4gPSBDT01NQU5EX1NJWkUoc2NzaV9v
cCk7DQotCQkJaWYgKHVubGlrZWx5KGxlbiA+IHNjbWQtPmNtZF9sZW4gfHwNCi0JCQkJICAgICBs
ZW4gPiBkZXYtPmNkYl9sZW4gfHwNCi0JCQkJICAgICBzY21kLT5jbWRfbGVuID4gQVRBUElfQ0RC
X0xFTikpDQotCQkJCWdvdG8gYmFkX2NkYl9sZW47DQorCQlpZiAodW5saWtlbHkobGVuID4gc2Nt
ZC0+Y21kX2xlbiB8fA0KKwkJCSAgICAgbGVuID4gZGV2LT5jZGJfbGVuIHx8DQorCQkJICAgICBz
Y21kLT5jbWRfbGVuID4gQVRBUElfQ0RCX0xFTikpDQorCQkJZ290byBiYWRfY2RiX2xlbjsNCg0K
LQkJCXhsYXRfZnVuYyA9IGF0YXBpX3hsYXQ7DQotCQl9IGVsc2Ugew0KLQkJCS8qIEFUQV8xNiBw
YXNzdGhydSwgdHJlYXQgYXMgYW4gQVRBIGNvbW1hbmQgKi8NCi0JCQlpZiAodW5saWtlbHkoc2Nt
ZC0+Y21kX2xlbiA+IDE2KSkNCi0JCQkJZ290byBiYWRfY2RiX2xlbjsNCisJCXhsYXRfZnVuYyA9
IGF0YXBpX3hsYXQ7DQorCX0gZWxzZSB7DQorCQkvKiBBVEFfMTYgcGFzc3RocnUsIHRyZWF0IGFz
IGFuIEFUQSBjb21tYW5kICovDQorCQlpZiAodW5saWtlbHkoc2NtZC0+Y21kX2xlbiA+IDE2KSkN
CisJCQlnb3RvIGJhZF9jZGJfbGVuOw0KDQotCQkJeGxhdF9mdW5jID0gYXRhX2dldF94bGF0X2Z1
bmMoZGV2LCBzY3NpX29wKTsNCi0JCX0NCisJCXhsYXRfZnVuYyA9IGF0YV9nZXRfeGxhdF9mdW5j
KGRldiwgc2NzaV9vcCk7DQogCX0NCg0KIAlpZiAoeGxhdF9mdW5jKQ0KLQkJcmMgPSBhdGFfc2Nz
aV90cmFuc2xhdGUoZGV2LCBzY21kLCB4bGF0X2Z1bmMpOw0KLQllbHNlDQotCQlhdGFfc2NzaV9z
aW11bGF0ZShkZXYsIHNjbWQpOw0KKwkJcmV0dXJuIGF0YV9zY3NpX3RyYW5zbGF0ZShkZXYsIHNj
bWQsIHhsYXRfZnVuYyk7DQoNCi0JcmV0dXJuIHJjOw0KKwlhdGFfc2NzaV9zaW11bGF0ZShkZXYs
IHNjbWQpOw0KKw0KKwlyZXR1cm4gMDsNCg0KICBiYWRfY2RiX2xlbjoNCiAJc2NtZC0+cmVzdWx0
ID0gRElEX0VSUk9SIDw8IDE2Ow0KDQpBbHNvIHBsZWFzZSBjaGFuZ2UgdGhlIHBhdGNoIHRpdGxl
IHByZWZpeCB0bzogImF0YTogbGliYXRhLXNjc2k6IC4uLi4iDQoNCi0tIA0KRGFtaWVuIExlIE1v
YWwNCldlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA0KDQo=
