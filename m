Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29B4B03DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiBJDXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:23:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiBJDXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:23:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A7205F1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644463405; x=1675999405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2hVPBhm3bJVayKa0Iph58q53MY9aD0Pb4IobGDeNwYw=;
  b=1U8q/lIM8kbFxHy9uoM0jz4JvQH8zblWEpCI4UR8g5Hq33nDRiIsJAE+
   tUF3GF9xjSF+gB8xReIQUcuMkAAenNpDTSRQmusp4EEOS0oe7QHt3tpFg
   x4foZFTmWAvGxCKcnyHNSdoGgPj7+w9LuRiRinuDDqgzBnVnJnzwefydh
   XGylvX2afWQ1Ay9lPeO5s2XVMKw+A9iGgtgl1krRNflLJ6GfLH0/vOx7n
   TqSH6yFz1qbH7DN/VAD7vMhaHrT6RkAc8vSSBxfs6dc+tAYF3chWw5EML
   sDwVr5Gozl6j2UYvlP/MUgRzSBspPoD8rz2/5DPdXaWSoQE7lbK7MEVNA
   A==;
IronPort-SDR: jePZvD5sHaOGE7APs4gvN9aqY1MI1lzLxv0F+dSYEwMFZ00a7TjeIXNxsziYAfML5MmApltlEX
 SYl5AE2Lkh+Vo5Lshb8sOfkVTMGohZv6zZz077S7MZXy6Ag2Rs8nb0z8A3yZKX8K8PP3ckV32y
 vDtXlEJdpIZnJXkNheYyP6PajXCVB26idSrjPGKdh+eBicqN6zrTlMmWoV9xgkR47FFvx9AD5O
 W2lY0GKK4/WBBrqEYv3+n+Nnbxo6pguYqv15hXOu4ffKYhICAOJVA0xTYRRDOFujcXraM9pq/Q
 Nm721m8Xg/3QunuH9YFT0hNQ
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="153078411"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:23:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:23:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 20:23:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMtAaHwIZzH+wGWZVRtNhY+rPBGxQX2cLr1KNxW6XZn3XvNWhqK08XZXPvscro9p8NTqdP383GfhdBKXVL7QHyjEyi7B/LKgFMDwTTxTpgRV+RV/fSSpiXmcuxH94XCs9cUcqLDczO3ceQCc5KZfCul6liV6s/o/BIjkH9zMR+ec/DQnPGmGDYt3SO8GzYfFzRkLcM/OHZZIy4ztD+h708v/JIq66BCN8N8QqBYmeLbWI03YO43f+BHiHAPedt8nAmu2Bm/QNZrpK09c3IYL8vCxiMbP9ddWfqhogrOa8tLDKGtRD/4UIB5QWAmCTDXOWC2gU4jXBxsT1AiUYRy5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hVPBhm3bJVayKa0Iph58q53MY9aD0Pb4IobGDeNwYw=;
 b=n6B7t98UAPMkmQ2M81kpeicCXd4PKQx6yJ2NE7AQA0nRFhWsPa2x238xbeWFPvWN7Pi4Gkls4AXPeDguhcD0EHDhY3Zz+PyH0zvdtJAZmwc9oEQ0o9VndjMbrA8zRTxVApwkF2awsUq+Inxm7sdsnlAYYrtuJNcT6szKqtmiFLnefTvdV107PsQZJlDfLs9HNZICKPe8YYwI6fM/OcotIVH+W5gOJbghQz8Mk7dE456R9eFtHe7fmmJYloVqxcdqn3/UCk0J+6cV/k+cfzYV1Uvj0oZwYeYlJ23wvNekXQJ7nT/ZmdpZghiK/OkzZaM38UbfSc5df7xrsnpq0dyfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hVPBhm3bJVayKa0Iph58q53MY9aD0Pb4IobGDeNwYw=;
 b=GLKWaT8Cy7v/xvwDWbRfF6MRLS8O/Li310GAK5r6j8D5ROk2XKa+QSrKBwHAr0od0RC5y0Zs2SNJas/7fkhXhqHRPAVdIqlHn9384mMbtXbACpmcx7kQbpy3yXi/VojW1/Wp+sgl0zKPfAt6SKdrS0Sib06CqMELAu9pwW3iQNM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 03:23:20 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:23:20 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 10/14] mtd: spi-nor: micron-st: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v1 10/14] mtd: spi-nor: micron-st: rename vendor specific
 functions and defines
Thread-Index: AQHYHi2No5a64VrrkkajkVo0YQK4Yw==
Date:   Thu, 10 Feb 2022 03:23:19 +0000
Message-ID: <39cda7ec-ba71-98f8-4477-cffd7f66fb8a@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-11-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-11-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9db800b5-6a79-4999-bd53-08d9ec44afbf
x-ms-traffictypediagnostic: DM5PR11MB1914:EE_
x-microsoft-antispam-prvs: <DM5PR11MB19147AB2FAB0F4B6C752205CF02F9@DM5PR11MB1914.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yLwyWQD+6Vb+HWp6yaEbUawvtGrbuDAExowA89PiOk+KeTHjzpEc/K2p72Tot6t2N6bRY8wcpTGVVgQfh4ikSncp/vmJurys45rvDemA4UxIg/4ixNb/oM72WyJgfEqTqRbzvFsOOBwJ/erixCIO7/PEUwlgk/Z9jElDyfV3p2NdAdC+vArJMmFW0KhT35Sfzt6apWqNWis56fUqCo04SGlrpcaE5pahVGtssgual0W+2/YD40o/BaWqLX65EI4WHBssakzIL6IY2YJYl38nDLhUaGJuPPoi0gfvNAe3jNLe7H7lKaILmXzb/nU6Qc9GyzoixOFH3PI6yX47RPSJlKzfjyn5XH3T1g94HWYiLNaIRbDjnUD5/B3hI7GNJ5PDeBn6FcuCFvHwwmCoJEZRaXJPrNKDckYIkFvWuO5iuz0gVHU+RUnGWWUDp6P3WeS26GwSTmVydkdhd15LO5fC0Qr0P4+1qhrn0plxMjIses7IAUEzgWElOniW9wGvLrMdBJoTZNfuq3Jfrk7tTxaC8BEn+N+m7syz8204tNiIGDFJXhbMEwNw9+GE/yufMz0UJ4iYP/KJXjATPU7WmdreP08MFRWdM9F5ZHmo5nFMmWf4pF/JNFXasxJdIkCF0PGSezq/oTAYd/pmpBrshXl/ggKusLndLAOHJJrHH4joRPzDDoZheFnrux4uqKIVXWGmGky4WkpkJGLBrGyA8cCjLitU429iBLPk/M+o8vKXT3IM+dFjjGEenTzv8vNvPmCQenJfUPHbY8Nrfa1Z3I9c6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(2906002)(8676002)(86362001)(316002)(66946007)(31686004)(4326008)(38100700002)(8936002)(64756008)(66446008)(5660300002)(76116006)(66476007)(38070700005)(91956017)(508600001)(54906003)(66556008)(31696002)(2616005)(71200400001)(186003)(83380400001)(6512007)(6506007)(53546011)(36756003)(26005)(110136005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3Jkc3F3QXB6emh2bG1nbzZyaTRRU2djZEVNV3FyelpYNC81T0tZOTFTYW92?=
 =?utf-8?B?dkoxUnhTWGdUVDF1d2VHVkNxcUtUVXQ2WEgxdkE0WTJTemRBTXJ3R0pMNUtW?=
 =?utf-8?B?SEtsS3ZtVUhZWXp0ODNPQWE2blR1UU1QN2tiTUhFbVljZjZFRzFocG5mOG9l?=
 =?utf-8?B?Yndtdi8wak14MkpERE9KcGRxM2tTWGFJUHduV2M3NUFwdVdDWU14Zm05aU1j?=
 =?utf-8?B?Nm5QZUdJY2NzR2kxZ2pvU2xGalNDWk04QldWQjdrWnprdHVFZDhCdDd3V2dN?=
 =?utf-8?B?cExONTdMMWh2dkMxOU9NSzF2K2VUdUhod0N5MFlRbVB5b0NUTjlwOXlGZ2tx?=
 =?utf-8?B?NFY5cFZodkIyUXQ0dHF2RTNpWnhQWXdNZUtNOTlWSHlXVUV2WE9oVXA0K0lL?=
 =?utf-8?B?cXdWcGVJZXJkZXZrTHF0MjFiVW5weGVVcGsyWHIrbklqV21tdWkyWUNRNXhK?=
 =?utf-8?B?Z0gzR1YrNFY4blhBOGhtZDhrT2NTdElvWkJBS2Z1NDBRMmoxTTBsMVdnRHZG?=
 =?utf-8?B?RXpEWExHd3ZQTFRYZjArekhqSFd4WDJBeGh2V2FPQjBBYlI1SCtRUlNwcmkv?=
 =?utf-8?B?T253b09acTYyMW50aFNoaUFyNm1GcW56WS9PMjNPVTFTczJCak1nT1lwMnAw?=
 =?utf-8?B?eExETnBKZWZKREFvMVYzaGk1TXBzUW1uc1diYnE3TnduMkt1c3FqV0g2aEd3?=
 =?utf-8?B?SmEwK3JoUHZkbFhGQ3Ivb2ovMjAzQWJrNWJybVFVWEtDMlNTTWlmbldPOVJh?=
 =?utf-8?B?L09rV1Y5dDBqZDZzaHdxSWFMVlNTdGVWNlZJUWlJb3lSM0pLbGxzeFZTNzJF?=
 =?utf-8?B?LzJKSVBqV0RCUUFRdVBZRGhyZEl1cGtXOVhnQkt4RmZNT0l1Tkhha1RQSEpO?=
 =?utf-8?B?V1ozcXU2NWFiZE5FZkplQVd4OExLVTc3Rmt0VGd4ck1rTjdiK1IwakJJMHBK?=
 =?utf-8?B?VmpFMWNic3FXbGQ1YlFHcXFsNlREc0dzdTBVeG1qaXFsYlQxVkZFWDdEbSsz?=
 =?utf-8?B?Q2VHQUtXbzBPRnN6RjN0Q3FBOVdoN01ub3J5S25Kb3VjSXdIUncvZ2dtb2w4?=
 =?utf-8?B?RHJVYzRuRVZIWjQrMmpmQUNyTmNISWZRWGdaNmxyRUxzYkR2NGx4bllsekV3?=
 =?utf-8?B?QWFZN2l0MVRsclR1c0ovcnNBV1FRcmRTc01NL3piY01GQ3VhRnRtNFRxUUJQ?=
 =?utf-8?B?MmlSV1pmZ2doemszVzNKck50OW1XWHFweWoxNmRIWGZoNjBQaWxSdUZ1eW9F?=
 =?utf-8?B?c1M5azBTbC8wNnRuUVU0TUtLUlFYUWc1SUFqTVIyMkNjWHFqNzRBTmZncThn?=
 =?utf-8?B?NjVhb296UlhoU0t4THRkQjRUdUJlZzRhWkNTUnhHbG9abWJ1ZmcvdFpTNWts?=
 =?utf-8?B?NWpZVmZlTWdZSnpnWW9OZmNSWmlSZ3cyTU5ReTgxOElCeS9PT2l1akxpdXZm?=
 =?utf-8?B?MzJWRE1ocVRFVzgwMVRkamV3L3BtbnBQUkdoVmczMi8rcHRjd1lsbE13aFc3?=
 =?utf-8?B?RWlHR0lRMStIUjFhK3dnOFBYT1NwekVCVERBUEpwQW51ZS9RUmVZV1N5YU82?=
 =?utf-8?B?anYvZHdrN1pYbjZPQldJUFVRSEE3WG5yMkx5OHVDYXBQM2VLL3JjNGt2aTAv?=
 =?utf-8?B?aktSRi9odUNqTkJ0bExWUzY2Tmo4YWxYT3V1NSt4cmhOeFJnK2w1S3lRc1Ni?=
 =?utf-8?B?UVgxeksrUWVYYkljNGU3d0ZQR1B4aCs5WTJuNWoyNGNVdWl2WklyZUtuN3BZ?=
 =?utf-8?B?STVQREhVRWpqQjIvaHVkOUpYVUtyclN2em5zRmE5bDdwdkRadm95R2t0QkZu?=
 =?utf-8?B?eEIzcFM0cWcyVTVVanNLWnpSc2tqQ2plc2g1NGdlejU4SVp6TllYb1FaSDNO?=
 =?utf-8?B?VHIzY0NWSE83bXA0RVd3SEE4WVhmanZaVkNHWVZpaFFCSG1QRzFtRlBVRnNU?=
 =?utf-8?B?TVNZR0xudFJ0emtNWWJ4dGZia1pvdlc1eEZrSkVZV0lYRXFWdmE0TXZZR0c2?=
 =?utf-8?B?MWhra1d3NVMrZHJ5N2swYXBjNE9URjlZZW9FOElQZVNzcnBjNWpQRFVtZjJM?=
 =?utf-8?B?MG1hNTFrZk0rWWpvMmhoOTNnWi9GMy8vVWVRSG1qeDlZVkJsNE9wM3o3L01z?=
 =?utf-8?B?b1BvOHhRRzJDS0ZiTUlpRFZEakhDUkdKMHJ6YkFUZjJYMHpDUHhFN3FMT2J6?=
 =?utf-8?B?VjQzVGtQSjRLQkcvbnozYytXUjVkc3FDc1BUZ3RoYjBOUGNHK0lGTEM3cHNS?=
 =?utf-8?B?Sm9RRXplT1lhbzVUMDdBbEtObWtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <151A30A7277A6F48B81B594B7959F0BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db800b5-6a79-4999-bd53-08d9ec44afbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:23:19.9208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypmbi1qbbdcoE8iWlJhwZf3Fe+sj7qRFFNoSCnWfMyZ/Tyxcjfikuwf29wK/aO4gZ+R68nE5f9GAkkzmWU+hjglFoTcURwMZ4WkpTFoMhNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1914
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
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IERyb3AgdGhlIGdlbmVyaWMgc3BpX25vciBwcmVmaXgg
Zm9yIGFsbCB0aGUgbWljcm9uLXN0IGZ1bmN0aW9ucy4NCg0KcGxlYXNlLCBuby4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIGIvZHJpdmVycy9t
dGQvc3BpLW5vci9taWNyb24tc3QuYw0KPiBpbmRleCBjYTM2OGI0OGJjYjAuLjk4OGVjYmZmZGMz
NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPiArKysg
Yi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+IEBAIC0zMDgsNyArMzA4LDcgQEAg
c3RhdGljIGludCBtaWNyb25fc3Rfc2V0XzRieXRlX2FkZHJfbW9kZShzdHJ1Y3Qgc3BpX25vciAq
bm9yLCBib29sIGVuYWJsZSkNCj4gIH0NCj4gDQo+ICAvKioNCj4gLSAqIHNwaV9ub3JfcmVhZF9m
c3IoKSAtIFJlYWQgdGhlIEZsYWcgU3RhdHVzIFJlZ2lzdGVyLg0KPiArICogbWljcm9uX3N0X3Jl
YWRfZnNyKCkgLSBSZWFkIHRoZSBGbGFnIFN0YXR1cyBSZWdpc3Rlci4NCj4gICAqIEBub3I6ICAg
ICAgIHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9yJw0KPiAgICogQGZzcjogICAgICAgcG9pbnRl
ciB0byBhIERNQS1hYmxlIGJ1ZmZlciB3aGVyZSB0aGUgdmFsdWUgb2YgdGhlDQo+ICAgKiAgICAg
ICAgICAgICAgRmxhZyBTdGF0dXMgUmVnaXN0ZXIgd2lsbCBiZSB3cml0dGVuLiBTaG91bGQgYmUg
YXQgbGVhc3QgMg0KPiBAQCAtMzE2LDcgKzMxNiw3IEBAIHN0YXRpYyBpbnQgbWljcm9uX3N0X3Nl
dF80Ynl0ZV9hZGRyX21vZGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFibGUpDQo+ICAg
Kg0KPiAgICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UuDQo+ICAgKi8N
Cj4gLXN0YXRpYyBpbnQgc3BpX25vcl9yZWFkX2ZzcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCAq
ZnNyKQ0KPiArc3RhdGljIGludCBtaWNyb25fc3RfcmVhZF9mc3Ioc3RydWN0IHNwaV9ub3IgKm5v
ciwgdTggKmZzcikNCj4gIHsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiANCj4gQEAgLTM1MiwxMCAr
MzUyLDEwIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkX2ZzcihzdHJ1Y3Qgc3BpX25vciAqbm9y
LCB1OCAqZnNyKQ0KPiAgfQ0KPiANCj4gIC8qKg0KPiAtICogc3BpX25vcl9jbGVhcl9mc3IoKSAt
IENsZWFyIHRoZSBGbGFnIFN0YXR1cyBSZWdpc3Rlci4NCj4gKyAqIG1pY3Jvbl9zdF9jbGVhcl9m
c3IoKSAtIENsZWFyIHRoZSBGbGFnIFN0YXR1cyBSZWdpc3Rlci4NCj4gICAqIEBub3I6ICAgICAg
IHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9yJy4NCj4gICAqLw0KPiAtc3RhdGljIHZvaWQgc3Bp
X25vcl9jbGVhcl9mc3Ioc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gK3N0YXRpYyB2b2lkIG1pY3Jv
bl9zdF9jbGVhcl9mc3Ioc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gIHsNCj4gICAgICAgICBpbnQg
cmV0Ow0KPiANCj4gQEAgLTM3OSwxMyArMzc5LDEzIEBAIHN0YXRpYyB2b2lkIHNwaV9ub3JfY2xl
YXJfZnNyKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICB9DQo+IA0KPiAgLyoqDQo+IC0gKiBzcGlf
bm9yX2Zzcl9yZWFkeSgpIC0gUXVlcnkgdGhlIEZsYWcgU3RhdHVzIFJlZ2lzdGVyIHRvIHNlZSBp
ZiB0aGUgZmxhc2ggaXMNCj4gKyAqIG1pY3Jvbl9zdF9mc3JfcmVhZHkoKSAtIFF1ZXJ5IHRoZSBG
bGFnIFN0YXR1cyBSZWdpc3RlciB0byBzZWUgaWYgdGhlIGZsYXNoIGlzDQo+ICAgKiByZWFkeSBm
b3IgbmV3IGNvbW1hbmRzLg0KPiAgICogQG5vcjogICAgICAgcG9pbnRlciB0byAnc3RydWN0IHNw
aV9ub3InLg0KPiAgICoNCj4gICAqIFJldHVybjogMSBpZiByZWFkeSwgMCBpZiBub3QgcmVhZHks
IC1lcnJubyBvbiBlcnJvcnMuDQo+ICAgKi8NCj4gLXN0YXRpYyBpbnQgc3BpX25vcl9mc3JfcmVh
ZHkoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gK3N0YXRpYyBpbnQgbWljcm9uX3N0X2Zzcl9yZWFk
eShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgew0KPiAgICAgICAgIGludCBzcl9yZWFkeSwgcmV0
Ow0KPiANCj4gQEAgLTM5Myw3ICszOTMsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3JfZnNyX3JlYWR5
KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICAgICAgICAgaWYgKHNyX3JlYWR5IDwgMCkNCj4gICAg
ICAgICAgICAgICAgIHJldHVybiBzcl9yZWFkeTsNCj4gDQo+IC0gICAgICAgcmV0ID0gc3BpX25v
cl9yZWFkX2Zzcihub3IsIG5vci0+Ym91bmNlYnVmKTsNCj4gKyAgICAgICByZXQgPSBtaWNyb25f
c3RfcmVhZF9mc3Iobm9yLCBub3ItPmJvdW5jZWJ1Zik7DQo+ICAgICAgICAgaWYgKHJldCkNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiBAQCAtNDA3LDcgKzQwNyw3IEBAIHN0
YXRpYyBpbnQgc3BpX25vcl9mc3JfcmVhZHkoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgZGV2X2Vycihub3ItPmRldiwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIkF0dGVtcHRlZCB0byBtb2RpZnkgYSBwcm90ZWN0ZWQgc2VjdG9yLlxuIik7DQo+IA0K
PiAtICAgICAgICAgICAgICAgc3BpX25vcl9jbGVhcl9mc3Iobm9yKTsNCj4gKyAgICAgICAgICAg
ICAgIG1pY3Jvbl9zdF9jbGVhcl9mc3Iobm9yKTsNCj4gDQo+ICAgICAgICAgICAgICAgICAvKg0K
PiAgICAgICAgICAgICAgICAgICogV0VMIGJpdCByZW1haW5zIHNldCB0byBvbmUgd2hlbiBhbiBl
cmFzZSBvciBwYWdlIHByb2dyYW0NCj4gQEAgLTQzMyw3ICs0MzMsNyBAQCBzdGF0aWMgdm9pZCBt
aWNyb25fc3RfZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICAgICAgICAgbm9y
LT5wYXJhbXMtPnNldF80Ynl0ZV9hZGRyX21vZGUgPSBtaWNyb25fc3Rfc2V0XzRieXRlX2FkZHJf
bW9kZTsNCj4gDQo+ICAgICAgICAgaWYgKG5vci0+aW5mby0+bWZyX2ZsYWdzICYgVVNFX0ZTUikN
Cj4gLSAgICAgICAgICAgICAgIG5vci0+cGFyYW1zLT5yZWFkeSA9IHNwaV9ub3JfZnNyX3JlYWR5
Ow0KPiArICAgICAgICAgICAgICAgbm9yLT5wYXJhbXMtPnJlYWR5ID0gbWljcm9uX3N0X2Zzcl9y
ZWFkeTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9ub3JfZml4dXBzIG1p
Y3Jvbl9zdF9maXh1cHMgPSB7DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
