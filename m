Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E284B0401
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiBJDiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:38:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBJDiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:38:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B6E23BEC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644464299; x=1676000299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AbwHyNzTg4AUsNQr4eAHNsvyC62vuvKiGyluKXAK8Xc=;
  b=v0cCldj/AOmXaHmEkAk/RLZGpni4kfqK82aJ7xWfprPvlyrzDG2jTPlL
   2lZM2kgMAvBIquy1Bcos9plpYMaSok3kNBKXWy6dKl/eKFGP5b1RgOcQI
   mLUkzm0JRmQMzqhK+GrH3Mzld5GgR+vIJpLaSeRglOlIz0/7xi1kR4Huv
   VhYjJpRtNRol4ISQ4eppINJ7FsvEImtsTuGxSkHxj1DognGxvkHud+GxS
   X0F5TFnz/DDG65r284XlAvkdGhO5D1FnbO54EI8wsn+mDEn64YXuBRXQa
   QRfErZpxcO95yhfMPo8FGzdAU6VrOjO3K+odb0ZvpLpBQkYG0Bb22qqqW
   w==;
IronPort-SDR: nNHJ/8kzKcWldsx36gjhCOTQLDIYjGQpInH3LUEKpYqqAcNDwLJ86nbIFDZ8AJVGdfys9NwxuL
 kVCs0fdt2hnP3lxVnkrCVmqjDi9Ul9w1pUXsrcAJk6nKyJd98NZwotXYWXIj8/JAYfHDCrCRnx
 zcPryNvWcQEf0rVRZniVMm21O0IhUnxsem1WtqL5ZZqmU/moSR50mcWNM8PMBKh19s4V/XgKsU
 h4M1V9bQxAWp18CICNzuumD4XSMQtYM+DGcatONBGNKpMon/YGeqW2tfJaV97F8qFHQz5RI8n6
 rjAptrKVgcnEx1SvfqQ55Xnj
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="152558490"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:38:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:38:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 20:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrckpZ3Tde/ad0pVW26yd/XzjeNOi0txVH39rMCwb087Z1Lp45vqKxggOx4+hAs8M4aM6DShcq/sK35UvZpWp1lJEcvJhOE6a28RH7LDDdDEyfA35jh8GfLNVk18s3viOFVs/dAyWOBZqkwd2U/MY4OaUico4cG+YCGOCc7xPc+AilxUv5Q05AZ+9XIe3Da7qc41XDPJ8Bj2Ba+s3IAWTpQBRVmmEQGWh3duMt/DlTJ7wkksjrhHYTi3WFXmhHh5ypkbB++xlVL3qvl4YRK1nOma2mQtvBqEt6fuRtcSWeNk7oeRRSnHu9OHRUOUQzMVluT4Yqye87jZN59NO9XWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbwHyNzTg4AUsNQr4eAHNsvyC62vuvKiGyluKXAK8Xc=;
 b=E4Z65BMPcwHVnBsji0ULDOG/ZsZlMoZsLpItdFUh+YYSVEn6zfuqZ7qCnQ1qXWsqtMd+cjdgvFrpDU7WsA5PAZkivmKpPJnl0rlUeQmHJ0gZhuq9u8wmydvT7ndf6iOMzzbtcg9IVgeOSaplI5e5LRUBfsSWIeSkishvPyGP5C4IDgr+a2j/RZJgqs07gFUv0Iy4piv5PMJu235mZGEjwmmiPNmKd5pkJf/ZeSR1ReHrKr1EGPfQlwVeluUO280/Rt/Mkg8KiWTpNpQnHA1ch/DfDyz08YSMJQcCSDD5LhBIX0bPFyZs6WYIB8KBaMvaWDHjCnysZF5zh5zLFqYpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbwHyNzTg4AUsNQr4eAHNsvyC62vuvKiGyluKXAK8Xc=;
 b=YQfsKjdHlo5HB59xoxxC92IQGM6VAsI+q90PZ7wcAK0DqkGAND1FBTTvdnEbXE8ZhSxXzhGfJ5bpwP+o33lTuwm++rZdSKw6NNK25bcgdenmiAD+UBbd0b9AvMqdezhgUtbQG5kvafp0DHOUMflLZdYHip5Wz2lSgSF7d27CjFQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB3824.namprd11.prod.outlook.com (2603:10b6:208:f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 03:38:15 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:38:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 14/14] mtd: spi-nor: renumber flags
Thread-Topic: [PATCH v1 14/14] mtd: spi-nor: renumber flags
Thread-Index: AQHYHi+iSxDQuaVTREqygK85YTdBcA==
Date:   Thu, 10 Feb 2022 03:38:15 +0000
Message-ID: <9e116cc3-fc36-f7c0-54c7-71fc726668c5@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-15-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-15-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 505db9e1-f3b8-490a-efe1-08d9ec46c589
x-ms-traffictypediagnostic: MN2PR11MB3824:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3824317A471BBC5C3BEB9C43F02F9@MN2PR11MB3824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:156;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PPcumsiy2eBNQS7yedx/DalAzayeoc1ceqmIu6t0KbQ/AS6QbbVNfVftjsjSyWAbiMTds1JTdfH5Hy+4fcCUfEa63ATwisTHjdfIEseQI6rpQxo5wEEg2/do6m1RK493zY4KvcnWsjCXX2ezDK+JkVpRyAteNLhdzAUuQx2Giv1Wns7GCSt/5WDUi/FTzLtmaylxDnpZjGXz9Xbchker2AXucZFtmkTJDMt6PuUZIx1OfBnzH4D7nqTGue4Yixb1CtGGQT96sxllz3D0YMpZQBSOpCSMvLWReiIfGeABC8s22dNQVpElhmHKmtXr1MD7tKH8dU8dvU6PEIhgkiZ/pK+4SdiQfYAB8QKAL+8ExPGXMz8BcBo837ZfzfDcHwXXxqPfEyb2AG7NKiY5OMFIPitSo+cuBMQ8Yg6B9p8GK8XKLM4YsmAktzN30ffZiydFvwz5Ph4QKILq0cSBRtSEJ2uRNlad5s1h8OdHuIVAhDVu7mTKlabTbJu8fKPXhz/Q0dBXgo3N9sxfx5mxM6CoATupi/ihYjbhaAxtG1ygV65gc/qXFGbnxxNCJZftz5kgwRLszRDXs6vSGnaqvj7RcNkuyGavubpOLpK21gkW9guBqsesmtvoh3AkTa0CqZV3Z4kFPvUclVfsmdWYKcrIMqQi4hZrX79w33t8IXjsa4El3HBfwHLtMcPNR9VM/jbN3OWzh2cBZF7I7DJvIKhXcIVrZVhWImw8E9YQxGIBfJQpncTXUbfKKaArDjzwCUq7Q0ikwK5PwwIai5TAy8qw8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(64756008)(66446008)(66476007)(66556008)(8676002)(26005)(6486002)(66946007)(508600001)(76116006)(91956017)(316002)(54906003)(110136005)(6512007)(36756003)(2906002)(2616005)(83380400001)(31686004)(186003)(53546011)(6506007)(38100700002)(38070700005)(86362001)(31696002)(71200400001)(5660300002)(8936002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVhhWmlpYW5xZ0ZQZTJxbGxxWFBNYUs5elR1SVFyNXhRTDIrNlN5REVWdElF?=
 =?utf-8?B?cU9oaW9PWXRnZ2h5ZnU3RG10M3Vab0hNR2NsY0tnYVpQUEJ0dUJOdkZEUjB0?=
 =?utf-8?B?alZvcDdIVlF0b1JNWno4anArK240Y09IQ2ErN0U1alhmd2o5QWE1bitVcDlY?=
 =?utf-8?B?MGpLbW4wQitiWGpzVnNRaFlKZEo4Qjk2eGpIU3IwWUIvRGFJczJENmd5bHNM?=
 =?utf-8?B?dDRMenRZOWdaaVB4ZlpYbUdIOW5BcnFoeU45U0hwOXNPdVErOENuUWpvSnRm?=
 =?utf-8?B?cEpVTVRzR3kxV0kyOXBvQlp3YVlDbTJMS0NUYTBZNXdOYkd4S2NNWktWbkRT?=
 =?utf-8?B?Q1d4WWp0L3BZN3FXT2E3WUlybklZR0ZuRitNbWFuaVBqL2F1OUFZR3BkdUMr?=
 =?utf-8?B?VTBkaldIZmdpQ0NEL2d4Z0Rnc3Z4cEJEclVjZm53Z29icWVQdG5DVlJ0UU5y?=
 =?utf-8?B?M1ZVd0JTTmZxeVkrL0U5NkhzcDQyL0JNaHVyNDZsMkNOTVUyYS95UEVDek9i?=
 =?utf-8?B?ejI0NU5OdGF4czRHQThmbUJESGRsalJvaGJMYy9jMTZHcEQ5QW9PSG92Tlkx?=
 =?utf-8?B?QmZ2YUtFNnZqVkJXU2g5YmxnZEcwSTYwQU94YjJnSVBraTh6ZzRVcVNZUnFp?=
 =?utf-8?B?a05OSy9IZnBMb3N1SERyQjlaamhJKzViYi9YQ2YyRWtGZ01EUEdBb2U1enFY?=
 =?utf-8?B?TDdmUkhCN3czd0xmTXRvb1dWWEN6NFhGNTNYSFZ2WVhhNlNOczJlZS9lSTh4?=
 =?utf-8?B?WXpHQzRvMEhFM2Q0czRLRlk4MWwzUVN2bFUvdkpNa05KMEttaVNqT3lpenAr?=
 =?utf-8?B?OE5oYnRHSm9zb2pFSnYvZ3pEUmxjL2E0RWNIcS9mQ0pRc1dlSUgwNGI3bU1h?=
 =?utf-8?B?T1I2MzRUdnR1VG5GSkZ5Mnhkc3hIOFFtQS9zSndCdC9hLzA3TUplOUY5cHI0?=
 =?utf-8?B?Rkt5ek1pYm9MaTlwQm5YYTk0d2FhdUFKZldWK3pCUFdKb2FvUEF2QVpMaFpG?=
 =?utf-8?B?N1lHZ2xnM201cWRQcEovYi9TR2YydU1scHZ0dkIvZ25hbXBVdUlyNTZWSUNG?=
 =?utf-8?B?cXNiMXg5UXFQZUxjQUJPbHpTbzdKV2ZCZmtxdGptT1JzSkQwbmdSNU13RXVN?=
 =?utf-8?B?UGtrT2I3ajlxYi9CTHdxb3BhQ3NaU3RqemIrZGRZUWVyNDJQZVVhOUhqQU9m?=
 =?utf-8?B?bTliVGVHWnFzdUVCcHlWYmdlUWVEZzVjZGU1U3JNRStpQk5YUjZ4OGp5a0Mr?=
 =?utf-8?B?Wk5DRW5tK0MvMVA1dGZlNytFS1AyTnhZVmdkUWpVTzhDSzRJRmhEUTNCcFBT?=
 =?utf-8?B?TlZSR3V0RGlVazdFYmgwTWJaUnV0R0ZHeTRjOU50bTk3czY5aEJYaTFBUmhD?=
 =?utf-8?B?NnNoWEIvdzhkVjl5aWJOZCtJOGIwS0o3ZitmTE4ybUdESXhEaW4vY0hnOENl?=
 =?utf-8?B?QWFNZXBKNjdndGs4enZtTE9UeVNlQnRzR3VEYjcxS0Nmc21GdlFXdm9YRnB3?=
 =?utf-8?B?ZkNCT1pzOUlSQ0xjMkxJL0hTaUJiS2V5QnNuNlJDa3A2Y29sbW9KTEhIZmpr?=
 =?utf-8?B?cC9jUitnRHNVZHVyMUZ2Sk9FS091ZUV1NlZxYm1obmlLbFkyQ1Q0Ym05SXhk?=
 =?utf-8?B?eEY2UFBGUDRXVlpiajFIV0hJRlNmNm80T0g0bnlCckorZEw2ak01REFLTXZ3?=
 =?utf-8?B?bmR6eThmb3JIWkpEb3gvTkJ2SDhQYjdNaFo5TllTZWQzNkJETHl0aStaUE10?=
 =?utf-8?B?NTVmcDFWRXdWME5nbXBnblY2VDczeHhmZFVmNENBc3hyY3FKbm91V1ppUVNq?=
 =?utf-8?B?dmJUY0ljLzhwcndiQ29iZXZSWUhpbURzYUZ2YytCbkZxRkF5c2ZhdjV5Skp6?=
 =?utf-8?B?MXhBTW5FZ00xQjQ5a1NvL2tvYU02Q2lyODVBaEE1T3h5c3c3d2o0d2wzbUF1?=
 =?utf-8?B?aFU4WDJ2QWpveEtzZVF4UmJrL1Jhd0ZlbmVZYVpnUitBRUozR0ZCeFpXSXBL?=
 =?utf-8?B?S2R1U1NLbmg0emZ6VGhVYitpUldPNTl4YWgvZHVOM2M4SExuaWxHK0NMTk9l?=
 =?utf-8?B?bklDTXBFOGZhR3dvcDNnWUJ5dHFXUG5GN2NwQXJVanhqbGJadFh6U2xYbjBQ?=
 =?utf-8?B?MHRxeW9PY093RVRFUk9pcmw3WGtmUW84UktUV0lKR3NTYldVN0JWRXdqclB5?=
 =?utf-8?B?VjVIaUJWaTBCMzJtMjluVkFtLyt5WENaRStyS2F3clBxUSswVVJlUW43Ynhu?=
 =?utf-8?B?emsydHpDaHJWaUVuUktpRG54cnh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC514A7A074E8847A62AF5369AD211CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505db9e1-f3b8-490a-efe1-08d9ec46c589
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:38:15.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyKcufb+mdhHK2d2FqEt41hKi0LliglvycfhMyUQIjzeuo0d1vecbzbW4fnmJfF8LCrC1eQAguXFlSJ7wVbItRfLZWf5lQvVZHsN9tNDEiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3824
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yLzIyIDE2OjU4LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFzIHdlIGhhdmUgZGVsZXRlZCBzb21lIGZsYWcsIGxl
dHMgcmVudW1iZXIgdGhlbSBzbyB0aGVyZSBhcmUgbm8gaG9sZXMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KDQpSZXZpZXdlZC1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmggfCAyOCArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggYi9kcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuaA0KPiBpbmRleCAyMTMwYTk2ZTIwNDQuLmI3ZmQ3NjBlM2I0NyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmgNCj4gQEAgLTEyLDIwICsxMiwyMCBAQA0KPiAgI2RlZmluZSBTUElf
Tk9SX01BWF9JRF9MRU4gICAgIDYNCj4gDQo+ICBlbnVtIHNwaV9ub3Jfb3B0aW9uX2ZsYWdzIHsN
Cj4gLSAgICAgICBTTk9SX0ZfSEFTX1NSX1RCICAgICAgICA9IEJJVCgxKSwNCj4gLSAgICAgICBT
Tk9SX0ZfTk9fT1BfQ0hJUF9FUkFTRSA9IEJJVCgyKSwNCj4gLSAgICAgICBTTk9SX0ZfQlJPS0VO
X1JFU0VUICAgICA9IEJJVCg1KSwNCj4gLSAgICAgICBTTk9SX0ZfNEJfT1BDT0RFUyAgICAgICA9
IEJJVCg2KSwNCj4gLSAgICAgICBTTk9SX0ZfSEFTXzRCQUlUICAgICAgICA9IEJJVCg3KSwNCj4g
LSAgICAgICBTTk9SX0ZfSEFTX0xPQ0sgICAgICAgICA9IEJJVCg4KSwNCj4gLSAgICAgICBTTk9S
X0ZfSEFTXzE2QklUX1NSICAgICA9IEJJVCg5KSwNCj4gLSAgICAgICBTTk9SX0ZfTk9fUkVBRF9D
UiAgICAgICA9IEJJVCgxMCksDQo+IC0gICAgICAgU05PUl9GX0hBU19TUl9UQl9CSVQ2ICAgPSBC
SVQoMTEpLA0KPiAtICAgICAgIFNOT1JfRl9IQVNfNEJJVF9CUCAgICAgID0gQklUKDEyKSwNCj4g
LSAgICAgICBTTk9SX0ZfSEFTX1NSX0JQM19CSVQ2ICA9IEJJVCgxMyksDQo+IC0gICAgICAgU05P
Ul9GX0lPX01PREVfRU5fVk9MQVRJTEUgPSBCSVQoMTQpLA0KPiAtICAgICAgIFNOT1JfRl9TT0ZU
X1JFU0VUICAgICAgID0gQklUKDE1KSwNCj4gLSAgICAgICBTTk9SX0ZfU1dQX0lTX1ZPTEFUSUxF
ICA9IEJJVCgxNiksDQo+ICsgICAgICAgU05PUl9GX0hBU19TUl9UQiAgICAgICAgPSBCSVQoMCks
DQo+ICsgICAgICAgU05PUl9GX05PX09QX0NISVBfRVJBU0UgPSBCSVQoMSksDQo+ICsgICAgICAg
U05PUl9GX0JST0tFTl9SRVNFVCAgICAgPSBCSVQoMiksDQo+ICsgICAgICAgU05PUl9GXzRCX09Q
Q09ERVMgICAgICAgPSBCSVQoMyksDQo+ICsgICAgICAgU05PUl9GX0hBU180QkFJVCAgICAgICAg
PSBCSVQoNCksDQo+ICsgICAgICAgU05PUl9GX0hBU19MT0NLICAgICAgICAgPSBCSVQoNSksDQo+
ICsgICAgICAgU05PUl9GX0hBU18xNkJJVF9TUiAgICAgPSBCSVQoNiksDQo+ICsgICAgICAgU05P
Ul9GX05PX1JFQURfQ1IgICAgICAgPSBCSVQoNyksDQo+ICsgICAgICAgU05PUl9GX0hBU19TUl9U
Ql9CSVQ2ICAgPSBCSVQoOCksDQo+ICsgICAgICAgU05PUl9GX0hBU180QklUX0JQICAgICAgPSBC
SVQoOSksDQo+ICsgICAgICAgU05PUl9GX0hBU19TUl9CUDNfQklUNiAgPSBCSVQoMTApLA0KPiAr
ICAgICAgIFNOT1JfRl9JT19NT0RFX0VOX1ZPTEFUSUxFID0gQklUKDExKSwNCj4gKyAgICAgICBT
Tk9SX0ZfU09GVF9SRVNFVCAgICAgICA9IEJJVCgxMiksDQo+ICsgICAgICAgU05PUl9GX1NXUF9J
U19WT0xBVElMRSAgPSBCSVQoMTMpLA0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3Qgc3BpX25vcl9yZWFk
X2NvbW1hbmQgew0KPiAtLQ0KPiAyLjMwLjINCj4gDQoNCg==
