Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B448C50939B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356481AbiDTXby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiDTXbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:31:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2559F2DAA7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650497345; x=1682033345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gru405AzP3ooucYAEiuaHfjlDv9Ivz20NOYiIDJ8Pdc=;
  b=RagJ+EeS4OWEii97DM9kNVTUCj8yHN3AAkl2qKtGXXk1zNJuMo8DZsZB
   xrcESDMWBWrBoB5TFQTpF/0d2uK399r7Jsg6jrLKBZnYTDL3mZcE2BEai
   0NlUTEuDlKtOSRTBet7n0hqhqMYZJGY6Et88D9NoqT64GUL9bqwsHAxSK
   5xD2mnG5VxoFHDsdhXNDk3ryWk5YmhTv4YWPpyXFXYJrGCCvNiNwEG9aR
   rfKC/2cAblMMfWh5LflUJE9MWDQUBfaY2u4XJrvTlCY8ehv1zaTKYS0yZ
   HlI7X5JjTRh9pVkdU0485S9YflROaPCN8HDMT7VDJ913USZGJ8axX/5xW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263938874"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="263938874"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 16:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="576865720"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2022 16:29:03 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 16:29:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 20 Apr 2022 16:29:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Apr 2022 16:29:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSiNXolhW9KOhjESANr+p+Y37DRFm4/8foozJsdvKxMqjQwdmQ9qDa8NdQORCdgFJHFKmDOC17GAFjpKDZn7qyRPIKk4+Q7cav5ImVSPrg+Zc3kE9QxFV47GCWf4Iha2lsNJpKMFjflGko3sW9ae3I2NHMYMcLP8M+0WqkYgCv6zPcC/i1AQDq55G5TEhi1Y/Hri6sxRdZlVZd6QgAy08mQwepzQRTU5wJykGuuJRFpRp92wuU0miFD0NUfen1DGV3fY4Oont1MpfOqMkg6G+h1orI1D/o+4cE/DIJN4q2543sPjg+KSKhqH3qqN1W1motaJVEOHQotTApPH+fgaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gru405AzP3ooucYAEiuaHfjlDv9Ivz20NOYiIDJ8Pdc=;
 b=dAUrvngW81h6numoiDY8/48gjpgNkF+GLJlzjj4cVRPKC8w2eAVkWl8+wEkst9RE/RxxjiuIRyi6ZjO3PiPkowEywtPkix3M9lMDZjP9hvObj0aCC1kstnQvbkRwCt3djHjSRoj9bb73DvsV68vh8VrrrQkZFtGwocPgINmToiYt6thOf8YYCDIxrFmML+AdWjbXEQsRqMfAlX6N6ExRJAxBFp/WGRELjfHVgYQa7j66p4e9o1UctHNbQWgHbwqZzsQlmdLSwN71CP30ymVvi428psw3Pa+/HyLvcCF5zc632Pj0+JJR2qwxX3Wu4RVoGzHnLEKQS87PgK1rP7TZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10)
 by DM6PR11MB3452.namprd11.prod.outlook.com (2603:10b6:5:9::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.25; Wed, 20 Apr 2022 23:29:00 +0000
Received: from PH0PR11MB5078.namprd11.prod.outlook.com
 ([fe80::4d00:bf7b:fd4b:e415]) by PH0PR11MB5078.namprd11.prod.outlook.com
 ([fe80::4d00:bf7b:fd4b:e415%5]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 23:29:00 +0000
From:   "Moreira, Joao" <joao.moreira@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Brown <broonie@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>
Subject: RE: plumbers talk on kCFI, BTI, & IBT?
Thread-Topic: plumbers talk on kCFI, BTI, & IBT?
Thread-Index: AQHYUEaVjvSr7ym/Q0KgphPxLde+fazxQvPAgAg25qA=
Date:   Wed, 20 Apr 2022 23:29:00 +0000
Message-ID: <PH0PR11MB50787B814A611120054DA76485F59@PH0PR11MB5078.namprd11.prod.outlook.com>
References: <CAKwvOdkyMyE0ZRUU9Rh4qTxpOseD=fydo-FB9kdd7zRo7nVreg@mail.gmail.com>
 <PH0PR11MB507871A2E984E6AD0D2C600E85EE9@PH0PR11MB5078.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB507871A2E984E6AD0D2C600E85EE9@PH0PR11MB5078.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edd32b78-7d54-4aa0-0027-08da23258c58
x-ms-traffictypediagnostic: DM6PR11MB3452:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB345206FF8039BB27ACC59FB885F59@DM6PR11MB3452.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ooFG9jq4Hkrt/bYpShGoTCdyPh1K3p/8J5F4wYmUnS/s/i4nTJWcM4swUAARh+pz4Rs65px/HxJy1ZHSPQMVChsF+p4lVNWWYYioSKgfHH3f40eDlSc2JBMpp0vAJZgm+m7OK3bwNdXe/6w2W8BHoRlgObbFEVCk0F9CLPKXX01L1y7TLWjHAyTKPvzlNafgMzwqnW9+bSs+DMvW2X2ruo5URMGx0jqW0PRGwdqy3xQqC25HR51sEZnGh1+CA//u3F1pnA+2wwu0UF5p7ewq8zw/JP0G2CiQdfJM9J8iR3Qg0+eg4YOdZKB9nPrE6HQy+On+71uVJWsH7Yms6nFB6M5oh1oeYl8q1WiOhBB8zVINQWlTGZAO3VPtrY0xeuZCKkADhpfFqN0ea+vD4JRne86pbpFaUvL9w82QaInqw21mYXNuprZyk8Yaqr2bRnbwOFLZcILHOepBimE3yjsZ0vba6CEB4LPgKHbjXa6i0A5DbNkiY0ON04axwNYJCbuVIqCmtHOQoErnvFQaK9npVshjUi+KpPrDgvQrvWb4HrToKTvCcCuzHwxiCnemq4sHPHDO1mHy5+WGHdi+Ps6CK+u/1+PICmrsB0ePjmfqhuUZAw8iRa5s861aUtHPHfjZNrHAW44Vb7b6nuJjhG7GBNDKVmIeQW53hIBOxIrM7/gQ4yjZgWBPWXMTYguhKsw3jldkkUzoudpBMKRL+06bFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5078.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(82960400001)(316002)(110136005)(38070700005)(38100700002)(6636002)(86362001)(9686003)(508600001)(122000001)(7696005)(6506007)(5660300002)(2906002)(83380400001)(8936002)(52536014)(53546011)(66556008)(66946007)(66446008)(66476007)(64756008)(76116006)(4326008)(8676002)(186003)(26005)(33656002)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3N4NFlHQTFPVlRpWnZkdzFBL2JjQnlzLzJROTdRVEZicmloU2V6THNTQmpI?=
 =?utf-8?B?MHJIcnZBL3V1My9FK2dpc1FKNVNQMFFaUHd2RndpaUVHUzBmdHFFb2JBMSsr?=
 =?utf-8?B?RDRTWEVYMVVGS1h3SW1HcW9YYzQ1UHp4TkRWa2tiMkl5MWI4VHBmNUkwajBN?=
 =?utf-8?B?NWVZZm9GNWl4VURHdFo4UnBiaVI2d3hlNFNkakE4cGowc2I0bXVJTjNaUmNS?=
 =?utf-8?B?eUdsY0JSa3gycW93d09CakZNWTRpZzB2dHFMeVhQbW9DaW95ZUxPMGpXRFdq?=
 =?utf-8?B?S0dYTUpoUmh2MWhWWS9vOHVhWS9YYnQzK0w0MzU4cTZxNEhqME5uV1BkN1Qz?=
 =?utf-8?B?Rkh2U25tNENZcGl3eFVtY01CSnNxYUFDOGtqL1paS2FLQ25ReFpBZ1JkZVpL?=
 =?utf-8?B?REFXcHpacVVHMGNxYkEwZDFDNS9FOXVYQ3ZGSFFVT2p0MGQyd1orYWZaWjlx?=
 =?utf-8?B?VlhpN0tLOS9sRkRCTC82UUR4ZmdqYWFvWTQrOEFMVXF5M3VTNDd5c3duZTBp?=
 =?utf-8?B?REswZ0lJL1NLOUFNaDAxamp2cFI0TDB4d1l0QzBjcVk1d0YvQVBXNkZ4RWlX?=
 =?utf-8?B?MFhMQVYxcG9ReVd0ZHhyYStmelRXT3JndEVRVFRaYmJ1QWN3V2FYeWhkazFI?=
 =?utf-8?B?UGcwRE45enRYMWFGZVFMZFhQVjhFN3VuNTRESjJCYVREMWlVZkNsSzhpaTN2?=
 =?utf-8?B?UnVzTkJhOUMwaGZWa2krK0pLdE5DRE13Q2ZBalhKZFAyTzJsTkQzbG9XNjJv?=
 =?utf-8?B?K2hOdDFiU2VQeWRwYTA3UFJ0RDQ4YTB6dGRkWXljRWZxNXE5VEdvMk54VHZw?=
 =?utf-8?B?bi90bTVDN1Q5QXd1S1JBYWJsRXJxcDJXeFZIa2pRZS9rQ2dNOTRzNFBOcVRF?=
 =?utf-8?B?c0l0NXEyaG53TjFDeGlBaW9PTmVLNUpuQWlNaGtLWThlaXd0bWhPRTIzV1hH?=
 =?utf-8?B?RksyU2NaMHV2R3c1U0g5aWNBcHZJTU5DYUVVdW1Kd2ltVVVFZXVsQkJkZ1hk?=
 =?utf-8?B?QWZaaDBwKzBVbUtpTDlpVVRGZmpJUVhQclVQaHNIMGtvb1BwMzh5MTRxL3Ix?=
 =?utf-8?B?TEpyWU42VjNjRG1tcERBM0FSMjdZdjJaM3U2cERSbFAwZjg4SnZQWmNYYlFa?=
 =?utf-8?B?ZkNDWHUxdldzNUdReFltZndNbmtyZyt2MENFWll2NW96QVRnUGc3ckYwTVBQ?=
 =?utf-8?B?SngxaXhIMkJVWG5Eejc3enZIMThJS0pPOVdNRDhzdmw2VXpmYklZazgrNGZv?=
 =?utf-8?B?cEx3Y2laODJCZmdlWkdsNXZRQUZnczc2VHlFWjNtK2xtb21vR3gwOUsvQmRV?=
 =?utf-8?B?c3c4WFhnTitTaDZsUDd2OGc0UGZCenlQMTE2Mk45WG81SmMvckhHb1huMTBk?=
 =?utf-8?B?eHp2WWp0L0dxMUhERGRYOHp4bnhkKzJvRTVDNEpCRDdUOTNsVnl6dkdac1FF?=
 =?utf-8?B?aGc1RytzcXBPeVYvOUxub01LQmQxN3dScjU1MDVIKzZzd1l4UFFlMGxFUkp2?=
 =?utf-8?B?VVYxN0FHYlhRM1craGxwdlVkenA3L1ZrWjNKVHFIUzcwb213SkdXazFlV08y?=
 =?utf-8?B?ZHJibFRTRjY1THJMdU5HdkZqVWhJT1lLUEErbVM2N0F2eGtkK3NlZlM1eFYx?=
 =?utf-8?B?MGE2VmV0TVZvWkVYUHJGV2NwTVhGbGpMV2lDL3hZQ2NDUnhIci9hS1E0SE9l?=
 =?utf-8?B?T0l2TDZraXo0THBBcFdrTHNGbFhhT1NCNmdtY25ZZkZGNUtMVG50aUVOZTU4?=
 =?utf-8?B?dVNIN01zODlSeFM0a1l2TW16NEl0K09FQUk1aGxtcytjSit1MmdjOGVIQUJp?=
 =?utf-8?B?TXoxQjF1ei9VRDFkZEw4K2RHNHBVS1l5Q3FGN0VJL2ppOWl5NllzcHBQME45?=
 =?utf-8?B?N1VHaDA2ZGNnL0JFMVpLVEx1YVFMeE9GTWRPeGY3VGkwMWJINHZzRVNDK1RW?=
 =?utf-8?B?VGpwTU5rcmVIZTgrdVkxOXR1ZDFBQVA4azdhd05MRFZSUlRmRU9PR1NVQUlV?=
 =?utf-8?B?NmIvMnB3d0RMcTFueWlTbVRNTktUVDdnOGEvSlJYaEVROVFmS3FlMnovUlBB?=
 =?utf-8?B?TnNnMVY1RW5XV3hYYjV0aFZ0K0JxVTd2cEx4RGR2T2ZEMUFGY1pXL2g0RUlI?=
 =?utf-8?B?cHRiekpFUnpFTktkb2ZvREpBSVBKTFFjUmc4Mkt3Q2FkWWpPMkJyeHMvdkRY?=
 =?utf-8?B?WjZYL1hMQW42R2hDZnBkdnN3cmcweHA0c3cwd3NoQnBzMnJRNGZ0dVZNNnlv?=
 =?utf-8?B?S0NtTmR4bTd5djhqU2x0UWk0bWUwR3RuaDdWWkZIVE1iZDAwTTh2UzhRTkFw?=
 =?utf-8?B?L3dWZUdyM24yQlJ1NVRHUkVEWUIwZVd1R3pOM0lIZWVDSmRacE9IQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5078.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd32b78-7d54-4aa0-0027-08da23258c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 23:29:00.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYyR1fA+V6um6wU+8pA/DrIcXJNKLp0nwN6YRpThBTomN3wwFZ/UKpFdgKw2bOe6sP3UePaEj5I/502yn9DjWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHV0dGluZyBSaWNrIGludG8gdGhpcyBsb29wISBIZSBpcyBpbiBjaGFyZ2Ugb2YgaGFuZGxpbmcg
a2VybmVsIHN1cHBvcnQgZm9yIHVzZXItc3BhY2UgSUJULg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogTW9yZWlyYSwgSm9hbyANClNlbnQ6IEZyaWRheSwgQXByaWwgMTUsIDIw
MjIgMTA6NTUgQU0NClRvOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNv
bT47IFNhbWkgVG9sdmFuZW4gPHNhbWl0b2x2YW5lbkBnb29nbGUuY29tPjsgUGV0ZXIgWmlqbHN0
cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3Jn
Pg0KQ2M6IEpvc2UgRS4gTWFyY2hlc2kgPGplbWFyY2hAZ251Lm9yZz47IGNsYW5nLWJ1aWx0LWxp
bnV4IDxsbHZtQGxpc3RzLmxpbnV4LmRldj47IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBQb2ltYm9lLCBKb3NoIDxqcG9pbWJvZUByZWRoYXQuY29tPg0KU3ViamVjdDogUkU6
IHBsdW1iZXJzIHRhbGsgb24ga0NGSSwgQlRJLCAmIElCVD8NCg0KU291bmRzIGdvb2QuIEknbGwg
ZG8gbXkgYmVzdCB0byBiZSBhcm91bmQuDQoNClRrcywNCkpvYW8NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUu
Y29tPiANClNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNCwgMjAyMiAyOjI4IFBNDQpUbzogU2FtaSBU
b2x2YW5lbiA8c2FtaXRvbHZhbmVuQGdvb2dsZS5jb20+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+OyBNb3JlaXJhLCBKb2FvIDxqb2FvLm1vcmVpcmFAaW50ZWwuY29tPjsg
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KQ2M6IEpvc2UgRS4gTWFyY2hlc2kgPGpl
bWFyY2hAZ251Lm9yZz47IGNsYW5nLWJ1aWx0LWxpbnV4IDxsbHZtQGxpc3RzLmxpbnV4LmRldj47
IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBQb2ltYm9lLCBKb3NoIDxqcG9p
bWJvZUByZWRoYXQuY29tPg0KU3ViamVjdDogcGx1bWJlcnMgdGFsayBvbiBrQ0ZJLCBCVEksICYg
SUJUPw0KDQpIaSBTYW1pLCBQZXRlciwgSm9hbywgYW5kIE1hcmssDQpKb3NlIGFuZCBJIGFyZSBj
dXJyZW50bHkgaW4gdGhlIHBsYW5uaW5nIHByb2Nlc3MgdG8gcHV0IHRvZ2V0aGVyIGENCktlcm5l
bCtUb29sY2hhaW4gbWljcm9jb25mZXJlbmNlIHRyYWNrIGF0IExpbnV4IFBsdW1iZXJzIENvbmZl
cmVuY2UNCnRoaXMgeWVhciAoU2VwdCAxMi0xNCkgaW4gRHVibGluLCBJcmVsYW5kLiAgV291bGQg
eW91IGFsbCBiZSBpbnRlcmVzdGVkIGluIGEgc2Vzc2lvbiBvbiBDb250cm9sIEZsb3cgSW50ZWdy
aXR5IGluIHRoZSBrZXJuZWw/DQpNaXRpZ2F0aW9ucyBpbiBoYXJkd2FyZSwgc29mdHdhcmUsIG9y
IGJvdGggbWlnaHQgYmUgb2YgaW50ZXJlc3QgdG8gZGlzY3VzcyBtb3JlIGluIHBlcnNvbj8NCi0t
DQpUaGFua3MsDQp+TmljayBEZXNhdWxuaWVycw0K
