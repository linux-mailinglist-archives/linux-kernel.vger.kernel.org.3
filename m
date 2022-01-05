Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA4484F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbiAEIYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:24:18 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36227 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiAEIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641371057; x=1672907057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VcmVJ7Iw/4zgS4qVdFEFgzF5Mo1+/eLdQtHnw15bqaw=;
  b=2PSzFk0LbwoUzRwkxNzSjLky5JmgCvHuPFAb2G3bgfr5KQkOpKjniL6R
   5/SgMtOcW+Hrx5bhKaLjyEwNc+JU2mv25zz9Ix6o8YkXFsWEF9ajXrBhE
   H0/cD17b/RS1/ZJ/U9fXa+Z6m7ldvSBv01BjxxGZc/jL4FZ0UH96C3eAv
   BZbioxIYVO2Afl4WTQOYEjsyWxIiEA7iPDk9EppyNZpeOAXZSNG+xiOJg
   NpYjOF1kC3vqwwbHm038Z/GenPV17o37FBSR7h/ZV7Pu4eeqNozHsBtG0
   UuheSfwxZsWiMsgdhrvEczu5gTa7foUSk8IXX56GwWzPEFY8Zl6ef3wp8
   Q==;
IronPort-SDR: rc58Ml71kWZ7M10peSMkLcCN7wMG70FeHLvkwxf+LnpUdCfZdWcPt19GKsx1RyJvcDypdgFPRt
 KYEV35ecbe6vUqG5MBeCTer/jNPi1b4rLTpE66csB3zfHcyeIXmzHdSh8pLE8ywzolDXiEt6uL
 G2zzeWtok+0dWbvhsQIm4mUmpaCYclEnIFQrFmHuZ5mXycH7AdgHw9l9TFO4ApmG47G83C7Gnc
 0rHzKzHNlFyWkWalqH+qSe6vVUqo5y/BZNRMPUWi8ksOjyn1OvisFVZxrquV7itFbk7ZddlSrH
 nOvjuqwINZ+IL1et6BzGAmwb
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="148602216"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jan 2022 01:24:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 5 Jan 2022 01:24:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 5 Jan 2022 01:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEp2dqp4mJL+c0tc+AKJXtHVlncTbkevownNudYxmo3eQ5sQWJ97B6pv5bZpZH2u9Sil9NJqZCT20gNE7Be+2BggjCCb0nK9MR6AUHBnH7P09KY3tK1TD1ppDv2otRNjWEUUnj6OuIYIamJt55CD0FYfsxHg/tagmTwUOO+Gd8dvMnFaV5X35+B61TD8ZvMNZXCsd8mP2PsKNDvEufxePndSWqoE2qaRdcJguOXCQNSr4502VMvsj5okPLG4YMvRTfRuOpNinNzQ7nwQUflhKKhagXGxy7C1+YF4DWC/pxzEnnRkbrJ5jUNDaMG26LC8qn1Dv4+Hi1OJZxXYJ9Vwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcmVJ7Iw/4zgS4qVdFEFgzF5Mo1+/eLdQtHnw15bqaw=;
 b=OWxAiJLf/M08y+MniEpnvrrx5HUt7YX/rvHXe1j1FAFZuX/uNRnlA4DnT6TJDJPAn+gft2tobqgk5QKtwhmPScSYYSFlPWHBIdPRaBDTnrrdfBIWdwJxjXp3VE9ewYfLyznUZXuDsh7UQ/FN3SK/LIO+mZONmOdmNMmxyD1GtgAgUTUDP/yO+W/vopyLO0eGh426637EjujaDbjhyMEk/LGY7vrc2BizJOz/nDKlCGbtTPG+JQsqEZOcZtXQrOv8mE2iyX47oxC8MAYP+mH0Ho77seRI118lm1I7tRewso5EpPoqCASM41d0GZDkPXB6E4EKVPpmV/+MDWZ605Cyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcmVJ7Iw/4zgS4qVdFEFgzF5Mo1+/eLdQtHnw15bqaw=;
 b=tkMbT/tLTC8egJ1SIvZ4C7P0AVPCy7DpXSqefOMN4bt12N4pqf6HKXcKYWqflc21wXOEVBycWvo1vGn6bSP+9+4NTRstlMAj8uTY8XpyzJcpcJCgm2adynRcuRHLs1kY3waYfkaJXcPupEigIcFtgCPUEg37B+7GMDxRHgcDppM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2943.namprd11.prod.outlook.com (2603:10b6:805:d3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Wed, 5 Jan
 2022 08:24:09 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 08:24:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <a-nandan@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <patrice.chotard@foss.st.com>,
        <christophe.kerello@foss.st.com>, <daniel@0x0f.com>,
        <alobakin@pm.me>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <p.yadav@ti.com>
Subject: Re: [PATCH v3 01/17] spi: spi-mem: Add DTR templates for cmd,
 address, dummy and data phase
Thread-Topic: [PATCH v3 01/17] spi: spi-mem: Add DTR templates for cmd,
 address, dummy and data phase
Thread-Index: AQHYAg2c8cXnJFrnW0OuUAfZC0aRLA==
Date:   Wed, 5 Jan 2022 08:24:09 +0000
Message-ID: <57e25816-40bf-e7cb-89d6-3bad9e48d6e2@microchip.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
 <20220101074250.14443-2-a-nandan@ti.com>
 <20220104163100.56850d0b@collabora.com>
In-Reply-To: <20220104163100.56850d0b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03624664-9aec-4638-f0fa-08d9d024bef6
x-ms-traffictypediagnostic: SN6PR11MB2943:EE_
x-microsoft-antispam-prvs: <SN6PR11MB294357FD215A3D2BB48DFD43F04B9@SN6PR11MB2943.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lehSRwd7Z2PWjVxYlWgsgkL2j1T174Ldz+iTIIy4JZjPf3CDfeCFlOmT35OTkTe73ftc+XH9YO3Pt2tiOuvusVjApFbscNikkfFEbuQ/7Yhs8vDh3qjZ5KRIohFTy2F3F8AzF1pUFOxGoHLscCxMaYHjhK7ot0x3ggdIMLH0HfZlJr1ZlHkO6yQJmQHNYVsliIw41mlrwARF4n54oteX1b1GXfBrlEH+YaFrr4gq7BCZ36TOho9TvlzKcnVYJZucxfM8Yc22ufe7Hjc7IiY++8U8dEDr13c1zl6TqMOwqgI+4tzBirQOVXRXyr5MB699BWvG2z2GjP7I4XrCbgokWyjLP1IuxYFgM2AD+47HSPLRU/cxP66bchLJXUrf+oIQd5A/nnwhChANkTglCHEt5D/UIJy/6xTPLCGbQIpu4eqP1koO7YykiFMaTWfJTRWVFtc+NHtQEZ1qM5hYw7vuZlqdqkrMHumpx3lY1Exdw3mV0D5TZyotvIYSFST4RECMSi2JHPK1aXCq9kt3cG6WMT+QK01OjoNsUqLFO+7eLf0BTghtn/AN126R6ZEv3gXRQUtir2/n3Ogpm0bSs22tKyzJVCjjz9UoQNfEPen+h5b2UYBcF6Ft+6kes7yPcMRHUqLmujLkaD/0XyxJ2wgc4wvX45OQJkOpAF5OUoeKHsMwk1fbRed5zeFKmWPyi6gl+HdFIW4Hfd5C96GejrVxRQhMeATfUS8FptbDLRQhtjKpMcljHejQU/77FdSEBMqbo5Ujjja7f/9JGFDb7sZi5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(6512007)(4744005)(186003)(66476007)(508600001)(2616005)(6506007)(4326008)(53546011)(26005)(71200400001)(5660300002)(110136005)(7416002)(36756003)(316002)(91956017)(6486002)(2906002)(83380400001)(76116006)(86362001)(122000001)(38070700005)(38100700002)(31696002)(54906003)(66556008)(66946007)(8936002)(64756008)(66446008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVzNnp0aTRDeUZjRHIrSngzMDBCd0tjeEt6NEhjbzlra2ROeXlpeUxjUlRy?=
 =?utf-8?B?YlB0QkhtdG8weDZBSkJwb1FHQStnOGtoYUpIdURtQ2FCd0oxRnJQbWF2SkNX?=
 =?utf-8?B?QTJyTU1seFhoZkxsMG1kZjIyRkxZV2o0eU9ZR2d6YmlhcCtXM041OGlSR1RL?=
 =?utf-8?B?TjZ0UEJqTXZZSWtzZHhCWjV0RUJDRzVVQ2Y3ekVDa09ZTFN4MnJZY0xac2lC?=
 =?utf-8?B?U0FUNDZobDdwdzc5OGpkUjJBK08rVnFONS9lbHFyckRqWFVrTkNrUDJnUy85?=
 =?utf-8?B?cXNVMWpNVkczUWdYWlN6QTRIT1BLTWQ3UmliT28zRzR5SmE2V3hwdlhoYm1Q?=
 =?utf-8?B?S0M2SE1VWWRESmFwVVZqK3pLa1o5OTQzSHlzS21uQ2ZDR2FmVHd1NlMyNTZi?=
 =?utf-8?B?cmgxb1FzV0x4dnk3R29OcG5Tb1RXdFRLQWYybUlZRU5xY001ZWVDbjd6VXZp?=
 =?utf-8?B?Nk40VHhtNnk0eVRUTFhwbHlEMFB6L3NuRlFqMjhtK2J0V2xhQ3ozeEg4UDBP?=
 =?utf-8?B?M0p4ZjVNWVZuYXlURlU0TnlrbXlia2s2S3I1aGdFZDZZdmIyT0EwbDAxcXBI?=
 =?utf-8?B?czFDWHltY25PbURjL0dmbTMwa3RGNUxOY1A5MWdHL1ZWbElGR29RWTdXS2J2?=
 =?utf-8?B?OFdzZXZ3WUtmdHZ0VmUyajl1dVo3ZHd4aFdUUGVQcXJGVm1UVjlCVCtHRjB6?=
 =?utf-8?B?QmVMVERMbzRNM1dlcG9jMW9xRUwzaGdid1BVd3gyRVQ5SWZRQTR2TDJEdGxm?=
 =?utf-8?B?TU9MYkpsOGhKOVVRUjFlZ3k2eGNHWWlHNU9qejdPcEZVOGxhZ3YybzRVaWNF?=
 =?utf-8?B?Zk5vSUZ3Rlozc1hjZVl3Nyt0c2dGTUE3TU1GQ1gvZUVudlhNbUdHZFY5SWtW?=
 =?utf-8?B?V01HYzRqUWlSTWdvS2FjZWN2WlpRL25RTFhodW9kSExGT1lwcVA5UE9Pd3N0?=
 =?utf-8?B?SnpTbDlqQ3dvdjUyVEZXb0VYYVdmampOaTRmb2JmdkJ4RkpkdmN1RTA2aWRY?=
 =?utf-8?B?YzJuL0M4dThVQkkycVExZDZhaXQzL3NJRzhaQitJWWdZNVA2NnBnbFpJUWt3?=
 =?utf-8?B?S1ZMZXZOdTBRaFRIeEF4eG5vejFHL1RlSTA3ZFdPVWNJaU5qVU9MU1U3bWRv?=
 =?utf-8?B?aXBCSEpndTRiMXR6WHZ0RkFRdlUxcUVRMlplZnh0NCtUelVjeUJhcHR1TkZB?=
 =?utf-8?B?eDFlNWh1N2N4RzNHVHFrWkIrS1A5czBPdmliS3NUaDEyOUZhNHRUbDlvNmxE?=
 =?utf-8?B?TnJBU0ZsNjlnWW1CNnlZNnYxZXMxUFhHbjM1Y21FM2xmQkdESXJTLzFYL2hq?=
 =?utf-8?B?MURFN3ppaURIWTlDTjl5RDlwaUp6cVgzcEVKV3dxaVJNdjZhaStxT0ZmNDJT?=
 =?utf-8?B?QlFwSmdVMVprNEJpb3Z4MkFpU1lmTnVDSzQ4S3ByV3R5b1FvQ3JpNytiUXQ4?=
 =?utf-8?B?UGw0U2FWSS9ZT3phWnZuckN2ZmRFbVpZMVd1TCtxb1BPNzZIRW1XdkNEOFdr?=
 =?utf-8?B?N0VSbmVWUTBsb0JsbVZmcG5ONXNDbVU1dGJFejAyeEZNZVduV3FNTURmZlFa?=
 =?utf-8?B?Q3ZxVVlUVHJsLzBMUXV6MDFEWjRySVlQWEZHSFJxTGd0VThBTXFoUXpGYlpZ?=
 =?utf-8?B?N3M1ZnA1TzVaanZ3QXdCaVRITkpCN3Z1NzN1dytZTGoyWmZwWm1JSWNxTlZB?=
 =?utf-8?B?MTNmWjZhcVF2bEhYb1cyVjFPNnIzd0NtdERSd3NaMU5BSnB6RkhBbFVGdFpT?=
 =?utf-8?B?c0Zjbll5RXArVFozUGNZZ25nQ0NvM2g1bDd6NFgrVER0RmNGTXNuMUcrZVgr?=
 =?utf-8?B?aUdlcko2S0tTbllkMk5ES0pENHhCNzNhcUdNK3A2ajYvVzAxalJnWjNUQWxP?=
 =?utf-8?B?dWtWYlpidlVaYVNXc1AyU1dRUWs0MC96eC9VdmxJNWlkTzdZZTg3aVZxeUJI?=
 =?utf-8?B?R25mK1JjcCt3ckpnUVhtVVF1NWR1azFSZVg0Y0pvaXNYOHR2a1R0K1JLSjJK?=
 =?utf-8?B?UG0rYzNoNEtQM0VFeXpEVVlsOTFOWXJSS24veXFSYndvb0xHSVJMTHZBN0hp?=
 =?utf-8?B?T3k0d09xRzlXQ2d2a3lub2JNWmVuMzl4cytsaTR1L3dDS2plVFJhcGJ4b1Bo?=
 =?utf-8?B?cm82TEhCZTlkRHY4ZUswNXUwUitTVUVSWWxOdmlqMGJsMm44UVBHUW1Vc3cx?=
 =?utf-8?B?U0JyTk5xTFFoT1ppQzZacS9DZklUZnl2Nk83amtEa0JOcmtNVUJnWTZmd0RF?=
 =?utf-8?B?Wlo2bzFkb1Y1UldnVHcwbVB5Q3RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F10E012E5C0C974A8F994393F6031F18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03624664-9aec-4638-f0fa-08d9d024bef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 08:24:09.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdRu1B4dg6Ia5hPA9RSbavFy4QQ098cpeovSmfEeCuzlswiEp2o4hfSXmpAyI5nOMOiRh5tktjR67uQ7TPrp50ZaRIb0IWRIGEFTzn+gm0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS80LzIyIDU6MzEgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gLSNkZWZpbmUgU1BJ
X01FTV9PUF9EQVRBX0lOKF9fbmJ5dGVzLCBfX2J1ZiwgX19idXN3aWR0aCkgICAgICAgICAgICAg
ICAgXA0KPiArI2RlZmluZSBTUElfTUVNX09QX0RBVEFfSU4oX19uYnl0ZXMsIF9fYnVmLCBfX2J1
c3dpZHRoLCAuLi4pICAgXA0KPiAgICAgICAgIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAgICAgLmRpciA9IFNQ
SV9NRU1fREFUQV9JTiwgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAg
ICAgLm5ieXRlcyA9IF9fbmJ5dGVzLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAg
ICAgICAgICAgICAgICAgLmJ1Zi5pbiA9IF9fYnVmLCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiAgICAgICAgICAgICAgICAgLmJ1c3dpZHRoID0gX19idXN3aWR0aCwgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgICAgICAgICAgX19WQV9BUkdTX18gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgIH0NCj4gDQo+IC0jZGVm
aW5lIFNQSV9NRU1fT1BfREFUQV9PVVQoX19uYnl0ZXMsIF9fYnVmLCBfX2J1c3dpZHRoKSAgICAg
ICBcDQo+ICsjZGVmaW5lIFNQSV9NRU1fT1BfREFUQV9PVVQoX19uYnl0ZXMsIF9fYnVmLCBfX2J1
c3dpZHRoLCAuLi4pICBcDQo+ICAgICAgICAgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgICAgICAgICAuZGlyID0gU1BJ
X01FTV9EQVRBX09VVCwgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgICAgICAg
ICAubmJ5dGVzID0gX19uYnl0ZXMsICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAg
ICAgICAgICAgICAgICAuYnVmLm91dCA9IF9fYnVmLCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQo+ICAgICAgICAgICAgICAgICAuYnVzd2lkdGggPSBfX2J1c3dpZHRoLCAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAgICAgICBfX1ZBX0FSR1NfXyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQoNCkkgbGlrZSBpdCB0b28uIFRoaXMgYWxzbyBj
b21lcyBpbiBoYW5keSB3aGVuIHdlJ2xsIGhhdmUgdG8gZGlmZmVyZW50aWF0ZQ0KYmV0d2VlbiBy
ZWdpc3RlciBhbmQgbWVtb3J5IGFjY2Vzc2VzLg0KDQpDaGVlcnMsDQp0YQ0K
