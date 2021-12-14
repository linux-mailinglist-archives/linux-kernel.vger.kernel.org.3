Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B36473D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhLNGUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:20:04 -0500
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:31905
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230359AbhLNGUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:20:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK0Hli48BeEDdRZBnqz5cIsC2a0O4WOC0znQQgNUaSTEnb0RdP6di3thtCqyQvdfF+Wlo3UcYZtnrVP3APF828xEl4T667IWSo83ZBnUTYpi7ulpCas16v9ZIWkIAhjNqoG8GUxyTBO/XXVwvQf5cFwiTUI94W+oThwRnqjOg+acdEFToRKVXOpNpjQchDPuM7r819FZ84WmWFUai25nK4Q/MszE6+661t66+uI0LaVV5z2gni6GL6dRfEGM1AJ1jUi7zQ3x5RyGN5uoqD6gBt6ettJsPOZP9yLmP6lGmXqeHNsSeIrXKXmWnEFkCfPI1kh0a7050eavdLZvoH06Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhmoCuAFSni3Pjc/4zkAVKQ1b2Vr/N/LYLcGPhyRokM=;
 b=P8weKPJ/Qr4JpcaGZVOLiqQ6t9GjpC0gE/BOBY3eDIG9PpMlSzXJeMhybx0q4PHmiIu1qfk8jHE8e4g++UFGyatT8Bvd0+EaC5Uokmp9JGlrMbZHVv7NVIX3127yPrmmgx6Ga8SXQsJksp03Lp+4nefG49h13HcFmAMbY0+M8zjkTfoAqv1jKRZ64tgTopo95tCLQbPAss0b/VuMmwIZ7txL9MD+4MeerQNws1bMTzYtk4I2jqiVtYD4hIObCe9EmJq25j/gxT+o3syft9Wfe/qID1DniNTW/ITbcK0kHKsHQMjBwBdhWNIUNV/YI9Vjov4y3h80n/L+PeifzflNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhmoCuAFSni3Pjc/4zkAVKQ1b2Vr/N/LYLcGPhyRokM=;
 b=BZsJ0RJJoOCRVfPF44YFUdX/YkdHnnw15Tg33rlVRCnNQluptHVbIhUx3c9pVhafIKtn2f2n5gZxfsU7xY8D/CiJG2nZG9IKMG7/Km1b3Rv2uaaOLjP7dBxeb4bVWe1pdzlxyyG3zzNVuXF2mXbg/KIEJnLU02M2Y6GrYksT1wo=
Received: from PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 06:20:01 +0000
Received: from PAXPR04MB8816.eurprd04.prod.outlook.com
 ([fe80::11b9:890:dba4:8243]) by PAXPR04MB8816.eurprd04.prod.outlook.com
 ([fe80::11b9:890:dba4:8243%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 06:20:01 +0000
From:   Biwen Li <biwen.li@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/8] arm64: dts: ls1028a: add ftm_alarm1 node to be
 used as wakeup source
Thread-Topic: [PATCH v2 2/8] arm64: dts: ls1028a: add ftm_alarm1 node to be
 used as wakeup source
Thread-Index: AQHX8LIl9UTZX1Zrz06NcL+BuWTWoawxgxhw
Date:   Tue, 14 Dec 2021 06:20:01 +0000
Message-ID: <PAXPR04MB8816CF4DA72C45300F99D3498F759@PAXPR04MB8816.eurprd04.prod.outlook.com>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
 <20211204001718.8511-3-leoyang.li@nxp.com> <20211214054619.GI10916@dragon>
 <AS8PR04MB89463CB1B95BD7C4333BE7DC8F759@AS8PR04MB8946.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB89463CB1B95BD7C4333BE7DC8F759@AS8PR04MB8946.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5f31f8d-fe65-4d96-d621-08d9bec9c299
x-ms-traffictypediagnostic: PAXPR04MB8880:EE_
x-microsoft-antispam-prvs: <PAXPR04MB8880225F8EA39A5F77B6D87E8F759@PAXPR04MB8880.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFcqsW/Ams7mL4EhEYpEZNos0O3IhbrV5WUr5N3WgE9C0lRUywcfsIHJd0eq7LXeYuGiQ7AHYQuJUVG4xwB6jMdKK9tXZUK4KIGjQF4fcIq8qTLPBAH2Ox2g4rUKzr1Fn7x3FEOc0kIzu9YhT1MpVX+C1116dh9zuE1ygq/B0u0h+qpBT0WqcNO83KQWtEhX3gh1XU03BzJZ9qaDq7OHnhoiZvE9P9rp6BSBhFD+v9RDJThekfHiEYmEf8g3t2i7VGu4AdLyhCXD2i8Ds1Kc88G1GVXMf0JjF69jODJzuPwvEiiF9yiaDOVxfXgsORlF6maVzIbss4IdY5vIwlbHizf8D0/IHhOyIjS82qjHGKBoxHCjKBK4UhBy1mV1NQMysHmcZKfs1/7/v6q50majgIPrwmK4sG72MIpt1G72ax1Kj1yqYcPJD3HdLUcvjUX+EoYeZgb4N9kSAAfaT0lHd49raaSkqcUgKWtG1scMZDuxpZVKYE+plOldAe0eQPIDjpee3Mh0wt+j7sYQ4tFHI5NdYGOlBl08L/viGUvis+pRYi+QFa/J9mOWrvaViESFCPvVUsB6gLZvioWXQRKpRBfWPrUazSVXi4P+bZXVosEnlAsCnU54/ck0W6uHVm08BY1bHZe6Kh2xzCOc160LGwA6i0A2GVAoByIdduYM5sbB+7sbxI8bPrHmfXlQqAempzdTCMfzUJtSl0fTYa+5fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8816.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(508600001)(5660300002)(26005)(53546011)(7696005)(52536014)(54906003)(8676002)(6506007)(9686003)(110136005)(38100700002)(44832011)(71200400001)(38070700005)(122000001)(2906002)(76116006)(8936002)(64756008)(66556008)(66946007)(316002)(66446008)(66476007)(33656002)(55016003)(4326008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YlFhMGUyVzZHSDI2SWlwa0RzalVubGg5MzR3S1JpcXZxdUVzNnJQSE5zeGhp?=
 =?gb2312?B?WHYrZHBSMnZVTGxXMm1ZL2VHRVErYzhWdUVmTFN3cVUyVkFsR3RoYlJwdzZW?=
 =?gb2312?B?dUtFVkdTZkl1bGc2OW13aDQ5ZG9ZVnhxMWhMczZpWSs5ZktMd2pLR29UYmgy?=
 =?gb2312?B?NjJzazZhcmIwTUVsQW1HdjNVQ3ptZmlVUFMrNnIwWDJlSkRNTDlNN0lGQW11?=
 =?gb2312?B?N05LSUlMZjFtZWNqVndkVG44Q1pwN3BrKzQ5UFNrOCtPRkJra1RQalJ3TnZn?=
 =?gb2312?B?RGZkeGxRWXlMVHUzNENFdXo1Z2hwZ25nNkxSM2dYK1VSVnBmanRYdEM2ZVNo?=
 =?gb2312?B?UEVEWFliSUo1QmQzdUx5U2NXdnZuVzBRYU5tRVBGMk1wK0lOVVllQTRZdXBT?=
 =?gb2312?B?dHA1VUt4WHhmRE5Bak93Yzd0N2NDNTMwK0F6L2dRV1U2ajFNamd6dUEzOVZJ?=
 =?gb2312?B?NEcxTTloY3FTUnNLSG16REp3ZHVDKzd0NXJYZkNack53bmJMcUI4b2JKMWhB?=
 =?gb2312?B?VGxjTkxBSDlTSFBiMk90LzNPdWZDNDJ6VytOQTFYOWdEc1N0QVJ4Z3BWY1Fh?=
 =?gb2312?B?QXFnTmo3UGJJc1pqS015aVZOeCsxSGxNbG1CUHRzZnE4azh1UjE5SVFPSU5v?=
 =?gb2312?B?QkE2UWZhTVNpVVBHUk9NeldkZzFiOE4xNnVzbVpZdUlVc1ZtbFlsRVZOMTQ1?=
 =?gb2312?B?dUFQcWpJdnY1SDV5clZZYXk1MFZqaTd0NmpwUWtrdGJOaUlHaldwcnp0RDQv?=
 =?gb2312?B?NkFzT1BDREVkS1RJd0sxTnVpVmE1aC90cTF0cDFhUTNwcmlYNnJQR2I4c2kw?=
 =?gb2312?B?bnZDZXdoMU1ZbzVQMUFySVIvOUxJdjVuUjBxQ3ZlSXl0RlRnL0d4YkpVOCtE?=
 =?gb2312?B?dEl2bFE5QVNuUjlMcHlyb0l3ZDNQSDR6S2xPU21teWpZcThqSk1ZQVFyQVhq?=
 =?gb2312?B?TGxoVkpCb2ZEKzZUMUVnOXBIYjN5d3BScHJtVWNZeENIenN5VGI3OEFXTlRF?=
 =?gb2312?B?djJoeWRnb1EzaUI3RDBQYmF2c29NZ3c3RTUrN3FDNFpPbVdEb1dsUUZib3Jp?=
 =?gb2312?B?YUtJUmFaY3JvQkNJOGF1UDlJMGh1Znh3WTU1S1ZUaXdVU1R3MUFBMlB6N0dq?=
 =?gb2312?B?SDVFdC9OOXNkYjNVdUNraXJJYXNhSk45bUZHbEEzTGlUSkxXMW9TdmJHRkx3?=
 =?gb2312?B?YjM2aGZLN3psbHgwRHhxVXRJVGExUXdHTEFMb3l2cHU1TFZJTER5VjR3UjV4?=
 =?gb2312?B?VmFZUlB0SzVIejFDWFpkWEhaRjNGdmhNK0lSRTl3S0NzQWxENDlwbkJERjNv?=
 =?gb2312?B?WGEyWUdqRWlzWE92bmRYTStDYnVVWDN3K0plMkZVUlFxdkg5dVFkWHk4c3hs?=
 =?gb2312?B?WkJrQzlKTFpXR0xMNmJoU0tCNHFPODZhWEN2N0F0bDBxTUpZU0ttUUlFT2M0?=
 =?gb2312?B?eXJIOUFqYVJSTm9UWlNLak8zd2pEajNtUHI3MlZORGFjNnFGbmZwUWpZYXQ1?=
 =?gb2312?B?SThMaHUxdG9BYlZ1a2xXMTdiK1dWMFVrd2ZJdWpGMUVJbm5OSlFBRjQ5c3c0?=
 =?gb2312?B?eU00VWtHMWV4NVRPZ2RJSnQ2b092bmpvTW5JY2l6WTJHMnNncnVPSmZvV21w?=
 =?gb2312?B?c2hkNGVoTm85Q0hGYVBSb1NGU0FEbWowQTBkUnhHS3pQMlpVekdIbmdtTkhx?=
 =?gb2312?B?VmZPeDkrWEd0d3ovZHo0S0N1YjlqUHh4SFRwVTQ1cU4xU0xqMW03Q25uQnpQ?=
 =?gb2312?B?bzgrNHZESmgwREQvM2ZjQ3ZNd1V5L09mMnFXaVVJRDlLQjdsS21EdFV6T0Fp?=
 =?gb2312?B?c1Y0Ynh6bEozM1l5T2lVZndpNFJWTC9Pa1dodmZWRW96SDFnQnR0enNvYWhr?=
 =?gb2312?B?WHRLa0g1OFNBRVZsQlFCcFIybUhRbks5YmExOUlVUCtkeVp5OXRXOFNqbjZs?=
 =?gb2312?B?MHJnNTA4TlozRW44cE0yU1JsZVpPR3dqLzBJUWlFNjhUcGc1TE1wMFdBR2lH?=
 =?gb2312?B?UXpDRnN1bzNZclB5ZXFVMUROTTByMHcyWFlwSXNDampNYVZvRjhyUTg4T2ZW?=
 =?gb2312?B?bDRwOHF6ckVzaE50cWxNdmdHRGNJRVVOa1ZlcXFrRkhYbm5UeURiZW9LZWZF?=
 =?gb2312?B?R24xZlhxZGtoaThXZjdRQWVNdGQweXlYbm5zcVI2SEN1ampHUU5oSys0cWUy?=
 =?gb2312?B?cUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8816.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f31f8d-fe65-4d96-d621-08d9bec9c299
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 06:20:01.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mb0TI5xKqG763x0UAqd78wucmvFOsl8jmSJpDMeJzSKQXNW5R4S4NkHqJXx8yfvrb0rcjff58saJOP8EV3J3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvIExpIDxsZW95YW5n
LmxpQG54cC5jb20+DQo+IFNlbnQ6IDIwMjHE6jEy1MIxNMjVIDE0OjE3DQo+IFRvOiBTaGF3biBH
dW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEJpd2VuDQo+IExpIDxi
aXdlbi5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDIvOF0gYXJtNjQ6IGR0
czogbHMxMDI4YTogYWRkIGZ0bV9hbGFybTEgbm9kZSB0byBiZQ0KPiB1c2VkIGFzIHdha2V1cCBz
b3VyY2UNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciAxNCwgMjAyMSAxOjQ2IFBNDQo+ID4gVG86IExlbyBMaSA8bGVveWFuZy5saUBueHAu
Y29tPg0KPiA+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQml3ZW4gTGkgPGJpd2VuLmxpQG54cC5jb20+
DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzhdIGFybTY0OiBkdHM6IGxzMTAyOGE6IGFk
ZCBmdG1fYWxhcm0xIG5vZGUNCj4gPiB0byBiZSB1c2VkIGFzIHdha2V1cCBzb3VyY2UNCj4gPg0K
PiA+IE9uIEZyaSwgRGVjIDAzLCAyMDIxIGF0IDA2OjE3OjEyUE0gLTA2MDAsIExpIFlhbmcgd3Jv
dGU6DQo+ID4gPiBGcm9tOiBCaXdlbiBMaSA8Yml3ZW4ubGlAbnhwLmNvbT4NCj4gPiA+DQo+ID4g
PiBBZGQgZmxleHRpbWVyMiBiYXNlZCBmdG1fYWxhcm0xIG5vZGUgYW5kIGVuYWJsZSBpdCB0byBi
ZSB0aGUgZGVmYXVsdA0KPiA+ID4gcnRjIHdha2V1cCBzb3VyY2UgZm9yIHJkYiBhbmQgcWRzIGJv
YXJkcyBpbnN0ZWFkIG9mIHRoZSBvcmlnaW5hbA0KPiA+ID4gZmxleHRpbWVyMSBiYXNlZCBmdG1f
YWxhcm0wLiAgVGhlIGZ0bV9hbGFybTAgbm9kZSBoZW5jZSBpcyBkaXNhYmxlZA0KPiA+ID4gYnkN
Cj4gPiBkZWZhdWx0Lg0KPiA+DQo+ID4gV2hhdCdzIHdyb25nIHdpdGggdXNpbmcgZnRtX2FsYXJt
MD8NCj4gDQo+IE5vdCAxMDAlIHN1cmUsIGJ1dCBwcm9iYWJseSBiZWNhdXNlIHdlIG5lZWQgdG8g
dXNlIGZsZXh0aW1lcjEgYXMgUFdNLg0KPj4+IFllcywgZmxleHRpbWUxIGlzIHVzZWQgYXMgUFdN
LiBTbyB1c2UgZmxleHRpbWVyMiBhcyBydGMuDQo+IA0KPiBCaXdlbiwgIENhbiB5b3UgY29tbWVu
dD8NCj4gDQo+ID4NCj4gPiBTaGF3bg0KPiA+DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
Qml3ZW4gTGkgPGJpd2VuLmxpQG54cC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBZYW5n
IDxsZW95YW5nLmxpQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzIHwgNiArKysrKy0NCj4gPiA+IGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMgfCA2ICsrKysrLQ0K
PiA+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgICAg
fCA5ICsrKysrKysrKw0KPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0cw0KPiA+ID4gYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+ID4gPiBpbmRleCA2ZTJhMWRh
NjYyZmIuLjAwZDViODFiZGVmMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gPiA+IEBAIC0yNSw3ICsy
NSw3IEBAIGFsaWFzZXMgew0KPiA+ID4gIAkJc2VyaWFsMSA9ICZkdWFydDE7DQo+ID4gPiAgCQlt
bWMwID0gJmVzZGhjOw0KPiA+ID4gIAkJbW1jMSA9ICZlc2RoYzE7DQo+ID4gPiAtCQlydGMxID0g
JmZ0bV9hbGFybTA7DQo+ID4gPiArCQlydGMxID0gJmZ0bV9hbGFybTE7DQo+ID4gPiAgCX07DQo+
ID4gPg0KPiA+ID4gIAljaG9zZW4gew0KPiA+ID4gQEAgLTIzNCw2ICsyMzQsMTAgQEAgbXQzNXh1
MDJnMDogZmxhc2hAMCB7DQo+ID4gPiAgCX07DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiArJmZ0
bV9hbGFybTEgew0KPiA+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gPiArfTsNCj4gPiA+ICsN
Cj4gPiA+ICAmaTJjMCB7DQo+ID4gPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiA+DQo+ID4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRi
LmR0cw0KPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1y
ZGIuZHRzDQo+ID4gPiBpbmRleCA3NzE5ZjQ0YmNhZWQuLjQxOTAwZDM1MWE5MiAxMDA2NDQNCj4g
PiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5k
dHMNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhh
LXJkYi5kdHMNCj4gPiA+IEBAIC0yMSw3ICsyMSw3IEBAIGFsaWFzZXMgew0KPiA+ID4gIAkJc2Vy
aWFsMSA9ICZkdWFydDE7DQo+ID4gPiAgCQltbWMwID0gJmVzZGhjOw0KPiA+ID4gIAkJbW1jMSA9
ICZlc2RoYzE7DQo+ID4gPiAtCQlydGMxID0gJmZ0bV9hbGFybTA7DQo+ID4gPiArCQlydGMxID0g
JmZ0bV9hbGFybTE7DQo+ID4gPiAgCX07DQo+ID4gPg0KPiA+ID4gIAljaG9zZW4gew0KPiA+ID4g
QEAgLTEzMiw2ICsxMzIsMTAgQEAgbXQzNXh1MDJnMDogZmxhc2hAMCB7DQo+ID4gPiAgCX07DQo+
ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiArJmZ0bV9hbGFybTEgew0KPiA+ID4gKwlzdGF0dXMgPSAi
b2theSI7DQo+ID4gPiArfTsNCj4gPiA+ICsNCj4gPiA+ICAmaTJjMCB7DQo+ID4gPiAgCXN0YXR1
cyA9ICJva2F5IjsNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQo+ID4gPiBpbmRleCA5ZWZjYWY2ODU3OGMuLmVm
OWQxN2RmMmFmYSAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gPiA+IEBAIC0xMTk4LDYgKzExOTgsMTUgQEAgZnRt
X2FsYXJtMDogdGltZXJAMjgwMDAwMCB7DQo+ID4gPiAgCQkJcmVnID0gPDB4MCAweDI4MDAwMDAg
MHgwIDB4MTAwMDA+Ow0KPiA+ID4gIAkJCWZzbCxyY3BtLXdha2V1cCA9IDwmcmNwbSAweDAgMHgw
IDB4MCAweDAgMHg0MDAwDQo+ID4gMHgwIDB4MD47DQo+ID4gPiAgCQkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDQ0IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ID4gKwkJCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ID4gPiArCQl9Ow0KPiA+ID4gKw0KPiA+ID4gKwkJZnRtX2FsYXJtMTogdGltZXJA
MjgxMDAwMCB7DQo+ID4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YS1mdG0tYWxhcm0i
Ow0KPiA+ID4gKwkJCXJlZyA9IDwweDAgMHgyODEwMDAwIDB4MCAweDEwMDAwPjsNCj4gPiA+ICsJ
CQlmc2wscmNwbS13YWtldXAgPSA8JnJjcG0gMHgwIDB4MCAweDAgMHgwIDB4NDAwMA0KPiA+IDB4
MCAweDA+Ow0KPiA+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA0NSBJUlFfVFlQRV9MRVZF
TF9ISUdIPjsNCj4gPiA+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ID4gIAkJfTsNCj4g
PiA+ICAJfTsNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0K
