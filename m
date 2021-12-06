Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6505468EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhLFCCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:02:49 -0500
Received: from mail-vi1eur05on2080.outbound.protection.outlook.com ([40.107.21.80]:11744
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231624AbhLFCCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:02:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxMTO9PjMNAJomreCPszmKp5uL/nqWnvDZ5NIQubZy8MxJBKHGS3FLmULQt/duKHhkAGb1TFYn+hF2K/Q1gnqYyiyv4cvsPWa3qFOjygdb6coBSBzY5VHz3Is+tj4PS4TfPheC34i7nQkT9J/xwInEabdhzj8gezul3PrDGt9CaHy24PIZJd8pvJCU+bywU5x27O6qjTe8IOluFWT7IL35sbBEbF1jtb21/XNGRJo14W/App2/XDtSRonWK4/+REL6d/7bCZQFSZQ3yW3iNrS/48aIWacmxlWtpUcnzuWEnCR8e98BzC/KmRvfppznvb1oZJotjh7ShftUcKvM2YYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25ei632bHZV468M959kpmpm6EBPu5x6oO8MvblKkmLw=;
 b=Opxbk8SEhZFqaT9hTLcz69X10UX8KsliU4ATHdTj+r6Etu+saNLIkQPG4rdm7MSjSm8zR6ecero/vm48nOADjMjKnCF5mpffYsjT6KgYvCOFZz5/H7t2PU0morQFe/PsFxTe3crq2JtG23zmj15sh2eDKDVOTikaueCqS+PobO67J1Ht9w00n5cRjoh2mFb28Ff6vy45+oHw5nYEHwXW3+n8CY1nuOPUWisoDohlte3X31CoH9EuQ6O1wERwC0GXy5n32FUGjhP1/N0akMZBQwMoYGo+PCUbWJ30tV5xTLFaWpYDOHOj7GJanMatNUTGYIVbZrnXvBwsQ4zRKEDb+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25ei632bHZV468M959kpmpm6EBPu5x6oO8MvblKkmLw=;
 b=CXX975hNvaInRwf2dIZGFH+Ke7D8jFGkjeDb6cCUCpxV3fx+t+5WIOuFqKetIVVUvDCL3thaYQ0t2xC/KIhKz+6uVpht3sH4GUi8OGLDHmr8RcSr8tzxd1TegeZJEKhRm6+YTcIkNbH+ltRGh//2Os80qn9yfPq9CJCsVoNagrk=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB7017.eurprd04.prod.outlook.com (2603:10a6:10:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 01:59:18 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 01:59:18 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] arm64: dts: imx8m: configure FEC PHY VDDIO voltage
Thread-Topic: [PATCH 4/7] arm64: dts: imx8m: configure FEC PHY VDDIO voltage
Thread-Index: AQHX4EDam6k4ckJ/5kqN1vg17UaMcKwkvQSAgAAJvuA=
Date:   Mon, 6 Dec 2021 01:59:18 +0000
Message-ID: <DB8PR04MB6795F657BDD2962D032F567BE66D9@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
 <20211123080506.21424-5-qiangqing.zhang@nxp.com>
 <20211206011531.GM4216@dragon>
In-Reply-To: <20211206011531.GM4216@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05d2aa69-0ffe-4f55-ad88-08d9b85c0378
x-ms-traffictypediagnostic: DB8PR04MB7017:
x-microsoft-antispam-prvs: <DB8PR04MB701728F30FE0E4E67173FAE0E66D9@DB8PR04MB7017.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50/kEAlHRMy9uoJMWZtLT7o8pQV+MdaP+8u3c0Emujh3+xur2ckRU1zbT1UN1NW9aQ2+jbaTwRQJvcEKncmmOQ6CNdkbRfaWiIRFztlxP8CqiDdA7hitvS9oZ5j7xMdO5U9uiHfvEAXWZybHZMZHYk+qRRQyVq+ozZJW8vDiCaQ7XJJlHJ5PDF/i5dVkTRl3ZRkzYAiWTAonIz5WRuauhvH9Ahg7oc/xCzgUi33JdhUWh5rPxZAiT1y59kndwXhu39OGWLk/IdJYRO8fPsnu69wZTIhz4p1UY4TTixN2tukwd6jA6eXt2vC5J/chvkdKsQJUJpKV9hJIyCXfsSpCh9exSHXCU0ewY+f0zM9JbAA54QyCYav3tzKLCrdwAy56VJLI2/BU9hlakCoeM8qtoQeRvpFoATwwYi72mppKDdlFqF6/DGwXpszCK3N0VIpU0mkLwzRwRieiuynS2psZPVPjuqt2eCV46og3rxZXLXYpAbyz+Do1YiWmFznkM0ZzI9uKwXkz8ehpst7wIK6Kk1NVHfjjzlbif55ykA/UxIcMhsHAQjEDi41VbGDSmd96HQ282mAK5Fm9M6XdVBxqJTbbvp6USWLTxGSSa/uH/gByDaqBScAaiL8BkbtbQyVB41MaxTkaVpEBFtXFuwYJMDqcZegWPJRrpmwGBBZxgYgHJin22nx2RbRcUY3Bhm0Hw+OQB4mg2aOhWyu7Cr36ufcHlVPYHj2zNBxDqO/UOAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(52536014)(33656002)(6506007)(86362001)(53546011)(508600001)(316002)(9686003)(55016003)(186003)(54906003)(83380400001)(4326008)(71200400001)(122000001)(76116006)(8936002)(2906002)(66946007)(66476007)(26005)(5660300002)(6916009)(66446008)(7696005)(38100700002)(38070700005)(64756008)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UUxGUnk4TTFZNkgrUitkU1RORFBRWHJtRjk2NlE5amZDTHAzNWUwVzJ3Qk9L?=
 =?gb2312?B?MWFuVng5ODZaaXZvYmhIdENOSnhJdGE5ZFZBU2FnSExWL1pScXFBVGZQZWho?=
 =?gb2312?B?U1RXL2VVQmpVdTlOVmFhSnJLL1VzaEg3bm1iOWhnK1pBRmVKUis0QWxSKzVT?=
 =?gb2312?B?SVFpNUM3UjBhMTlXa1pFcWluUTdJUkV1SjAzaTB3QmlQVjI0K3VNYkRaRWZr?=
 =?gb2312?B?Nk1FdmZ3cUh1dE42YzExcXk1VHd5KzVLZHZ4N0U3WFRRcjhGV3VaS1JTbHNX?=
 =?gb2312?B?c0RyNTJEUVBjTmg1dTBGUDVWQmFCaDJuNFVoeXFoL1lFTlVDSk1UdmVBcklj?=
 =?gb2312?B?alR6NEo4dDVzZE1lbXNaRnlrejNQVHdUU3pmcmVGQnBkMFhzei9ERFA0amJG?=
 =?gb2312?B?WGJZU0NTbVZXa3h2TFk1K3Bua3hYQk9ydk5WcXlwRHZhRkZBOFBCamdPTDdI?=
 =?gb2312?B?NzB5eUxvMVliT0UrcHNpMnJhM1BsbmdTa1NTbWRsRXZlS3VRVmRzR3hNcGh5?=
 =?gb2312?B?YjdaTGJkRDNxMHh2RUtoa3pIZm05YTA5OGNhcTBlNWxES29CdXVublVEZUtW?=
 =?gb2312?B?V3hndldDem1GV2o1WEJWZHBWM1RBUUF6NUYvbzl1cFFPY055TXNQMG1VQ1ls?=
 =?gb2312?B?UnFpeTFsZzVic21IaGkwZHdobGV1UGlyMXJTNG5aT3NFWFZ4Um9VbFltNitp?=
 =?gb2312?B?eUlLTVVGMWtvbnRURUpKYnFmYkZBVnVFb3FIb1JrdFdpSlpYRGljOE1aMmc0?=
 =?gb2312?B?bkRiTkNWRnlBYlRhODNMclFmVmNHU2pXbVE5dDFqellxQmI2UlRNbXBZWm9z?=
 =?gb2312?B?aGhIakZNV283d1pzdXZIVEovS0xqWlhuZ0MyOTBQdWlFdi9EbWlFQW5WOEox?=
 =?gb2312?B?dkFGbGV0MUpTd1l6eGdzNTlncjQ1VnE3ZlkwZWw5UHZRc0p2bmdoN29hTUVr?=
 =?gb2312?B?bDloSm4wTmI3VEtRK3A0Q2tmQlNDb0tYWU0zSVFPSzlFRjh3UEVEenh4czEr?=
 =?gb2312?B?MCtqTWJSa3hPemJjNGh1Rmw4d0NwZ2tLbW5qNlh0dDBoZkZGeWQvYk5qbERr?=
 =?gb2312?B?VVV4U0s2dmFpdm9QVCsxODk4RENZcUt0U2V0OVpFWFFvNW1NNUYvNHk2Vldr?=
 =?gb2312?B?RHVvc1p0TWhpdHBhRkJRSWdhWGVPb0NRZTc1MXNDWWlrV1hNUkU5Y3VDYnAz?=
 =?gb2312?B?RytnT0R3NStNUzg0U1FNUzBZa3ByTHl5bmt2VEpOMjlhaVl0VHRkZWRzMEt0?=
 =?gb2312?B?STRWaGRVSllVWjJzN3Q1R3ZDbzBqNTVGL25UbDVOM2xSWVVNd2p5dDg5MWl1?=
 =?gb2312?B?MW8yTUxwdm42MDFWUGVydGlObWhSc0M3OVRkdkhoMkxsc0djVzMwZVVPWHV4?=
 =?gb2312?B?TjhEVit3djBNTzhEV3B2SXhqaWJsTndOSnJhQ2ltWnJZSUJ3bHl2aXZEc1ZM?=
 =?gb2312?B?S3BDVmRXZTh0MVdpSnRrMUdwbFRWdC9FRWFxZ0JDcUpLVXhpWjFOMWppbFI0?=
 =?gb2312?B?alZwVXd6YWthV1lKTXJOZGlZdXRrL2NtTzlTNlFjN3JTMFcvV1dBSkhIVE9y?=
 =?gb2312?B?ZDZ2MTVVR0JjVm1HUHAxTmwycStFRklpT0ZiL3Q2RUk0Smtoa2FkUEdWM0Rt?=
 =?gb2312?B?NEUvWHMxODJPT3FYWUhkbFcxanRlMTllNHB2VVgxS3ZsSW1ESitZRElyM0lx?=
 =?gb2312?B?TE14dFBXbTl4dldBREkwNk1wcjlPTDh5eVpBVUhicmFxeE9BUTZqUGJRYXNL?=
 =?gb2312?B?cVk0eHR6VFhGMU0zS2pDanZQcktIRzlaazB5UFE2dzE1Y0lVdXJGMjVWUUNB?=
 =?gb2312?B?SUhxcDlFU3Z6RkxtSExHTHR5WlUzNWRZbHY3aTJwcm1YVW9tUHFBaHBJdjF3?=
 =?gb2312?B?eHpjMlZ0YkRoOEx3T0xqODN1eDVScmsrYnhNT2JZMGJXdFNtWU1EQ2p2eUtJ?=
 =?gb2312?B?YUFvb25jNU5rOHBYbS9xTlljTUlLSWhpQ0o5eGZWeUtVTGhka08xWmhrRGZt?=
 =?gb2312?B?K2hzc0crR3ZvWWM5Q3lIa3ZHd2FMWFhOUUozcmZXYlBHZHZFcjkzcDZwYU9h?=
 =?gb2312?B?dDJIQks0TVN2Ykk2MlVOTFkzTVd0UXJvaHAxVDVCSEU2RWNPT29zM1M3djhG?=
 =?gb2312?B?alR2K2RmMnNaRE5JTHludFVWUVlBck1PN0hnOVNhdzdRUE1jQ3BSUWh1RWov?=
 =?gb2312?B?RHc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d2aa69-0ffe-4f55-ad88-08d9b85c0378
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 01:59:18.3522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyhM0haXjD7vYlPWgfEURafoddnfjZSf7jSCpeBgMVo6r5hGmrXE9MQuJ90YQ2ahfWPXIZKMXqCqDVIs7Kp+aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBTaGF3biwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjHE6jEy1MI2yNUgOToxNg0K
PiBUbzogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgr
ZHRAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4
LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvN10gYXJtNjQ6IGR0czogaW14OG06IGNv
bmZpZ3VyZSBGRUMgUEhZIFZERElPDQo+IHZvbHRhZ2UNCj4gDQo+IE9uIFR1ZSwgTm92IDIzLCAy
MDIxIGF0IDA0OjA1OjAzUE0gKzA4MDAsIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPiBBcyBjb21t
aXQgMmY2NjQ4MjNhNDcwICgibmV0OiBwaHk6IGF0ODAzeDogYWRkIGRldmljZSB0cmVlIGJpbmRp
bmciKQ0KPiA+IGRlc2NyaWJlZCwgY29uZmlndXJlIEZFQyBQSFkgVkRESU8gdm9sdGFnZSBhY2Nv
cmRpbmcgdG8gYm9hcmQgZGVzaWduLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFpo
YW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpIHwgNiArKysrKysNCj4gPiBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZXZrLmR0c2kgfCA2ICsrKysrKw0KPiA+IGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzICB8IDQgKysrKw0KPiA+
ICAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzaQ0KPiA+IGluZGV4IDUw
YjNiYmI2NjJkNS4uM2JhYzg3YjdlMTQyIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzaQ0KPiA+IEBAIC0xMTcsNiArMTE3LDEyIEBA
DQo+ID4gIAkJCXJlc2V0LWdwaW9zID0gPCZncGlvNCAyMiBHUElPX0FDVElWRV9MT1c+Ow0KPiA+
ICAJCQlyZXNldC1hc3NlcnQtdXMgPSA8MTAwMDA+Ow0KPiA+ICAJCQlxY2EsZGlzYWJsZS1zbWFy
dGVlZTsNCj4gPiArCQkJdmRkaW8tc3VwcGx5ID0gPCZ2ZGRpbz47DQo+ID4gKw0KPiA+ICsJCQl2
ZGRpbzogdmRkaW8tcmVndWxhdG9yIHsNCj4gPiArCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDE4MDAwMDA+Ow0KPiA+ICsJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTgwMDAw
MD47DQo+ID4gKwkJCX07DQo+ID4gIAkJfTsNCj4gPiAgCX07DQo+ID4gIH07DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1ldmsuZHRzaQ0KPiA+
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWV2ay5kdHNpDQo+ID4gaW5k
ZXggMzQyZjU3ZThjZjYxLi5jM2YxNTE5MmI3NmMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWV2ay5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWV2ay5kdHNpDQo+ID4gQEAgLTEwMCw2ICsxMDAs
MTIgQEANCj4gPiAgCQkJcmVzZXQtZ3Bpb3MgPSA8JmdwaW80IDIyIEdQSU9fQUNUSVZFX0xPVz47
DQo+ID4gIAkJCXJlc2V0LWFzc2VydC11cyA9IDwxMDAwMD47DQo+ID4gIAkJCXFjYSxkaXNhYmxl
LXNtYXJ0ZWVlOw0KPiA+ICsJCQl2ZGRpby1zdXBwbHkgPSA8JnZkZGlvPjsNCj4gPiArDQo+ID4g
KwkJCXZkZGlvOiB2ZGRpby1yZWd1bGF0b3Igew0KPiA+ICsJCQkJcmVndWxhdG9yLW1pbi1taWNy
b3ZvbHQgPSA8MTgwMDAwMD47DQo+ID4gKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwx
ODAwMDAwPjsNCj4gPiArCQkJfTsNCj4gPiAgCQl9Ow0KPiA+ICAJfTsNCj4gPiAgfTsNCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2ay5kdHMN
Cj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzDQo+ID4g
aW5kZXggYTllMzM1NDhhMmYzLi5jOTZkMjNmZTMwMTAgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2ay5kdHMNCj4gPiArKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cw0KPiA+IEBAIC0xNzAsNiArMTcw
LDEwIEBADQo+ID4gIAkJCXJlc2V0LWdwaW9zID0gPCZncGlvMSA5IEdQSU9fQUNUSVZFX0xPVz47
DQo+ID4gIAkJCXJlc2V0LWFzc2VydC11cyA9IDwxMDAwMD47DQo+ID4gIAkJCXFjYSxkaXNhYmxl
LXNtYXJ0ZWVlOw0KPiA+ICsJCQl2ZGRpby1zdXBwbHkgPSA8JnZkZGg+Ow0KPiA+ICsNCj4gPiAr
CQkJdmRkaDogdmRkaC1yZWd1bGF0b3Igew0KPiA+ICsJCQl9Ow0KPiANCj4gV2h5IGRvZXMgdGhp
cyBuZWVkIHRvIGJlIGRpZmZlcmVudCBmcm9tIHRoZSBvbmUgb24gaW14OG1tLWV2ayBhbmQNCj4g
aW14OG1uLWV2az8NCg0KSXQncyBkZXBlbmQgb24gUkdNSUlfSU8gdm9sdGFnZSBvdXQgZnJvbSBT
b0MgYW5kIFBIWSByZWZlcmVuY2UgZGVzaWduLg0KDQpGb3IgOE1NL01OOg0KCVNvQyBSR01JSV9J
TyBpcyAxLjhWLCBhbmQgYm9hcmQgZGVzaWduIHVzZSAiUmVmZXJlbmNlIERlc2lnbiwgMS41LzEu
OCBWIFJHTUlJIEkvTyIsIFBIWSBkZWZhdWx0IHdvcmsgb24gMS41Viwgc28gd2UgbmVlZCBjb25m
aWd1cmUgUEhZIHRvIHdvcmsgb24gMS44Vi4NCkZvciA4TVE6DQoJU29DIFJHTUlJX0lPIGlzIDIu
NVYsIGFuZCBib2FyZCBkZXNpZ24gdXNlICJSZWZlcmVuY2UgRGVzaWduLCAyLjUgVi8gMy4zIFYg
UkdNSUkgSS9PIiwgUEhZIGRlZmF1bHQgd29yayBvbiAyLjVWLg0KDQpCZXN0IFJlZ2FyZHMsDQpK
b2FraW0gWmhhbmcNCj4gU2hhd24NCj4gDQo+ID4gIAkJfTsNCj4gPiAgCX07DQo+ID4gIH07DQo+
ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0K
