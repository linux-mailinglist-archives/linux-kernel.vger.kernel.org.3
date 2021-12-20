Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4465247A867
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhLTLKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:10:20 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:15971 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhLTLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639998618; x=1671534618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tusYmzE5TaDf1PW52Pio01i7G3Esl6bKNTt+CAHXr3A=;
  b=gNaDQMGOtKeDC+hT5HKrIxOqASK0mhwq3Sc1hlHRcuop+CQtJcP0t9Ey
   TnF8SQ/8DRGpOlUBOoXaz/quL6oP1U8G4FTdooZG4pWFBzsw4yvTzzC3K
   voOmv9u6SQ3kWLzkDyR5qjGI64l5gWkKLAMR3XTAhMZLLpDZDNT75cV/R
   U437A7dqpu2JAJCoSEr6C9Oz3PE8x792OTn8hziCGxQxbvm7V605wfKor
   OWKnEbh3LAMRp7iyg5K59f2vfpzsbueRMxjmgZFAIRuKcjr7COReH+Bum
   jJLLMzo6kDIEy9Rw11MHY+oA+RtvpUYKUNqBL4AcILw+gtwnhmrlZXgyk
   Q==;
IronPort-SDR: tylhvHnyeRyxcnCZkCicUrp6EziIHHaeAh9RadAK6bTGQKkdqO1PLKpZJKV7tP2qK1o3lz5hSE
 yJtNIp1axzs0hLGoj/tk4LynC4KrbZXRP/hUs2rGj/BN1y6H2KAGBn2aAa5ao9murlPPapOKfz
 fhaakogheS+INTIQGgSzq/rnbAmj31T10xHinUHd80uRR5mhtEWEmSQzb9idDwaQVT+wRZ7C1a
 EmT1+GMdmnaPrLK041j3d/zy0HL+SBZ8zIi1W7KIsPURs37O07y40YqP5iYadidpR7Neg9h0g0
 BxFwiQhdh13QdLB86yOFBjnf
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="140334471"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2021 04:10:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 04:10:17 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 20 Dec 2021 04:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vjm7HhtlYTdwSDWX9ercOtaRtV0c40jID/OPjtbVKVUa2xXoDoN/v0Km8KaSTR25dHlF9dkghbXz4z+xJMcTMIrBqfgse0np94LzoctX9Bhyzq8kZEGvcpUq9/r71LmNyNn9f1hz/J5OmoONWrV/c6jQhMm99jj2ev+Z/l+dp8t2TDi4J2rodNIzmeSVIFbZY2AsrggUsZiik7LMWvpwwEnVGrkdlxoBc+pInISyYenMH/5M12rNMYdPcrxtMyntznvEvO0CBXDHM/DRgrlRtzTeQmBA0YBB+98L1HzdTmRBiAeLoAPPYhdueXXJ58n9w1mL8c8c7MO1YaNnYUmp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tusYmzE5TaDf1PW52Pio01i7G3Esl6bKNTt+CAHXr3A=;
 b=B0KjjqGu+NtUCyoe27CBCOjfCAS3i4/nvQllBSXNz1UtM1vtwbWRPa3+fzHlZQ6Txi+PavF01hHWik4fKA8SNCGoGxHwH5AnqUTtTXf3n9+j5BSEDf4QlSk5EAZRisovJ1leqe+tfsTs7DPHvyS8YjUx+oSdMgZfU572aAIROOz97cOwXzseJkEOx5CZjZgpu9mF/hW6tGTBzCykyW3WYlhPEvlX9dC84TivTUoTIl7nEz3Qor4XrCe5p1PNZ8nc/zdRM7XTn2GNktTPnjuHeRnkMyHjtHJCAWcyEG8/zI66GAmGik0sumC03QrIZnlr5o1JGAjF6GbfRbUaNat5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tusYmzE5TaDf1PW52Pio01i7G3Esl6bKNTt+CAHXr3A=;
 b=ZrIj7KEFT/YQzZaiOdlneflmPfeiM3wuueLJhXLRXRwUzrEKttzi5tptjGYvaz2CKZstZ9QeLcz5fO7VmmmPKJa3jrNZeM/Sgjtv/mG69BBi1UG5Viq1mhSOjnWAPrD5cU0JNRjcMEBAXhzmlalARoN1fT2dx3GVMdZ560vekjo=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 11:10:12 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 11:10:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: macronix: Add support for
 mx66lm1g45g
Thread-Topic: [PATCH v5 2/2] mtd: spi-nor: macronix: Add support for
 mx66lm1g45g
Thread-Index: AQHX9ZIoiHDp/cIQZ0mqLWmoNk2VfQ==
Date:   Mon, 20 Dec 2021 11:10:12 +0000
Message-ID: <213719a3-ed81-b1c6-9c9e-85dbeee85ff5@microchip.com>
References: <20211217180601.585825-1-tudor.ambarus@microchip.com>
 <20211217180601.585825-2-tudor.ambarus@microchip.com>
 <20211220102514.bnws67ks5uia5yfh@ti.com>
In-Reply-To: <20211220102514.bnws67ks5uia5yfh@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69be9ff8-4732-40b0-5bde-08d9c3a94ae3
x-ms-traffictypediagnostic: SA2PR11MB4907:EE_
x-microsoft-antispam-prvs: <SA2PR11MB4907F935ADAB9FF6EC546598F07B9@SA2PR11MB4907.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnfOBhziSnz4IauxY9f0pP5jE7E6HCeV+Uxdfk/x2pfuvUjN9elytM/knVYh6J0vDvNI5ntnUO8cGIvLG3l/PyYhj8IYB/xLvnpIMuqjHP9WFbKxCPk7JwLB+DXormttLd8I62Njl30syXPV8mqhhuIHIKFpIqgT85vnJH2qwFCRyTCoDcXakaBOavkBRw0Nab8DQf+Q09KITP6Sa1VoZXo2vircLmCr9xqR7srBm6uGs8f1NDkuzD3ZVKZt+9Lm6BPMoXFhv1XShy4cPupB0DCemILgBgILD+J+4egzcEnwMksqOJpZiYPXE1Osc+sU70csfsOOgWt1+KRJwA561tVtR+wsWMMjLTBtV/WFxNvbmyoHKCOFNfYADllGqq8GsWDkOsxcldUReHto3ZRWP94ZBlcpOTSOAuZwvzDWrdgiAyiMyD+daUsb44I+alU5oyYDxGi4BccsX+Qm7ENeBNdPu9c77l+ZCtx2oFNgOlw2SPrZDXSJ0J4xROrTyfQkwYBjn10rm2h0dMEXbbi5XNOgP6imwujEVTgh+GsicfxR7+k81Lj03ND4c8PfxFkgWyKLvU0qYsfIdesJVGnhfMJmP9VvOPmWOD0aKoNwjjDUgdJ1QQon2y2OoOk8wd7fI0VPMLU5+k9zFGVkvqUcwcqkngjdeg9RnT/szD2eNxBEUHai3+T30OMVtVxRbfaoEFecacwziIn5qhCb0Sa3Zkrue/nz3eY//Rd8PyVV4BH4tCrodpx35uJD6CDCM+HJTostd7bO/RUUko4kjQmryLLhEuShv62gyhQgyV4zOXx+SjqQYaGs9XqOTU5RdXZX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(6506007)(186003)(6512007)(508600001)(4326008)(107886003)(31696002)(316002)(26005)(53546011)(2906002)(54906003)(6486002)(8676002)(8936002)(71200400001)(2616005)(6916009)(5660300002)(122000001)(86362001)(36756003)(38100700002)(66476007)(66446008)(66556008)(64756008)(66946007)(38070700005)(83380400001)(76116006)(91956017)(138113003)(98903001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkR6RXVPRlJwRXVVWHZoemtUNVAvWjkwRHk0Nm5PVnJYRE9NaWUyaEdobHdU?=
 =?utf-8?B?RkJ4Y0l6MWxlZE9GTEkwc1k0d05wUCtsOEsyMjRHVkwxNjdVOGxRQVRkNGds?=
 =?utf-8?B?b3JFMjdXMGw4d09zdFM0S3grdk1ZYzlBeXZnbnpqWUdRRTdSc3lFakxHeXpv?=
 =?utf-8?B?akZQaW1KMXo1Y1FmWms4RGhwcVBvUittZWR2anFUNXQxODJjOG9CQjBpNTFO?=
 =?utf-8?B?V0szalFyVERiN3VlQWFWdGhycWlZN3RYSVZ0V1ovZWgxaDBXSlpCSEVNczVL?=
 =?utf-8?B?NHV1YUkreDBlUEQvRXNWTlRpRG0vZjRxeC9tR1dyVmdBcHdhcWZTR1F1RFBt?=
 =?utf-8?B?T1lUdVM0NTNwd05ZdFRyNTVyQ25LbkxJNGtmbTlLdkR6M1JWTjI0dHBwUFpD?=
 =?utf-8?B?VjJkVVJGQzVpa1BWNDMyUFZSZm4wMHF3TGxLVDE5Uy8zZVE2NFFiUmZubjAw?=
 =?utf-8?B?TGZVd2xOMkdYc0ZXSTVVRGxJeVdHZ3YzdXVhM2NWQWhQNTdFUm5tUENpZ05p?=
 =?utf-8?B?WXdLK1ZUWGtneVZROHBUS1Z0bmlUdTNCUnlHNDhudmlRbnFBSUp4MDZ2dXJz?=
 =?utf-8?B?MUpnaHNUejgyYXZ0Z3Z6YWFwc3IzemlPZTI0bWttdXA4YzBMa2x1aVg4Yzk3?=
 =?utf-8?B?SmlYYmF5RS9mVXJFc09xL01aMGRBT2FaQU1TeDdEOTIzRGlnTlZaOWF2K2Nv?=
 =?utf-8?B?aHh3L3JIY2VHNnY0cDdJeWNkK1R2SzM3YU1kOWEwSU5SVVJPa0ovMlgveUg4?=
 =?utf-8?B?cFpJcUluMDVjVVZvcmdJL2g1THpiclZlK21Lei9jOUF1YmJyZi8xNkpVcnh0?=
 =?utf-8?B?S2tPSzMxSHpJbE1Bc0N2MHQxbDJ4YU1mTHJRRjI1V3VLQ2xSa2ZTSjdHcmdV?=
 =?utf-8?B?YVZseUxIVVA3bzhVTDNhcVlPMTFtZHpYYzhHd24vOTJVYW9OUWtBK3BGREV3?=
 =?utf-8?B?cmhOQkpLM2QrTnkybWJYUXRrUUJHUUp2Ukp1ZVA1QnhpOGFYWVBKK3VtWHNn?=
 =?utf-8?B?Z3I0a2tNanNBUXVLd2cybmdFTGxueXN0WE9jNTJOeXpEYUNZRGllNmRoYWdk?=
 =?utf-8?B?SCsveVBHdGpWbXhEVXpoOVIxNE9nVVZKTi9WcU5Xbk1VUkU0U004N1FkWUky?=
 =?utf-8?B?WG5WMUNBbEpLQ2I3ckgvTnBkcnRqbW9ic0RsbVZhU1puSGwycks5aS91Yzkv?=
 =?utf-8?B?TDFDQUpzcjhjQ0NMU3psWlZsRU8xTHVXNlp3TXU2YTFwZnp5TVlSck9FVllj?=
 =?utf-8?B?eitjRCs5NTlZcUk1cEFuV0VBa2JzL2pvN3VVZ2NFWjVuU3d6NU1FQmtCWmRM?=
 =?utf-8?B?S3FZRjh1T3YwdXE2aVlwZ1FZTytvc2ZvOEhJSjM0OFd3YUdkNE05UXFCMC96?=
 =?utf-8?B?RTVKTXJsRlYyajBGazVTNU0wRmcxbVRXK1V4cW1sbmdQckxOY1NySmNSSVdN?=
 =?utf-8?B?NG1ob0NJbXFkaDk2MmRWeThGTUh0VXFHSHJsZUNBZlFmQkc3S1lSQWV4VFhC?=
 =?utf-8?B?U3laQ1ROcXJiVThMekgvVDNzK0h0NEIwMjlwUGZBODVQQ0VtdUM4U1BabDI2?=
 =?utf-8?B?WUYvWGNjaTF3VnNDNlFjOGpzNmRCalpRL0FyRnF1OXpTMmJxOEtlU3pKdnht?=
 =?utf-8?B?bzMweDlTOS9pVVNtSEVHb3pyWHR6MmI3WnVHdGdjbXVwd01QZjUxQ2ErSnZD?=
 =?utf-8?B?VUtQYUdrS25OSkszdVZqZlVQRGl5VHZ1Lzh5Q3JWUysrR0JwaEQ1dzM0OEp2?=
 =?utf-8?B?c1p0VTI0YU1kUStZTy80L0NLUjFnZnRoNG91bnI5TEZjU1BNOXp0VjNJZzJI?=
 =?utf-8?B?clpoSHFzRGlsSlNCbXFTLzk5TGF1Y2pCdDhOZWdsdElEYmNGUlBnalBiWmRD?=
 =?utf-8?B?RVBvZ2V3QTBmSnkwaXNRTGdKNi9XRWJJMkxpdm1mSTJBeC8wYzdPbGtNQVpn?=
 =?utf-8?B?NVFvNmtQRU9YbC9RQ0g4Uy9NRlhwSmJRNlVVZTFwbGFpVlUyeE40T1Z0U05H?=
 =?utf-8?B?NnRWSTM0R2I3SFhSQVVFR05tdVBmYk5uejF6UzA0c0VVOG8yR2V4c1VMaTVk?=
 =?utf-8?B?b2s4RzdhSFEwS2IxaXVELzNoQlIvL3U5aEtFRHhSTjVJeko0U1l6SnBMYk9N?=
 =?utf-8?B?dnp3S2duUkVBdlNpNkIra05UVUg3Ty93WEg5aHNQcWVOUndYZjM1UFJoam92?=
 =?utf-8?B?Z0Q5K0JYTmJUZmFCZ2xHNWh1TWM2T2s3Z3pvQmt5RWdNSlhGcjJkcXM1ZXdX?=
 =?utf-8?B?blQySWRTeXlWU3FEK2RmU3g5RnR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46706AE1DB0A4347A719CD1204FBA2AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69be9ff8-4732-40b0-5bde-08d9c3a94ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 11:10:12.2351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyCcP4YegHCOuDz13di7ppJ/3Oy5hfZlRQHlf8ol0E1KUC7pEZsqR0+xF2j25Xg4jG85t3s4171X+G+yZGJU/lsbwdPh8/wZDKq+N3V5Qoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjAvMjEgMTI6MjUgUE0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFR1ZG9yLA0KPiANCj4gT24gMTcvMTIv
MjEgMDg6MDZQTSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4+IG14NjZsbTFnNDVnIHN1cHBvcnRz
IGp1c3QgMS0xLTEsIDgtOC04IGFuZCA4RC04RC04RCBtb2Rlcy4gVGhlcmUgYXJlDQo+PiB2ZXJz
aW9ucyBvZiBteDY2bG0xZzQ1ZyB3aGljaCBkbyBub3Qgc3VwcG9ydCBTRkRQLCB0aHVzIHVzZQ0K
Pj4gU1BJX05PUl9TS0lQX1NGRFAuIFRoZSBSRElEIGNvbW1hbmQgaXNzdWVkIHRocm91Z2ggdGhl
IG9jdGFsIHBlcmlwaGVyYWwNCj4+IGludGVyZmFjZSBvdXRwdXRzIGRhdGEgYWx3YXlzIGluIFNU
UiBtb2RlIGZvciB3aGF0ZXZlciByZWFzb24uIFNpbmNlDQo+PiA4RC04RC04UyBpcyBub3QgY29t
bW9uLCBhdm9pZCByZWFkaW5nIHRoZSBJRCB3aGVuIGVuYWJsaW5nIHRoZSBvY3RhbCBkdHINCj4+
IG1vZGUuIEluc3RlYWQsIHJlYWQgYmFjayB0aGUgQ1IyIHRvIGNoZWNrIGlmIHRoZSBzd2l0Y2gg
d2FzIHN1Y2Nlc3NmdWwuDQo+IA0KPiBJIHJlcGxpZWQgdG8geW91ciB2MiBqdXN0IG5vdyBhYm91
dCB0aGlzLg0KPiANCj4+IFRlc3RlZCBpbiAxLTEtMSBhbmQgOGQtOGQtOGQgbW9kZXMgdXNpbmcg
c2FtYTdnNSBRU1BJIElQLg0KPiANCj4gTGluayB0byBkYXRhc2hlZXQgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlIHdvdWxkIGJlIG5pY2UuDQoNCkRvIHlvdSBrbm93IGlmIHRoZXJlJ3MgYSBzdGFuZGFy
ZGl6ZWQgd2F5IHRvIGFkZCBhIGxpbmsgdG8gYSBkYXRhc2hlZXQNCmluIHRoZSBjb21taXQgbWVz
c2FnZSwgaS5lLiBzaG91bGQgSSB1c2UgdGhlIExpbmsgdGFnIG9yIGp1c3QgYSBzaW1wbGUNCmxp
bmsgd2lsbCBkbz8NCj4gDQo+IEFzIGRpc2N1c3NlZCBvbiBJUkMsIHRoaXMgZmxhc2ggcmV2ZXJz
ZXMgYnl0ZSBvcmRlciBpbiA4RC04RC04RCBtb2RlLiBTbw0KPiB0aGUgZGF0YSB5b3Ugd3JpdGUg
aW4gMVMtMVMtMVMgbW9kZSB3aWxsIGJlIGhhdmUgYnl0ZSBvcmRlciByZXZlcnNlZA0KPiB3aGVu
IHJlYWRpbmcgaW4gOEQtOEQtOEQgbW9kZS4gRG8geW91IGhhdmUgYW55IHBsYW5zIG9uIGRvaW5n
IHNvbWV0aGluZw0KPiBmb3IgdGhpcz8gT3IgZG8gd2UganVzdCBsZWF2ZSBpdCB0byB0aGUgdXNl
ciB0byBmaWd1cmUgaXQgb3V0Pw0KDQpJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBhbWVuZCB0aGlz
IGluIHNvZnR3YXJlLiBSZWFkaW5nL3dyaXRpbmcgaW4NCjhELThELThEIHdpbGwgZ2l2ZSBzYW5l
IHJlc3VsdHMsIHRoZSBwcm9ibGVtIGlzIGp1c3Qgd2hlbiB5b3UNCnVzZSBTVFIgZm9yIHdyaXRl
IGFuZCBEVFIgZm9yIHJlYWQsIG9yIHZpY2V2ZXJzYS4gVGhpcyBpcyBqdXN0IGEgYmFkDQpkZXNp
Z24gYW5kIHdlIHNob3VsZCBsZWF2ZSBpdCBhcyBpdCBpcy4NCg0KSSdsbCBhZGRyZXNzIGFsbCB5
b3VyIG90aGVyIGNvbW1lbnRzIGluIGEgdjYuIFRoYW5rcy4NCnRhDQo=
