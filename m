Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4346634C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357774AbhLBMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:15:46 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:37511
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346513AbhLBMP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:15:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crkFrVzD919KJt3BifQepdyD64reZFG+gHTGrA2N6xjOmbwdjFCZM+x+Z3rCMSTqTyRkprPdpVyZ5cc5EFFYK6NCvAJmqltqptsNl7vkmo8IFdzrKCSedz18KBIBtFi3aNEyWKnpIF6bkZEiCoBgi8Wvsj6aB+UsvOA8rBQaLhQTpJK2wFZ+fKIMgh7PzQiVblx7AIx0pyVbcNPvLDMMzv43kOYnRUAiWHm+WL+mx4GZpb0BdgLwRDLK1ubd+lDfB21A58CbI3VPfHOarcR3vI+s0jWor3zBpjRpvAhTpOy9L3IzQkgh5YAFBaPH1yfYZLcLGsmUXQK6QJKidzONvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBkeABNA0ZmAkX8adx8HWShJRq6RvgUxfpVs2s+Pugk=;
 b=lGOJwk1x+WVM78XnwLa0TV67fa7HsTqhjRncB8m3LEqzwCjR8nQ1cw5UGvdHfysYK2NDarXwNnQorCxx3Ft+RybkuzW7YIYRV+EQTHj62HZvEgAKt9dJJnWOtVbh6ZQcbKRcinTvgwIpU2FWoqvtuTBMV9K5R01iXIoc6mu/TPDWjK63tT/dp/oGSY68Pi3eBphInLbBEc1zflQMQOyU3bXazYQkbSf6wGmHMwoiyi10Z3mym690k47sSb9EKt7lr2B8X2YamoMBjmtNpqLkCu3x0rllbbWrs+CRBqyBfPD3uSR1DRlI9gdyQI5OgO4hoXMUp68w4ceSP/R5dzPbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBkeABNA0ZmAkX8adx8HWShJRq6RvgUxfpVs2s+Pugk=;
 b=sLrW4Ox4wQSF9fJuS1wr1M271s9Lj/WQhMTwx+QMjqFWKqz5jlRjJwreh3YfnRq2S/Zbwm+x5aCkJSNK7kZHwWhOJG/JKwEaLFneRReTaOftF62yNg1bRyWac95M5f/LRGs+uN/2rMa3LUYKB92HQ2XubktXDpzbza3MIRKZR2Y=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 12:12:04 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 12:12:04 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/4] watchdog: da9062: reset board on watchdog timeout
Thread-Topic: [PATCH v3 2/4] watchdog: da9062: reset board on watchdog timeout
Thread-Index: AQHX5oucZnRw3eiBrEm6X8WjUQIv26wdra6AgAEly4CAAC5n8A==
Date:   Thu, 2 Dec 2021 12:12:03 +0000
Message-ID: <DB9PR10MB4652D886000C35FFB91E511D80699@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211201081512.3580837-1-andrej.picej@norik.com>
 <20211201081512.3580837-2-andrej.picej@norik.com>
 <13e0b9047f114722a0b4ebb4c1d24f2b@dh-electronics.com>
 <9298e77a-d74e-f51a-187f-830da184e67d@norik.com>
In-Reply-To: <9298e77a-d74e-f51a-187f-830da184e67d@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 373eaf65-cdcc-4bf2-62c0-08d9b58cf3f7
x-ms-traffictypediagnostic: DB9PR10MB4761:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB9PR10MB47619C5FEF44B7D74342600AA7699@DB9PR10MB4761.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pYDhD39W2MO+QVlRzYlYIWwPuAWejV8cykDCcYGYTHF0DGVnLnsaHi24GbmWoQMr/+fcDO/gNc1+VBq80Q2j2uWxyX1D28ArNSn+xkRaKkc6ZjoMSJQvHCkOVdyKfQ6r2KS5/8X6C0Ft111LiEcCJ8jgcdLB+t61cpJVd92ou2KOwRqfA1ntPuaVTejsXRNT7QS2vAsAnfNUOShQmme0ZaRVRGlQAovxyAmftAI3aGSsHot6LY/10lmWsKJC5vMsto3003gDv80R7OH/w/s6rcfo42bk58IZXenGjxOD1C60EFctxNmX7tbSgL2ByoQFAQaxFKoz6LWpF/tvLObtdRZUkJh1xxsqCWY6NfeMZPgexNfgZFVfp63b4K39bF2IvnDK8p7VMSp/NvT/nEGcO+WHcct53Nk277MJX56bwTr09lqMIiv++AHhVn4rh0TovQQfAkK4XnqJsZ4oHCbic+zBZ8Likyd7mVoWDQEnFPANvUTxPrErbyIaENQpxAU/7bKc1ucTHDwunX1VwscbZiawZ/3Ds4429s6hZcKNkJQVr91sqRXx69dywcniFxfpjhetsnsZPTo95Fe98+wSS5/iCQ8Ic/onAMBd4sUkYIs0uPu9oRcYIIFeoCutxL/1J+huF1tSxz1P+8uHxpLUcBf46V3T0JfNQypXDR+l6mCmrHYcDD+NJPMq8YaCkTydw3LNBov1rdLtjgRMjw0t7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(38100700002)(71200400001)(122000001)(86362001)(7416002)(83380400001)(66556008)(508600001)(53546011)(38070700005)(5660300002)(316002)(4326008)(110136005)(54906003)(7696005)(64756008)(76116006)(8936002)(9686003)(33656002)(52536014)(6506007)(186003)(66446008)(2906002)(8676002)(66476007)(66946007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUhodWdCWm9Wb0JQdVIyNVIzeVE0aWE1Y1k5ZFhzZHFwMHdkQkpLL0JtdWFa?=
 =?utf-8?B?QzB2OVJTc1V4Uld2MHZGVE9aZ0hTSEZpcVZqUHlwNkRTY09Ga0E3YVd1MkRq?=
 =?utf-8?B?K2NlUHZxcG90Q1lnZDVJbkE2K0w0dHI3V2xRK3FkQlBwTTVxSk5yREZhMDRp?=
 =?utf-8?B?bU5aVDdiSFMxaThUR09ZK0dFbVY5QTR5dmRhcktLdk4xalJMSFdoVXRXL2VK?=
 =?utf-8?B?STY1UFI3TUVtSGN2ZGlkak14cDJqNnlLTVdZeHBLQ1l2UEgxUnVaMTBIZy82?=
 =?utf-8?B?VmUvbnJzM3VlaXlCME5kc3hGRm9rMjRwTm91OGswUmVXNEhyVVcxeDFEU1cx?=
 =?utf-8?B?U2JWSGZJaTZ2aFNHMzJDbGJITGdQYkpWM1dlQXN2T1UvajE1Q25OQWt3QUcw?=
 =?utf-8?B?UUQvSDhGd3F6SmVadmJnWmpFUU9GeUl0bGUyZ0crSzhzU1c5MHRDZjFDRGM2?=
 =?utf-8?B?MUdBSkFCcWVPOXl0aGdheHdCVWZBdncwSGxUVjBITGd4U0RWQjFES2ErNFp1?=
 =?utf-8?B?TEZQVGxGL0hLOCtneWkvc0hCVmxweUxRMS9IaU5RcW8wYXI4RGpPNHFuR3Q4?=
 =?utf-8?B?VWtIeTdHYWVmaGgxOHJnM2E1TDNqNXE3K1ltdUZPZWd3ajdyQTRBcGc0a0s0?=
 =?utf-8?B?S1lGVytPWk4yamZRcTRtMGgxcHhPVkNsY09lSnltaExZMk4zUWZxaHQxZmRB?=
 =?utf-8?B?Z3UrUUxGbWZkQkd4eVhwQzYrYXYwZ3VRdisyRFN1T2pSZmJJMlJMOEtMQkVJ?=
 =?utf-8?B?aWVjWFFZcFJzSytJNGhybDZ4SVMvc3ArU1JJakFBdTZVbFM3VXR6OUxIcm00?=
 =?utf-8?B?MDExRDI4Slcyakg2SlZYRDJBZ0I0SklBQW5YOUovZytER1llSE1ucnNpalZ0?=
 =?utf-8?B?MUdPQ1pqMmpqY1RqOGx1dDZzcGdTaENqWHJ2VGo5WDY4QVJxdjl0TlZUUmV6?=
 =?utf-8?B?NDY2Tys2eGdMZzdZNmE1TTdGQWU3MVgwUk1XQ2dpQ2tNNU9jbUtvOVNmT1hh?=
 =?utf-8?B?OFB1bmdHa084bG94ckhxYThVNzFFTnFlNzljeEdUODZJTkxSTUNITVUzeFlY?=
 =?utf-8?B?S1FaRHpydUJZSkZwWUZZZWFvb0hpM3Z5Wk03citTYWxqSlNqWGNCSG5YeHd3?=
 =?utf-8?B?R0I0eWdwbElSRkF1ejJDQVhWaDQrV0trWEpUcW5BOG9rVWZHRjc4L2ZwWUZU?=
 =?utf-8?B?OFR5VURDc2JieHNNdHU1SWJza1B3QVpLaWx6QTRXNHJJdEZRelJrTWVZOTg5?=
 =?utf-8?B?R0FsZXdZSndvWWlnUzhuTjVDc2Ntd1VHVG1UaEo3WWxCVFg4UzdLWnlaMHNH?=
 =?utf-8?B?SzhvdG52UzlqenIwYnFpR2ZjL2ZYV1YvMUNxMStCVVpvSXQzYXk4ZUhxSU5J?=
 =?utf-8?B?MHFWbEhSZld2SzVsMkJDekRkb1BxdFJoNWlCN1l2S21KTzVCS2NjZnZhTUUx?=
 =?utf-8?B?QnNsNU1QU0VrZEFZNVBPNHgvbFFOaml2cmxjRmh4SDI4aTV6ZnN1NnZTUFNt?=
 =?utf-8?B?WlVxajBZNjJCVG5JWnR3clJTSTNscGo3dS92bUVMTE5FMWxqZ3VCM1A1aFRq?=
 =?utf-8?B?cTg3L2I4UHY0Q2l5a1hjOHRVSXVnUUQzbkxTTDJkOXNscnFNNzViTVlQTG9j?=
 =?utf-8?B?b3A5N0M0TWhIUkNQQTFMMzZvWGRiZEpVclJucjcraXdicGU3Zlg4N2tPL3FG?=
 =?utf-8?B?RkdweGROQXlRY1dGdy8rdk42WUlNTndGU05XTC9EcHZsc2ZIUGppVE4wZm9B?=
 =?utf-8?B?US9NbXJHUHFzM3hlMGg3SHE3TUpoeGNmeXYwaXNsQksvOFdETmNMOVNYYnVr?=
 =?utf-8?B?VDZnYk9QeGR3anQ5T01icFBCc0N1cXhSYmR3TDlMUHZFNkFFSjd2cjN3dzFU?=
 =?utf-8?B?NEFpYWdqTGZ1RDk1ckN1NXU5NzFRYTdkZVB5WmZsZW9QRUhwUkZHMzRhdVNX?=
 =?utf-8?B?ZUtsVEY2ZUVTTURPMDQzcFAvVHI5UU9NTmYzYjZ4eTVhbkkvaUpuM3hraG94?=
 =?utf-8?B?bDNCeEpMVlIzVEQyMUNYbXV1S0FDdXlxaVZ0T3B2YzRkQVFPaDJiSzQzZk1n?=
 =?utf-8?B?Y05GZC9WZHNuZFdrdEZrTks2WCtGL1ltdUNUcllyR0VvaXJSOTZ5YVVjeHBP?=
 =?utf-8?B?c29rTzdqU2k5aWRTUEdYajFsSmQ5QmlheERsb1E2cktyclRlb0dRalc4VUlZ?=
 =?utf-8?B?Y0NFNUJvQi9FZE02RlgyZ0xFdHJRUGFJaGZud0FQanZadHpyUnEyQUFxSDli?=
 =?utf-8?B?cmVBL0NvNGZ3clhVckhxODY5bFlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 373eaf65-cdcc-4bf2-62c0-08d9b58cf3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 12:12:03.6627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKEGExmF4rUtqm/qRSHcS3doz888lyWSsIiagPAKH0gg/+oA6pNgM14wyPEiYHoLbzp11wQivW1EHWNy/jdxxSs0OduHPzl6bFovwcFinn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4761
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIgRGVjZW1iZXIgMjAyMSAwNzo0MywgQW5kcmVqIFBpY2VqIHdyb3RlOg0KDQo+ID4gSSBo
YXZlIGEgcXVlc3Rpb24gaG93IHRvIGNvcnJlY3RseSByZXN0YXJ0IHRoZSBzeXN0ZW0gYWZ0ZXIN
Cj4gPiB3YXRjaGRvZyB0aW1lb3V0Lg0KPiA+IElmIEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0IGFm
dGVyIHdhdGNoZG9nIHRpbWVvdXQgdGhlIHN5c3RlbQ0KPiA+IHJlc3RhcnRzIG9ubHkgaWYgV0FU
Q0hET0dfU0QgKEJpdCAzKSBpbiByZWdpc3RlciBDT05GSUdfSSBpcw0KPiA+IHNldC4NCj4gPiBX
aGF0IGlzIHRoZSBkaWZmZXJlbmNlIGlmIFdBVENIRE9HX1NEIGlzbid0IHNldCwgYnV0IFdBS0Vf
VVANCj4gPiAoQml0IDIpIGluIHJlZ2lzdGVyIENPTlRST0xfRiBpcyBzZXQ/IEZyb20gb3V0c2lk
ZSBvbiBteQ0KPiA+IHN5c3RlbSBJIG9ic2VydmUgdGhlIHNhbWUgYmVoYXZpb3IuIEFmdGVyIHdh
dGNoZG9nIHRpbWVvdXQNCj4gPiBteSBzeXN0ZW0gcmVzdGFydHMuIFNvIHdoZXJlIGFyZSB0aGUg
ZGlmZmVyZW5jZXM/DQo+ID4gSXQgd291bGQgYmUgbmljZSBpZiB5b3UgY291bGQgYW5zd2VyIHRo
aXMgcXVlc3Rpb24sIGFzIHlvdQ0KPiA+IGNlcnRhaW5seSBrbm93IHRoaXMgY2hpcCB2ZXJ5IHdl
bGwuDQo+IA0KPiBUbyBiZSBob25lc3QgSSBkb24ndCByZWFsbHkga25vdyB0aGUgY2hpcCB0aGF0
IHdlbGwsIEknbSBqdXN0IHRyeWluZyB0bw0KPiBhZGQgdGhpcyBmZWF0dXJlIGFuZCBob3BlZnVs
bHkgaGVscCBvdGhlcnMgaWYgdGhleSBydW4gaW50byB0aGUgc2FtZQ0KPiBwcm9ibGVtLiBJIHRo
aW5rIEBBZGFtIHdpbGwgYmUgbW9yZSBoZWxwZnVsIGhlcmUuDQo+IA0KPiBCdXQgZnJvbSBxdWlj
ayBsb29rIGF0IGRhOTA2MiBkYXRhc2hlZXQsIG1haW5seSBjaGFwdGVyICI4LjggUG93ZXINCj4g
TW9kZXMiIEkgc2VlIG5leHQgbWFpbiBkaWZmZXJlbmNlczoNCj4gLSBzZXR0aW5nIFdBVENIRE9H
X1NEIGVuYWJsZXMgU0hVVERPV04gc2VxdWVuY2Ugd2hlbiB0aGUgd2F0Y2hkb2cNCj4gdGltZW91
dCBpcyB0cmlnZ2VyZWQuIFRoaXMgcHV0cyB0aGUgY2hpcCAoZGE5MDYyKSBpbiBSRVNFVCBtb2Rl
Lg0KPiBUYWtlbiBmcm9tIERBOTA2MiBkYXRhc2hlZXQ6DQo+ID4gSW4gUkVTRVQgbW9kZSwgdGhl
IGludGVybmFsIHN1cHBsaWVzLCBhbmQgTERPMSAoaWYgY29uZmlndXJlZCBhcyBhbiBhbHdheXMt
b24NCj4gc3VwcGx5KSBhcmUgZW5hYmxlZC4NCj4gPiBBbGwgb3RoZXIgREE5MDYyIHN1cHBsaWVz
IGFyZSBkaXNhYmxlZC4NCj4gPiBEQTkwNjIgaXMgaW4gUkVTRVQgbW9kZSB3aGVuZXZlciBhIGNv
bXBsZXRlIGFwcGxpY2F0aW9uIHNodXRkb3duIGlzDQo+IHJlcXVpcmVkDQo+ID4gVGhlIERBOTA2
MuKAmXMgcmVnaXN0ZXIgY29uZmlndXJhdGlvbiB3aWxsIGJlIHJlLWxvYWRlZCBmcm9tIE9UUCB3
aGVuIGxlYXZpbmcNCj4gdGhlIFJFU0VUIG1vZGUNCj4gDQo+IC0gaWYgeW91IHNldCB0aGUgV0FL
RV9VUCBiaXQgdGhhbiB0aGUgY2hpcCBlbnRlcnMgUE9XRVJET1dOIG1vZGUgb24NCj4gd2F0Y2hk
b2cgdGltZW91dC4gSSB1bmRlcnN0YW5kIHRoZSBQT1dFUkRPV04gbW9kZSBhcyBhIG5vdCB0aGF0
ICJkZWVwIg0KPiBtb2RlIGFzIGEgUkVTRVQgbW9kZSBEZXZpY2Ugd2lsbCBnbyBmcm9tIFJFU0VU
IG1vZGUgdG8gUE9XRVJET1dOIG1vZGUgaW4NCj4gdGhlIHNlcXVlbmNlIG9mIHBvd2VyaW5nLXVw
Lg0KPiANCj4gVGhlIGFib3ZlIGV4cGxhbmF0aW9uIGlzIGp1c3QgbXkgdW5kZXJzdGFuZGluZyBh
ZnRlciBxdWljayBsb29rLCBAQWRhbQ0KPiBwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gdGFsa2lu
ZyBub25zZW5zZS4NCj4gDQo+IFBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUgREE5MDYyIGRhdGFz
aGVldCBmb3IgbW9yZSBpbmZvcm1hdGlvbi4gU29ycnksDQo+IHRoYXQgSSBjYW4ndCBiZSBtb3Jl
IGhlbHBmdWwgaGVyZS4NCg0KWWVzLCBQT1dFUkRPV04gZG9lc24ndCBnbyB0byBSRVNFVCBhbmQg
dGh1cyBkb2Vzbid0IHJlLXJlYWQgT1RQLCBzbyBzb21lDQpzZXR0aW5ncyB3aWxsIHBlcnNpc3Qu
IEFsc28sIGRlcGVuZGluZyBvbiB0aGUgc3RhdGUgb2YgTlJFU19NT0RFLCB0aGUgblJFU0VUIHBp
bg0Kc3RhdGUgbWF5IG9yIG1heSBub3QgYmUgbW9kaWZpZWQgdG8gcmVzZXQgdGhlIGF0dGFjaGVk
IHByb2Nlc3Nvci4gVGhlIGJlaGF2aW91cg0Kb2YgUE9XRVJET1dOIGFuZCB3aGljaCByZWd1bGF0
b3JzIGFyZSBkaXNhYmxlZCBpcyBkb3duIHRvIHRoZSBPVFAgY29uZmlndXJhdGlvbg0Kb2YgdGhl
IGRldmljZS4NCg0KRm9yIHRyYW5zaXRpb24gdG8gUE9XRVJET1dOLCBpZiB0aGUgV0FLRV9VUCBi
aXQgaXMgc2V0IHRoZW4gdGhlIGRldmljZSB3aWxsDQppbW1lZGlhdGVseSB0cmFuc2l0aW9uIGJh
Y2sgb3V0IG9mIFBPV0VSRE9XTiB0byBBQ1RJVkUgYW5kIHRoZSBXQUtFX1VQIGJpdCB3aWxsDQpi
ZSBjbGVhcmVkIGFmdGVyIGEgdGltZS4NCg==
