Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34C246E31A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhLIHYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:24:35 -0500
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:60032
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231586AbhLIHYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:24:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+AJjn85Zf8MsoavlJdEYAVyUlR8QPnin9btwMAPbgmK9fixj/5AY/zRdmwIR5XAhIAyqC1IySgMfm1gDc7pfONs7F1k9LnNDRl1ceaeOSLzYXyEBo2I2RZGnYF0LsLZC3Toy0Aif9V4ZMCCzyREH4fUw1EB/2bQKP3VPSH2kHcKmq+kahfw4vDmPkJfmTeBkBZAZcZB3/SoQVPrCpy6xEe8jcOesnShY0GPqQp+iCiNxLNEjaJOLWpONDa1ctZTIdSun60OhuD+ffOW+D15qB5K4LzBUaiklL/8cRCwOQJFpM+1p88G39zVLwVNub9gdVDeHHScycGs59FMTp0p6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zc3YTyNngUgcN48q2spxi4tWrjOA+7POIr+4O0zoHU=;
 b=mbBnYs8rR8Qn/jAARmH7geOxHkD1H3hJtKVZu8LZoHzg5lOGLoMqOICYnoyfroPxJgeWi3dXGyW3SpWP/gSS+LztDdsYkdFH6a8UBINYoqwB7B10KfYmlPaAOEhdwtaNfxCgVehhGByebwKojhPG3m6tIg+AcAP0ds+XbeWW3g4qLgKE1Pkn6e2deRPAyX6MlHBbw+V30hlCbjBstdp4uoKqKgVmpTzshmbvKwV5w3rhTzAqtZdbndELjBPgUQA3rkIi/2KhZ8ypqaBnUQ7QOi7OT6LDaOVe3PvvlosSF/fV6yiHRhWs3unaU/jn7FAw9kVd5s5kn2DKO8U6SmQSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zc3YTyNngUgcN48q2spxi4tWrjOA+7POIr+4O0zoHU=;
 b=l0VD6Ms62w//vfHo/JGi2zX0I9oEKqN+9anfLpNsHgvCO8GT157aDIF0HvVVR67dQdSCKZZR8P+x/n6RmFffFq4rbY1seQnRJRbu5teoq/LvY/L6Kbik4Hj7oLqvrqcMm6SDmTye0NMCTsvf+xb76RvOdmTQvV6FYsNTzCkcm8o=
Received: from SJ0PR02MB7279.namprd02.prod.outlook.com (2603:10b6:a03:2a1::9)
 by BYAPR02MB4102.namprd02.prod.outlook.com (2603:10b6:a02:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 07:20:55 +0000
Received: from SJ0PR02MB7279.namprd02.prod.outlook.com
 ([fe80::f443:babd:3293:bd5e]) by SJ0PR02MB7279.namprd02.prod.outlook.com
 ([fe80::f443:babd:3293:bd5e%4]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 07:20:55 +0000
From:   Harsha Harsha <harshah@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Harsh Jain <harshj@xilinx.com>
Subject: RE: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP SHA3
 driver
Thread-Topic: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP
 SHA3 driver
Thread-Index: AQHX5cfr6to0KPQfhEexxeTWGhF7m6wnl6kAgABwLGCAANopAIAA7DWw
Date:   Thu, 9 Dec 2021 07:20:54 +0000
Message-ID: <SJ0PR02MB727937420272FEBB19BC0D51DE709@SJ0PR02MB7279.namprd02.prod.outlook.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
 <1638262465-10790-4-git-send-email-harsha.harsha@xilinx.com>
 <Ya/SYqbVTPRdch5x@robh.at.kernel.org>
 <PH0PR02MB7271C9F92C667D80AB0A5CA8DE6F9@PH0PR02MB7271.namprd02.prod.outlook.com>
 <CAL_Jsq+FWdOBB6YxUkK1rqGe-WiW6MAcKuQd=CXA4+7fRcF4xQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+FWdOBB6YxUkK1rqGe-WiW6MAcKuQd=CXA4+7fRcF4xQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efc63e65-a701-42eb-fade-08d9bae4705d
x-ms-traffictypediagnostic: BYAPR02MB4102:EE_
x-microsoft-antispam-prvs: <BYAPR02MB41028D9102E6B7675CD668A5DE709@BYAPR02MB4102.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6csLbfVy5kqT7LZrzc3Ma0cX/cKDbftWBRgXX1siST695Bbcn6DOyCzG64WOGgGJkuLnWhMGcfzeti7RphcNfnTmVa1NhzewcDmCyke8KcoqDo8WLSfDES3wt1K5PnYfe1axADhqCDyRMyrbW4jkOapBbeO971+rmQxQJGEoF5T2YOyIZA6+Mu4vjL4UyWg1eOMmdjgFiZyx5W+jZ1YT4NMmTz2MTNJZFwvoLCVYTr09QRhfZkE5gzHzXwfanVabIpU6q4neGBaW7TkiiTwxaQZdyOiJzLXdvAExqC28LzVT76v66STtm8opeEXMnBjfGFpIWaaH+KLcM2/s2NcCEqq9sL1KpUO5AUM0CYnRLLxAxIAiv430affsn1Snxgd/slaVCdq5+MixpoY2pvZK08l26ZB2BkPihhgm7qnLO+AppOr+e4iKq8LUXyBKoXeXfB4DXM+iHxuH9Wqzbl73iTTH+2Lzsz+cnKSrlW4q14MeW01igOjM2QBnhA9EgN6iX4QKff83M7PMhsYAO65Ap8oVEEzXqAaT928J9Rhe55NVL6nZpBb+K8IHz/Irk1PM78MRk106vbLlxPsIUhSI+TPcjp84O787f5kCeZ7A8lxqwx0QIvj29LtphHAOFicFFHtw6egO79XAYfr+QkuBjBILmC0GnHeF6sNQIJGPZ9xBtrhELvihmFXHH9W5yYJpnvtE8jlCz+69VAmosK7bnzGEl7WDZ9DG4zq0uKHH6Fo+m9QDXSDmAELdJadLRRQ5Vr91LngyiG24fakvuBEgOUuPg1LVvtsmmwsLJEvuJJzerNMpM9UL0UXp43qa5QnotgretWkXx44JJflN01ujw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7279.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(86362001)(7696005)(38070700005)(54906003)(66446008)(107886003)(6916009)(83380400001)(55016003)(53546011)(8676002)(33656002)(316002)(6506007)(8936002)(52536014)(9686003)(2906002)(508600001)(66476007)(71200400001)(26005)(186003)(966005)(66946007)(84970400001)(76116006)(66556008)(5660300002)(38100700002)(64756008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzAyallZSncwWlY2NkNxUEtmdlV4TXJXcVVmRkNvMHRXdG9Hcy9xc3FWUUFT?=
 =?utf-8?B?TmxTRzQ5VXRUczY5SGcxSkROM1NxYjdxUnd3cG80dXBRKzJYeVZ0TmpGUEwv?=
 =?utf-8?B?RDV3d2NuQVc2RkJMOG56ZDhqWHYrTjdGVE5EREpPdXY5YXNRL0dNQmlDYzNj?=
 =?utf-8?B?ZllFZ28yY3I3Szc1RnY4THpndnYzeDdNOCtza0xBYlhlZ3Z6dHVrblBpK3Z4?=
 =?utf-8?B?NWlyN1M3MHpTUEd4OWxPdDcxYVVFQ0x2dmN3RklxaHczeHI4UXpCcU9MSk9i?=
 =?utf-8?B?VGh1TXNicnJqTW1ISHBFckFvOTlLQy9uZDhxWDdoNG93MFk2VXpGYWlheWM2?=
 =?utf-8?B?ZUpIZ3NWbjhJMkUrUkJmYnJTbWRYbzBmcUVFSWdjR09DUWU2MXJKYTlFQXJD?=
 =?utf-8?B?T0taSlFtNUswbWpYZW5OUTdWVFoxU0tseEcwaDZ4dTh0UERYMExLcE5tb29R?=
 =?utf-8?B?QnRtckJyZXFaZk05WTd3NGE3SlkrbEF6bHgwcmlQWGR2QUxEZTVEMCt3Q1RF?=
 =?utf-8?B?SkhWajZCczBHd2FSSUxBaHhQOUR5N0lzMVBxbnNDQm9UZ1FmT240a3ljQng0?=
 =?utf-8?B?cEpoTThaV05PR1I2VjlmTEd3V1pOWU1RMDhHUlFGR2Z3UUo3azJCL3VnTHB6?=
 =?utf-8?B?N2NsY01maitMTHRBT3h4VmdsVkhkZVBmVjdDeTdiV1RLblZhQ1c3NHBlY1Rn?=
 =?utf-8?B?L1JWdkJiekVCY0hpYnJLekpzV2I0V1N3T1dseXNjQW04c09MRTdiRVBwYVpi?=
 =?utf-8?B?Qk5DUjYyNFJrUU04TWlPTzY1ZFlJcEhyVXMraTJPeDJpZmpKejk1M3ZSZkFu?=
 =?utf-8?B?RUFGT0RnSW5wL2xzanlTU3VkdWlBVUlyblFSdVl0YWl6ZlQ1RWVCUjVJVGRl?=
 =?utf-8?B?YUNZL0ZQWmYvODN1VGhEUVdJaVlza0dmcGFzUGw0eTRrajlQOEdhTGhlL1BX?=
 =?utf-8?B?WEZmdVM5K2hOdFRiUE0xZTRjS3ZjaklNOGpyL0FpVTFKVE85MzQrY3J1cjcy?=
 =?utf-8?B?dC9UV0NBdk1QcjBLM0RKTUQvcEZPYU9pVVJDOHduQ05CL1laU05TcFVZZXJM?=
 =?utf-8?B?cHRrQXJzQ29GUkUrMXIvMXZPUUpodFZla1ZFbjRSb0o3TDI2U0l2OGRwZ3JF?=
 =?utf-8?B?SlUwVUQ3eWdLMVFNSzBZN1k2YkZaTVZZcFFEQTBtZHIxcGxOQ2Z1YTR4NUxQ?=
 =?utf-8?B?YUo2NXpOeGk0RFpnaTZEMk9WQmRUY3RYVG1yUkZzb3gya1V1dnJwbUdnTnNr?=
 =?utf-8?B?NmpWczhEN3dRY3JZUWQ3YVdaSE1LWDNpaWRHWWozMmVySkk2ZUY5MmlMVWZi?=
 =?utf-8?B?OWNRQ1FNa0JydmpJOWR2VjA0aHhBVWxmT2xxTDdxTXdabUIvMHFJMUZhSWN6?=
 =?utf-8?B?M3QweDluVTBQS2x1cU0xeTZjUG5ZVGpveThBSmhRU0tsZDY0SnEwdGtDSERD?=
 =?utf-8?B?NGNHUFlpazFKUkYrRkVPLzdWMEw1OC9NL05MVWRXSG5Iak5wWCsrZml6RTIy?=
 =?utf-8?B?WmJ2UklMeWphYmthMzNkbGtuQXhpSktldEt5SkdqNzljcWc1eVN2YkJ4WVcy?=
 =?utf-8?B?enNFKzREOG5DYlJQbmhxMjBuMkNFbGtFMElLdmFFY0R6NHp3UnpXaldkdmpQ?=
 =?utf-8?B?YnNCYmU0Ny84TVlRMDF5UGRJUjZFbmZ3SlpLNjliU01Xb1JQcHJaZVRTUTEx?=
 =?utf-8?B?YWtabXUyYmZrK3lhSGNpazJJUitNamV1SkRuQ0c3U0dFVURaT3ZHbnJIcFYz?=
 =?utf-8?B?dDEwMGFYMjQzU2dNV3FHd01rMlR6MWk0T2VXTkE4VlY0WmpQR2YyTkczYk5q?=
 =?utf-8?B?YXBzczdFV3Fqd1ROcnZlVEp0QzdibGdOVE5YdFJ0eDJaekFIQWoxMFNpZWhK?=
 =?utf-8?B?bjQrUGpwSk4ybzdPU2J5T3RCQVlNUkxQSHBYTUQ4V1RKM01IU0ZNalJ6TC9W?=
 =?utf-8?B?ZWROUkZHQ1k0M2wvMFF1S3hSYTFnQU5mOUNpK2w3SCs2K1hERm81d2haSlJ2?=
 =?utf-8?B?S0F5cFBNTjFURTlCOHZROUY5K3VkM1VsUjJLV0l3b3BkTExYb2JmSjR2R24v?=
 =?utf-8?B?Unh1NmhqVWJ2OVo3NHJsb1lENGVmalNnN0QwOFR0NGkvVDdCVzVJcVVuajla?=
 =?utf-8?B?R0orWE1uUnh3eUlzNVVHSFJMa0p5eS95TDdocXBZcjVnWUNEcDltNzdyaVpt?=
 =?utf-8?Q?qxqLXTe+0Gi80O66GIRo0Fc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7279.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc63e65-a701-42eb-fade-08d9bae4705d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 07:20:54.8278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPXva6ush/2l7ICMsOVsJod6Dacb8Lle2v84U596qCCPxl8pEYwf1lWUjC+LVRJO9kvbtk7rGWOJkjinw8zU2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBQbGVhc2UgZmluZCBteSByZXBseSBp
bmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA4LCAyMDIx
IDEwOjQyIFBNDQo+IFRvOiBIYXJzaGEgSGFyc2hhIDxoYXJzaGFoQHhpbGlueC5jb20+DQo+IENj
OiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGxpbnV4
LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1p
Y2hhbA0KPiBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgU2FyYXQgQ2hhbmQg
U2F2aXRhbGENCj4gPHNhcmF0Y2hhQHhpbGlueC5jb20+OyBIYXJzaCBKYWluIDxoYXJzaGpAeGls
aW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMy82XSBkdC1iaW5kaW5nczogY3J5
cHRvOiBBZGQgYmluZGluZ3MgZm9yIFp5bnFNUCBTSEEzIGRyaXZlcg0KPiANCj4gT24gVHVlLCBE
ZWMgNywgMjAyMSBhdCAxMDoxNyBQTSBIYXJzaGEgSGFyc2hhIDxoYXJzaGFoQHhpbGlueC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gSGkgUm9iLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmll
dy4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwg
RGVjZW1iZXIgOCwgMjAyMSAzOjAwIEFNDQo+ID4gPiBUbzogSGFyc2hhIEhhcnNoYSA8aGFyc2hh
aEB4aWxpbnguY29tPg0KPiA+ID4gQ2M6IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDsgbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgTWljaGFsDQo+ID4gPiBTaW1layA8bWljaGFsc0B4aWxpbngu
Y29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgU2FyYXQgQ2hhbmQgU2F2aXRhbGENCj4gPiA+IDxzYXJhdGNoYUB4aWxp
bnguY29tPjsgSGFyc2ggSmFpbiA8aGFyc2hqQHhpbGlueC5jb20+DQo+ID4gPiBTdWJqZWN0OiBS
ZTogW1JGQyBQQVRDSCAzLzZdIGR0LWJpbmRpbmdzOiBjcnlwdG86IEFkZCBiaW5kaW5ncyBmb3Ig
WnlucU1QIFNIQTMgZHJpdmVyDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBOb3YgMzAsIDIwMjEgYXQg
MDI6MjQ6MjJQTSArMDUzMCwgSGFyc2hhIHdyb3RlOg0KPiA+ID4gPiBUaGlzIHBhdGNoIGFkZHMg
ZG9jdW1lbnRhdGlvbiB0byBkZXNjcmliZSBYaWxpbnggWnlucU1QIFNIQTMgZHJpdmVyDQo+ID4g
PiA+IGJpbmRpbmdzLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYXJzaGEgPGhh
cnNoYS5oYXJzaGFAeGlsaW54LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vYmluZGlu
Z3MvY3J5cHRvL3hsbngsenlucW1wLXNoYTMueWFtbCAgICAgICAgICB8IDMwICsrKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+
ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2NyeXB0by94bG54LHp5bnFtcC1zaGEzLnlhbWwNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8veGxueCx6eW5x
bXAtc2hhMy55YW1sDQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
cnlwdG8veGxueCx6eW5xbXAtc2hhMy55YW1sDQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gPiA+IGluZGV4IDAwMDAwMDAuLjQ1YTgwMjINCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL3hs
bngsenlucW1wLXNoYTMueWFtbA0KPiA+ID4gPiBAQCAtMCwwICsxLDMwIEBADQo+ID4gPiA+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkN
Cj4gPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gPiArLS0tDQo+ID4gPiA+ICskaWQ6IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2NyeXB0by94bG54LHp5bnFtcC1zaGEzLnlhbWwjDQo+ID4g
PiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFt
bCMNCj4gPiA+ID4gKw0KPiA+ID4gPiArdGl0bGU6IFhpbGlueCBaeW5xTVAgU0hBMyBIYXJkd2Fy
ZSBBY2NlbGVyYXRvciBEZXZpY2UgVHJlZSBCaW5kaW5ncw0KPiA+ID4gPiArDQo+ID4gPiA+ICtt
YWludGFpbmVyczoNCj4gPiA+ID4gKyAgLSBIYXJzaGEgSGFyc2hhPGhhcnNoYS5oYXJzaGFAeGls
aW54LmNvbT4NCj4gPiA+DQo+ID4gPiBzcGFjZSAgICAgICAgICAgICAgIF4NCj4gPg0KPiA+IEFj
Y2VwdGVkLiBXaWxsIHJlbW92ZSBzcGFjZSBpbiBuZXh0IHZlcnNpb24gb2YgcGF0Y2ggc2VyaWVz
Lg0KPiA+DQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ID4N
Cj4gPiA+IERvbid0IG5lZWQgJ3wnIGlmIG5vIGZvcm1hdHRpbmcgdG8gcHJlc2VydmUuDQo+ID4N
Cj4gPiBBY2NlcHRlZC4gV2lsbCByZW1vdmUgfCBpbiBuZXh0IHZlcnNpb24gb2YgcGF0Y2ggc2Vy
aWVzLg0KPiA+DQo+ID4gPg0KPiA+ID4gPiArICBUaGUgWnlucU1QIFNIQTMgaGFyZGVuZWQgY3J5
cHRvZ3JhcGhpYyBhY2NlbGVyYXRvciBpcyB1c2VkIHRvDQo+ID4gPiA+ICsgIGNhbGN1bGF0ZSB0
aGUgU0hBMyBoYXNoIGZvciB0aGUgZ2l2ZW4gdXNlciBkYXRhLg0KPiA+ID4gPiArDQo+ID4gPiA+
ICtwcm9wZXJ0aWVzOg0KPiA+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gPiArICAgIGNvbnN0
OiB4bG54LHp5bnFtcC1zaGEzLTM4NA0KPiA+ID4gPiArDQo+ID4gPiA+ICtyZXF1aXJlZDoNCj4g
PiA+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gPiA+ICsNCj4gPiA+ID4gK2FkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtleGFtcGxlczoNCj4gPiA+ID4gKyAg
LSB8DQo+ID4gPiA+ICsgICAgeGxueF9zaGEzXzM4NDogc2hhMy0zODQgew0KPiA+ID4NCj4gPiA+
IGNyeXB0byB7DQo+ID4gPg0KPiA+ID4gPiArICAgICAgY29tcGF0aWJsZSA9ICJ4bG54LHp5bnFt
cC1zaGEzLTM4NCI7DQo+ID4gPg0KPiA+ID4gWW91IG5lZWQgc29tZSB3YXkgdG8gYWNjZXNzIHRo
aXMgaC93Lg0KPiA+DQo+ID4gQWNjZXB0ZWQuIFdpbGwgYWRkIHJlcXVpcmVkIGRldGFpbHMgc2lt
aWxhciB0byBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9o
ZXJiZXJ0L2NyeXB0b2Rldi0NCj4gMi42LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9jcnlwdG8veGxueCx6eW5xbXAtYWVzLnlhbWwNCj4gDQo+IFdoeSBkbyB5b3Ug
bmVlZCBhIG5vZGUgZm9yIGVhY2ggY3J5cHRvIGFsZ29yaXRobT8gQ2FuJ3QgeW91ciBmaXJtd2Fy
ZQ0KPiB0ZWxsIHlvdSB3aGF0IGFsZ29yaXRobXMgaXQgc3VwcG9ydHM/IFdvcnN0IGNhc2UsIHRy
eSBlYWNoIHBvc3NpYmxlDQo+IG9uZSBhbmQgc2VlIHdoYXQgZmFpbHMgb3Igbm90LiBOb25lIG9m
IHRoaXMgbmVlZHMgdG8gYmUgaW4gRFQuDQo+IA0KDQpEbyB5b3UgbWVhbiB0aGF0IHRoZSBmaXJt
d2FyZSBzaG91bGQgYmUgc2VsZiBkaXNjb3ZlcmVkIGFuZCB0aGVyZSBpcyBubw0KbmVlZCB0byBh
ZGQgYW55IERUIGJpbmRpbmcgZm9yIHRoaXMgZHJpdmVyPw0KDQo+IFJvYg0KDQpSZWdhcmRzLA0K
SGFyc2hhDQo=
