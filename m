Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9384E6F59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353945AbiCYISl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbiCYISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:18:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F7CC527
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648196226; x=1679732226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yMcddEG0m3Qlx4cOCIdxPkiaNKcIsXeTEHhdidBhOE8=;
  b=JFDO4BqdCUmFWE6ByeSMSCIdrzvS4Ia/QOkSnO8inBaP3xiQBfYJMzxp
   qTqT5bXcNw8m4M9vz3jlPcmfvGMEHTGF0pjB/TSDphgreko7083SXhkjY
   qXloKC3sOUT/0fkk+ZekJneqYvH4aIC5QZ46vYlGzocHpfdoUL2qiw4hu
   Wlmq6oMc9MrkwJdvVAURnlxrgG1xLImM7+vqbDWhwl/ZIKT9SLgRkNAQt
   kFbJ2qjhW3FnNWhbik2Cq/Dxs+Gt7aeZ9bmrGdzrFPKXaASk0ftDwnl8t
   CeskEEq15fa2e+ZlJRejrPomtaG/Eg1u+mE5w4tU9qZcw7H2mx3IjUmEE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="258300305"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="258300305"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 01:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718137777"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2022 01:17:06 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 01:17:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 25 Mar 2022 01:17:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 25 Mar 2022 01:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAU7fZZkcvJ/RRabCa448GyyRw6Q+FywKssmj8fQgFN59GAzOG7AomrkGnObL6ZfzGKqFB/e9NJv6KPIE8vHVLUqtXomKJPzK0VqoWU9/o32a0CvEhbT8bxG4LNvpBobOTu8wcA4bLuCG89tLacmGF3EyWHYoGZVk0K5EnvbQ5/OiqjiWVf4wHVlg5NU234DGV1cNby4wtxmzHu6H+utgvnD6bhEHmcaZ+3BHerCTN0ITtDga0hCxK7+Zff7gpUMI/kPl0pzjSlDGXBKczWs1BnJgN1820eGx7aH5fRs6uXokONPTC8kXY71fGfk9mNpupwljuMy4SCOiTgjMCoxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMcddEG0m3Qlx4cOCIdxPkiaNKcIsXeTEHhdidBhOE8=;
 b=N/z67Vv3FERLK59HuTEvgANWZG9lpTaI9+SdrJ+vkCGi/RU7fYhh9PEuZ41vAcjmaop6Pxwg1wkvScl+pMH0t/Ih3GMbZzV1+PB6htRAArR4vJRf4KVQpUwGibM2/5i41A59ipHKmt7CFQUSDlTg+QqmzsiSR2YEslDrC4p8N/BtbrOQ6uC/8OzuBHQ72t9MXyZQ3TzvLIj65zaJTJX+2awOgrgecxBVtFjJzI2cmB7R46VUac03Vkbg4mhEO2SG8GRr4Y5o2Ol6lld74nJ/I2I5FvA2xohgWejpva/BJbvXmW/zqs3cMRsHVZSsILNced0vJt5UNEwyvW/EL/mQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5538.namprd11.prod.outlook.com (2603:10b6:610:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 08:17:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.018; Fri, 25 Mar 2022
 08:17:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     David Stevens <stevensd@chromium.org>,
        "Zhang, Tina" <tina.zhang@intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Thread-Topic: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Thread-Index: AQHYPbc7YJqxtY3XIkKe9qY2q/ald6zPnLVggAAX/wCAAAfXAIAAB+dg
Date:   Fri, 25 Mar 2022 08:17:03 +0000
Message-ID: <BN9PR11MB52766D2B028F7EBD7D6696FE8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220322063555.1422042-1-stevensd@google.com>
 <BN9PR11MB52761E41CAD28CFCB935688C8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <MW5PR11MB58814148CD05C8284C3BCB23891A9@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CAD=HUj5dPb9jsUyh5REm=dX0HJaqW807LxnAouQ9rspMHB7vuw@mail.gmail.com>
In-Reply-To: <CAD=HUj5dPb9jsUyh5REm=dX0HJaqW807LxnAouQ9rspMHB7vuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d58b6f19-a029-4a49-1c6b-08da0e37d828
x-ms-traffictypediagnostic: CH0PR11MB5538:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5538D0176E38144D99DB98DA8C1A9@CH0PR11MB5538.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlzpW6OHOfYCFbZQIl7tqeHRcSHKucOcWYgK945XyM2t8pFuT7NAP7Xrz2a0fLXDUteoMDNQzARsRYRABhBv6x/Wnbn4umQiaEnYIH2sXeAWPgzpU/IotrXn8Bc2mgsC5f2tMI2F3jpdlBm4J/q2pvMMtPZLaaNloD79LmJ7RPlVROWZWMsB5PogI5Hidk6PYQXQ05BI9ZhWxUGjCQ4B2iQQkAkOLmTAB5TYhVVV07ofi9k9Rtp1r52J72ShBd+HbtUQtVhhrXuMWvTTahAPG9nP3xRAmpthLBeTIqjfiCXHDieNZQySmSHaWBh3EhfJvluLF5nTFeopfe5X5v8Ir+Li8+kK09YicOujL3cLIpXvAo2TNVgi3JtKZNrTV+oCEz2WOUV88jMMRj92PzZsqp78iWndyFbGkO9fsCExVwd7jH3G0kw3NUKiiz5lQecD2Ybuk4t4sTmaxFPBwE2xMTEur74UF2NQlMAtbqYoOLMxFKIZdaNA/RC2lTQchnweU0L7kIClC3E2ftumDaJLP1dhUkNhXgOmEkMPpQNy+BFHjZS1Vc2QG6odLrLWIyLt76mkUDl8Kfql5Zus9pBs0tuNcXIZVvHHLzFPsmA68dVY5+za5khoi214Tf8oh7Iurt8rm2D9eakJp7LOWlAiXTrQdpuIYAsbSh5XUOYQYaaxO8UmUkB876orAuSvZn20RTZMWP+oW0cwu7cFDnj5Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(55016003)(9686003)(54906003)(82960400001)(122000001)(2906002)(5660300002)(38100700002)(52536014)(8936002)(186003)(508600001)(6636002)(86362001)(26005)(71200400001)(7696005)(53546011)(6506007)(110136005)(76116006)(4326008)(66946007)(83380400001)(66556008)(66446008)(66476007)(64756008)(316002)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VExUa0tMNk5IOXRKcEVNNVpmV2VWaWFGQmFnTjZXSElFZXBDbW96SkNvT3h6?=
 =?utf-8?B?a0QrT0lUR0lFYWdRajlFbXcvdUdxeHErc3VqR2hPTFRrNnlNdEwrS3FTay9K?=
 =?utf-8?B?Mm1zdWVXaTN3VjVzVGpQaURkZENjZFpmL3JGRVlxN2ZyODNNMzdSNHJVZUNz?=
 =?utf-8?B?UWJpVE81Zm1xSGRKWTY5MitjN3VNdUtZTkJVcStVWElCV21PaUg1Nm5lMWUw?=
 =?utf-8?B?Tko5bXo1RWpqTk1GR0U3OE55UlpNdUhSbnRiMXNNZ0g3NVpkc041dy8ySGVR?=
 =?utf-8?B?UkJPc0lOcUxiekZ4Y1BjVVlFbEJseXkwU3hNdGpWYzNvYjdrdWpYQXIxZjlM?=
 =?utf-8?B?a3NhVDhVYUNnSnNGRXRaQ1FweXRXWkVGVkJQNlZjYzMrZHIvN0w3QXZTWith?=
 =?utf-8?B?TXBnWHRHbDcvL0JuNVd1ZTRuSjBvVkVta2pwUFRIOG1ueWVLSlJHYjkvZVcz?=
 =?utf-8?B?eFprQnV6TEF6VFlvbUFZVFc3RlQwVUZrZXM5czY5KzNUeWxRVFFFS3h2V1F6?=
 =?utf-8?B?a2RXeGxoaTgwY1FHblpkQzN3bUJUYnNuMlBHbHpWeWY3c1RGWHdsOHV3VXRa?=
 =?utf-8?B?U1gveHJqYUkzUFJVRDNidmpoRHM3S0ZJRlBKUjd0bnVLVjVWNkZrMktKM1JC?=
 =?utf-8?B?a1BZamxIQjNRSW05ZXdzL0FvUlNxeXJ3Wk54UTIvTlcrajR3Qk9PNUMrcVdB?=
 =?utf-8?B?djlaU2JvUG5IU1ZkK1VheGJCQ1pSMWY4U1J3RXRQdXBaRS9XS2tIdjF2UzVQ?=
 =?utf-8?B?YmdHaUtlb0hWMzRRWnVVRzdLd2xlb2hIcnBYT2M2NlY4TVdmOXBjREVCUWdE?=
 =?utf-8?B?alVDUkh3T0hQNUkxc0pZalFMcXB5UDNmTkVFOUR3SndlenhyNkNUUVFSY25w?=
 =?utf-8?B?WUZUL3hoR1VQZU8zQUk5cmtJVjB3akhZQ1ByNWZFNFVhNEh2YjdEL3ZFRDBL?=
 =?utf-8?B?K2RSdHdBU2lMWjF2YWdncVVvbk15Mk1VamZaQmdCcTlBVFRUeW85Q0s4ZlpC?=
 =?utf-8?B?ZVZaOFRMTjBxM21TUDhTUVJLbVYwMnhYV0RvbWNudGhuM3BFQXdBd21ZTEdG?=
 =?utf-8?B?cHNmL1FzQ0NhanpEM1hFZ1BFK29GQ3VDdU80ZzJCWmNLK3hBVk1NVjhJUExF?=
 =?utf-8?B?YUNEWnhyUldJbHMwQ0h2QndFMWVHOXdnMk5YK2tobzhScVF1ZzB0TFBEZHZ5?=
 =?utf-8?B?YWczQnJnRUxlRmxKY01xcW8rSUcyT2lhZWhHUVViZmgrcmQ1bU9EYXVKNXZF?=
 =?utf-8?B?NGl5Qk5EUjJYeGQvZHllZExhemZFcG5NSWVNdllZTlNsUDhRd200Sm5FZVJ0?=
 =?utf-8?B?OGNoTERqNk96STBiY2pSZyt6SEZEU0NFblI5OFVFZ2s3NC93RHg5RUlVTjdn?=
 =?utf-8?B?cGxFeFpFalFkeVlIb1VqNVpQekVmUkV3a1BnTVpRUXBZVlYrSWlZWFFmNmRq?=
 =?utf-8?B?YWJNRGJ5cVpIVWxMT2Mwa3Q2dXY0WjV4OFVkQkVSVXBYWXRhYkwvNDVVSEpG?=
 =?utf-8?B?Rk5INCs2ZzYzY1NERDFYenh1dFV4ZWVzd01wam5CUnAyMkV2OWxTZ3FaOUs5?=
 =?utf-8?B?SEhoU0tQVy85cXFlU0lRWURIeldTV1ZMdGpCOGdOSXB5UUNmc2lMSHQra3NI?=
 =?utf-8?B?WDZlQzVZdkRNcmhLUWh2b1gxSyt6RjREWDc5c0hYL21xSy9SWStpSlZoaUNs?=
 =?utf-8?B?blJEMHpOeFArSWVzd1p2S3hIcW5yK3NjTzkwanJNcUtvQ1JuRlNBbnZwQjlt?=
 =?utf-8?B?YmRVNm5ZS3hrRlc0TjhVK3dVMStkdlVSdzhiak9hYzZ6MVJLOVllaTFrd0t5?=
 =?utf-8?B?UEw5RnJUNEhRTXhCVDRsNE1USHA5a2FrcEpSRkhMUTVrS0lXdVFoR3BvUVJQ?=
 =?utf-8?B?cDJ4MG1tNGVWRVRhdmpOTTV0dXNCejlITEFDaGJIL0JhZ2dCMXkrTTNHL090?=
 =?utf-8?B?RWhHNVFQWFpvbXpXS1Q2alU5VDMvQi9la2hjRGFYa3NCYk81Q0s0NEw4YTRH?=
 =?utf-8?B?TVgyZG00a0hRTjJFSlh2bGkrUXg5N0VJUTErNnIxVFJqL0JLdXJ3UFNPK0pS?=
 =?utf-8?B?MkROemFhY0RFRENRWkxuMit2ZVhvb0ZRNHRMWnhYb2hCV0ZhZm5DMUtuazV6?=
 =?utf-8?B?d1gyRnhPZ2hHSU1ZMEoyT0o2V0kwdGtZVWl0TFUwME1VMlBiZ1ZvcGJ3Nmdk?=
 =?utf-8?B?V1I2dGwraGhoVFdXYkNQWnBacmx6NER1aFpickpDRHVWeExsM0RCNURmU2Jh?=
 =?utf-8?B?SU8wbTEzUG5qYUJRVHVIVVRkS08rb2RpcTkzVkhnVXZySjdPUU9BTTI4QnNw?=
 =?utf-8?B?RHYyWFozeVg1RjVDNko0Qm1xdk9QaTFzdFo3TnZTQUZiR2V6Z3p6UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58b6f19-a029-4a49-1c6b-08da0e37d828
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 08:17:03.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoQJQnQC5UKrOE8zE4vVCafb6gsMt+TUU8Txyd3yylEtdI5A/xmyC5kp2CcatrM8P0ly1ta2nsaqdBbPUaIQcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5538
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYXZpZCBTdGV2ZW5zIDxzdGV2ZW5zZEBjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IEZy
aWRheSwgTWFyY2ggMjUsIDIwMjIgMzo0MyBQTQ0KPiBPbiBGcmksIE1hciAyNSwgMjAyMiBhdCA0
OjE1IFBNIFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4g
Pg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogaW9t
bXUgPGlvbW11LWJvdW5jZXNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+IE9uIEJlaGFsZiBP
Zg0KPiA+ID4gVGlhbiwgS2V2aW4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjUsIDIwMjIg
MjoxNCBQTQ0KPiA+ID4gVG86IERhdmlkIFN0ZXZlbnMgPHN0ZXZlbnNkQGNocm9taXVtLm9yZz47
IEx1IEJhb2x1DQo+ID4gPiA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+ID4gQ2M6IGlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyXSBpb21tdS92dC1kOiBjYWxjdWxhdGUg
bWFzayBmb3Igbm9uLWFsaWduZWQNCj4gZmx1c2hlcw0KPiA+ID4NCj4gPiA+ID4gRnJvbTogRGF2
aWQgU3RldmVucw0KPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyMiwgMjAyMiAyOjM2IFBN
DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IERhdmlkIFN0ZXZlbnMgPHN0ZXZlbnNkQGNocm9taXVt
Lm9yZz4NCj4gPiA+ID4NCj4gPiA+ID4gQ2FsY3VsYXRlIHRoZSBhcHByb3ByaWF0ZSBtYXNrIGZv
ciBub24tc2l6ZS1hbGlnbmVkIHBhZ2Ugc2VsZWN0aXZlDQo+ID4gPiA+IGludmFsaWRhdGlvbi4g
U2luY2UgcHNpIHVzZXMgdGhlIG1hc2sgdmFsdWUgdG8gbWFzayBvdXQgdGhlIGxvd2VyDQo+ID4g
PiA+IG9yZGVyIGJpdHMgb2YgdGhlIHRhcmdldCBhZGRyZXNzLCBwcm9wZXJseSBmbHVzaGluZyB0
aGUgaW90bGIgcmVxdWlyZXMNCj4gPiA+ID4gdXNpbmcgYSBtYXNrIHZhbHVlIHN1Y2ggdGhhdCBb
cGZuLCBwZm4rcGFnZXMpIGFsbCBsaWUgd2l0aGluIHRoZQ0KPiA+ID4gPiBmbHVzaGVkIHNpemUt
YWxpZ25lZCByZWdpb24uICBUaGlzIGlzIG5vdCBub3JtYWxseSBhbiBpc3N1ZSBiZWNhdXNlDQo+
ID4gPiA+IGlvdmEuYyBhbHdheXMgYWxsb2NhdGVzIGlvdmFzIHRoYXQgYXJlIGFsaWduZWQgdG8g
dGhlaXIgc2l6ZS4gSG93ZXZlciwNCj4gPiA+ID4gaW92YXMgd2hpY2ggY29tZSBmcm9tIG90aGVy
IHNvdXJjZXMgKGUuZy4gdXNlcnNwYWNlIHZpYSBWRklPKSBtYXkgbm90DQo+ID4gPiA+IGJlIGFs
aWduZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFN0ZXZlbnMgPHN0
ZXZlbnNkQGNocm9taXVtLm9yZz4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IHYxIC0+IHYyOg0KPiA+
ID4gPiAgLSBDYWxjdWxhdGUgYW4gYXBwcm9wcmlhdGUgbWFzayBmb3Igbm9uLXNpemUtYWxpZ25l
ZCBpb3ZhcyBpbnN0ZWFkDQo+ID4gPiA+ICAgIG9mIGZhbGxpbmcgYmFjayB0byBkb21haW4gc2Vs
ZWN0aXZlIGZsdXNoLg0KPiA+ID4gPg0KPiA+ID4gPiAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBiL2RyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuYw0KPiA+ID4gPiBpbmRleCA1YjE5NmNmZTllZDIuLmFiMjI3MzMwMDM0
NiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+ID4gPiBAQCAtMTcxNyw3
ICsxNzE3LDggQEAgc3RhdGljIHZvaWQgaW9tbXVfZmx1c2hfaW90bGJfcHNpKHN0cnVjdA0KPiA+
ID4gPiBpbnRlbF9pb21tdSAqaW9tbXUsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGxvbmcgcGZuLCB1bnNpZ25lZCBpbnQgcGFnZXMsDQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBpaCwgaW50IG1hcCkNCj4gPiA+ID4gIHsN
Cj4gPiA+ID4gLSAgIHVuc2lnbmVkIGludCBtYXNrID0gaWxvZzIoX19yb3VuZHVwX3Bvd19vZl90
d28ocGFnZXMpKTsNCj4gPiA+ID4gKyAgIHVuc2lnbmVkIGludCBhbGlnbmVkX3BhZ2VzID0gX19y
b3VuZHVwX3Bvd19vZl90d28ocGFnZXMpOw0KPiA+ID4gPiArICAgdW5zaWduZWQgaW50IG1hc2sg
PSBpbG9nMihhbGlnbmVkX3BhZ2VzKTsNCj4gPiA+ID4gICAgIHVpbnQ2NF90IGFkZHIgPSAodWlu
dDY0X3QpcGZuIDw8IFZURF9QQUdFX1NISUZUOw0KPiA+ID4gPiAgICAgdTE2IGRpZCA9IGRvbWFp
bi0+aW9tbXVfZGlkW2lvbW11LT5zZXFfaWRdOw0KPiA+ID4gPg0KPiA+ID4gPiBAQCAtMTcyOSwx
MCArMTczMCwzMCBAQCBzdGF0aWMgdm9pZCBpb21tdV9mbHVzaF9pb3RsYl9wc2koc3RydWN0DQo+
ID4gPiA+IGludGVsX2lvbW11ICppb21tdSwNCj4gPiA+ID4gICAgIGlmIChkb21haW5fdXNlX2Zp
cnN0X2xldmVsKGRvbWFpbikpIHsNCj4gPiA+ID4gICAgICAgICAgICAgZG9tYWluX2ZsdXNoX3Bp
b3RsYihpb21tdSwgZG9tYWluLCBhZGRyLCBwYWdlcywgaWgpOw0KPiA+ID4gPiAgICAgfSBlbHNl
IHsNCj4gPiA+ID4gKyAgICAgICAgICAgdW5zaWduZWQgbG9uZyBiaXRtYXNrID0gYWxpZ25lZF9w
YWdlcyAtIDE7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgLyoNCj4gPiA+ID4gKyAg
ICAgICAgICAgICogUFNJIG1hc2tzIHRoZSBsb3cgb3JkZXIgYml0cyBvZiB0aGUgYmFzZSBhZGRy
ZXNzLiBJZiB0aGUNCj4gPiA+ID4gKyAgICAgICAgICAgICogYWRkcmVzcyBpc24ndCBhbGlnbmVk
IHRvIHRoZSBtYXNrLCB0aGVuIGNvbXB1dGUgYSBtYXNrDQo+ID4gPiA+IHZhbHVlDQo+ID4gPiA+
ICsgICAgICAgICAgICAqIG5lZWRlZCB0byBlbnN1cmUgdGhlIHRhcmdldCByYW5nZSBpcyBmbHVz
aGVkLg0KPiA+ID4gPiArICAgICAgICAgICAgKi8NCj4gPiA+ID4gKyAgICAgICAgICAgaWYgKHVu
bGlrZWx5KGJpdG1hc2sgJiBwZm4pKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgbG9uZyBlbmRfcGZuID0gcGZuICsgcGFnZXMgLSAxLCBzaGFyZWRfYml0czsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIC8qDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICogU2luY2UgZW5kX3BmbiA8PSBwZm4gKyBiaXRtYXNrLCB0aGUgb25seSB3YXkg
Yml0cw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAqIGhpZ2hlciB0aGFuIGJpdG1hc2sg
Y2FuIGRpZmZlciBpbiBwZm4gYW5kIGVuZF9wZm4NCj4gPiA+ID4gaXMNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgKiBieSBjYXJyeWluZy4gVGhpcyBtZWFucyBhZnRlciBtYXNraW5nIG91
dCBiaXRtYXNrLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAqIGhpZ2ggYml0cyBzdGFy
dGluZyB3aXRoIHRoZSBmaXJzdCBzZXQgYml0IGluDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICogc2hhcmVkX2JpdHMgYXJlIGFsbCBlcXVhbCBpbiBib3RoIHBmbiBhbmQgZW5kX3Bmbi4N
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICBzaGFyZWRfYml0cyA9IH4ocGZuIF4gZW5kX3BmbikgJiB+Yml0bWFzazsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICBtYXNrID0gc2hhcmVkX2JpdHMgPyBfX2ZmcyhzaGFyZWRfYml0
cykgOg0KPiA+ID4gPiBCSVRTX1BFUl9MT05HOw0KPiA+ID4gPiArICAgICAgICAgICB9DQo+ID4g
Pg0KPiA+ID4gV2hpbGUgaXQgd29ya3MgSSB3b25kZXIgd2hldGhlciBiZWxvdyBpcyBzaW1wbGVy
IHJlZ2FyZGluZyB0byByZWFkYWJpbGl0eToNCj4gPiA+DQo+ID4gPiAgICAgICB9IGVsc2Ugew0K
PiA+ID4gKyAgICAgICAgICAgICAvKg0KPiA+ID4gKyAgICAgICAgICAgICAgKiBQU0kgbWFza3Mg
dGhlIGxvdyBvcmRlciBiaXRzIG9mIHRoZSBiYXNlIGFkZHJlc3MuIElmIHRoZQ0KPiA+ID4gKyAg
ICAgICAgICAgICAgKiBhZGRyZXNzIGlzbid0IGFsaWduZWQgdG8gdGhlIG1hc2sgYW5kIFtwZm4s
IHBmbitwYWdlcykNCj4gPiA+ICsgICAgICAgICAgICAgICogZG9uJ3QgYWxsIGxpZSB3aXRoaW4g
dGhlIGZsdXNoZWQgc2l6ZS1hbGlnbmVkIHJlZ2lvbiwNCj4gPiA+ICsgICAgICAgICAgICAgICog
c2ltcGx5IGluY3JlbWVudCB0aGUgbWFzayBieSBvbmUgdG8gY292ZXIgdGhlIHRyYWlsaW5nDQo+
ID4gPiBwYWdlcy4NCj4gPiA+ICsgICAgICAgICAgICAgICovDQo+ID4gPiArICAgICAgICAgICAg
IGlmICh1bmxpa2VseSgocGZuICYgKGFsaWduZWRfcGFnZXMgLSAxKSkgJiYNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgIChwZm4gKyBwYWdlcyAtIDEgPj0gQUxJR04ocGZuLCBhbGln
bmVkX3BhZ2VzKSkpKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIG1hc2srKzsNCj4gPg0K
PiA+IEFjY29yZGluZyB0byB0aGUgdnQtZCBzcGVjLCBpbmNyZWFzaW5nIG1hc2sgbWVhbnMgbW9y
ZSBiaXRzIG9mIHRoZSBwZm4NCj4gd291bGQgYmUgbWFza2VkIG91dC4gU28gc2ltcGx5IGluY3Jl
YXNpbmcgdGhlIG1hc2sgbnVtYmVyIG1pZ2h0IG5vdCBiZQ0KPiBjb3JyZWN0Lg0KPiA+IFRoaXMg
c2Vjb25kIHZlcnNpb24gZG9lcyBnaXZlIG1vcmUgY29uc2lkZXJhdGlvbiBvbiB0aGF0Lg0KPiA+
DQo+IA0KPiBSaWdodCwgdGhpcyBpcyB3aGF0IHRoZSBtb3JlIGNvbXBsaWNhdGVkIGNvZGUgaGFu
ZGxlcy4gRm9yIGEgY29uY3JldGUNCj4gZXhhbXBsZSwgaWYgcGZuPTB4MTdmIGFuZCBwYWdlcz0y
LCBqdXN0IGRvaW5nIG1hc2srMSB3b3VsZCBvbmx5IGZsdXNoDQo+IFsweDE3YywgMHgxN2ZdLCB3
aGljaCBzdGlsbCBtaXNzZXMgMHgxODAuIFRvIGVuc3VyZSAweDE4MCBpcyBmbHVzaGVkLA0KPiBt
YXNrIG5lZWRzIHRvIGJlIDguDQo+IA0KDQpJbmRlZWQhIG9idmlvdXNseSBJIG92ZXJsb29rZWQg
dGhlIHRyaWNrIGhlcmUuIFRoZW4gaGVyZSBpczoNCg0KUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4g
PGtldmluLnRpYW5AaW50ZWwuY29tPg0K
