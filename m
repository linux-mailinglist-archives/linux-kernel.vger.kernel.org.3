Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F646B117
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhLGC53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:57:29 -0500
Received: from mail-sgaapc01on2105.outbound.protection.outlook.com ([40.107.215.105]:18401
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230374AbhLGC51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:57:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah8fZ4ILvystdVjZlk74jecIPfXcVWdYO1GLj1XcgkaeMzU7GkiI3MQelnPMqtmohfg0PSN+g8J5bky6/GmODAKiBsBYpe/PwnQ5DbzW616Nrhqxes6umLFZwOmIShbyeAEVnNZGNcodpb8TPW6K0jY5lUA3bPOK+H7M+yZ1wrqZyPaHnHkZ7XA/nWNYNp0vGxlhUkQEP3ySeNPs0kqiMsIzVww5Nor8TlfDTxrtt2wFVj9heg/ChuM89ut5hveeuFtbg2/JjRn3FU2qznLiBmyIuYwgDS+jRiyop+U+ECQPUx5iksAFMrAacz8Jfn3Wj4ri3mfZWXsqVLXwddLmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Clx8ESvujD63OvAJg2+wYUf8ACNqdKEQCK5hMOxalZk=;
 b=RVzz1YjEkcaFsDBUApwLt6fpGRpVix3SMpgcAEJwhTe1CgyM4v5ALNISVfTTpt4DY8jMEE147hAb6fdCzG7jmjdmHu6LpGUpjwajDZafehoX6DfWhMx9kqYIxSxoFmQPt2kBM0463rtxW8r+nHyqUoJj9pldj5sJckV9pt7UpDJzFdX6OE9mIX/WnwG6bEQgrUW2gImTbF+taWRQH9bKSkfZzYpLYjrFqloB67RP2WY9Sjh3kvPbeeovwsV6vs+RmzJzc69vzcQOcXQBhQFQfScvg65/YOsCzdsat33AF/uhJuQCVWXT1NqNcpJyb8fEFJXTpXcIEqcuTjNpmfgcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clx8ESvujD63OvAJg2+wYUf8ACNqdKEQCK5hMOxalZk=;
 b=q89kK9XzRRWfGjQAWmOlDlfJYC0Hm+4ly+fIc4gaJc2DQqEHDR21rFrf08QhuUgEtVUtipMezLPC6VVwWgfpYLhkTbDjIElgRTB2Hc9bkbDL0goTrmokFXPhyCSBaOR6AONagbr+pLj0DpWkYHBTuh0WMMzCJyPsl2J3fNocomU=
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com (2603:1096:203:df::11)
 by HK0PR04MB2897.apcprd04.prod.outlook.com (2603:1096:203:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 02:53:53 +0000
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::50ac:5788:d373:7194]) by HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::50ac:5788:d373:7194%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:53:53 +0000
From:   =?utf-8?B?SG93YXJkIENoaXUgKOmCseWGoOedvyk=?= 
        <Howard.Chiu@quantatw.com>
To:     Joel Stanley <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
CC:     Howard Chiu <howard10703049@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Topic: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Index: AQHX6vPlDf93t8kSvkG92vOctn4vNawmU+qQ
Date:   Tue, 7 Dec 2021 02:53:53 +0000
Message-ID: <HKAPR04MB40033D58E2C1F96DDF16C13C966E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
References: <20211201033738.121846-1-howard.chiu@quantatw.com>
 <Ya5/v+VhOM9o9BtQ@heinlein>
 <CACPK8XdCjqB+HZ_g9O=gjnSne3=iV44i6jKP5M8yWcsjnttaog@mail.gmail.com>
In-Reply-To: <CACPK8XdCjqB+HZ_g9O=gjnSne3=iV44i6jKP5M8yWcsjnttaog@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc595948-6a7e-43e9-524c-08d9b92cce3f
x-ms-traffictypediagnostic: HK0PR04MB2897:EE_
x-microsoft-antispam-prvs: <HK0PR04MB2897FFF708D575E74A039965966E9@HK0PR04MB2897.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TspiqLFU5+27mTf4hIvk2D0yMS5mByNpPpyYF6z7EM3srICP1djsfruUuwu8U+CqZUXzS0qpdO1NoW/njJZqhutWgQQjryZmqSQATXhJZZ3x198Sb4Ya+0MFenjX4TmUAcAhGvn3VZ4ck6/QGd73/zcsSX//5J2Sepjrj7gkQlYUOyx0MNGI/Ljwdjszo4eNKymbuUbYo8ZyChhkEE+yxnwmnbHtyHhhrbt9ZFAi6R2NJ3/lZ89CW/qhVFjcwHyNpdYgq8dIqknXnOP3htYNH2Qeve2dHr0fL+K0ig6jWBsbo6gHljOmTEgzLYysdM5x/xm4EegJ0dx7vpgWYzJH5wXtJ5z15hdkmwE1TWKzJXYhrrrPCkjUSUW0ju3FLAtaqS1128k/eWuC8yewkjD1BI7pW8w/b2W72Xwg9qR9BQ4NnA7QvP/ROwuLoRiuSoVhp03O3ejD4jIZYmvM8f2RH4YFX5AVrTFUwOsEvHRsV1WInkpN8Zu/FiKm8ziW0Teko0rquKcDX2sVfty3WW9YoSgIN4MHdSjHHoVAyyXqn7YUlYS0I678Vh1+f3C6xa2YQQxA58QJQrI7vBjqa3oCUFYXuv2qSpsUrv0sM0N0j7GtWmVNbkkY9E+hbclu+2t4fg4xaE6hZ22b1I9LwMJdHqrJ0yQvuqhWHPx7lyjaN5qcLSRg7tVsrvO4GCbEc+BEo8AVJv6bWnU+2gbyvK2RQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR04MB4003.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47680400002)(53546011)(7696005)(6506007)(38100700002)(5660300002)(2906002)(66556008)(55016003)(66446008)(71200400001)(64756008)(122000001)(54906003)(66946007)(186003)(52536014)(85182001)(7416002)(66476007)(8676002)(4326008)(38070700005)(316002)(76116006)(110136005)(26005)(508600001)(83380400001)(9686003)(33656002)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGErT3RHS0hmNnlLQ21WcCtWTndFSWs1bnVPc0xwNnpxUGR4WEg2N0FBcnBv?=
 =?utf-8?B?SjY5MlZiUks3a0NaUVdGUTQ3bytWd0VSSEx0Qy9USlQveUtEVUwveWFmMGFF?=
 =?utf-8?B?Unc4SmRmQ2VBTTM1NlE0eVNoZjUzdUxickZZL0JxMURDaml3bno1T2lpMVNC?=
 =?utf-8?B?Z3g0NGhlOE0rTGNGT3hGc05lNGlUZ3ljM3NmVXppY1Q4eUFMNWJ1T3pUbWN5?=
 =?utf-8?B?TVlMZjIxMDVld29RU3JwQWh4cC83c1drOHlXT3I0c0J0NjAwN1ZnakZMSEsx?=
 =?utf-8?B?a3NUN2E4bmx6bVBuWHRFRnU0NU1mVmZXNkdITkg3aGtzQUJndnAzYTByemVT?=
 =?utf-8?B?STJnSlMyS1F5ZE9YYWVjU0FrSWsvS0xYUWRKR09McVNCY3ptdXVRNWRqQjNX?=
 =?utf-8?B?V3BpSldSelMrVU1HMU9Fdk81Z3JEanMxUUNrY3A1enRDTHFDeko1UDJERjRR?=
 =?utf-8?B?TEZIT2NSZWJJbU00cjlnUWFQbmVpQzY1R1BqODRxS3ozTW1YOXBmTU5SaDZQ?=
 =?utf-8?B?azI3TnREUisyZHEweVRvN21YU0dpZjl6aVNyYi9SRFYyZ3Zsa2MxL2thMnZW?=
 =?utf-8?B?K0dQL3JTY2xKRUhXU0QvMDVrM2JCSlFHYnBWWUE5SDBaZk9GRm1LRWRncmVi?=
 =?utf-8?B?SklSUStFS3gyZXYzYXNPenJRUkRFL0FnOGdxNEhweTZhd3JXMXFpSHEyRXlV?=
 =?utf-8?B?aFA5NU1TbUFzSWt4a0JQbXRzSmVWeVgveUdjOENaT21wemc3eFpoNTMydVph?=
 =?utf-8?B?TFIzYWtvR1VKcTIyaEZRbTBYbi9IK2RXVUk1Smx4MDVvZmpCaDN3TXhPdzVQ?=
 =?utf-8?B?ci9sVDNyNjB1UGZiTTZPaHZmVDEwU2pxRXBqL2U4Z1FpQ3VCNjgvMmJHQzJ6?=
 =?utf-8?B?R0lNY3lBdk1zUXRsSTZ6QjlZZTdzQTJ4WjBPSmtUemtBWnEyZ0ZkamtScFht?=
 =?utf-8?B?MVRzd1czQ0pFeVlRS1JHYXB5SUpjR1NncnBIbWx4UXd1Y3diSk4zUkJxWXRk?=
 =?utf-8?B?U3NhTVlJQ21NcXIzcVZVNUZkblk0K3pnMFh0OHk5dVd3bHZaRGJuaThIM3U5?=
 =?utf-8?B?dktRU3dVaEJuWUkrZXBPVXUwMm01bGk3a0hBSTllVFBzRVZkSVlCMWt4bm1q?=
 =?utf-8?B?UVJLWlQwTGU4b0pSbzU1YUlLaU1UOE81aTUxV01qY3NrVWtrS3BYZnpxL0VJ?=
 =?utf-8?B?eWtEQUswMy80NU14VWxsNS8xa3pucEd1azFCeDJvZ2ViS055K0VNdVRSMkpR?=
 =?utf-8?B?MVZrVmcyOUdhMUsrbU9IWVB4SzZpeFNYci9IREFsdStrNWpzdFpQckk0Y2Vy?=
 =?utf-8?B?QmV0NlV4c2JIdUpLc2hyRjR1T1ZzTHNzMitSSDdqNGtuY2dUMjAraWxkUUNO?=
 =?utf-8?B?OHBMV1NBNVRQU2sxSjBGZG1vTnNXSll3SmMrbHpwaXhlcnNENWxKSW82Q1Nx?=
 =?utf-8?B?eTVLWEpBZjRvUjZ2NDlTclk0L0ZjYXB4SGtxMkN3SWpjbEpUZzRLclRuaE1O?=
 =?utf-8?B?ZUlQUG1JWkJDcTBEQUwwV2FnQ2hnb0ROM3VmK3NFT25mdkRzL0RoQVQwdTk4?=
 =?utf-8?B?THZKQ3BXMk8yVzZQdXpmM3pFbjVHQ3dONjlDdXgwNktLYmFaUkpEZngrR3FS?=
 =?utf-8?B?N2VrcVBFVjFBS0FhOU9tcmNKOGpWRmRSdVk1ZjJMVmRUSExxSVFSYUwwTEZB?=
 =?utf-8?B?VjFoaHpSTGhMUS81ZU0zSkJJMFd3U0V5SXlvaUo5aVltYW1Pb2c3OG1aOG9O?=
 =?utf-8?B?dDA2ZE1uV2ZWTWdBTXVIS05NQXdXZXdvb0hOR09Rdjk3NmpEbjZtMGE5NFRF?=
 =?utf-8?B?Rmpid3puMU1wcjVkY1JkK2NEUVcyWDBkekZ4b3Zpc2JlRUxxSXh2NXBRUHFu?=
 =?utf-8?B?WERKK1V2NEdjSUVydzJXRG5USW9adlNZNzUyWC9YcjRQSE5rVkNxTjNCV3Nk?=
 =?utf-8?B?VFVrTlN2S1o2b2JzVS9xM3YySzFJN2R6OWZoS1ZWTHY2NGEzVERFNDJxZ3RE?=
 =?utf-8?B?WGV2RHpIb3Bnc1NpWDZlQTJHTFhnWk4wZXFuRkxaeWNqMkpaam80bllOa0hi?=
 =?utf-8?B?S3U0TnFUcVd6c1V3OXRGeUQ5YzVZY3AwdUZSMzJuTlExT01WSVBBL0ZtY2Z6?=
 =?utf-8?B?NG1XM0ZkTTExOTlkNzBvWVpYb0gxd1pHb2F5MnRZSjNoOURNTUlXUFNhYktX?=
 =?utf-8?B?bnJseHBRekRLRnBwNXY0OVVkR1M1cC9rMEVJTnQySTUxL05icXFLZXBZQmRR?=
 =?utf-8?B?TVZVU1VrV243QWpVSTkyanpxNzBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR04MB4003.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc595948-6a7e-43e9-524c-08d9b92cce3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 02:53:53.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Sv3XoEwxvaGb58hlVjdviThPWCa55KyLD/VESeVEzz+qwBZyq3HrtGHb6H3TTTedEK2ixbAsuuJrSKnHrU7zRJyNyaNapV5OkcDK9TMxyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2897
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lbA0KDQpCbGV0Y2hsZXkgcGxhdGZvcm0gbmVlZHMgdG8gc3VwcG9ydCBmYW4gY29udHJv
bC4NClNpbmNlIEJpbGx5J3MgcGF0Y2ggZm9yIHVwc3RyZWFtIGlzIHN0aWxsIHVuZGVyIHJldmll
dywgSSBjYW4ndCBhZGQgcHdtL3RhY2ggbm9kZSBpbnRvIGR0cyBvciB0aGUgYnVpbGQgd291bGQg
ZmFpbC4NCg0KQXMgeW91IGtub3csIEkgaGFkIGNvbW1pdHRlZCB0aGUgcHdtL3RhY2ggZHJpdmVy
IGZvciBhc3QyNnh4IHRvIE9wZW5CTUMgbGludXgsIGNvdWxkIEkgY29tbWl0IHRoZSBkdHMgdG8g
T3BlbkJNQyBsaW51eCBpbnN0ZWFkIG9mIHVwc3RyZWFtIGZvciBlYXJseSBidWlsZD8gDQoNCkhv
d2FyZA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvZWwgU3Rhbmxl
eSA8am9lbEBqbXMuaWQuYXU+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDcsIDIwMjEgNjo1
MiBBTQ0KPiBUbzogUGF0cmljayBXaWxsaWFtcyA8cGF0cmlja0BzdHdjeC54eXo+DQo+IENjOiBI
b3dhcmQgQ2hpdSA8aG93YXJkMTA3MDMwNDlAZ21haWwuY29tPjsgQXJuZCBCZXJnbWFubg0KPiA8
YXJuZEBhcm5kYi5kZT47IE9sb2YgSm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD47IFNvQyBUZWFt
DQo+IDxzb2NAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBB
bmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGFqLmlkLmF1PjsgTGludXggQVJNIDxsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+Ow0KPiBkZXZpY2V0cmVlIDxkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1hc3BlZWQgPGxpbnV4LWFzcGVlZEBsaXN0cy5vemxh
YnMub3JnPjsNCj4gSG93YXJkIENoaXUgKOmCseWGoOedvykgPEhvd2FyZC5DaGl1QHF1YW50YXR3
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Nl0gQVJNOiBkdHM6IGFzcGVlZDogQWRkaW5n
IEZhY2Vib29rIEJsZXRjaGxleSBCTUMNCj4gDQo+IE9uIE1vbiwgNiBEZWMgMjAyMSBhdCAyMToy
NSwgUGF0cmljayBXaWxsaWFtcyA8cGF0cmlja0BzdHdjeC54eXo+IHdyb3RlOg0KPiA+DQo+ID4g
T24gV2VkLCBEZWMgMDEsIDIwMjEgYXQgMTE6Mzc6MzhBTSArMDgwMCwgSG93YXJkIENoaXUgd3Jv
dGU6DQo+ID4gPiBJbml0aWFsIGludHJvZHVjdGlvbiBvZiBGYWNlYm9vayBCbGV0Y2hsZXkgZXF1
aXBwZWQgd2l0aA0KPiA+ID4gQXNwZWVkIDI2MDAgQk1DIFNvQy4NCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBIb3dhcmQgQ2hpdSA8aG93YXJkLmNoaXVAcXVhbnRhdHcuY29tPg0KPiA+ID4N
Cj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4gPiBDaGFuZ2Ugc2luY2UgdjI6DQo+ID4gPiAtIFJlbW92
ZSB1YXJ0NSB3b3JrYXJvdW5kDQo+ID4gPiAtIFJlbW92ZSBncGlvIG5vZGVzIG9mIHBjYTk1NTIv
cGNhOTUzOQ0KPiA+ID4gLSBNb2RpZnkgZ3Bpby1saW5lLW5hbWUgb2YgbGVkL3Bvd2VyL3ByZXNl
bmNlIHBpbnMgd2l0aCBvcGVuYm1jDQo+IHBhdHRlcm4NCj4gPg0KPiA+IEEgbnVtYmVyIG9mIHRo
ZSBHUElPcyBkbyBub3QgaGF2ZSBkZWZpbmVkIG9wZW5ibWMgcGF0dGVybnMgZm9yIHRoZW0geWV0
Lg0KPiBUaGUNCj4gPiBuYW1lcyB5b3UgaGF2ZSBjaG9zZW4gYXJlIG9rIGZvciBub3csIGJ1dCB3
ZSB3aWxsIGJlIGNoYW5naW5nIHRoZW0gYXMgd2UNCj4gcmVmaW5lDQo+ID4gZGV2ZWxvcG1lbnQg
b2YgdGhpcyBtYWNoaW5lIGZ1cnRoZXIuDQo+ID4NCj4gPiA+ICsgICAgICAgICAgICAgZ3Bpby1s
aW5lLW5hbWVzID0NCj4gPiA+ICsNCj4gIlNMRUQwX01TX0RFVEVDVDEiLCJTTEVEMF9WQlVTX0JN
Q19FTiIsIlNMRUQwX0lOQTIzMF9BTEVSVCIsIlNMRQ0KPiBEMF9QMTJWX1NUQllfQUxFUlQiLA0K
PiA+ID4gKw0KPiAiU0xFRDBfU1NEX0FMRVJUIiwiU0xFRDBfTVNfREVURUNUMCIsIlNMRUQwX1JT
VF9DQ0c1IiwiU0xFRDBfRlVTQg0KPiAzMDJfSU5UIiwNCj4gPiA+ICsNCj4gIlNMRUQwX01EX1NU
QllfUkVTRVQiLCJTTEVEMF9NRF9JT0VYUF9FTl9GQVVMVCIsIlNMRUQwX01EX0RJUiIsIg0KPiBT
TEVEMF9NRF9ERUNBWSIsDQo+ID4gPiArDQo+ICJTTEVEMF9NRF9NT0RFMSIsIlNMRUQwX01EX01P
REUyIiwiU0xFRDBfTURfTU9ERTMiLCJwb3dlci1obw0KPiBzdDAiOw0KPiA+DQo+ID4gU3VjaCBh
cyB0aGVzZS4uLg0KPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0KPiA+DQo+ID4g
T3RoZXJ3aXNlLA0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IFBhdHJpY2sgV2lsbGlhbXMgPHBhdHJp
Y2tAc3R3Y3gueHl6Pg0KPiANCj4gVGhhbmtzIGZvciByZXZpZXdpbmcuDQo+IA0KPiBIb3dhcmQs
IEknbSBtZXJnaW5nIHBhdGNoZXMgZm9yIHY1LjE3IGJ1dCBJIGNhbid0IGFwcGx5IHRoaXMgdW50
aWwgeW91DQo+IGZpeCB0aGUgd2FybmluZ3MgSSBtZW50aW9uZWQuDQo+IA0KPiBDaGVlcnMsDQo+
IA0KPiBKZW9sDQo+ID4NCj4gPiAtLQ0KPiA+IFBhdHJpY2sgV2lsbGlhbXMNCg==
