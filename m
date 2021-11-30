Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF0462CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbhK3GgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:36:23 -0500
Received: from mail-am6eur05on2074.outbound.protection.outlook.com ([40.107.22.74]:37953
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238594AbhK3GgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:36:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY1VVTI+XKCh+KJ7cJgjey1QuPHKGKGjsHaIfNid8j1mwivQhoUJTCERhXVTHfnE7FFKDqhuxbrdxZpDKq1wfLXo5UxkJV1SI39S2xjHkaliJ7Yh5LkFrT/8bVQ24hXU6tsbvfJzgfQm+0t2XBZUFikuHG37ymShSi5zou5YiR9ntsmVfaqlYzhIQzJ4aGfugC4syKJALYGAl2e45rzTHt5Hrfs4dCeseQF1r5W/wNMm58PhIZ5wbmG3a4D5HaH1aysZdJ6S/zm6aXxNn6bzJnVIY1aNfQ1tDfzf43jcCoCwAQhen3g0i/rATUxyJt+NutKzK/iApxSxQ7rdQgzTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiIOV4hSSz/RRNvwAeoBaeBdK1jJcRI0A3hgRSp+Tis=;
 b=aJsvRdiGdLpp4iLxkwWvs98JOKap+H/L232MpBxKwQf2g5w0H3Ap+U3MvaaLSl7c23w7Bu/bcz42bcgWNmZnrt0QYARWrmAk6kXzqSonAzrUyb52XC0aOmLLLXskmycN3/MVKvkWm28nE5mwpBzg6rwYEX60WULaTfTQvabTlZ1vwXhuftmSi5cPHKPSAnXNI4AJpEip+1hnlH140jBu/xjMiAnOPLZZy7+YvKQAqev/qAiewVbpQYg97yUuh5nRNacY2hbGYGChTc+bbMyDQFxZ7H8nZ84C1RUyPX7fj4lxLFAffmDJZpjU44IMDzgJFI2LT4iZBUUigKVM3fz0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiIOV4hSSz/RRNvwAeoBaeBdK1jJcRI0A3hgRSp+Tis=;
 b=SwyRWXfvke8ReSYB4TDy3VHfxeysWvKNXi7R6w+O17905F0XhZ1IdBrcDgkFejiZ4B5Hqnglhf22QetCfXST79Ooviv/iibfA95l7+jl7J5Pl+DNQ0oMbyYmCFqMPoXfST3VGOTLXEj1++wFlLOqOpUP03P0YlJ74aLUHJZZZBg=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2778.eurprd03.prod.outlook.com (2603:10a6:3:f5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Tue, 30 Nov 2021 06:33:01 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 06:33:01 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        =?utf-8?B?c2hpbWkgPj4g5riF5rC0IOW0h+W8mA==?= 
        <shimizu394@lapis-tech.com>
Subject: Re: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Thread-Topic: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Thread-Index: AQHX2uUgAyZ64u/b2EuYwDXlo7neoqwIjSeAgABDOACADPMrgIAA2WoAgAIXggCAAqqSgIAAU2oA
Date:   Tue, 30 Nov 2021 06:33:01 +0000
Message-ID: <d14580b3-1647-5105-4770-2cd8751d9fe5@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
 <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com>
 <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
 <CACRpkdZXhw9+txdLv-k01nzH3+GvGivyAoCO1JCf2VyYK96CnQ@mail.gmail.com>
 <57f97c5f-aedb-7f7e-d269-90bd97bbba09@fi.rohmeurope.com>
 <CACRpkdZ9EEmWSb4mq7WJywma4dFCms+Z3BAKfntcsb9y_1THNQ@mail.gmail.com>
In-Reply-To: <CACRpkdZ9EEmWSb4mq7WJywma4dFCms+Z3BAKfntcsb9y_1THNQ@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5f39f58-0079-4a4c-7ab7-08d9b3cb41e6
x-ms-traffictypediagnostic: HE1PR0302MB2778:
x-microsoft-antispam-prvs: <HE1PR0302MB277837D9F510FBCB5E69BC99AD679@HE1PR0302MB2778.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ow0905P3IdgmYcC+pdy/T8tLlrKzMxyAdFhnNkC6jDJQ4W5wuZbZMUM8cvyEKapsO6Ah8AljxgZLqNSOiY0ickjR4ml8dKSIxgwFf5D94iXIqwVZSTHx5kQNYsHytXOsINsPSnn/kYwg/qb9rxDij0kD013dYVJCKISpk6BoRwgMOpE8l4gqOO4AqYLvk065tbpbhJc4/pivl5egp3O5w6zMPoNFxkQAgGrMMDbAyv8yV6nec7zjgDsKVknQrNt+ZMHru0QVpUTPEn728xRnlthsoaI+Y+FpXvt1PkzET2mG7hSHp7I9ooHaJDDy8j1X0bep+lcLjQTWzPL4qHPdl/HTfPEx0ZNBPXrBd3t5eoCBmH0c2WUZVoI3H6bRbkDWN5Rfquf+C3EWvAUM1Ffa46wMebnogYhEmO7DWS7AQeZKwhfjAnte7TH2UZopj994WGchYQKIdB43zSD4DMHbjdfSDRkEEGNK1VvnuP8Cj7/zqBzDnCMQP14hU8mqdx3jzUt8UoWDiu0LXx87yo9WB2Q8rNaX83AST5ikYBpenoWu6czY2Ik69RvU4cRIejHzvSMsYxd+V5EJaLaI089PoCNYSTlk65clHTTblII13FZgxUSiM2KPk3iQom5ifYjg2FU7nrjwF8MgNDyHuVl+KCOVmTYrLHISS7KIUCMmKeG/XSTG2RUJKbM021/uvqSeUYhRfvLrisNtUpWf0jr2XazN/+q5prg80AU6ORmxpFpi5k+E+8oRh3E6OgLkfkSd8SgXG+7fejOWtxeHHJ1RaUK44wg2IKHs3Skpw60qML732qGHAb1g18VRr/p0dg3s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6916009)(66476007)(66556008)(38070700005)(5660300002)(64756008)(76116006)(508600001)(31696002)(122000001)(66946007)(6506007)(83380400001)(31686004)(6486002)(86362001)(2616005)(6512007)(186003)(66446008)(7416002)(2906002)(4326008)(8676002)(316002)(8936002)(54906003)(53546011)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEsxR1ZPR0tIcURMOUlGYlFGYWMzSHh3enZDOTVQcGhwQmJSeFBsbXNXWWFo?=
 =?utf-8?B?eTFHRTY2aVM0cENvdURhTnNLT2syZDdVMC90dzNPNHFBc0hCaXh5NkQrWld2?=
 =?utf-8?B?Wmg0bTA0NFlCdXkrRHZkeU9nTXBHb2JHQnY4ZG1yNDhKYkNNMDlFWjVuQ3Rt?=
 =?utf-8?B?YjZCdGRJTTBsM0dVenRjOWlVdy9mKzdXek9RNXQzS0d5VXo5cW4rbU5EZzZK?=
 =?utf-8?B?Y3hJSlBCWXBqK1JRWmFhRFpaYmFMYW9YMjdISTVNZFloUDR0MHhxblBpcTJp?=
 =?utf-8?B?VXRjMVg0dElERHlYTjd3eWtBL0JnVElZL2VmZzg5azIya2VZaXpMeU5NUmZ1?=
 =?utf-8?B?bkhWQWl3OHI0SzdaaTNUY1pCOUFIYmtFd1B1cmFTZW1wcTk5cnJYTG5uZXlL?=
 =?utf-8?B?RkpmNXZBRWF3QnJKcVZNQkhPMExsclIrT1V5RXNBV3k2cExYMTNJK3VabnRV?=
 =?utf-8?B?ZFZuSElTblVTKzBlZGw5NUljcW52S3h1M0R2SjZWaG5UQWVNSG82Tk5RMXE1?=
 =?utf-8?B?d2J1Uk4ya2h0Sjh2UGUzR25yYWFKVHdHcFo3OXBQSFpFSXB2Nzc3K09YNU5V?=
 =?utf-8?B?bjI0R0ZsM0RiVmxUbjdNV2xrOVpjYWFzbVN6YjQ5VWpQOEtya2p5ei8wdHdG?=
 =?utf-8?B?NWhjQlpqcnRqTDlzbDdEWStGVitGRHVlYlNGZ1dhMmx2RHBWVkUwUzAzbmpt?=
 =?utf-8?B?T24zQVNSVjZWeWlQNDRrWWpUcjEwbEdyaVc4b09BNk9LUWVvWWhoVm12L1di?=
 =?utf-8?B?TU9yWVZjUWxFVXEwcUJvc245NXVFSXpPVk1WeTQ2dks4OFd3bm1jYXlwc1Rk?=
 =?utf-8?B?YjFua01wWFl2V3pVci95SUdDT0Q3RWtudVdiSEpLQitzTldFeDkxQWI2SnQ2?=
 =?utf-8?B?TTFyeW1ncjhoc1VDVFBqeFgvZ1lEYVpGdDJqLzRYOWM3WDI1N2pGeXh3YVRV?=
 =?utf-8?B?aXRycXRTdWdKVnAvRVZIU3g4ckxQbkFPMGlTRFhHbU8xeDlpUlRyQ0I4VzdZ?=
 =?utf-8?B?SGlZRmRxU3N2aTFOUGlocWEwTzJpbDRMZEFQVGljSkl4RSttNkNsaHRHWDky?=
 =?utf-8?B?bTZsWlZHN0ZYL3pyYmNZWCtnSzVCR2kreFZxN2tVanVJa3RnMHBCWDlBU3Fp?=
 =?utf-8?B?OXkxTlB0eSs2d1IycGYzOFR6QUZ1cVhXU1RRU09zVFpwWUt6L1VlUG44WVBD?=
 =?utf-8?B?VWIwNDZnRlJlUW9tNEI2aHpXZStuRDNibXIxbm90ZHdUMUxnaExzYmdqaFIw?=
 =?utf-8?B?NzFBRWZQT3c1QlpuZStUNktLNGVFbmRZQU1jdTZqYWxJcWlIaW4xWll6NE01?=
 =?utf-8?B?aTlPSGpxKzRRSjdWRG1kVzdRTW56SzZSN2lwdVBHRTJTakZ3N0krWm5zWWEy?=
 =?utf-8?B?U1ZlckJ5bW92TXdRRXdDMXNuNU9UclYxZTJRcDBJVlVuall0Y3QxaFNuUWto?=
 =?utf-8?B?b0pveFVzQ1lvclE3aDN1NkpWem9taG9rb2hNeU9nbk1kY1JJUGFWSkx2blZ2?=
 =?utf-8?B?SHRJOW5PbzNnbjdFQWZKSTRsSWd4RFFXQ0JBeGU0QmYwNldRcEp2T0w4cFFG?=
 =?utf-8?B?OTR6OUV2NVNnWjczSzBTcUxpSVFJZW5pazU0MlFqS0grVExMQnRJTCtacjBP?=
 =?utf-8?B?UVBKQU5nKzU3RUJpbXhoY1pDNEtDSHlKaEVBak9nY085NkVKZlJLTkp6akVs?=
 =?utf-8?B?ZnRkaUk5Y1JLTXJpdlk5VDVXcnpIY041QTJ3QzltOVFQR0NoalZ2djJxQkIx?=
 =?utf-8?B?T1hoeDBuZE5oTDBxQWdBYWFTRC9mWUJzVFMweW5sakJRMVI2QVNUbkVkTldN?=
 =?utf-8?B?Q0Z0Z3BiTWx4UWZDSG1uRDBCWk53Wk16WVk2R1hSQWpUM1BpejA5RVVISWJv?=
 =?utf-8?B?YTN2cFJsY2ZMUGxEMGdRTWhQWEpoUU5FV0p0UkR5V1ZHdFZZamNxK3R4dlBI?=
 =?utf-8?B?bjRFcW9MUkQzeEY3RFdzditOWkJoZEg3T0hObUdseVkvY1NpUmdBZVpEOWQ0?=
 =?utf-8?B?TWpCR1pGOU5oK3lLNDk3UXFOUnFyTjhVdmVhUHNIL0ZqajBQb3RXTDMycnRD?=
 =?utf-8?B?K2xTY01iRTRqN1NRRGpuMEx6aWhnU2FxWU9iMmdIYkhKc2ZBcVdMN0x2RVJD?=
 =?utf-8?B?c2FHbHpic25DbFlReDl4dHRVb05seTd1S1U2NXRYSjNFOEVSY2R5LzFXSzN5?=
 =?utf-8?B?WU9VS2haQ3NTMDd5cFdWNlp3M2ZKdEZXb2FFOFFjT1lUL0dvRmxkMUhyVUFj?=
 =?utf-8?B?ZXczSHh0NzNXTE9McWE1NWFYZVZOWkg4dmUzcDR6U3dFZURhN3IrYXVWUmF4?=
 =?utf-8?B?N1dIQWZMOS9CU3FUTmtPbHlIMmNZempqWnZzT3lSZlF6eU16YTJ3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C027E90AB900884D843757C87517BEF0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f39f58-0079-4a4c-7ab7-08d9b3cb41e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 06:33:01.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqYe/wK5KXKe9aOMjefwFu+oOCKKEs6vhOkMLRUuuWw/BrEKWCFqQ+CvF2dKNl9svKy5u1ZJ6jDLNpMKrpVnot++EYWZ6FYdTwHlDiZrFeFOFZznkLn1WCyXecc1AImZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMzAvMjEgMDM6MzQsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+IEhpIE1hdHRpLA0KPiAN
Cj4gbm90IHNvIG11Y2ggdGltZSBzbyB0cnlpbmcgdG8gYW5zd2VyIHRoZSBjZW50cmFsIHF1ZXN0
aW9uIGhlcmUhDQo+IA0KPiBPbiBTdW4sIE5vdiAyOCwgMjAyMSBhdCA5OjUxIEFNIFZhaXR0aW5l
biwgTWF0dGkNCj4gPE1hdHRpLlZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4gd3JvdGU6DQo+
IA0KPj4gSSBhbSBwcmV0dHkNCj4+IHN1cmUgdGhlIGN1cnJlbnQgcG93ZXItc3VwcGx5IGZyYW1l
d29yayBhbGxvd3MgdXMgdG8gZXhwb3NlIHRoZSBjdXJyZW50DQo+PiBmdWxsX2NhcCB0byB1c2Vy
bGFucyAtIHNvIGJ1aWxkaW5nIHlvdXIgVGVzbGEgZXhhbXBsZSB3aXRoIHRoZSBzdGFyDQo+PiBz
aG91bGQgYmUgZG9hYmxlIC0gaWYgdGhlIGRyaXZlcnMgY2FuIHNvbWVob3cgZ2V0IHRoZSBpbmZv
cm1hdGlvbiBhYm91dA0KPj4gdGhlIGFic29sdXRlIGNhcGFjaXR5IGRyb3AuDQo+IA0KPiBUbyBk
byB0aGlzIHdlIHdvdWxkIG5lZWQgdG8gZXhwb3J0IGEgY2FwYWNpdHkgYXQgY3VycmVudCB0ZW1w
ZXJhdHVyZQ0KPiBhbmQgY2FwYWNpdHkgYXQgbm9taW5hbCB0ZW1wZXJhdHVyZSAod2hpY2ggaXMg
dXN1YWxseSAyNSBkZWcgQykNCj4gc28geW91IGNhbiBzY2FsZSB0byBzb21ldGhpbmcuDQoNCkht
bS4gSSB3b25kZXIgaWYgd2UgbmVlZCB0aGlzLiBQZXJoYXBzIHRoZSBleGlzdGluZzoNCkNIQVJH
RV9GVUxMX0RFU0lHTiwgQ0hBUkdFX0VNUFRZX0RFU0lHTiANCg0KICAgZGVzaWduIGNoYXJnZSB2
YWx1ZXMsIHdoZW4gYmF0dGVyeSBjb25zaWRlcmVkIGZ1bGwvZW1wdHkuIA0KDQogDQoNCkVORVJH
WV9GVUxMX0RFU0lHTiwgRU5FUkdZX0VNUFRZX0RFU0lHTiANCg0KICAgc2FtZSBhcyBhYm92ZSBi
dXQgZm9yIGVuZXJneS4gDQoNCiANCg0KQ0hBUkdFX0ZVTEwsIENIQVJHRV9FTVBUWSANCg0KICAg
VGhlc2UgYXR0cmlidXRlcyBtZWFucyAibGFzdCByZW1lbWJlcmVkIHZhbHVlIG9mIGNoYXJnZSB3
aGVuIGJhdHRlcnkgDQoNCiAgIGJlY2FtZSBmdWxsL2VtcHR5Ii4gSXQgYWxzbyBjb3VsZCBtZWFu
ICJ2YWx1ZSBvZiBjaGFyZ2Ugd2hlbiBiYXR0ZXJ5IA0KDQogICBjb25zaWRlcmVkIGZ1bGwvZW1w
dHkgYXQgZ2l2ZW4gY29uZGl0aW9ucyAodGVtcGVyYXR1cmUsIGFnZSkiLiANCg0KICAgSS5lLiB0
aGVzZSBhdHRyaWJ1dGVzIHJlcHJlc2VudHMgcmVhbCB0aHJlc2hvbGRzLCBub3QgZGVzaWduIHZh
bHVlcy4NCg0KYXJlIGVub3VnaD8gSSBhbSB1bnN1cmUgdGhlIHVzZXIgaXMgaW50ZXJlc3RlZCBp
biBrbm93aW5nIHdoaWNoIHBhcnQgb2YgDQp0aGUgbG9zdCBiYXR0ZXJ5IGNhcCBpcyBjYXVzZWQg
YnkgdGhlIHRlbXBlcmF0dXJlLCBhbmQgd2hpY2ggaXMgY2F1c2VkIA0KYnkgc29tZSBvdGhlciBw
aGVub21lbmEuIE9yLCBkbyB5b3UgdGhpbmsgdGhhdCBzaG93aW5nIGxvc3Mgb2YgIm5vdCANCnJl
Y292ZXJhYmxlIiBjYXBhY2l0eSBsb3NzIChsaWtlIGxvc3MgY2F1c2VkIGJ5IGFnaW5nKSBpcyBz
b21ldGhpbmcgdGhhdCANCnNob3VsZCBub3QgYmUgZGlzcGxheWVkLi4uPyAoSXQnZCBiZSBuaWNl
IHRvIHNlZSB0aGF0IHdoZW4gYnV5aW5nIHRoZSANCnNlY29uZC1oYW5kIFRlc2xhIC0gYW5kIHRo
YXQgd291bGQgZm9yIHN1cmUgYmUgYSBzdWJqZWN0IHRvIA0KJ3JlcHJvZ3JhbW1pbmcnLi4uIDpy
b2xsZXllczopDQoNCj4gVGhpcyBpc24ndCBpbiBzeXNmcyB0b2RheSBidXQgd2UgY291bGQNCj4g
cHJvYmFibHkgYWRkIGl0IChhbmQgdGhlbiB0aGUgd29ybGQgb2YgVUk6cyBiYXR0ZXJ5IGljb25z
IG5lZWQgdG8gY2hhbmdlDQo+IGluIHJlc3BvbnNlKS4NCg0KWWVzLiBJJ2QgcmVhbGx5IGxpa2Ug
dGhlIHVzZXJsYW5kIGRpc3BsYXlpbmcgdGhlIGRpZmZlcmVuY2Ugb2YgdGhlIA0KZGVzaWduZWQt
Y2hhcmdlIGFuZCBmdWxsLWNoYXJnZSBhbHJlYWR5IG5vdy4gSSBjb3VsZCBhbG1vc3QgY29uc2lk
ZXIgDQpzZW5kaW5nIGEgcGF0Y2ggaWY6DQoNCmEpIEkgY291bGQgZHJhdyBpY29ucyAvIGRlc2ln
biBVSXMgLSB3aGljaCBJIHJlYWxseSBjYW4ndA0KYikgSSBrbmV3IHdoaWNoIHVzZXJsYW5kIHNv
ZnR3YXJlIHRvIHBhdGNoLi4uDQoNCj4gDQo+Pj4gVGhlbiB0aGUgcXVlc3Rpb24gaXM6IGlzIHRo
ZSBtZXRob2QgdXNlZCBieSBSb2htIHVuaXZlcnNhbCBhbmQNCj4+PiB3ZWxsLWtub3duIGFuZCBz
b21ldGhpbmcgbWFueSBjaGFyZ2VycyB3aWxsIGRvIGV4YWN0bHkgdGhpcw0KPj4+IHdheSwgc28g
aXQgc2hvdWxkIGJlIGluIHRoZSBjb3JlLCBvciBpcyBpdCBhIHBhcnRpY3VsYXJpdHkgdGhhdCBz
aG91bGQNCj4+PiBiZSBpbiB5b3VyIGRyaXZlcj8NCj4+DQo+PiBJIGFtIG5vdCBzdXJlIHRoaXMg
aXMgdGhlIGNvcnJlY3QgcXVlc3Rpb24uIEknZCByZXBocmFzZSBpdCB0bzogV291bGQgaXQNCj4+
IGJlIGJlbmVmaWNpYWwgZm9yIGRyaXZlcnMgdG8gY29tZSBpZiB0aGUgY29yZSBkaWQgc3VwcG9y
dCB0aGlzDQo+PiBmdW5jdGlvbmFsaXR5IC0gb3IgaXMgdGhlIGZlYXR1cmUgdW5uZWNlc3Nhcnks
IG9yIGFyZSB0aGVyZSBiZXR0ZXINCj4+IGFsdGVybmF0aXZlcy4gSWYgY29yZSBkb2VzIG5vdCBw
cm92aWRlIHRoZSBzdXBwb3J0IC0gdGhlbiBpdCBpcyBhIGhpZ2gNCj4+IG1vdW50YWluIGZvciBv
bmUgdG8gY2xpbWIgaWYgaGUgd2FudHMgdG8gdXNlIHN1Y2ggaW1wcm92ZW1lbnQuDQo+IA0KPiBJ
IHRoaW5rIHdlIG5lZWQgdGhpcy4NCj4gDQo+PiBJIHRoaW5rIHRoYXQgdGhlIGFncmVlbWVudCB3
ZSBjYW4gZG8gaXMgdGhhdCB0aGUgT0NWK3RlbXBlcmF0dXJlID0+IFNPQw0KPj4gdGFibGVzIGRv
IG5vdCBwcm92aWRlIHF1aXRlIHNhbWUgaW5mb3JtYXRpb24gYXMgdGhlIHN1Z2dlc3RlZA0KPj4g
dGVtcGVyYXR1cmUgPT4gY2FwYWNpdHktZHJvcCB0YWJsZXMgd291bGQuIFdoZXRoZXIgdGhlcmUg
YXJlIGJldHRlcg0KPj4gYWx0ZXJuYXRpdmVzIC0gb3IgaWYgdGhpcyBpcyBnZW5lcmFsbHkgdXNl
ZnVsIHJlbWFpbnMgdG8gYmUgZGlzY3Vzc2VkIC0NCj4+IGFuZCB0aGlzIGlzIHNvbWV0aGluZyB3
aGVyZSBJIF9kb18gYXBwcmVjaWF0ZSB5b3VyIChhbmQgZXZlcnlvbmUgZWxzZSdzKQ0KPj4gaW5w
dXQhDQo+IA0KPiB0ZW1wZXJhdHVyZSArIE9DViA9PiBTT0MgaXNuJ3QgZW5vdWdoIEkgdGhpbmsu
DQo+IA0KPiBXZSBwcm9iYWJseSBuZWVkIHNvbWV0aGluZyB0byB0ZWxsIHVzIHdoYXQgdGhlIHRv
dGFsIHVzYWJsZQ0KPiBjYXBhY2l0eSB3aWxsIGJlIHVuZGVyIGRpZmZlcmVudCB0ZW1wZXJhdHVy
ZXMuIEkgc3VzcGVjdCBhbg0KPiBpbnRlcnBvbGF0ZWQgdGFibGUgaXMgYmVzdCB0aG91Z2gsIHRo
aXMgaXMgZ29pbmcgdG8gYmUgcXVpdGUNCj4gbm9ubGluZWFyIGluIHByYWN0aWNlLg0KDQpIbW0u
IEZhaXIgZW5vdWdoLiBNYXliZSBpbnN0ZWFkIG9mIHByb3ZpZGluZyAndGVtcGVyYXR1cmUgcmFu
Z2Ugd2hlcmUgDQpkZWdyYWRhdGlvbiBpcyBjb25zdGFudCcgd2Ugc2hvdWxkIHNpbXBseSBzdXBw
b3J0IHByb3ZpZGluZyB0aGUgDQpkYXRhLXBvaW50cy4gRWcsIGFuIGFycmF5IG9mIGtub3duIA0K
dGVtcGVyYXR1cmUtW2RlZ3JhZGF0aW9uL2NoYW5nZV0tZnJvbS1bZGVzaWduZWQvZnVsbF0tY2Fw
YWNpdHkgcGFpcnMgYW5kIA0KbGVhdmUgc2VsZWN0aW5nIHRoZSBiZXN0IGZpdHRpbmcgbW9kZWwg
dG8gdGhlIHNvZnR3YXJlLiBMaW5lYXIgDQppbnRlcnBvbGF0aW9uIGlzIHNpbXBsZSwgYW5kIG1h
eSBzdWZmaWNlIGZvciBjYXNlcyB3aGVyZSB3ZSBoYXZlIGVub3VnaCANCm9mIGRhdGEtcG9pbnRz
IC0gYnV0IHlvdSBhcmUgY29ycmVjdCB0aGF0IHRoZXJlIHByb2JhYmx5IGFyZSBiZXR0ZXIgDQph
bHRlcm5hdGl2ZXMuIE5pY2UgdGhpbmcgaXMgc29mdHdhcmUgaXMgdGhhdCBpdCBjYW4gYmUgY2hh
bmdlZCBvdmVyIHRpbWUgDQotIHNvIGV2ZW4gaW1wbGVtZW50aW5nIGl0IHdpdGggbGluZWFyIGFw
cHJvYWNoIG1lYW5zIG9wZW5pbmcgYSByb29tIGZvciANCmZ1cnRoZXIgaW1wcm92ZW1lbnRzIDsp
DQoNCldlbGwsIEkgZG9uJ3Qga25vdyBob3cgY29uc3RhbnQgc3VjaCBkZWdyYWRhdGlvbiBpcyBv
dmVyIHRpbWUuIEkganVzdCANCmd1ZXNzIGl0IGlzIG5vdCBjb25zdGFudCBidXQgbWlnaHQgYmUg
cHJvcG9ydGlvbmFsIHRvIGFnZS1jb21wZW5zYXRlZCANCmNhcGFjaXR5IHJhdGhlciB0aGFuIHRo
ZSBkZXNpZ25lZCBjYXBhY2l0eS4gSXQnZCBiZSBuaWNlIHRvIHVzZSBjb3JyZWN0IA0KYXBwcm94
aW1hdGlvbiBvZiByZWFsaXR5IGluIGRldmljZS10cmVlLi4uIFNvLCBwZXJoYXBzIHRoZSBkYXRh
LXBvaW50cyANCnNob3VsZCBub3QgYmUgYWJzb2x1dGUgdUFoIHZhbHVlcyBidXQgdmFsdWVzIHJl
bGF0aXZlIHRvIGFnZS1jb3JyZWN0ZWQgDQpiYXR0ZXJ5IGNhcGFjaXR5IChvciBpZiBhZ2UgY29y
cmVjdGlvbiBpcyBub3QgYXZhaWxhYmxlLCB0aGVuIHZhbHVlcyANCnJlbGF0aXZlIHRvIHRoZSBk
ZXNpZ25lZCBjYXBhY2l0eSkuDQoNClNpZ2gsIHNvIG1hbnkgdGhpbmdzIHRvIGltcHJvdmUsIHNv
IGxpdHRsZSB0aW1lIDopDQoNCkJ5IHRoZSB3YXksIEkgd2FzIHJlYWRpbmcgdGhlIGFiODUwMCBm
dWVsLWdhdWdlIGRyaXZlciBhcyB5b3Ugc3VnZ2VzdGVkLiANClNvLCBpZiBJIGFtIGNvcnJlY3Qs
IHlvdSB1c2VkIHRoZSBiYXR0ZXJ5IGludGVybmFsIHJlc2lzdGFuY2UgKyBjdXJyZW50IA0KdG8g
Y29tcHV0ZSB0aGUgdm9sdGFnZS1kcm9wIGNhdXNlZCBieSBiYXR0ZXJ5IGludGVybmFsIHJlc2lz
dGFuY2UuIFRoaXMgDQpmb3Igc3VyZSBpbXByb3ZlcyB0aGUgYWNjdXJhY3kgd2hlbiB3ZSBhc3N1
bWUgVkJBVCBjYW4gYmUgdXNlZCBhcyBPQ1YuDQoNCkVwaWxvZ3VlOg0KSW4gZ2VuZXJhbCwgSSBz
ZWUgYnVuY2ggb2YgcG93ZXItc3VwcGx5IGRyaXZlcnMgc2NoZWR1bGluZyB3b3JrIGZvciANCnJ1
bm5pbmcgc29tZSBiYXR0ZXJ5LW1lYXN1cmVtZW50cy4gU29tZSBkbyB0aGlzIHBlcmlvZGljYWxs
eSAoSSB0aGluayANCnRoZSBhYjg1MDAgZGlkIHRoaXMgYWx0aG91Z2ggSSBsb3N0IHRoZSB0cmFj
ayB3aGVuIEkgdHJpZWQgdG8gc2VlIGluIA0Kd2hpY2ggY2FzZSB0aGUgcGVyaW9kaWMgd29yayB3
YXMgbm90IHNjaGVkdWxlZCAtIGFuZCBtYXliZSBmb3IgDQpmdWVsLWdhdWdpbmcpIG9yIGFmdGVy
IGFuIElSUSBpcyB0cmlnZ2VyZWQgKGZvciBleGFtcGxlIHRvIHNlZSBpZiBjaGFuZ2UgDQppbmRp
Y2F0aW9uIHNob3VsZCBiZSBzZW50KS4NCg0KSSB0aGluayB3ZSBjb3VsZCBzaW1wbGlmeSBhIGZl
dyBkcml2ZXJzIGlmIHRoZSBjb3JlIHByb3ZpZGVkIHNvbWUgaGVscGVyIA0KdGhyZWFkIChsaWtl
IHRoZSBzaW1wbGUtZ2F1Z2UpIHdoaWNoIGNvdWxkIGJlIHdva2VuIGJ5IGRyaXZlcnMgKHRvIGRv
IA0KZnVlbC1nYXVnZSBvcGVyYXRpb25zLCBvciB0byBqdXN0IGNvbmRpdGlvbmFsbHkgc2VuZCB0
aGUgY2hhbmdlIA0Kbm90aWZpY2F0aW9uKS4NCg0KQmVzdCBSZWdhcmRzDQoJLS1NYXR0aQ0KLS0g
DQpUaGUgTGludXggS2VybmVsIGd1eSBhdCBST0hNIFNlbWljb25kdWN0b3JzDQoNCk1hdHRpIFZh
aXR0aW5lbiwgTGludXggZGV2aWNlIGRyaXZlcnMNClJPSE0gU2VtaWNvbmR1Y3RvcnMsIEZpbmxh
bmQgU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0KOTAyMjAgT1VMVQ0KRklOTEFORA0KDQp+fiB0
aGlzIHllYXIgaXMgdGhlIHllYXIgb2YgYSBzaWduYXR1cmUgd3JpdGVycyBibG9jayB+fg0K
