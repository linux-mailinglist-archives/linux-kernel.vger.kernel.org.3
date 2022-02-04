Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20F4A9AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359269AbiBDOYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:24:55 -0500
Received: from mail-eopbgr120084.outbound.protection.outlook.com ([40.107.12.84]:24400
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351482AbiBDOYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:24:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL7y3MJ1+wtTIo0038DcbXnVK9xkQ1pBCQQvM8ogs95OWxP3dMRlwgBXw1B6f69PrdrK1kfs9wG7GGzgxtxQoIDQ68rde3DwtdnQtEmjCoqeR81l5C603Hnsznk7kmpGxfC7AmyiHs7aJ0HcWtm1m2CP2tlVWv8ZIXGYNbW/dcFnYCUnBgofP0oekmA7TRDiT0auFWrycKMC0AroWVAguuK5eGh0nMra4ZG2ZdKIDCfo92DhGqpSBwjCoBhx2sFqASpeEb2zJJgz6JLl+OjI098vQ7V799ngXZk6FxrPi6bxw5qsQkfM31iB3K6cEdeYAA3S40spDEZAOfJjOH0Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjNcpY8IZuk4VOIJCW/ETCihFKbEIn56uqKRi+ONWhM=;
 b=Fjq5Ax04K+kWF9fKOr2Xmt6+IXU2RDS8gCgBdWEq2twl/FUBFsIs+m+YqLY1YYMBzvHPZ3g26B3FF9B2uWpznIe2YERD9Mq9MciH1CBsp7QfdWd9Y40QMBEnUhJdaTh+E7SYf88zaqhkf4P7ZtteyI1r5RnOYgB1dBSYGWsEy4lDxZltBMNCf+Vjj+0DH+sD2LenOdF5azEM9c2tcbC4XApZ4vNDAXQ9CnK++/uCNXPW4lJpccpZ5C+vg5ELMxYvv8vRdU+ayJKDr3o72Nc9WifKtsiDOiheSjZb8Mx5S6jxJnisEImav9qHS4u18Jk9fY+oAiEQ/fALNtI/up6e5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB4323.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:43::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 14:24:50 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 14:24:50 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [kbuild] arch/powerpc/net/bpf_jit_comp.c:225
 bpf_int_jit_compile() error: uninitialized symbol 'pass'.
Thread-Topic: [kbuild] arch/powerpc/net/bpf_jit_comp.c:225
 bpf_int_jit_compile() error: uninitialized symbol 'pass'.
Thread-Index: AQHYGbM2me9wAHP6Uk6Tfh6mEuEeiqyDX/iAgAAP0ICAAALBAA==
Date:   Fri, 4 Feb 2022 14:24:50 +0000
Message-ID: <0ede8979-2a7c-ab16-b97b-11c5678ae045@csgroup.eu>
References: <202202040124.7MMKaXXV-lkp@intel.com>
 <45bd66d4-14b8-bdb0-7d6c-096d6d7cddb6@csgroup.eu>
 <20220204141459.GJ1978@kadam>
In-Reply-To: <20220204141459.GJ1978@kadam>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87cffeaa-0eff-47c8-aa9f-08d9e7ea1ac8
x-ms-traffictypediagnostic: MR1P264MB4323:EE_
x-microsoft-antispam-prvs: <MR1P264MB43230C0D1E96CD544D51751DED299@MR1P264MB4323.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yz+VBkVlkhE4fU1zMd2E0Daxms8VRy563I6WynbIm1kjxPwuPxjZBqzg7fc9nGx6oduJ3QWHbCCbREVkOlnOeANsosrUC8jrMBVr+ntWYnO2xY8GPqOhszGLOuOvO4Mv3ZYxG/ww17M7DANPGej1c93nue9WvvUVewZVFHZCQZN1glPOSa61nSsRIuB/k/xr0W+GeWHq9VKhx91Ut9XMq6cKJb4wqScvE881mTjS7PKidZ0QQ4Oyda3R57NkePh4MTL5d0Ba/5FjbnGhU5KWZ28BzVGlw9gWOsCLjkSuyuvoqYzuJCgekDU34YAflaE8RfJ/KgMVHO/oWem2SazCkJKEqMXHEHkjMke9DnlxIjbdb77ln7kskZQv5BkSEl30kmoAYqen3ixWPlAOAAOLQAKjFjAfHfsEnuGcb0W2pFsRe3T4RZWbzrghlXl9wUIQbJnH/CjKky86+Xt6lXQUwGLZpkWGZ/WH514lGif08vHQHd/4DFjNHZ/OTmXcAZd/1XWr/LuOwe8R0ShgnACv3u0G7xB9ew4YqApjbwPFgXu6h1joy5HICr7M7uNmG0COVxdH1vyfBrbpFMOuAT2ZAadwHu7wrAriEsqwAue/fKAbaYZmRcP5ABgLBiEwF3kzUA4A3VWaAu0nT1tlndNZ29Lps4Cu5bkgPftFS7XpNzY/bfbmJdjpBwCafX96xu1kSbu/O7rjsbvk+AHga1/BLNq81ro0/nFN5saybZw0mDcuzRSKORgGxJqcyhI+XEW6TP1+lipduT5vytQzpAi13TiEmzBfYpgGNjdRmncdfIqzcZvHXnUPARsASQwZHEWRfXXXtpZnqtJ2Sa55WDHapCRq2moLUPy6WIkFNe0KOlk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(26005)(186003)(38100700002)(122000001)(6512007)(6916009)(54906003)(76116006)(91956017)(66556008)(8936002)(4326008)(8676002)(66476007)(66446008)(64756008)(6506007)(86362001)(2616005)(316002)(66946007)(2906002)(71200400001)(44832011)(5660300002)(83380400001)(966005)(6486002)(31686004)(508600001)(31696002)(66574015)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHZBUUJteFlNU09rUklxZmhlanMxTUhoMzhmNkYyNnJtNDBoTkY2ZWg1TzRn?=
 =?utf-8?B?R3FqMEZ2bVQ4NzFGL3JSV0RUY0paQmlzdFlHQVArR0Q3M00zQ3hCSlR4aUw0?=
 =?utf-8?B?dzJ6OHd1UzZXdW5iUnROcjdVMGxrMWxwWFNOWlk2VGN1ZHdNd2xSREM0bm9M?=
 =?utf-8?B?d29ORDE1WG5ZM0lQajEwQzgrNUU1cDNIdThZNHc1elZnUnRXRXV5aTVrZkJs?=
 =?utf-8?B?NndMekFOTHp3cG15bFR0eWY3QktLcWprRlZ2OFBGZmhXMmk4UTd3UVJEMUJ4?=
 =?utf-8?B?KzJzSlAzZTMzZDFrN251ZWRZUE1UaFUzQWxXWWgvay9sbXNDR0lhbHlqNEIw?=
 =?utf-8?B?cFlGSkJiajk5a0pRQnVibzFDV1ZleWhKQnA4eEdlQ0R1S3BqRlcxQlFlWkFw?=
 =?utf-8?B?Vkh2S2dLaTc5bi9RbTZHRjIxdmJySk0xUS9FUzRjaDlEcTF3bk9HTHNxaGxR?=
 =?utf-8?B?WEVRaXdycVZrQ2k4bWZsOEtUS29mVnYvYWxqS3orMlJuUlFwM1lGSXBxUEFo?=
 =?utf-8?B?Tm53MGZFSUEzeWkzTGo0V1JmSWJma2ZMTHhSeENoTXNDSmxKaW84UVhuVEVq?=
 =?utf-8?B?VnNqT1N2U09NRmFDTnNETXEvcEJLTlJYZ0JDZ0xGblIzTUlYaWc4azRXUXpZ?=
 =?utf-8?B?Uy83S3M0cTduaWUwemhvYlBHR2pmbjFZODVsVnFjYXJHbkJOM1hCMmg1M3hr?=
 =?utf-8?B?Y2dXcHpITGVvZW4rWTJCejJMZDFIVjVrYVIzNkJhN2Z1WkFKNkFJZ3FnTWc0?=
 =?utf-8?B?L1Z4UDhJWWRvbUZzVHkrTDU1WE5GTklWWUJ6NEh1MWZJeVltUGJPejRDb2p4?=
 =?utf-8?B?NmpvSW9PTjM0M2JDd0xDam1DSG9xNkdSTHRtRWdFalZNc2w2WE0vY3lOVkdR?=
 =?utf-8?B?UEpLOG05c05aZWFyTHdGSm9xeklBcGticjc4RVRYOWZkNEZDM200Umpsd2NX?=
 =?utf-8?B?R0haa1JxQ0J0UGFiZEF0WkNhamtsT0FlbzlnN0ZYYzhsc09KQzBTb2RIQzlK?=
 =?utf-8?B?dE56MnA4SVIzL29wellNNzA1ODVzekRwV2VVWFhhemdDRFJyOXNjRENDUk9N?=
 =?utf-8?B?RXJPYzJqaDErUWNya0VkcUdaRlRFdlRWc3VuRXNXYS9qUVlZeklBWFZMRElT?=
 =?utf-8?B?TjdSSTNLRjlFcFNyR1g4WlBHd0grQ0VIU2wxV2lycytlUDFhd1B6SGxET0xV?=
 =?utf-8?B?WkVpWW1ER3QrYWhtOGNJZENYaEVUbWpnVWtKM0djRWh0dnhpdGFlSnlMZm9V?=
 =?utf-8?B?Y3RWNk1FcVQ2YXA2eHlaeW05T0FtVldSc2tLYWlHWCtlcVhKZkxTVktieFBs?=
 =?utf-8?B?dGU0UTZxRG53Vmt6ZjB3R2JTanVTNU5NMU5KbW9hRmlHQWJoNXROc1hwNGJy?=
 =?utf-8?B?TXN6SDZTV2xZUGp2QXloQVVGYTE2d2drOHJyVytyV3FDSmpjYXVHS2txd2Ir?=
 =?utf-8?B?TWttdkxTNnprNEdCRCs5TUo1cU1vaUxTeFIycVpDeXRJdncyUnZmeEo1RFJL?=
 =?utf-8?B?czdTeWZHdjVZNGdhYTRaK3psclNTUHdDY054aFlqTFZWZkxnd0xTNWcxRFds?=
 =?utf-8?B?VDE2bzI4dEl6RkxHb05sOW1rYVBGd2pTaFMybzdWZjZXRVBSdkNXUHhySFU3?=
 =?utf-8?B?Zk5LdG8rZGxObkVUVU5Rb1cwQW9JY2w2dkcrbGc4RCs0QUQyS1VDa3pvYks4?=
 =?utf-8?B?Myt0N3IzOHZXUXRxK2lOcDMwcW0vOE81K01CSnB3djZxNjVzSEZQSVpGa2FC?=
 =?utf-8?B?dVJPYnl5OW9DSGU5M3dqS29NSDQ1ZFJ0dytrUW0rYmY1MGl5TGEwSkRaS3Fl?=
 =?utf-8?B?N3dUNEh1cExmS3ZQNTVNVU5sMVk2cGttL291Z05EUlpzQUN6Y3V2Z2E1NDVM?=
 =?utf-8?B?dVNWWVRUMFVwcEVhSkhzNFErVmlVU0JaVXVlWVFYYmZtUkV6M0FoS3h0Nmti?=
 =?utf-8?B?Vm5xWnBxZXJ1QmFuU2QyMUdzNkE2WWk3WkdiUTcvdnc4UWVYbHgvbWpUdnhz?=
 =?utf-8?B?eVBDVXJML2hPUG9zWVRpK3pScGhZTS95c0lUbEhXMXZHcEV4RlJwY1V2NXJt?=
 =?utf-8?B?MDcvRmNvSXFVMDRYVTQvSUN5QzFaUHRWSmRWVDZhTVh6TW12VGVOOUgrTHNQ?=
 =?utf-8?B?V0RaQ3FvVDFGMXd5bnNrOE84S25vQUZFWEF4Um0zREtXNG1tLzFkcTBQeFQ2?=
 =?utf-8?B?OXF2L3lyRVJoZ3paTmhrWXRzY09yWjlOS3BGWU02SDlwQVE2ejgxcTNZMkpt?=
 =?utf-8?Q?AFmP4Hb0qxlylr5Wi10Dgdr2z+B5WzTkrmNmzFSbfU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FECB249C5E05FE4A8DD3B774D17D086A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cffeaa-0eff-47c8-aa9f-08d9e7ea1ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 14:24:50.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lw2A6nwtp4JfcEwh9kNBp/XwFUWpR/1ZJYk3IJp1k+dj+a7Y4DKpkHJg9ELWGJ/OA4Egh5GjImyR7inV3O4hjSNbMpoZmkcpV/IV+x+QCAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB4323
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA0LzAyLzIwMjIgw6AgMTU6MTQsIERhbiBDYXJwZW50ZXIgYSDDqWNyaXTCoDoNCj4g
T24gRnJpLCBGZWIgMDQsIDIwMjIgYXQgMDE6MTg6MjRQTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJv
eSB3cm90ZToNCj4+IEhpIERhbiwNCj4+DQo+PiBMZSAwNC8wMi8yMDIyIMOgIDExOjM3LCBEYW4g
Q2FycGVudGVyIGEgw6ljcml0wqA6DQo+Pj4gdHJlZTogICBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQgICBtYXN0ZXINCj4+
PiBoZWFkOiAgIDg4ODA4ZmJiZWFkNDgxYWVkYjQ2NjQwYTVhY2U2OWM1ODI4N2Y1NmENCj4+PiBj
b21taXQ6IDUxYzY2YWQ4NDlhNzAzZDliYmZkNzcwNGM5NDE4MjdhZWQwZmQ5ZmQgcG93ZXJwYy9i
cGY6IEltcGxlbWVudCBleHRlbmRlZCBCUEYgb24gUFBDMzINCj4+DQo+PiBBcyBmYXIgYXMgSSBj
YW4gc2VlLCBpdCdzIGJlZW4gdGhlcmUgbG9uZyBiZWZvcmUgdGhhdC4NCj4+DQo+PiBTZWVtcyBp
dCBjb21lcyBmcm9tIDAyNWRjZWIwZmFiMyAoImJwZjogcG93ZXJwYzY0OiBvcHRpbWl6ZSBKSVQg
cGFzc2VzDQo+PiBmb3IgYnBmIGZ1bmN0aW9uIGNhbGxzIikNCj4gDQo+IFRoZXNlIGVtYWlscyBh
cmUgYXV0byBnZW5lcmF0ZWQgYnkgYm90LiAgSSBqdXN0IGxvb2sgb3ZlciB0aGUgZW1haWwgYW5k
DQo+IHZlcmlmeSBpdCBsb29rcyByZWFzb25hYmxlLiAgTW92aW5nIHRoZSBjb2RlIGFyb3VuZCBz
b21ldGltZXMgbWFrZXMgaXQNCj4gc2hvdyB1cCBhcyBhIG5ldyBidWcuICBBbHNvIGNoYW5nZXMg
dG8gdGhlIEtjb25maWcgZmlsZSBjYW4gYWZmZWN0IHdoaWNoDQo+IGNvZGUgaXMgY2hlY2tlZC4N
Cj4gDQo+IFRoZSBjb21taXQgdGhhdCB5b3UgbWVudGlvbiBkb2VzIG5vdCBnZW5lcmF0ZSBhIHdh
cm5pbmcuICBUaGUgd2FybmluZw0KPiBzdGFydGVkIGluIGNvbW1pdCAwMjVkY2ViMGZhYjMgKCJi
cGY6IHBvd2VycGM2NDogb3B0aW1pemUgSklUIHBhc3NlcyBmb3INCj4gYnBmIGZ1bmN0aW9uIGNh
bGxzIikuDQo+IA0KDQo/Pz8NCg0KRGlkbid0IEkgbWVudGlvbiBjb21taXQgMDI1ZGNlYjBmYWIz
ICgiYnBmOiBwb3dlcnBjNjQ6IG9wdGltaXplIEpJVCANCnBhc3NlcyBmb3IgYnBmIGZ1bmN0aW9u
IGNhbGxzIikgPw0KDQpDaHJpc3RvcGhl
