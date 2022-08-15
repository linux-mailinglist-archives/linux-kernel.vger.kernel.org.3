Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC59592A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbiHOIEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiHOIEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:04:13 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D81E3EF;
        Mon, 15 Aug 2022 01:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H415QnhOekKO9100si4/8omI158MyBd75NeKNmevbE5pIdqV7RykYWtBuYWPWZmgjLPKqCRJiBsWcoKLLzPzjCGmzWdZZD9LGZ34V+Tw9scnq2WAa8e8GKZjwl9iXxKFdafGX2gM0fVksO9C4+ug7g8ODC7/CoSoJAu6HjtBbzPHHJdOB44XLQla5RIjPMlKNy5b74Ghxl+od6MI0xtwBUceZTZ3LuX5mPhQu01H6G7JqaHSzHYy1DeKXlL/lUJgHj6FPY3N2axGxvts5RKU+4yMzlp1tb9bYotOVqOjnGyoQHQwIohL4BZ0902a1R/RchKtXBIPfiWY8k/XVfwjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4niTurLRtBFLqUjzi2mL3EDu9R0HYLcP/andPw72q5E=;
 b=PXric+AfyqZYPQH7Ps2jj937YLgaPFZVTjfkTi2qG5aiyrfU2DqjaJHxX0jMSemeeLvAcT3B+SsbYM7av7jSlhh9HWro1oL49maSd2Ydd4mn8HuiJDKjsdnelkqIDWdnFoipJGCkzc8xY7IQwnrlWsYKhCK/k5VQ+LwbhROT9TBp85kUH+Afk6DLU4DTr0cWQrpSCtJ1WopOYjgp2cO4U8PRgcwgk/PS/4kKlk0nW13P/ZOcdrmfB4GhSLtpzyR1NxF8N8XZzCGUSvf58/m+ulk4lgzXv3gnep2HoH92SvVthOJ5QGGSJCpof8afnqDIje3BPQgTSNZQ5/xVQAY2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4niTurLRtBFLqUjzi2mL3EDu9R0HYLcP/andPw72q5E=;
 b=MNzh61eNww9nGZRWDdPH0HLG+Z23wK7CXnw9ClEKsxdYqev5eO3dQI7SyRMsox6BcSyJqKnlKmd3rtykji22BJLoQPGRTHFDfBS1i+QkQpFnUfuhyl+8oih1uvL4FhOxwpog/ToOVCE8ax6rrIoudAKzfYJY5FNT2RcROUZ7Wvc=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8248.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 08:04:09 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::655b:f2cb:9c62:de0]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::655b:f2cb:9c62:de0%7]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 08:04:09 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] tty: serial: lpuart: disable flow control while
 waiting for the transmit engine to complete
Thread-Topic: [PATCH V2] tty: serial: lpuart: disable flow control while
 waiting for the transmit engine to complete
Thread-Index: AQHYp9Cq1lLe0+gYXUeTxqVAptUi562vq4ng
Date:   Mon, 15 Aug 2022 08:04:09 +0000
Message-ID: <AS8PR04MB8404EB2F6EDA79EB7A2BF4F292689@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220804070420.32186-1-sherry.sun@nxp.com>
In-Reply-To: <20220804070420.32186-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed374a30-e730-4a2d-d7e4-08da7e94bbb2
x-ms-traffictypediagnostic: AS8PR04MB8248:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jSK0by16zA7nAYzNOtyxRh3U8I7vW/7ZXEUYPsc1V0fs+YckXcOCwKEs2QitZs8PVSaEHT/C+5gjl6bmMi5GmYZ7QTpJwb00QKsU66o4+V7C25iCLH5MQEy0lBs8U39P1LiSH8RkXZPgfbfw2YDeVgB8pQzkuWe0o38JnVEPwHOqPyEHZybCDD3zdsgF3sl300/mWahVQgj30KEorOkgyOypfV3yCABA5LC8vP8eGWkrpD30lRRFGGsmZa7V4PYd9BmR1b2AUNhcXhhs90BDJ9N/Q4cubP87yTdJZiuxC9aVy4Od7XIRohnJr3PBLOiSEMtaGgL+0OUxAPh8PKq1ZlAgBEyydp0pIqqOPfcYhvkP7+5S52zO2rhkOZFmVVp3iJKhocxp1cNr0O4WuJ4XSmQjQwRDBp2V2FWXQkU8tQuJno1FXG5taNWj+gytLc4okS2/2UYFvB+vXgqVipVOqT2R5dc13MmO88uWQeTbztfoUcDD+Dut0H4DbLagYSeSQVHNivKTwjQqE7tHfkSbFAZ/P/qJP3RRYAYNyCshwJufGk7wcp24qnjIphCMlOqnq92hPZ1XFYeTtAo7Pq7s7p6/ULhOXWyHJyPM3gOmihil6fdfZ95aLabd+4CpzCdMOF0uLI9SAjls70YlHEYXqBFjZip9MX2bV/iqzYVqj7pXtJSXPUWEJGj4rRAAJEBBEWRR27/XuDpZKOblfoR4oE7BaKa5WNZbC74SLiJLoTPRy6dhbeNG90Csf7LF9c0IXKN5MciW5TCGyd6+0cPvZZ8K12CnWYg3BNG3KeC5MKc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(86362001)(38100700002)(186003)(76116006)(83380400001)(8676002)(38070700005)(122000001)(5660300002)(66946007)(64756008)(66556008)(66476007)(66446008)(4326008)(316002)(8936002)(44832011)(52536014)(7696005)(9686003)(6506007)(41300700001)(26005)(53546011)(54906003)(71200400001)(110136005)(478600001)(55016003)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TTBxR3FQd1E1UFR1N1NJZTVWZnc2a3RGVXlyd01lSkxDcE1CZzZnNGlWaStt?=
 =?gb2312?B?ZHZ3MUEyc0FDR1B1ZE5QeXFyQU8zNnRzWTRJc0t3TjVHZzlYeVM2M2pFWmJh?=
 =?gb2312?B?RU94enlvS1dNTTdleWZjMStIdHZMR3RrTnBqVXZwM1crTTVJeGtMdjZRUU1V?=
 =?gb2312?B?MXQ3Nm1sbkZQcDUyMGIwR1ZZdFlhTXp6Vk9MYWRzblZrRmNac0FKeGRnb29z?=
 =?gb2312?B?MVR1Wk1GckpPR3lJcE9YVktjNVhLZWFuZ2ZHRjk3c0VjcUVIOGtTWC9Vb2R4?=
 =?gb2312?B?WC9GL1pRRUtCcE0zdGloNFlVTG05bnRGVndrUUpvOTRxcDV4c0czV2d0OTlM?=
 =?gb2312?B?byt0cnhyRWFPNmkzVk5SSU1YZEx5bGk2ZGN0SjhOTHZkOVR0VG9yODNESHRM?=
 =?gb2312?B?Z2NHQjFDSE1mVndZc2o3MGNUaFlSbnROWWRZSVdPWHdPdkw1enlhUVY2NWt6?=
 =?gb2312?B?WVFxN2NvOWplanI4Tnk3SHFuV0xFYklNNjBieFVwbXhoNDJieGZQaE44U0to?=
 =?gb2312?B?T0dFMTRMKzloNmZHNWIzYTJEQ1NNMVRSYU1HblVpOFdPTVhlQVo1bU9KVzYr?=
 =?gb2312?B?TTBTK0s2dkhuVVhZc3lmZ0lpL3BBdkJYdEtxak4wbTZ1YUtwNnNrZ0QxMEVE?=
 =?gb2312?B?ZDdiUmMrWXA0QzVqbndrWWY2Wk5ZTjVBbzAxQnRBSkVXbU93dURjYmpuYmk3?=
 =?gb2312?B?N04xVFdNc1Rlc0tGMDh2dVJaL3ZHRFJvZnc0VmFHeC9qaTNuWjU5SkVKaHBq?=
 =?gb2312?B?dUc1Q0dHOGtUVDQwR2oyMzJiNXN3S0FIbnRyYjBTZnF3OUtjb01xbk00Nm5i?=
 =?gb2312?B?QWEvemk1NkcxRkF5dGtWWUlkYU5CZEIxUy9NMnMvOWo5eDlLZFV5azZjVmVn?=
 =?gb2312?B?cVd0NWlRclZRVDNjMVJBalFzbmhSRXo3a0VLSkRRRFA4SERYWmVNSU5ZeXBp?=
 =?gb2312?B?VDhkNHhtenQ1SEVwTGFaZDcrTnRUNXI4cnpzK29lZFlDSGF1ZW0rOFJRWnB3?=
 =?gb2312?B?aS92VHROYTBhU09vWnZMTnBuL2Q5aG1nT1V3YkZ5c2xFVXFxRGZ5aE83VmRJ?=
 =?gb2312?B?S3RlWUxrWUp6YlU2dm9VUlk4Zlhwdk9Wc0c4cDQrM0luc2UvS1ZHZWtoMFVv?=
 =?gb2312?B?cUFoMXNjZ2hkdmhjMGl0N2tZanNYeEY4NDlOY1FSNWkrZjBIbjBiU1FsQVZF?=
 =?gb2312?B?dEdtTXJIZExSaEZ3dnVoQVNjZzF3OUMvUkVDL29FdGpzUTFEQ2cxaXFKR0U0?=
 =?gb2312?B?eDJCU3MxVE9NSzlJY29GMHRJb0NBWFd2MmI3TUZvbVkyVU4wMEFQbG5oRTZz?=
 =?gb2312?B?NUNxRHFkYnYwUFZFdlIwSUh3OHczc2EyOEhlRDJmNkVMSFVVUkZxYmhUbWIy?=
 =?gb2312?B?dmI5MFdHRXlUS1VuN2o2OGJRWGg1NVVrWlhUajkwWFZ1SEpxTWJRYWxmUWlh?=
 =?gb2312?B?NUhuMlNjNzlacXFNeVFheEkxN3lzcXZQRGNPbFlmMHpxemZxOVkzQzA3d2pa?=
 =?gb2312?B?NzYwaFpodmprNEJ1eVhiQTRqUFpvS1o5b0djcGhWSlVZbEZtbmd3R090aEF5?=
 =?gb2312?B?a2IzT1BIbnY2NHRSMHNnTUtRNUJ6VS9RYk1rVWdWWmhyU2g1enRCN0hCVEUr?=
 =?gb2312?B?QmVyWUpxZXc3K3Z2Ui92TDk5U3JWRkVYM2dITTdxRWNSTUxCNmczYnRUVHNO?=
 =?gb2312?B?MjQrMC91UXJ4N0UzWFMvWmpGUmxPdEtuNkFkNitOeEQramNjMUdCUmVWK1Vy?=
 =?gb2312?B?ODA5ajk1Y0pLQ3VDcEpKWTlYa1JzRHVGajBHYWdUZmVqMW1HeUJaajNDbjRk?=
 =?gb2312?B?ZGxJYUJXZzVyZmtKWjlvUFVsa0IxVTVEUVdEZTFWRWszc3JzaERHYUJMbkZn?=
 =?gb2312?B?VENVekJJcFFZVkN4bU1GditWcXRJTGpnblpjNThVdlFEMTNqOXEwK3BWTXA3?=
 =?gb2312?B?SzMxMng1dGhsT0ZvbHNxQllQa25ORk5yVzJmTWxlTXdzSGNxbGdySHdqalAr?=
 =?gb2312?B?ZTdkQ3pjdzNSR1E2U0hEczVTc2FzQURlL3Z3cjhsOUU2Tmt0cHJSaFVmU09o?=
 =?gb2312?B?eGRyWm5hdWQ1WkIyS2ZJSE9sdHd1NnhjTy9uVENEUW1ITXM5OEZjWjdiWHdH?=
 =?gb2312?Q?aK0gy6UCqxXPsDbyfzRRVtjrF?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed374a30-e730-4a2d-d7e4-08da7e94bbb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 08:04:09.5041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bOjNLKoXVrP2hYl6XgmN5AkzSVuSwap/JYnuOtnyDaGcxX8djrpLBzZ73i3A+sRaNcleKUrNv2NvKtdA9mGzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8248
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KQmVzdCByZWdhcmRzDQpTaGVycnkNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGVycnkgU3VuDQo+IFNlbnQ6IDIwMjLE6jjUwjTI1SAx
NTowNg0KPiBUbzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGppcmlzbGFieUBrZXJuZWwu
b3JnDQo+IENjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBbUEFUQ0ggVjJdIHR0eTogc2VyaWFsOiBscHVhcnQ6IGRpc2FibGUgZmxvdyBjb250cm9s
IHdoaWxlIHdhaXRpbmcgZm9yDQo+IHRoZSB0cmFuc21pdCBlbmdpbmUgdG8gY29tcGxldGUNCj4g
DQo+IFdoZW4gdGhlIHVzZXIgaW5pdGlhbGl6ZXMgdGhlIHVhcnQgcG9ydCwgYW5kIHdhaXRzIGZv
ciB0aGUgdHJhbnNtaXQgZW5naW5lIHRvDQo+IGNvbXBsZXRlIGluIGxwdWFydDMyX3NldF90ZXJt
aW9zKCksIGlmIHRoZSBVQVJUIFRYIGZpZm8gaGFzIGRpcnR5IGRhdGEgYW5kIHRoZQ0KPiBVQVJU
TU9ESVIgZW5hYmxlIHRoZSBmbG93IGNvbnRyb2wsIHRoZSBUWCBmaWZvIG1heSBuZXZlciBiZSBl
bXB0eS4gU28NCj4gaGVyZSB3ZSBzaG91bGQgZGlzYWJsZSB0aGUgZmxvdyBjb250cm9sIGZpcnN0
IHRvIG1ha2Ugc3VyZSB0aGUgdHJhbnNtaXQgZW5naW4NCj4gY2FuIGNvbXBsZXRlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiAtLS0NCj4g
Q2hhbmdlcyBpbiBWMjoNCj4gMS4gUmVwaHJhc2UgdGhlIGNvbW1pdCBsb2cgYXMgc3VnZ2VzdGVk
IGJ5IEppcmkuDQo+IC0tLQ0KPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8IDEg
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xf
bHB1YXJ0LmMNCj4gaW5kZXggZmM3ZDIzNWExZTI3Li5mMGZjY2QyZmY3YWMgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gKysrIGIvZHJpdmVycy90dHkv
c2VyaWFsL2ZzbF9scHVhcnQuYw0KPiBAQCAtMjE3Miw2ICsyMTcyLDcgQEAgbHB1YXJ0MzJfc2V0
X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwNCj4gc3RydWN0IGt0ZXJtaW9zICp0ZXJt
aW9zLA0KPiAgCXVhcnRfdXBkYXRlX3RpbWVvdXQocG9ydCwgdGVybWlvcy0+Y19jZmxhZywgYmF1
ZCk7DQo+IA0KPiAgCS8qIHdhaXQgdHJhbnNtaXQgZW5naW4gY29tcGxldGUgKi8NCj4gKwlscHVh
cnQzMl93cml0ZSgmc3BvcnQtPnBvcnQsIDAsIFVBUlRNT0RJUik7DQo+ICAJbHB1YXJ0MzJfd2Fp
dF9iaXRfc2V0KCZzcG9ydC0+cG9ydCwgVUFSVFNUQVQsIFVBUlRTVEFUX1RDKTsNCj4gDQo+ICAJ
LyogZGlzYWJsZSB0cmFuc21pdCBhbmQgcmVjZWl2ZSAqLw0KPiAtLQ0KPiAyLjE3LjENCg0K
