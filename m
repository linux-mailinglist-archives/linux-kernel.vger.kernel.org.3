Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31024C9AD2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiCBCAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiCBCAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:00:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DA5A167
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646186392; x=1677722392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pHYfp2Atk+CiYpwkf8JEbfX6+Z1gkv1L3WD0ye6dBJs=;
  b=Q4tsaKRcBDdrwKQCuATYuGR/A3ZNlTkCrGRgQolv/XbBxh9N+reLUocg
   3SrTGyMrBqS69WM35OnnkaC6YZ2rG6qAfJ0PddIQctIPxbqnpKZugETeg
   IRz2yWKeIv2SdbM/uP+4phm0DRVuK7qhellkrFhbgYkR4ee/HuC4I4awm
   5L1DKzWyjTmP1wtgHVMYsRNZQYUZ9VXgWQYaoDpt8qzXfYpQPbJenSWL4
   eN/4LWUAAZkLp9sjp8Q7k8NzpvVOrBpr5Dm8JOcpB2MlzqlyCE62hBFQ+
   hYalMlnOJ/N3Vjs7/y3N+/qAOuMpwMWTKO+RviW0+HxQtG8TrHD8MXT8q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253481725"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253481725"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 17:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="609043697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2022 17:59:51 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 17:59:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 17:59:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 17:59:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzD76Dscyf8Vu0GOSNZuLz+5xp1PNT42IBam0C/LgHgZAVpeWELfyLMxiI9mqcjAxceRFK+f6YaXCyWO70swHh5f6TfMoE1A58hNDWNFiPWMysYvi/72x2b0vf5jL9Hn8Aa7/S62Me23es5/6ucfe1zqIYcD87Yz4b0sC5uqWU5/ZURsDL/GIiT1VuQv3nGsiz8LYnpYhUFX3PaiVHtiJU+fZ6JwlWs7ObPiRLH4boPX+5OY37FeoRMQfXseR23q91Vnny0UsTOZqK+0hEzz19qjAQJQdA896gyPLz8VZdEHAVoduXk72krKQlnwPikiiTzAzmWDsTnLo/k3GSHSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHYfp2Atk+CiYpwkf8JEbfX6+Z1gkv1L3WD0ye6dBJs=;
 b=QE8CKzlF1/XpIB7Qzkgu1jYO1rTpx0CJSvxsl/K+Q38JFzewSqYvgEFeLzEM+66n5zTloxjRy1BeX4MS6UaRE/7pxaCVHUnZkB+4PNfxyy3L2lVw+nzUk8vkk2rT5aCpwjtcPzqqYAryIJdaVZmpp2VdczZv1UimFA3vlM2PSghkLEHFbuDwn5VajIFd+Syetv6lpzBGfMxrPzaqeFexn2Slr41C0n5DTWghM5qHpCz4So822YHryQkPf0cqtRo2nuj8Meo5cHXI6s+LBNNrujK+2eB5GB1gqkKhCOKi2C3g2crHoC4mfrPoVXX8H1H/FtHS6w1kuLi9FzhBJ7avKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM5PR11MB1275.namprd11.prod.outlook.com (2603:10b6:3:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 01:59:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::e593:28be:c2a3:a163]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::e593:28be:c2a3:a163%10]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 01:59:46 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Topic: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Index: AQHYKm/X8z1QhyAgRU236IJfVj3evaykr3KAgAX51QCAAGE+gIAAJGiAgAAulQA=
Date:   Wed, 2 Mar 2022 01:59:46 +0000
Message-ID: <c5e53502274a29e39c996627a35a7aa8e0795ca9.camel@intel.com>
References: <20220224145138.952963315@infradead.org>
         <20220224151323.069205370@infradead.org>
         <eed8902f21ba9e5f93562432f6b5920137860a98.camel@intel.com>
         <Yh44YsW8viBscBD0@hirez.programming.kicks-ass.net>
         <20220301210245.GM11184@worktop.programming.kicks-ass.net>
         <20220301231303.pqexbxkpte6yjiww@treble>
In-Reply-To: <20220301231303.pqexbxkpte6yjiww@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76c1b12c-3064-467d-d643-08d9fbf053fe
x-ms-traffictypediagnostic: DM5PR11MB1275:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1275E812EB5218F9AAA43AEAC9039@DM5PR11MB1275.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlyqVvr5KalHhPxbhAmN01KcKxM8bx9pv8PxccwYXnSOlr33SPwWz+VDg2Y5241pAOPXh1iiAtfI1kcHI/G3CrcumKETfKY/9o97XS0PrWEHt9hX35CYMwBaMDrWEqT/xI15jsl8UoeMQSBEUlLWz3+1OGHcWB9Nav/SP8sE4Pw52NT5DhYfFHM4wyXPivA5pbuHO9ki/wBn4UQuo+5x97hsZH26wLWZV0wU2/VQNo/1Y7Kr0+gOAMotd7d11/i3qsxdlocp0pbxeP6t/1MD7Ht/vPt4qU3rjKpieQfu4HtV/p+ct2i0IGuBhmz4R4a2UkYok9DkqZZmTlGNAWiwRBThwR69oRKrp1u/h1CNIvx668CdliKlFXkopgn7b9FbseWuTdpAkD4Ci4N0s5RAd76/K3I7VAAq8fCjUiwbi7XfnYhmc/S5pW01nsjSfHRbQECmVcGRNDNXuhYLfiPiLxFe+BkLKYG8dbJsukxP5FMJJ1xMR4SRoAerGcdbNFZWM8QK16zHAbQ+jpDLQY9BY2jYHlOXFRvwziRU9fqaXlsKZ1fjBCUSRKD4blWxGJvIg4kiIrJ97/VRKSpp7KS/fw9Oulm1iljBE2YytIQvpQpgMlrUdI5uBm1+REhuouhyWHhoPfLyogD+x5ijk9oW8HniUCZn9+XfYs7dhV5H8pMzTelqJMz4E95h44jtNZrdH1cMhAi4D2kPgqK9rBFma0Pb8B31WRGe7CnwFPiUScY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(76116006)(38100700002)(6512007)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(2616005)(2906002)(86362001)(7416002)(26005)(5660300002)(8676002)(186003)(38070700005)(36756003)(71200400001)(508600001)(6486002)(316002)(82960400001)(110136005)(54906003)(122000001)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azU1Z0djaTlxMDdaNXdkV2p1S3M4cUlzZG02eFZHZ0lqNFdFa2V3TUVFSUEz?=
 =?utf-8?B?WVoycXlsUzhpQkZEdThwM0RPQmt6WlZYTVQ4eWZMWXVnNFhxOGlzSEUzS3lK?=
 =?utf-8?B?Q0JWeHBsNlkxKzQ1ZFMyV1lybkFXOEZzbTlSakRXSitEM1hkaVBEVW84aXFG?=
 =?utf-8?B?YXJFU1JpVUp5aXk0aGgzZVNheFRzVDRrWDhhNkJWZkdsb0k1MElIZS80d0Zy?=
 =?utf-8?B?Y0FEV3JTTEZPZkQ1TVhPbkxCVlNDQmNaWnJudTNRSGQ5cFBNWnRMelN3UjlF?=
 =?utf-8?B?UWVxOVR5emREVmt5WHB1K2NEbG9LdzBWYjRjeWdZcDQyUEpyMFFnajI0Y1kx?=
 =?utf-8?B?TEg3UWxVRDh1L2dLWU5GWkFaTDREekh4TEorZmdUUnJtKzNEb0RuNytoOC9h?=
 =?utf-8?B?Zm9qNlVmbVNYN0x6RXJ2Lzg4SWNFV2J0OXlNLysvbkZFeDBnM201ZEhkSHRU?=
 =?utf-8?B?anE3M2RxTk5LMFpkK3J1US9Db3VQenRnenJnOE9LbXJRSTlyWXhPenhKN0Q3?=
 =?utf-8?B?UFh5VEJRYUZVM3pVb3NqWGkwbDl5M1A5bW9LRHROcnJUdjFDS3YrUGxzTWc1?=
 =?utf-8?B?aFBvdDlkSEhXbmtYWlV3QS92U2cxZ2tza284SVNseko5NVRpSmZIaitLTFlt?=
 =?utf-8?B?clJFT2FUbmNKcG1XYUlNclBBVitNd3VRYkdXcHo0SnVpQWRSK1VFdCt4NldL?=
 =?utf-8?B?aEtIWW5GbngzbHhiL3M2cXVqVFJxL1d1WC9qVDVxNUw5V3g5dk9NN2VyUkRw?=
 =?utf-8?B?ZC8zMThOdHZ2M1AzYVZZdGxocGZDd01oZkZrNjRCdkZnU2p0M21MOEdRMGcr?=
 =?utf-8?B?b0p4S1Z3UUYrSVlpL2hqWkdoRlc2TExtbUNySUdlRzlHd04xaU9IbXpPek1h?=
 =?utf-8?B?S0dSZ2x1SGRTVDQ3U1Fwdjh5NW1XZ3NiU25wUHdvRVdISU55WFF5dWFMaHUv?=
 =?utf-8?B?VVY1eEdwVG50UFM1aVcxKzZQS1pHRWRRZ3JoaFk0WXBZdmMzNFVhRlYzRDhs?=
 =?utf-8?B?TW9sRGVaTDlTMW5kRjRHcmk5VldDMEZRcVdSdEg2cUJzL1V4cWQ3S2pHM2Vw?=
 =?utf-8?B?UG9xMG44RDQ1ZHgwSitVcWQ1WWk0Vi83Njc3anR5QlhVRzk4OGlzK0NCQ0JR?=
 =?utf-8?B?SXBkRjM0eWtEcm1UZit5bkNSSVcyVkVxUEM1bUJKZlNNbTc0QlJxbndpVFJ1?=
 =?utf-8?B?WmVNM2J4T0tZR0JJNWdFUDMyblNkb3VPeFZ2c2k0cWV0UnpyQmUwWk1saDZk?=
 =?utf-8?B?YWdMcGw2ZkRNd3Y5d2VsaDJHcmZjNDN1Nnd3T0dZcnVvVy9LKzN3RmVId21D?=
 =?utf-8?B?ejVja0t1VzA3aDVpQmtiMTV2Y2lTekdsa1FYek5MQmxPTFBTNnU1YVQ4dDZU?=
 =?utf-8?B?ZGJ6aWxIT051NlBVc2sxdkg5dHdjbnZPUXA0V2NsN0lrU0JLNGRqWFRnR2Jh?=
 =?utf-8?B?VHJQOG5xdDVsdytOd0drS1FMa0Mxb1YwYTZjZzhkUy9rTWhSc0lwUms2ZGQw?=
 =?utf-8?B?RmJKTXhSU0xMMVFMZTE5ckZOQ0V6ckdTdWlkQ05xdm9WYkIvSUFMRi9mdlJE?=
 =?utf-8?B?Zks1d2Y4MEtrSEdVSjJaL3dqV3pYdmtLQ3ptVGdIZzZLd1NuRTZrUytsN1BQ?=
 =?utf-8?B?YTB5S0dzemI3ejdVY3k4dXQyWGFvSkVzTkNwWDMwWWk1ZDlNUklLNkJ4RXhi?=
 =?utf-8?B?VlBtRnJxRDh0UGNXZ0tZanFkUmtmajg1REFvaURsaVBIbjVmN0RhYXVTN3ZX?=
 =?utf-8?B?Z2hNd3MvQTZINmNmcVV5U2t3YmlHNVhaUk5SaEYvZDFZcjZUak14bTNjd1pM?=
 =?utf-8?B?TGJFSk1udkxFNEZESi9LT2FZRGlZSm03aDdJaTE5Zjc0NzA0eVZhTGlyTDVq?=
 =?utf-8?B?ckptMGJaY1R6NFBjamtKam0ySFJpRkNJcG42TlFpMHUvZmxhVXRxMlVDc0NI?=
 =?utf-8?B?QkRsNVhLSExwWG0zcE44WS96Uy9RWVQ4TmwzT2hGOE5razlRdlE1bWlIb2hP?=
 =?utf-8?B?YzU2Um8zUkxEVEF1NlUwcEkzcGg5THYvMkdCUFJaVmhOK2RnTVIrbzFIak5w?=
 =?utf-8?B?MXZCWmVjaFloNmIzNzI4c1FodzJaQ1doNDNHSUhwMFhjK24ybkNwa0VHTll0?=
 =?utf-8?B?MmVtVEhaa1gzSzVZVjU1bHgxVlAzU1ZRN2xjUGgyMnp6dEcrVGh1M1BwNVNl?=
 =?utf-8?B?WU11QW9KaTAvYUp4clNDWXpIY0dtWjFwMU1uNUs3UVNPa3gvbnplTG1xY0U1?=
 =?utf-8?Q?5AwjeKtZ8wrr0c0C8RIyBzN/50xOKRP7VBFhvebNN8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A859EC1F8CFEE344AA1A0258051C25AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c1b12c-3064-467d-d643-08d9fbf053fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 01:59:46.8631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7W6w4GzncoO72ho4Pf1PhVuXBKl2tvxfPac9Giy/73MS/dBROEUqv3/kXxSazQqsbtLG4JT1+CfU+Cag0xKXimF5dgtfImH2YRokW3D6BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1275
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTAxIGF0IDE1OjEzIC0wODAwLCBKb3NoIFBvaW1ib2V1ZiB3cm90ZToN
Cj4gT24gVHVlLCBNYXIgMDEsIDIwMjIgYXQgMTA6MDI6NDVQTSArMDEwMCwgUGV0ZXIgWmlqbHN0
cmEgd3JvdGU6DQo+ID4gT24gVHVlLCBNYXIgMDEsIDIwMjIgYXQgMDQ6MTQ6NDJQTSArMDEwMCwg
UGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ID4gDQo+ID4gPiBTb21ldGhpbmcgbGlrZSBzbz8NCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxf
NjQuUw0KPiA+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMNCj4gPiA+
IGluZGV4IDM5OWYwNzVjY2RjNC4uNWI2NWY2ZWM1ZWU2IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJj
aC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+ID4gPiArKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMNCj4gPiA+IEBAIC0xMTQsNiArMTE0LDE0IEBADQo+
ID4gPiBTWU1fQ09ERV9TVEFSVF9MT0NBTF9OT0FMSUdOKGlkZW50aXR5X21hcHBlZCkNCj4gPiA+
ICAgICAgLyogc3RvcmUgdGhlIHN0YXJ0IGFkZHJlc3Mgb24gdGhlIHN0YWNrICovDQo+ID4gPiAg
ICAgIHB1c2hxICAgJXJkeA0KPiA+ID4gICANCj4gPiA+ICsgICAvKg0KPiA+ID4gKyAgICAqIENs
ZWFyIFg4Nl9DUjRfQ0VUIChpZiBpdCB3YXMgc2V0KSBzdWNoIHRoYXQgd2UgY2FuIGNsZWFyDQo+
ID4gPiBDUjBfV1ANCj4gPiA+ICsgICAgKiBiZWxvdy4NCj4gPiA+ICsgICAgKi8NCj4gPiA+ICsg
ICBtb3ZxICAgICVjcjQsICVyYXgNCj4gPiA+ICsgICBhbmRxICAgICR+KFg4Nl9DUjRfQ0VUKSwg
JXJheA0KPiA+ID4gKyAgIG1vdnEgICAgJXJheCwgJWNyNA0KPiA+ID4gKw0KPiA+ID4gICAgICAv
Kg0KPiA+ID4gICAgICAgKiBTZXQgY3IwIHRvIGEga25vd24gc3RhdGU6DQo+ID4gPiAgICAgICAq
ICAtIFBhZ2luZyBlbmFibGVkDQo+ID4gDQo+ID4gSSAqdGhpbmsqIGl0IHdvcmtlZCwgSSAnYXB0
IGluc3RhbGwga2V4ZWMtdG9vbHMnIGFuZCBjb3BpZWQgdGhlDQo+ID4gbWFnaWMNCj4gPiBjb21t
YW5kcyBKb3NoIGdhdmUgb3ZlciBJUkMgYW5kIHRoZSBtYWNoaW5lIHdlbnQgYW5kIGNhbWUgYmFj
ayByZWFsDQo+ID4gcXVpY2suDQo+ID4gDQo+ID4gTGFja2luZyB1c2VmdWwgY29uc29sZSBJIGNh
bid0IHNheSBtdWNoIG1vcmUuDQo+ID4gDQo+ID4gSSBwdXNoZWQgb3V0IGEgdmVyc2lvbiB3aXRo
IHRoZXNlIHRoaW5ncyBvbi4NCj4gDQo+IEkganVzdCB1c2VkIHlvdXIgbGF0ZXN0IGdpdCB0cmVl
LCBrZXhlYyBpbnRvIGEgbm9uLUlCVCBrZXJuZWwgd29ya2VkDQo+IGZvcg0KPiBtZSBhcyB3ZWxs
Lg0KDQpJIGNvcGllZCB0aGlzIG92ZXIgdG8gdGhlIHVzZXJzcGFjZSBzZXJpZXMgYW5kIGl0IHdv
cmtlZCB3aGVyZSBpdA0KZmFpbGVkIGJlZm9yZS4gQW5kIGxvb2tpbmcgYXQgdGhlIGNvZGUsIGl0
IHNlZW1zIGxpa2UgaXQgc2hvdWxkIHdvcmsgYXMNCndlbGwuIA0KDQpBcyBmb3IgcGlubmluZyBz
dHJlbmd0aCwgSSdtIG5vdCB1bmRlcnN0YW5kaW5nIHRoaXMga2V4ZWMgYXNtIGVub3VnaCB0bw0K
c2F5IGZvciBzdXJlIGhvdyBtdWNoIGJldHRlciBpdCBpcyB0aGFuIGp1c3QgcmVtb3ZpbmcgdGhl
IGJpdCBmcm9tIHRoZQ0KcGlubmluZyBtYXNrLiBJIHRoaW5rIHNvbWUgZnV0dXJlIGhhcmRlbmlu
ZyBhcm91bmQgcHJldmVudGluZyB0dXJuaW5nDQpvZmYgSUJUIG1pZ2h0IHN0aWxsIGJlIHdvcnRo
d2hpbGUuDQoNCktlZXMsIEkgdGhpbmsgeW91IGJyb3VnaHQgdXAgdGhlIHBpbm5pbmcsIHdoYXQg
ZG8geW91IHRoaW5rIG9mIHRoaXM/DQoNCg==
