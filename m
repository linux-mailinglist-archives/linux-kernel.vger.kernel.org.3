Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8774732D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbhLMRWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:22:34 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:26975 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbhLMRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1639416151; x=1640020951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K01p1AmThlZBsA76elncZubIv48IrOtOkYgW+l0YMxA=;
  b=2PR0YOEGg//WoF3FgnWCD3IGRbhvcnbpeu98+AOHKGpLzyabsK+HVtxV
   lnf6C7G27E5q+ni6tj4N/NqV0USGfVoEftEYD4i+9o8w/75ORTaLKGfPw
   ooRcCQcCTt3TzkJbJndZ2G3b4i8alZl59rTmGfiS1jbTDpkhZFezSz2nt
   s=;
Received: from mail-bn1nam07lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 17:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5Cj168b0AcjXQlvXF92F5LOMrThyrEgrUUs+Qet8NS909lulCYJI1vDQ5Zue9L8QhNRf2W6ZnlKUAgSVvTcuPphdEDpEygO649XyYH7alpVC/bZmYFw0f656EGeBDagOdT9OZjS0wMoAPJ0UZYLnxJ8w0oRn86XasDP9qQkt+A471fsOJ8+Gp0v3Z88K+jgHyv7QQSg7grDmTyE+V6DT3KnTG03KH1ZUUFdiSGE2mDhorN4pxBPl9PGDtFP+yLWsaStcfwC/BcOQGGnoQ1G0AHMFFXGuQ9W3qqmDQ7dlqSn3SAJo0Izfi/uTpvHuqukBFKrs16Q0HRu0ttTXJiitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K01p1AmThlZBsA76elncZubIv48IrOtOkYgW+l0YMxA=;
 b=Y0iLfQtPDdWandDZ9kwbmgsmnMfeUbEFoqU4UqITu2O0bgricClLS46mczA4ZXYEEyZ7qbkc1DG1lwWkd4Ki1Pshwuh1gOFNWk8GUF5lhFvkHb/BTqL/qjpH6Vo9CVW1iKyt4+Tcm6MLH/zUd3kUpa2q/KUinO+BVmgb1FA2s8v+1I+c41rGrTLUKf/5Lj5Y0HGnFw/ilXxBEUyN5pf2TLIM+Xc66mb4SV7SQjSWQSj0sSTs7dWAp8Yx49G8vPbebTpWIGXGq4420dvDpNHNo3dKRMmFDs0zJX3eqN+EFcDwCl6Rb5y8WvUAaqUVxXqHEqKLxku06trfIwNhH4j+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by SJ0PR02MB7773.namprd02.prod.outlook.com (2603:10b6:a03:318::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 17:22:27 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::6837:9c03:af16:e6a9]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::6837:9c03:af16:e6a9%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 17:22:26 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     Doug Anderson <dianders@chromium.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>
Subject: RE: [PATCH V2] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Topic: [PATCH V2] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Index: AQHX50c/AxvFsMywYUa9+bTRjnnN0awwpEgAgAAZIbA=
Date:   Mon, 13 Dec 2021 17:22:26 +0000
Message-ID: <SJ0PR02MB8449CB45F47541CC84C7136BCD749@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1638427092-9139-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <CAD=FV=VB6hsEHEb8yZmB=xA__47p4vC6dBc528RV37dvAKTgOQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VB6hsEHEb8yZmB=xA__47p4vC6dBc528RV37dvAKTgOQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e3e98fc-fc69-47cb-c6fa-08d9be5d2270
x-ms-traffictypediagnostic: SJ0PR02MB7773:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB77736A29F3C0405C54654218B1749@SJ0PR02MB7773.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfWFned8Yl34z+0eWeJYprNHuD/P9hx/lGFR1FUrhq9rj7dPHRuTTp9797byFbonqaYb7lhLSIaW1GMWgkQtC5oXzoA3UwEneTKFsB8yR4svMkRXYGAXNq1JStPhSReisoB9LON9IZnQ5APWq/GYOEZzGum20q+rPwDee5EsmRKQiPan2vKM0iHYRPPHtnmFbEmEKv5L+hMms81a3uJp+wbFkbP2p7lZ9kaiPsayhpD9HlyJzY45YFcWKZqD513gc5Q3cEIdJNRhl+iSHf/laI7ZaGqEERc8CewwcO3PUzMcDqhE/gZCHMBbOEtd/bgf26q5ANXCn3x2IJ2IO5KsfJQ/2UaPdGy9f07Xwxen1ERKh8WfRfI27w5r5N8NW1F8yXD4Bp3+rvA+tmQKP8xIgPyJqd3z4ywlJPVVOHY4Dckw+DvRc5wiDr+qlpwGrlrJDH9PV73pQQh3FUNYFzZfQDqB+xT4HMrosEJEXLVId8VvGcIspWE6PMC2qJSPDqSJEhmdWOLRxIged4gTF57n0GQNxURi1AS2eW8kCh+l57jZPimNMZ35IW+IoA3aCJchAQo6ZSkfDOkOsN0uw+MAi3MkfH67A+ECMN2rBpM2WY24ssxetzaM0JYojtpoFE7RP2hklOc79PTiCVdv82u0jm0PNSSC5lFhMsuY1li7I/HhFxN/FRaYvPkKSzU7fhg51PloV/1DzQfEC3kuozP4RexPxV8keZBXdV9nkbXjJPbfdngk0qkZ2fEgLuXoeocQKUZCt1M163IGfx+q/Ctz0LtmlMwpwQIY17O33nIjOfw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(316002)(66446008)(64756008)(38100700002)(54906003)(66946007)(66476007)(66556008)(110136005)(122000001)(5660300002)(86362001)(7416002)(55016003)(8676002)(9686003)(26005)(83380400001)(8936002)(33656002)(2906002)(71200400001)(4326008)(38070700005)(508600001)(52536014)(6506007)(186003)(7696005)(966005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm1PMDlBN09JQUtuelk2bWxoUHNLOFA0Y2ZTaHV6aUlVSmI3Yll6Yk9vcnZ3?=
 =?utf-8?B?Z1dZb3VnR3NBY0o4VnExakdTNEZHZFBnRjNBTXNoZVRqM2FSbE1tQzZOOVF2?=
 =?utf-8?B?R21XNWxOMlZxSjZ3MFBXNmhjaXNMeE1sakdBTW9RTWNpSmYxSG9PL0hQREFu?=
 =?utf-8?B?bm4xdGd1R0tQRk5ZalpVbkFqcEo2M0N1WTRtU01qelMwTnVWY3Z5cVRXTVpl?=
 =?utf-8?B?M0llS3Q2QUhQVGRRd1NycHNGODEzYkdoTjZDR1ZVUmpwU0E0K0Z1Q3RsK2xW?=
 =?utf-8?B?UEdSc3hsdVBVSVN1cE5RMzByS0Mvc1kweUVBL1k4TlRSdWUzT0FaaXFSbHR3?=
 =?utf-8?B?LzdHaGRuYm1sbTRKNWRHa3F2WXdockQ3ZTlRYnQwZWJreDNyMjVWRUdFYlpI?=
 =?utf-8?B?T2FicVJob05BQ0JVU1BRSHdNcmg2U2c5bWszUmlQNmVEMW85dXFMR3E5QjNT?=
 =?utf-8?B?bDdIbDhBeWRoVnN1cGc3bXNCN0R3TnVzZEFQMkVQRmdXODRwV3gzTUVwMVZH?=
 =?utf-8?B?bldPVE42T3ZIdmFiRjZMZkMySnhYbDkyWFFuZzlmRXRtQWdWL2tXQS9kRTVz?=
 =?utf-8?B?dFN0L212TzBYcnhpY3p3VnF1VEJoSHJZQzZGYXJIeXJaSlVxTm5KblYrbnZU?=
 =?utf-8?B?ZFNrMmxBU0hRSDBzeEEvczhRUTNlL2tLMTNMb2E4dXVkWDlldWFrS1lMZzBk?=
 =?utf-8?B?ZkFJYUlyb1lGNko0OFJwMmNYQlJWVzROQ0RSbGw0VGJYMWNzdXFyNHVpclhx?=
 =?utf-8?B?a1FSYnI2eFRPK25NZVBFUUM1ZURlc0U5angwNmRBejZjK2h6N3RVYVo3by8x?=
 =?utf-8?B?MllDRUJBSzJVSXRjb2RuSGl2elBiUmFDdnlqV0JXY1JkTHJNZFROYmVMUXRD?=
 =?utf-8?B?cTRNUmhtR0lxOFFWT0k3NFVYQzN6aTFNbHZteUlKaEd2SnFJbDFqc1RvVlJV?=
 =?utf-8?B?UXUwLzhRZDB3MDNCeWt3OWlud3JVR1hVeWM5Y2xSSWhsR1BxNE9kdFRsV0Vw?=
 =?utf-8?B?aUs2NGRPT1N0eWczL2NmcE5PTnRFbTdqU3NTQnNXVkhhZDZPZ0NiSDZ5YnJj?=
 =?utf-8?B?L1RjNE1rSGt4aEpITStqWDJKZUY3enpXVlFZSW4wWWJCUWF3RTcvTEJpTU8z?=
 =?utf-8?B?NktrMThBSzFxMHc0cnZHdEVpVHVhc0NjTXdBM1J1NWwvRUhycWRzdVJRaWYr?=
 =?utf-8?B?YnZDR2NucmQ1TVBlVitkb0ZSa0N1Vjk1V3V3MStJTlNIcjcvQnlVWnRQYkdE?=
 =?utf-8?B?Q1h5QzAyOWRoT0lMNGlCbllHTnVvTzJZNzFRTXRtZXNwb3BjNE5TQVFYUWVV?=
 =?utf-8?B?OGV4bDVCRGRHTmc1SkJBcjNOcmR3enRmQlZJTEhiZzk3VFJLMFVJWk5nV3BG?=
 =?utf-8?B?dGcyZDBlSVl3TWhLR3ZBSjB1S0djUXB5eGVNbFVkOFU0VnN3dWlnYnB1ZHFh?=
 =?utf-8?B?K3QvbWZuQWlYS0lNaDErVEQrdU9MNTZ4ZDZyclBoZFVUc3l0V2l4R3pLdkRL?=
 =?utf-8?B?MDlWUEVZUmFURHJrVmp0SVpaLzVDb0hVVWNBMzhYbEc5N1dmeDFNR29rTXhE?=
 =?utf-8?B?OTY1NHRZaXNSVklkU05Ba0p3U043NjRLTklnSWxHWmNMbkw1WjNKT2U4cm81?=
 =?utf-8?B?amFZMDBTMUlOdk9MeC9ORzZCSXJJYjZKWEJHMlZmQS81Zm9oZ2pJYWgrOHZs?=
 =?utf-8?B?SmVDNGVuMVpiSkZqRGpVZUF4UUwyRWJZbWxwU0ZMNkZuUC9oWVlDSmdDWlRZ?=
 =?utf-8?B?S0FIaXZYOFdPS016dlVaRlZudWJtMUJabW9CNDM1ck13bWYrM1FaN1QxVmll?=
 =?utf-8?B?UTRja3pJZzhVcUV2ditPZHJrWXhqZTB1YWpMNXJ6QWtkSlFCU1NaZHBsUFhw?=
 =?utf-8?B?amVhQzJLVzBUUHQ0MEIyS1p2V3VQSmhzK3lQQitVVDF2SEx2Z3lpMFZkUTlU?=
 =?utf-8?B?eU5kMVVEaWZnU2tyWTBHNk9hQVBROGhwOEtjdWdlcE1BUWpleHdVVmVVYXRR?=
 =?utf-8?B?c2JQaUFsV3BCb0dtT2d0SGpXdyt6TGVLc0RQa3E1MjdUMkJRd0FldWxnTnFU?=
 =?utf-8?B?SVdMZjhZalpYU3lVOUlGbTJiNEV2OWhDb1BpYXA3R3JYVmEvUnIrc2ZOQmdz?=
 =?utf-8?B?TURSY1VvaFBxYlhPVHNKTTl1STFWZE1YVjJxTG9EVDdkR0NvSG5JVThDZndB?=
 =?utf-8?B?VDY0ZFRQYUl4VjUvalRGM241MnNST3pTVDE2aEoxVTladS9PYi9RRkJUa1Nv?=
 =?utf-8?B?aHBwcVlvNWZZbXNDSGNLVUNqSXV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3e98fc-fc69-47cb-c6fa-08d9be5d2270
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 17:22:26.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOVzRBmmBRhB7rtCZ5p8MA/DPqbX1cxVNRnd0nFQx/8hNKJ6r7WojRjhxy7CGNCgOdDPZhaS23irQAtDbp+5FQOU/AqQAvf99dYfYFs/Cp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7773
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNClN1cmUsIFdpbGwgbWFrZSB0aGUgY2hh
bmdlLg0KDQpUaGFua3MsDQpTYWppZGENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IERvdWcgQW5kZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4gDQpTZW50OiBNb25kYXks
IERlY2VtYmVyIDEzLCAyMDIxIDk6MjIgUE0NClRvOiBTYWppZGEgQmhhbnUgKFRlbXApIChRVUlD
KSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT4NCkNjOiB0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb207IG1pY2hhZWxAd2FsbGUuY2M7IHAueWFkYXZAdGkuY29tOyBtaXF1ZWwucmF5bmFsQGJv
b3RsaW4uY29tOyByaWNoYXJkQG5vZC5hdDsgdmlnbmVzaHJAdGkuY29tOyBsaW51eC1tdGRAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3R1bW1hbGFA
Y29kZWF1cm9yYS5vcmc7IHZiYWRpZ2FuQGNvZGVhdXJvcmEub3JnOyBSYW0gUHJha2FzaCBHdXB0
YSAoUVVJQykgPHF1aWNfcmFtcHJha2FAcXVpY2luYy5jb20+OyBQcmFkZWVwIFByYWdhbGxhcGF0
aSAoUVVJQykgPHF1aWNfcHJhZ2FsbGFAcXVpY2luYy5jb20+OyBzYXJ0Z2FyZ0Bjb2RlYXVyb3Jh
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gbXRkOiBzcGktbm9yOiB3aW5ib25kOiBBZGQg
c3VwcG9ydCBmb3Igd2luYm9uZCBjaGlwDQoNCkhpLA0KDQpPbiBXZWQsIERlYyAxLCAyMDIxIGF0
IDEwOjM4IFBNIFNoYWlrIFNhamlkYSBCaGFudSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT4g
d3JvdGU6DQo+DQo+IEFkZCBzdXBwb3J0IGZvciB3aW5ib25kIFcyNVE1MTJOVy1JTSBjaGlwLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhhbnVAcXVp
Y2luYy5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiAgICAgICAgIEFkZGVkIHNw
YWNlIGJlZm9yZSBuYW1lIG9mIHRoZSBmbGFzaCBwYXJ0IGFzIHN1Z2dlc3RlZCBieSBEb3VnLg0K
DQpXaGVuIHNvbWVvbmUgY29tbWVudHMgb24gVjEsIGl0J3MgbmljZSB0byBDQyB0aGVtIG9uIFYy
LiA7LSkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jIHwgMyArKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jIA0KPiBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2lu
Ym9uZC5jIGluZGV4IDk2NTczZjYuLjQ0ZjE5ZjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivd2luYm9uZC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5j
DQo+IEBAIC0xMDAsNiArMTAwLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHdp
bmJvbmRfcGFydHNbXSA9IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTRUNUXzRL
IHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gICAgICAgICB7
ICJ3MjVtNTEyanYiLCBJTkZPKDB4ZWY3MTE5LCAwLCA2NCAqIDEwMjQsIDEwMjQsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9RVUFEX1JFQUQgfCANCj4g
U1BJX05PUl9EVUFMX1JFQUQpIH0sDQo+ICsgICAgICAgeyAidzI1cTUxMm53IiwgSU5GTygweGVm
ODAyMCwgMCwgNjQgKiAxMDI0LCAxMDI0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICBT
RUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCB8DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQikg
fSwNCg0KSSBoYWQgYSBxdWljayBsb29rLiBUaG91Z2ggSSdtIG5vIGV4cGVydCBvbiB0aGlzIGRy
aXZlciwgSSBiZWxpZXZlIHRoYXQgdGhlIG5hbWUgc2hvdWxkIGJlICJ3MjVxNTEybndtIiwgbm90
ICJ3MjVxNTEybnciICh5b3UgbmVlZCBhbiAibSINCmF0IHRoZSBlbmQpLiBFdmlkZW5jZToNCg0K
VGhlIFdpbmJvbmQgZG9jIFsxXSBzaG93czoNCg0KVzI1UTUxMk5XLUlNIGlzIDB4ZWY4MDIwDQpX
MjVRNTEyTlctSVEvSU4gaXMgMHhlZjYwMjANCg0KQ29tcGFyaW5nIHRvIGEgZGlmZmVyZW50IGRh
dGFzaGVldCBbMl0sIEkgc2VlIHRoYXQ6DQoNClcyNVEyNTZKVy1JTSBpcyAweGVmODAxOQ0KVzI1
UTI1NkpXIGlzIDB4ZWY2MDE5DQoNClNpbmNlICJXMjVRMjU2SlctSU0iIGlzIGluIGNvZGUgYXMg
IncyNXEyNTZqd20iIGl0IGltcGxpZXMgdG8gbWUgdGhhdCBmb3IgdGhlICItSU0iIHN1ZmZpeCB5
b3UganVzdCBhZGQgYSAibSIgdG8gdGhlIGVuZCBvZiB0aGUgbmFtZS4NCg0KWzFdIGh0dHBzOi8v
d3d3LndpbmJvbmQuY29tL3Jlc291cmNlLWZpbGVzL1cyNVE1MTJOVyUyMFJldkIlMjAwNzE5MjAy
MS5wZGYNClsyXSBodHRwczovL3d3dy53aW5ib25kLmNvbS9yZXNvdXJjZS1maWxlcy9XMjVRMjU2
SlclMjBTUEklMjBSZXZKJTIwMDMxMDIwMjElMjBQbHVzLnBkZg0KDQpBZnRlciBjaGFuZ2luZyB0
aGUgbmFtZSwgZmVlbCBmcmVlIHRvIGFkZCBteSBSZXZpZXdlZC1ieSAoYW5kIHBsZWFzZSBDQyBt
ZSBvbiB2MykuDQoNCi1Eb3VnDQo=
