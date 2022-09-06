Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E1D5AE0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiIFHXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiIFHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:23:03 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364A74BA5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:23:01 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-TtVczS-9O5i2R3pGGbef9Q-2; Tue, 06 Sep 2022 09:22:58 +0200
X-MC-Unique: TtVczS-9O5i2R3pGGbef9Q-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0920.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Tue, 6 Sep 2022 07:22:56 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d10c:ccdc:19a2:a141]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d10c:ccdc:19a2:a141%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:22:56 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Thread-Topic: linux-next: Fixes tag needs some work in the imx-mxs tree
Thread-Index: AQHYwXCGn+NEWalC/Uia5VqERQqsTa3SABYA
Date:   Tue, 6 Sep 2022 07:22:56 +0000
Message-ID: <c2131428c8398da5c1b4d9c5c0a491c2a262bb74.camel@toradex.com>
References: <20220906073746.1f2713f7@canb.auug.org.au>
In-Reply-To: <20220906073746.1f2713f7@canb.auug.org.au>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9a095f4-2223-4140-0bb3-08da8fd89ee2
x-ms-traffictypediagnostic: ZR0P278MB0920:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: W+gPftVbS7xy5hLvh/TpznkEl3zpQxPMbza7efn35Mt5t7IxgSMvpjKIicdg1sKdiA5TqsvbSXbbSQb2crBvXSvY34EfbJaDlkBIWeL0TFFO0Bvsydg4bHkHY4RbW60t1peQ272o2o6kKkdDNgy1ZPQCCyHPMiKm5hVFx4PubjzPRt0da9uWkm9YOSw+yPWkBkKn/M+6wHWogzeixd3V/95VdfEr5KYD9vdD7IbBU8foEFzrvTgkNkdaB5Frn4lMHq3RXbBcjrZtW3C9W9+/HN9JQtGrFSFAqrGHVMU7H2VWJJCotweJWRwTSrbA0I3OsSJnoZjrdI5v2DL6ftt8IeH+jpxjkw6uNw0qmE3PTbv96WG+kGxJoAuAca6UJLpXNGcpsJpIor6EO43GMFK1oH+kaqt2ZtaZQNC11UYtGFKRQrjVZSOp7o+H3BWooMbIoN93a6rVROmECiMiUzcf1zUYYfjOTlgLfJOcNtxd5/HKwDbfUspIBO2Z0SUEJDGN+mE/dNZqPcTvdR3WB5/QY8cgtGoION47ao5T4hxLJz4uyCILaE4xhAAU+6LwVe+JIbxJxZoUVnw51aN9xnFLXuTOFxOdPUKgA0hH8JN+MraEtXNGLeaEuS1+jS1vsI/KTY/R/NBvU9EKr6IP15hFpM8tx9h4fqBO9XlUoUG4QTRnIue1eE+Ry/7osUrvdaAf9FoOty+ZZ5vBVFc5xmb+Pmhg4R49+WDQWlZbvU1lwJaDXdTRJahTCj2hw1mnVqKy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39840400004)(396003)(366004)(346002)(64756008)(2906002)(66476007)(66446008)(8676002)(66556008)(76116006)(4326008)(66946007)(4744005)(36756003)(110136005)(54906003)(44832011)(5660300002)(8936002)(316002)(186003)(71200400001)(41300700001)(6486002)(6512007)(2616005)(26005)(6506007)(38070700005)(38100700002)(478600001)(86362001)(122000001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTM0a1NPUEFpaGtONXNIZ3UyU3hWUjdNbXBLNUZlUy92bDNqanBad0JRRTAz?=
 =?utf-8?B?dW5KeDZGMFRQVi9PUmJhSUNXZUFGdE1QelhZdTdCd1Q4YSs1K1ljYWdpTnVV?=
 =?utf-8?B?Nk1VSUxDSXQ4dXpzU2N5b092eDE5Tjl2NDhKcDhqUE14UGJjenQvVnBWSGZF?=
 =?utf-8?B?SThFQyt2QmNVV3NpVTZ4cVphcC9NNEcra0NUb3R6eERTNjlIY2taNUZaSXdj?=
 =?utf-8?B?WktYQzV1K0lwNXN3Nlc0anJNMUc1Ymx6VFozUFViaG1HaHJxOWNyNkh4QWZU?=
 =?utf-8?B?ZlZUMGQxVEIyMXFoMFhXa1VrN3hHNGdsN05lN25YdStsZnR3aHpHdkJyOEk2?=
 =?utf-8?B?eU5hSmkxd1liclhXdHo2czI1THM1cHUvYTY2c1dRNmNkV3VDWmd4dHZ0eFpO?=
 =?utf-8?B?YWJ3TkQrTkY3YXBBNXhxaFlTQ2ZXVVA3dkVaWnU1V2Q4c1h2cGZMcVozaitZ?=
 =?utf-8?B?aE14VW0ySnV4cENvMzdLNS91SGRTdkdtbTgwcEZnL2ZQZzJEdXFrQjVLR2I2?=
 =?utf-8?B?Q0Rha0ozNnYzM1VjQ2g4Z2kzZk9CNFlOZHZlSFpxeW5hcjJPUnVFVmJEM0k1?=
 =?utf-8?B?bW9zZ2Y5bkVNaEt1bTlVbUR6bUxZOThoMndoL3lnaWw1Rmw1YjZOZmQwaUVD?=
 =?utf-8?B?SGk1SHltTDhLK1AyUEFSWmVoUTl2VG9hY05KMHZ0eWg3T0FCaDAvRlgxcDN3?=
 =?utf-8?B?ZTNyUDVEOFkydDA1MHJMdDBZb25yNlIwYWVPQVRjK1lTRnNaejdCV3Fyb214?=
 =?utf-8?B?c0hOMTIxeUMrbmJVKy8ybHlTbWVwS1V1eXpEZ3dRUWxmbWc2eW93VEtpdWlx?=
 =?utf-8?B?M3lUcmhQa2ZkUXRLbXBTc0pYMWd1RGdwSkxpMlV3b3lFaUJpZUxHWXBkQ0pX?=
 =?utf-8?B?N1ptMFJhYU9pMFRDY1FLZXhLanlxV0xrYkd3RmtlTzZvamdNV1NXRWFlR2to?=
 =?utf-8?B?LzBhQ0tmQW1BeHhoZ2huRWZQOEJGL3VxZDdnSUZBUytmd0V5M1lUM045aFQ0?=
 =?utf-8?B?YzdWN0thdlRCMTJaZFRGR3E1aFZiRjk2ZkNuc0hhSi91VFVhcVhDODU0S1JW?=
 =?utf-8?B?eDVKd3VDUFVFQ0pSUy84eGVKV1N0eFhwbjkwREpxVHlQOHcvd2djaENsMXpy?=
 =?utf-8?B?UFQ0dnBxaFlLcVpMOVBJRWNhT2ZGTkFtL2ppaDZnWmxxSVhGZE9NeDRpWWlp?=
 =?utf-8?B?VTFmaHJ6c01JM2lNaGN4c3llT2V2a2dPQjZxdXhuQVFheUcxODNmRkJReE9V?=
 =?utf-8?B?RXdXaXgvV01PYStWY1Byclc4TThXbXg2Zno2Wi9VM1BqY3ZhYTNYSXgvZlBS?=
 =?utf-8?B?d3B2dUgreklQSFg0VnFjTmNPZnU0ZmhaYUdRUmVjQ2piY1lMLzFGK2pVdUdt?=
 =?utf-8?B?d0RQM1ZWQ0pCVXZwT0RHR01hVXVMbXdmRXBpa3M1cG0za2JQSWZMK2dMQVZl?=
 =?utf-8?B?Z2c4ZklodnRRcU9mY3AyVkw3WlhMQU4vakZNOXdzNzhUWDFzZ0d5cFRmWlFU?=
 =?utf-8?B?dWR5UjFKM0hOUEFmMmJ1bDh2bWJpN1k5UCtnVXRGUW5DMW1HNFZMcjVqb2da?=
 =?utf-8?B?ckdPeEpvRGloMUVzYXNUSmtyUHBDZlVsc1phVm5pdGltbWhaS1pWMjE1SjR6?=
 =?utf-8?B?TER4Q3JLaVMzYUlUMkJFcEhpWHpTZ29yWi9pVnNBMU9qcHI5L3FmQ3RBNHdZ?=
 =?utf-8?B?bmQ1RFJmbXFQYVYrL3RWanJyTkJIcHppRlV3RWUwQlV3Q3V2eU4vMkg4cXhP?=
 =?utf-8?B?R2Vyd1FjOEVXcm9zZ01mSjZSVUJ4YUtrSTI0NzlzNkJIZUQvSFNvZjVDL0Zh?=
 =?utf-8?B?bTZqcVU0RWJjNmVTZFdObXJPRXBySy82azVjbWg4WlBHTmxTOEMxdGozS3pv?=
 =?utf-8?B?bFhPVFdwVndtbjhsUlY3OThkbUl6OFU1eWFHL3prQmFpT1kvZk4zbi90VERS?=
 =?utf-8?B?Mlg5Qld3MXFqMWlzSzgwYTlSSGVXSkhNeWJibjlXRFp6V1ljZU0vTVVKVW9Q?=
 =?utf-8?B?WXJocVFYNk43UGFSMGNQa0hRbUU2V2EzMkVlUzJaWjVKU1ZMQXFrQzRWckhT?=
 =?utf-8?B?eUdaR3p6Ylc2aFBUbFNXMkJaUzZpTk9YaXdTOWlPa2JKTHpDUE9QaE9RUHFl?=
 =?utf-8?B?NDlDR1kxbWxod2VuK041eXFtNG1IRGJ6VVR1MmlHb1Fldkc3SzdvamorSWhy?=
 =?utf-8?B?eVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a095f4-2223-4140-0bb3-08da8fd89ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 07:22:56.7199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MH+YvKb2VZZT2vqO91XcIxbinhz3iJjIYDrWa/WDL0luQG5HpSZ2tb3O05xToyuptVPYxAfpQTR3BVjpFmFff5F/+73BJVqPBjE3iXpksTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0920
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <4B804D3F5B72D04299703AE075FC934C@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiBhbmQgU2hhd24NCg0KT24gVHVlLCAyMDIyLTA5LTA2IGF0IDA3OjM3ICsxMDAw
LCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3RlOg0KPiBIaSBhbGwsDQo+IA0KPiBJbiBjb21taXQNCj4g
DQo+IMKgIDQ3MTcwNDg3ZjY3NCAoImFybTY0OiBkdHM6IGlteDhtbS12ZXJkaW46IGV4dGVuZCBw
bWljIHZvbHRhZ2VzIikNCj4gDQo+IEZpeGVzIHRhZw0KPiANCj4gwqAgRml4ZXM6IGNvbW1pdCA2
YTU3ZjIyNGY3MzQgKCJhcm02NDogZHRzOiBmcmVlc2NhbGU6IGFkZCBpbml0aWFsIHN1cHBvcnQg
Zm9yIHZlcmRpbiBpbXg4bSBtaW5pIikNCj4gDQo+IGhhcyB0aGVzZSBwcm9ibGVtKHMpOg0KPiAN
Cj4gwqAgLSBsZWFkaW5nIHdvcmQgJ2NvbW1pdCcgdW5leHBlY3RlZA0KDQpTb3JyeSwgSSBtaXNz
ZWQgdGhpcyBhbmQgY2hlY2twYXRjaCBkaWQgbm90IHdhcm4gYWJvdXQgdGhhdCBvbmUuDQoNCkBT
aGF3bjogQ2FuIHlvdSBmaXggdGhpcyBvciBkbyBJIG9yIFBoaWxpcHBlIG5lZWQgdG8gZG8gYW55
dGhpbmcgbGlrZSBzZW5kaW5nIHlvdSBhbm90aGVyIHZlcnNpb24gd2l0aCB0aGlzDQpmaXhlZD8N
Cg0KQ2hlZXJzDQoNCk1hcmNlbA0K

