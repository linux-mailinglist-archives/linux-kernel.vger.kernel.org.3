Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E868B52AF10
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiERAP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiERAPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:15:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3851586;
        Tue, 17 May 2022 17:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaSdblDjj6Pcfdl4wRJlwApwXdf5hDrSgER7ftkJm5e6PSq+lQ25+n3kOkxoLt/U3N4ai2QjUinA4VfRO6hn3W3W+P1AEbW+P48K76cGGB7a4CUX/3BCjReZsZXnh46Wbr+ylfOzo6zC/boHVoFfz42fgM6fGqbNqyA+8qKJoxh/fGjobvWkJWcI7fuKWU/WtLrM66gE0XsapcEe80MiflKslPEnxE1J0ZH8PCC4EXdFLw/cRu7esBS16B9N5YgtlcfI5tXPLw8vsR2xm88CP1UI0guxx2w4+biwZhN8BBxWBrbEZ6USr9RNG24jsZq7ywSZF5IxLoqaizAQu69MOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWFrqBc1t94RJFUQMah4Z2lJRxcf5lt6Jsm7YyieMwA=;
 b=DsrSzxWd2d+YtJSv+ML6oUqy5fj47rBuw0wEnrkt4y/wdn14FJcz614i1MAeRqJnkKAEwNaU1vTxlTVhJJpy/W9ceELiFUO7N9VvRv3RxxeBolndDuY2/S4kLvQve+JNS3oTB0R2mnX+zkSAdw6BD20xWurL/+MOAkxO3fTSKuLKoidbymgLsZurM8t90IDxyuUrHlIdounTb7LTfpOXVAUZhFI1bXzd5a32otGOqpY3DeigkcUDUyz0/JuyG9SC8UUO3/TgcDSSqppfse1tYflhS4/Z81hivJFqJRosGYp18Y5UIxIRshJEnQpnhtXW1aFC1GP9ZSbAn+4Qkfk7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWFrqBc1t94RJFUQMah4Z2lJRxcf5lt6Jsm7YyieMwA=;
 b=JtBC4sqZyv1i2x65JCwUdBrG9PqkDIAp4+c6g8oqG9ju9Btcgf6dR0pFiHI1AV1xxS8PUIY8ucgJCQZRh7PPYWhVgvg2UzDkwWXQ1dF6O2fAfVvOGejkrbzpqiAzC1vVxk8HcdktKSVRVPcu1xy7OMtzGecxRz7DCBZStvPHKvC2u/zJRkFWqQh38tPhcRJp4ljW7nAqykR72L1Rm4b1FzWQ4vqwE7YNukXCk80TjFxyMTZYYUdLwfampprW1KF2MpHTkZgVDxeDCDfXbZmVVBW9G/+jqliws10hK7PJZzyw5jGIMFBtujOnBeLUyYyZixVXeME4I6u0GJMyC3Egcw==
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by KL1PR0601MB4946.apcprd06.prod.outlook.com (2603:1096:820:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 00:15:10 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::5058:cb66:c181:f869]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::5058:cb66:c181:f869%5]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 00:15:10 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
        "a.kartashev@yadro.com" <a.kartashev@yadro.com>,
        "patrick.rudolph@9elements.com" <patrick.rudolph@9elements.com>,
        "dphadke@linux.microsoft.com" <dphadke@linux.microsoft.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH v5 1/4] dt-bindings: aspeed: Add eSPI controller
Thread-Topic: [PATCH v5 1/4] dt-bindings: aspeed: Add eSPI controller
Thread-Index: AQHYaL+o2abcbGYCoEGML2AKszBqEq0jZ0QAgABb0hA=
Date:   Wed, 18 May 2022 00:15:10 +0000
Message-ID: <HK0PR06MB3779B567DE70F859E28F66C991D19@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20220516005412.4844-1-chiawei_wang@aspeedtech.com>
 <20220516005412.4844-2-chiawei_wang@aspeedtech.com>
 <20220517183154.GA1352926-robh@kernel.org>
In-Reply-To: <20220517183154.GA1352926-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e5f3470-df8f-4a9a-753e-08da386378c9
x-ms-traffictypediagnostic: KL1PR0601MB4946:EE_
x-microsoft-antispam-prvs: <KL1PR0601MB494607618A387893A12B2A9191D19@KL1PR0601MB4946.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DilGFSfqBN7Dawicm2wTjV3nZ4X0jfHpNPbdhemWZ06hhnEAGOvl047rlSgJjH7p+WXVuVa85ZmK7VE3Chz84kax/Vcpg07zsXaH1TUErRZ8A0pnNoSvw05ZpBgOEI6CgzPYy4gsUsY2102FgLKeB+TLvzE0MvYP70IZQO5FPo1OcPwr72eEarCX0uc+yfgQI5ufOQ4U91Bzk5VEYkfKHfyzJY7F3EOK+qwQIZfiVN4OYAgTxz5MtYMPgbFFv9EE/4IsOberNrBJ2RC0y1ipH7rjlt/N6R/1CkSN9dxbWvvnd8mAUtpJsDirWBg+K2I+c3zmt+KfqAr+AZ+XwjFUDazA3bEPOT0fsZQf1lgsH3VbmLucdnpfr3Km+dSbGU+fu8I4bwx4/SSh03+dsxv7cyiCEvlpCI3poBKBSxCP9aG4Vn8qOgsw//WhxpvPv+NEwIdUQ/W3r337PVaXVsQPzTIFu2C3xUm++vvm/Ty4PiJrgc5zf/g1Fga69vzlSMSf3+GaKMnY/fHMDGmqRcReG/LZ7wOUYI/xCh4OuDfuktOd0udMZQo5AEMlugZyD1D9SkFcnJf9qGOa+Ag33JyqgRcsePwx7ZflQ38ICcK6Vv+sjECkE+JmTd03xfy+vmx5S7tNgcE+Zi2K6c6XqvoqTtekwGpS/PMfpBypBCDIj4t4O4estpzTJpmWoClOXWhnvnZHvOnJSvNkgKnA9RF4u75O70of9HSB9Rr4EPn7w72U36O0nwHp7PHxqvYwHdqWgD1vChSvFYKntgQQy4wRjOA7ZQLSUMvTm70LCyxB/OKZgYiblpUOqpqPUz9hf9+I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(136003)(366004)(39850400004)(396003)(8936002)(7416002)(5660300002)(122000001)(6506007)(38100700002)(38070700005)(52536014)(6916009)(54906003)(107886003)(508600001)(7696005)(26005)(9686003)(71200400001)(186003)(316002)(55016003)(83380400001)(66476007)(66446008)(4326008)(76116006)(8676002)(66556008)(64756008)(66946007)(33656002)(2906002)(86362001)(41300700001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlBBWFdrcW9rc25DVzFJbDVEa09KaXB4dzFja2dFdllDOHVSRlh0eS9MVThL?=
 =?utf-8?B?cXZ3TUNGRVFyb2xxUVFjTCtNQ29JQUlpVGx2eElhQjJIS3J2UzhCS05wNVZh?=
 =?utf-8?B?a0NUWDlWS01CQk5PQTZxVGg3YWVWSFJrVTllZE9JeTVHZUQzS2cvc20zYW1v?=
 =?utf-8?B?Ukt2NnRMenJVRWNFY0plVzhCWEVlYnZzZGhxUHZwYTJ3cEN4VU8yL1plQWtL?=
 =?utf-8?B?Ykt1VU5jRFliZWxzbEh3UWJhaXdYdVNmTjIwWTdMWjhTK2Y1ZXcxMzZZcUdv?=
 =?utf-8?B?eVUrTkNIM05sT3RNL0lYUGNQaW52aXUzVG5VZUNTemFlTHhCRDRCTlJSb21n?=
 =?utf-8?B?NWo1OVZqTmY0VU9kVzByTzU3MDAvd25RSVFMSzcwMHI3UGJ0WDdyYVdKRFVD?=
 =?utf-8?B?WjlKUE8ycjV0cVBkeEV2bVdkVjJmNlE5b2hQUWZlbFJhV2lucVhvVnJocjRs?=
 =?utf-8?B?TEFOYzhiNEo3aUgwMGFVSGZ5ZFBOd1hnOVc1Uzd6TWdTTkltUFRvVk8vdXlU?=
 =?utf-8?B?MUNocjZncGF0ZEtGam04R0VSQlV2U0pKUWJ3SWh2N0dGUGhJbnlpSUFNZnBp?=
 =?utf-8?B?bHBlOWZmR3J5RjdKanhUYTBTWmVqLzVmK2Zkc2w0TUc2UEFBM1hrRG9RNDBl?=
 =?utf-8?B?Vm95YjBJMTZEVWRvZ0NQWUFFZWtJZkFxZEloOFltODNEOWc5bUp6NW9SczBY?=
 =?utf-8?B?OUxhRUExdG5paU1mVk1scDZ6SEREaGZaWDV5bU81VHBSZmh6dHlERHBQVTFS?=
 =?utf-8?B?UDAydFArSDBZRHdEWDBmQzVubXE4SDdNdGVIZ0dZQytBWFE2bHJyQkYxMHlo?=
 =?utf-8?B?eVdNNmdPMktOUE85bWtWaDlZVEhFaFJrb3YvM3RZUjVwNEw2ZUorQzNUa3Nh?=
 =?utf-8?B?Z3gyQVYwMXI0QjNnRFM5WXRSMGo5QlA3UTRJRjlQZGNzNVlpVHVqc1I3U3hY?=
 =?utf-8?B?L1I1MlZROTBzVk1OWFVZZHRqeG5EUjBUamgvd1FweE9vZVlVZTVvUDJ1M21j?=
 =?utf-8?B?aEZOUkhESGFMd09palN3NUY4M1dBTklJY0JzV29IcGc4dEJMeTNnWU83czBo?=
 =?utf-8?B?ejlQTkhiWFlVNWNLeU5MbWRnMml1WDUwOFU1TjIvMUlyZG4va1VMSkRuN0JF?=
 =?utf-8?B?ajNxc095M2JkdzhxZ1hOUDhqTDNkRXpoZi9reVNVcHlLb01GU05hMTlDQnlU?=
 =?utf-8?B?N3NVNFBIdzUzS2RqMGY2c3ZvcXo3Ri84ekNSZHNhcjd0a056anRNZHhhVlFa?=
 =?utf-8?B?ZGIrTEVKV1dOVEx0elJyTWtuM0ZyN0hhbm5ubU1RMlo3WGRHbktKaG1TamN1?=
 =?utf-8?B?dTNiY1ZGZWdHZUpaNE1VbERrVUhwbUM3L1c4OTRsWjlxbjE4R3BpbndFd3cr?=
 =?utf-8?B?ZGtpR0g3Rk5JbngxTmIzSDdWRk1SNUlnclVRNG1SS0NxWE16WXdxZ2psanR1?=
 =?utf-8?B?cmpDWFBHUU1JajJoUFM3Z0VOZlFNYzhiSlB5NHU4Q3dVbU01UGtZL0dvTklx?=
 =?utf-8?B?cElscXRUb2tUckdJam16SjdiVGZYVzBDUFlURWNOSTBxNTE4cHVQZVJRaUli?=
 =?utf-8?B?UHZwTWZvd1dSVHlqMDdXT3ZhK2ZuV1lVemh0amkwY2xvckN4UTY0S0kzMXhO?=
 =?utf-8?B?blhzSTZ5U0NQc2RnOFJDcFhjK05aOG52elVSb2hWK1g1dGpmeGhhWFlUOGZ1?=
 =?utf-8?B?M0s5ck51TGFVTko0YVliL01RQVNrNi9NMTA4UW5ocTBscDcxNkxVbkg4aG1U?=
 =?utf-8?B?bjRTalM3MDNZeG1WYjN2ZUFYWXgwZEdsT2hDQi9HK0hqb1FTeGROdmVCNU5G?=
 =?utf-8?B?cld5T0tlM2JCUHlnL0JyZTd6eWtYSWZVaUdRcFBZbDVJcUVYa2JhUzNvOWNZ?=
 =?utf-8?B?c1JJaWhDREpuODNUUGxyZWJOeWZXbWlRRUN0NzExZzdBSnd1NnlvSklvSnpC?=
 =?utf-8?B?ZS8xZi9uOS8xM2orU0tOREw3TS85N2wzTGpIU1d0ME4zYUdPd1h1V0Z4Mmw0?=
 =?utf-8?B?RE95RlRmOHo3Vll1SmpBT0VNS3h3bWhjUDBLLzVIVHAwSGNBNEh1bnlFc3Uz?=
 =?utf-8?B?MFpLbzNFRmRpYmRYQ1E2b2IxRG9PK3YwOUcxSzg0TGp3Z1VpS0tMK1R6SWtM?=
 =?utf-8?B?VEZ1dS9USVU4YkFDLzhGTzBMYnNqKzkwTDJsNXVVN2RWTGhkY2NwMXFRTTFY?=
 =?utf-8?B?SEMrbXo5K2RGVkNERVZCR2hKMmtzT3ZlNXNmMXNaRm1tSFpDMVpNandyZldm?=
 =?utf-8?B?OU0wMzVNQjhPcXI0MkVzeFovSlpUWi9IOWtyZitJTjVTM1pRb2ZhTnBTSFhO?=
 =?utf-8?B?WjVkaWlkRnYwL0d0QTRZTm1CYUxSM20yVjJPWFZVaGx2WnJjdktEMWVlYmVM?=
 =?utf-8?Q?iwpifI249heK8ygo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5f3470-df8f-4a9a-753e-08da386378c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 00:15:10.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9eIPmzSFWWBMorqteRfD1gZONWM9p+aZnf/8NKiiPRdrL/KZ+lvIsk3RZNIQavCNx8loIM98gt+4DkQa4IB8RADW6XBz6L+9kWaNwT3sTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4946
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgTWF5IDE4LCAyMDIyIDI6MzIgQU0NCj4gDQo+IE9uIE1vbiwgTWF5IDE2LCAy
MDIyIGF0IDA4OjU0OjA5QU0gKzA4MDAsIENoaWEtV2VpIFdhbmcgd3JvdGU6DQo+ID4gQWRkIGR0
LWJpbmRpbmdzIGZvciBBc3BlZWQgZVNQSSBjb250cm9sbGVyDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGlhLVdlaSBXYW5nIDxjaGlhd2VpX3dhbmdAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9hc3BlZWQvZXNwaS55YW1sICB8IDE2
Mg0KPiA+ICsrKysrKysrKysrKysrKysrKw0KPiANCj4gYmluZGluZ3Mvc3BpLyBpbmNsdWRlcyBT
UEkgc2xhdmVzLiBJcyB0aGVyZSBhIHJlYXNvbiB0aGlzIGRvZXNuJ3QgZml0IHRoZXJlPw0KDQpl
U1BJIHJlc3VlcyB0aGUgdGltaW5nIGFuZCBlbGVjdHJpY2FsIHNwZWNpZmljYXRpb24gb2YgU1BJ
IGJ1dCBydW5zIGNvbXBsZXRlbHkgZGlmZmVyZW50IHByb3RvY29sLg0KT25seSB0aGUgZmxhc2gg
Y2hhbm5lbCBpcyByZWxhdGVkIHRvIFNQSSBhbmQgdGhlIG90aGVyIDMgY2hhbm5lbHMgYXJlIGZv
ciBFQy9CTUMvU0lPLg0KVGhlcmVmb3JlLCBhbiBlU1BJIGRyaXZlciBkb2VzIG5vdCBmaXQgaW50
byB0aGUgU1BJIG1vZGVsLg0KDQo+IA0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYyIGluc2VydGlv
bnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9hc3BlZWQvZXNwaS55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9hc3BlZWQvZXNwaS55YW1sDQo+
ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2FzcGVlZC9lc3BpLnlh
bWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYWE5
MWVjOGNhZjZhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb2MvYXNwZWVkL2VzcGkueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTYy
IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNE
LTItQ2xhdXNlKSAjICMNCj4gPiArQ29weXJpZ2h0IChjKSAyMDIxIEFzcGVlZCBUZWNobm9sb2d5
IEluYy4NCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6ICJodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9zb2MvYXNwZWVkL2VzcGkueWFtbCMiDQo+ID4gKyRzY2hlbWE6ICJo
dHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMiDQo+ID4gKw0KPiA+
ICt0aXRsZTogQXNwZWVkIGVTUEkgQ29udHJvbGxlcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6
DQo+ID4gKyAgLSBDaGlhLVdlaSBXYW5nIDxjaGlhd2VpX3dhbmdAYXNwZWVkdGVjaC5jb20+DQo+
ID4gKyAgLSBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiArDQo+ID4g
K2Rlc2NyaXB0aW9uOg0KPiA+ICsgIEFzcGVlZCBlU1BJIGNvbnRyb2xsZXIgaW1wbGVtZW50cyBh
IHNsYXZlIHNpZGUgZVNQSSBlbmRwb2ludCBkZXZpY2UNCj4gPiArICBzdXBwb3J0aW5nIHRoZSBm
b3VyIGVTUEkgY2hhbm5lbHMsIG5hbWVseSBwZXJpcGhlcmFsLCB2aXJ0dWFsIHdpcmUsDQo+ID4g
KyAgb3V0LW9mLWJhbmQsIGFuZCBmbGFzaC4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4g
KyAgY29tcGF0aWJsZToNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4g
KyAgICAgICAgICAtIGFzcGVlZCxhc3QyNTAwLWVzcGkNCj4gPiArICAgICAgICAgIC0gYXNwZWVk
LGFzdDI2MDAtZXNwaQ0KPiA+ICsgICAgICAtIGNvbnN0OiBzaW1wbGUtbWZkDQo+ID4gKyAgICAg
IC0gY29uc3Q6IHN5c2Nvbg0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczog
MQ0KPiA+ICsNCj4gPiArICAiI2FkZHJlc3MtY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDENCj4g
PiArDQo+ID4gKyAgIiNzaXplLWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+
ICsgIHJhbmdlczogdHJ1ZQ0KPiA+ICsNCj4gPiArcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gKyAg
Il5lc3BpLWN0cmxAWzAtOWEtZl0rJCI6DQo+ID4gKyAgICB0eXBlOiBvYmplY3QNCj4gPiArDQo+
ID4gKyAgICBkZXNjcmlwdGlvbjogQ29udHJvbCBvZiB0aGUgZm91ciBiYXNpYyBlU1BJIGNoYW5u
ZWxzDQo+ID4gKw0KPiA+ICsgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgY29tcGF0aWJsZToN
Cj4gPiArICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAg
ICAgICAgICAtIGFzcGVlZCxhc3QyNTAwLWVzcGktY3RybA0KPiA+ICsgICAgICAgICAgICAgIC0g
YXNwZWVkLGFzdDI2MDAtZXNwaS1jdHJsDQo+ID4gKw0KPiA+ICsgICAgICBpbnRlcnJ1cHRzOg0K
PiA+ICsgICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgICAgICBjbG9ja3M6DQo+ID4g
KyAgICAgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgICAgIHBlcmlmLG1lbWN5Yy1lbmFi
bGU6DQo+IA0KPiBXaGF0IHZlbmRvciBpcyAncGVyaWYnPw0KDQpJdCByZWZlcnMgdG8gdGhlIGVT
UEkgcGVyaXBoZXJhbCBjaGFubmVsLg0KDQo+IA0KPiA+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4N
Cj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogRW5hYmxlIG1lbW9yeSBjeWNsZSBvdmVyIGVTUEkg
cGVyaXBoZXJhbCBjaGFubmVsDQo+ID4gKw0KPiA+ICsgICAgICBwZXJpZixtZW1jeWMtc3JjLWFk
ZHI6DQo+ID4gKyAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyDQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IFRoZSBIb3N0IHNpZGUgYWRkcmVzcyB0
byBiZSBkZWNvZGVkIGludG8gdGhlDQo+ID4gKyBtZW1vcnkgY3ljbGUgb3ZlciBlU1BJIHBlcmlw
aGVyYWwgY2hhbm5lbA0KPiA+ICsNCj4gPiArICAgICAgcGVyaWYsbWVtY3ljLXNpemU6DQo+ID4g
KyAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+
ID4gKyAgICAgICAgZGVzY3JpcHRpb246IFRoZSBzaXplIG9mIHRoZSBtZW1vcnkgcmVnaW9uIGFs
bG9jYXRlZCBmb3IgdGhlDQo+IG1lbW9yeSBjeWNsZSBvdmVyIGVTUEkgcGVyaXBoZXJhbCBjaGFu
bmVsDQo+ID4gKyAgICAgICAgbWluaW11bTogNjU1MzYNCj4gDQo+IFRoaXMgcmVnaW9uIGlzIGRl
ZmluZWQgYnkgdGhlIGgvdyBvciBqdXN0IHNvbWUgY2FydmVvdXQgb2Ygc3lzdGVtIG1lbW9yeT8g
SW4NCj4gdGhlIGZvcm1lciwgcGVyaGFwcyB0aGlzIHNob3VsZCBiZSBwYXJ0IG9mICdyZWcnLiBJ
biB0aGUgbGF0dGVyIGNhc2UsIHVzZSBhDQo+IC9yZXNlcnZlZC1tZW1vcnkgbm9kZSBhbmQgbWVt
b3J5LXJlZ2lvbiBoZXJlLg0KDQpUaGUgcmVnaW9uIGlzIGdvaW5nIHRvIGJlIGFsbG9jYXRlZCBh
dCBydW50aW1lIHBoYXNlLg0KSXQgaXMgYSBraW5kIG9mIHNoYXJlZCBtZW1vcnkgYmV0d2VlbiBI
b3N0IGFuZCBCTUMuDQoNCj4gDQo+ID4gKw0KPiA+ICsgICAgICBwZXJpZixkbWEtbW9kZToNCj4g
PiArICAgICAgICB0eXBlOiBib29sZWFuDQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IEVuYWJs
ZSBETUEgc3VwcG9ydCBmb3IgZVNQSSBwZXJpcGhlcmFsIGNoYW5uZWwNCj4gPiArDQo+ID4gKyAg
ICAgIG9vYixkbWEtbW9kZToNCj4gDQo+IFdoYXQgdmVuZG9yIGlzICdvb2InPw0KDQpJdCByZWZl
cnMgdG8gdGhlIGVTUEkgb3V0LW9mLWJhbmQgY2hhbm5lbC4NCg0KPiANCj4gPiArICAgICAgICB0
eXBlOiBib29sZWFuDQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IEVuYWJsZSBETUEgc3VwcG9y
dCBmb3IgZVNQSSBvdXQtb2YtYmFuZCBjaGFubmVsDQo+ID4gKw0KPiA+ICsgICAgICBvb2IsZG1h
LXR4LWRlc2MtbnVtOg0KPiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgICAgIG1pbmltdW06IDINCj4gPiArICAgICAgICBt
YXhpbXVtOiAxMDIzDQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IFRoZSBudW1iZXIgb2YgVFgg
ZGVzY3JpcHRvcnMgYXZhaWxhYmxlIGZvciBlU1BJDQo+ID4gKyBPT0IgRE1BIGVuZ2luZQ0KPiA+
ICsNCj4gPiArICAgICAgb29iLGRtYS1yeC1kZXNjLW51bToNCj4gPiArICAgICAgICAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgICAgICBtaW5p
bXVtOiAyDQo+ID4gKyAgICAgICAgbWF4aW11bTogMTAyMw0KPiA+ICsgICAgICAgIGRlc2NyaXB0
aW9uOiBUaGUgbnVtYmVyIG9mIFJYIGRlc2NyaXB0b3JzIGF2YWlsYWJsZSBmb3IgZVNQSQ0KPiA+
ICsgT09CIERNQSBlbmdpbmUNCj4gPiArDQo+ID4gKyAgICAgIGZsYXNoLGRtYS1tb2RlOg0KPiA+
ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogRW5hYmxl
IERNQSBzdXBwb3J0IGZvciBlU1BJIGZsYXNoIGNoYW5uZWwNCj4gDQo+IFdoeSBkb2VzIHRoaXMg
bmVlZCB0byBiZSBpbiBEVC4gSXQncyBjb25maWd1cmF0aW9uLg0KDQpUaGUgcHJvcGVydHkgaXMg
dXNlZCB0byBkZWNpZGUgdGhlIG9wZXJhdGlvbiBtb2RlIChpLmUuIEZJRk8gb3IgRE1BKSBvZiB0
aGUgZVNQSSBmbGFzaCBjaGFubmVsLg0KSXMgaXQgYSB3cm9uZyBpZGVhIHRvIHVzZSB0aGUgRFRT
IHByb3BlcnR5IGZvcj8NCg0KPiANCj4gPiArDQo+ID4gKyAgICAgIGZsYXNoLHNhZnMtbW9kZToN
Cj4gPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzINCj4gPiArICAgICAgICBlbnVtOiBbIDAsIDEsIDIgXQ0KPiA+ICsgICAgICAgIGRlZmF1bHQ6
IDANCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogU2xhdmUtQXR0YWNoZWQtU2hhcmluZy1GbGFz
aCBtb2RlLCAwLT5NaXgsDQo+ID4gKyAxLT5TVywgMi0+SFcNCj4gPiArDQo+ID4gKyAgICBkZXBl
bmRlbmNpZXM6DQo+ID4gKyAgICAgIHBlcmlmLG1lbWN5Yy1zcmMtYWRkcjogWyAicGVyaWYsbWVt
Y3ljLWVuYWJsZSIgXQ0KPiA+ICsgICAgICBwZXJpZixtZW1jeWMtc2l6ZTogWyAicGVyaWYsbWVt
Y3ljLWVuYWJsZSIgXQ0KPiA+ICsgICAgICBvb2IsZG1hLXR4LWRlc2MtbnVtOiBbICJvb2IsZG1h
LW1vZGUiIF0NCj4gPiArICAgICAgb29iLGRtYS1yeC1kZXNjLW51bTogWyAib29iLGRtYS1tb2Rl
IiBdDQo+ID4gKw0KPiA+ICsgICAgcmVxdWlyZWQ6DQo+ID4gKyAgICAgIC0gY29tcGF0aWJsZQ0K
PiA+ICsgICAgICAtIGludGVycnVwdHMNCj4gPiArICAgICAgLSBjbG9ja3MNCj4gPiArDQo+ID4g
KyAgIl5lc3BpLW1tYmlAWzAtOWEtZl0rJCI6DQo+ID4gKyAgICB0eXBlOiBvYmplY3QNCj4gPiAr
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogQ29udHJvbCBvZiB0aGUgUENILUJNQyBkYXRhIGV4Y2hh
bmdlIG92ZXIgZVNQSQ0KPiA+ICsgcGVyaXBoZXJhbCBtZW1vcnkgY3ljbGUNCj4gPiArDQo+ID4g
KyAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgIGNv
bnN0OiBhc3BlZWQsYXN0MjYwMC1lc3BpLW1tYmkNCj4gPiArDQo+ID4gKyAgICAgIGludGVycnVw
dHM6DQo+ID4gKyAgICAgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgICByZXF1aXJlZDoN
Cj4gPiArICAgICAgLSBjb21wYXRpYmxlDQo+ID4gKyAgICAgIC0gaW50ZXJydXB0cw0KPiA+ICsN
Cj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiAr
ICAtICIjYWRkcmVzcy1jZWxscyINCj4gPiArICAtICIjc2l6ZS1jZWxscyINCj4gPiArICAtIHJh
bmdlcw0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+
ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvY2xvY2svYXN0MjYwMC1jbG9jay5oPg0KPiA+ICsNCj4gPiArICAgIGVzcGk6IGVzcGlA
MWU2ZWUwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI2MDAtZXNw
aSIsICJzaW1wbGUtbWZkIiwgInN5c2NvbiI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MWU2ZWUw
MDAgMHgxMDAwPjsNCj4gPiArDQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgcmFuZ2VzID0gPDB4
MCAweDFlNmVlMDAwIDB4MTAwMD47DQo+ID4gKw0KPiA+ICsgICAgICAgIGVzcGlfY3RybDogZXNw
aS1jdHJsQDAgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNjAw
LWVzcGktY3RybCI7DQo+ID4gKyAgICAgICAgICAgIHJlZyA9IDwweDAgMHg4MDA+Ow0KPiA+ICsg
ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNDIgSVJRX1RZUEVfTEVWRUxfSElHSD47
DQo+ID4gKyAgICAgICAgICAgIGNsb2NrcyA9IDwmc3lzY29uIEFTUEVFRF9DTEtfR0FURV9FU1BJ
Q0xLPjsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICBlc3BpX21tYmk6IGVz
cGktbW1iaUA4MDAgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3Qy
NjAwLWVzcGktbW1iaSI7DQo+ID4gKyAgICAgICAgICAgIHJlZyA9IDwweDgwMCAweDUwPjsNCj4g
PiArICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEwOCBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCj4gPiArICAgICAgICB9Ow0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIHRoZXNlIGNoaWxk
IG5vZGVzPyBBcmUgdGhlIHN1YmJsb2NrcyBzb21laG93IHVzZWZ1bCBvbg0KPiB0aGVpciBvd24g
b3IgcmV1c2VhYmxlIGluIGFub3RoZXIgY29uZmlndXJhdGlvbj8gSWYgbm90LCBsb29rcyBsaWtl
IHRoaXMgY291bGQgYWxsDQo+IGJlIDEgbm9kZS4NCg0KZXNwaS1tbWJpIGhhcyBpbmRpdmlkdWFs
IGZ1bmN0aW9uIGFuZCBjb250cm9sIHJlZ2lzdGVycy4NCkhvd2V2ZXIsIGVzcGktbW1iaSBpcyBh
bHNvIGEgZmVhdHVyZSBleHRlbmRlZCBiYXNlZCBvbiB0aGUgbWVtb3J5IGN5Y2xlIG9mIGVTUEkg
cGVyaXBoZXJhbCBjaGFubmVsLg0KVGhlcmVieSwgaXQgaGFzIGRlcGVuZGVuY3kgb24gdGhlIGVT
UEkgY2hhbm5lbCBpbml0aWFsaXphdGlvbiBjb25kdWN0ZWQgYnkgZXNwaS1jdHJsLg0KVGhlIHNj
ZW5hcmlvIGlzIHNpbWlsYXIgdG8gdGhlIGxwYy1jdHJsIGFuZCBvdGhlciBscGMteHh4IGRyaXZl
cnMgb2YgQXNwZWVkIFNvQ3MuDQoNCkNoaWF3ZWkNCg==
