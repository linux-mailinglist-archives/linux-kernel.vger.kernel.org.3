Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2550E305
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiDYO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbiDYO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:28:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFAF1EC42
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650896719; x=1682432719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rvz91yDrecGfjOxWXS0k/HoJ4+3Yn23bOVB2JMf+v60=;
  b=eF8h6Vuxb5N81ScetJfrbXMns9qlZGxbQqiioiZ0+UTcY+QAJD5xOPFE
   F6ZqEdZ0xzlBkMOll7GBEbO/G+dUo54kONzL4y9WQUHcMapmDa8Psa8Zt
   9sU28bga6juhiP4ab2Fil9BcS7EcL+toi75tt6WxMMyr65tQV0zTpzASL
   mo6vsRgoaVIR8wXk3GYLmThkpy5U9cGe6tXAvSdQWtUmKKAIqkg5BEROk
   YlLSM8dmBiFZlQOfOgbtqTurYepG+SV+SqoN97OpMHmTIrnwzKvnihXrL
   msTy46j3EXa/jhx9VTCz3HjljolioRJlrT+NIgGUZKbJWN6AnJWCDe6Uj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325749662"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="325749662"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="677159426"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2022 07:25:19 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 07:25:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 07:25:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 07:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwnWONlxRLZ3dSqy+U57VmgP2VuklXv0vXFl4mMDo/p1ywtUZVFi7IBso9OdZVSwFGzvYzHcTcd4FQqg88NG1zrqrHcRAeFoZ1GkVMc8gB5U1p3bV56yWKClQiOU8C46HiHQHFY8dhlqy3S+0ii6ReEX9wYD2rQrOcXTRQopnPITUCEQC+B45bJUDaztqcjx7G6ICkqf8x7k8Malj/iLEt84D0xP7HHX/YRKBWbS5nr/9H/bopyRHeIaLMdc7vjZWDBzLNGW+UNMOqlQYG8HjDFPMljbvmOc3uG+66zKG6ih/H8NOhfb1t4lA55aadBHu9mcBMuR1sCh37OtFshyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqmtl6BoSF6QEMJmOdMoMOTzdVY0mdziqQ1HSMsxkUQ=;
 b=dC6sJ6yJmSTgIXkrU/d/eRrdO/Ug/AVLAyc+ZzqxvQ8DMjS3KsipvEao+O0QRDzBLte6mQWl+iBDDLjBAeObLtiXT4KHH69xzgEpH2MiFMZIkKb/nWSlP3HskMxm1/IHKhflvmvJ+V/dNjk6BGnlhi3rY0refFB1FGTrb9Em4j1WBSpBVIy+Q1PPleFvFrkF6zVZIjhpDek4yodBlGdmKMqtPae08mCPm//L4xbhGNY07v7MOeoM0gccSPyVR7aQ5BAtNUYh+Vvg+t1VVeWz6z4aegXq5E5h7RKFC5wgYmIPFF3f3obT0l4DPfpQPltLVOmi0tZlMM8vXAE7VQsISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 14:25:16 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%8]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 14:25:16 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexander Potapenko" <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: RE: [PATCH] kasan: Prevent cpu_quarantine corruption when CPU offline
 and cache shrink occur at same time
Thread-Topic: [PATCH] kasan: Prevent cpu_quarantine corruption when CPU
 offline and cache shrink occur at same time
Thread-Index: AQHYT6ulsqnvKUJhXEyVsracxSIbz6z6+R4AgAXGCXA=
Date:   Mon, 25 Apr 2022 14:25:16 +0000
Message-ID: <PH0PR11MB5880B595E4836DF66928692DDAF89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220414025925.2423818-1-qiang1.zhang@intel.com>
 <20220421150746.627e0f62363485d65c857010@linux-foundation.org>
In-Reply-To: <20220421150746.627e0f62363485d65c857010@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a98c373f-efdf-467b-c96b-08da26c76b13
x-ms-traffictypediagnostic: SJ0PR11MB4973:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB49734DDEA02821AA9FDE52A7DAF89@SJ0PR11MB4973.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PT5Lrq8nX0jW7+R9rGuAOQHfOHMS6hKLKxuC5kT1Y8nVTGSRgm5z9GvEtxOXGF4xz+CY+pC0WzSjx9I4HIYsA/t8meUTgFXTRA81UAW+47W8gmYZPN2a+2oMGK5W3aFjhZlkOzFUjhX7S5Sp7Xtn3xulzv3aSV33BEcgL0zZROismiJuqZxMmHfr3LjkJYL4rHnWfaLNhD9e84vHcA3fR1UD/qCjkosxjRzfr+zhd/+VxJaY9jlkwebQ0+bbzHj9DN6IQW5vNGiwA+qWd3xSlHqcKyUT7FXfclCxqHhekcYaVz30IrtAqIx8gdj6q6Ai5YZZMNpjvQTcgLsVefvRRb9Q8dXHZS+H/AIZ9Ugx8aZyV68Z8tV4EtMeGKUHIND4Vco25CUZaysoItlxClDqvclwiPoy7XqNCcwhSrfkkZqHMu5lBw5iitROd6Vf6VCHup+t7c0ilD/ISi9ukaRvBn0NY49iV3p7ymfOXYOPuvoQlcTXvcDq5H3wmqkCtWRmJnel1fCZcCmx0V7ggyDW34VdIW1dT/m8sCDiE6pRc+gdelks2cGYtfap8/KavUGn12T3XcuRtjugIfYKqejSttjRgDNn2Jsl2HQQiRRYm4kp0jvSqPx3WT0xGIkRJoAhV9RxXcDrrB2vYE1I0npY+2AmJ3HT0mM0hcVlSWm3A6zzfj2VmXE2DxHs1RrGvC1xdnZe2j9Krv5TKqWccyldHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(38100700002)(508600001)(2906002)(86362001)(38070700005)(76116006)(66946007)(8676002)(4326008)(66446008)(64756008)(66556008)(66476007)(71200400001)(82960400001)(55016003)(54906003)(316002)(5660300002)(52536014)(8936002)(26005)(9686003)(83380400001)(6916009)(6506007)(186003)(7696005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ffFJe2GNdeQ3POxQELmOI4ekTeRWmDAunhmsH5XnvptRX4YC9/ECEXHLZh9Q?=
 =?us-ascii?Q?hg1wUX18LytpE1Te2g+bD8c/iA40VgH6fcDOEOeV4QWn5OhcNzaT5zAAOiNC?=
 =?us-ascii?Q?WWR6yRe+1PT8m/TGOj65i6uRQucEs3Ddohl3/HDWLs1AToCXgWGOzCSJCSHo?=
 =?us-ascii?Q?1lIAw3PgfhY2YcaBc35p5/aCM3/JCsMDVRiaok0UTi650EfR3aX++QhzLKHL?=
 =?us-ascii?Q?dP7LpB4J6ZhvLuigkBlEud4L+T3TOp44fLpIalRrTFuoBrL9gd7Hx161IWaw?=
 =?us-ascii?Q?EDMoGYaimcs4PwIGOUKIReuD9Wm0VVrgqWDSx5hGRQNHt6TQ+wZacetbVuU/?=
 =?us-ascii?Q?3x76nuIf5KMGQUou87J5NmdzROVInB1Gg0KBIGjhI53b8Wlzgi6MHG/s5f8J?=
 =?us-ascii?Q?2e14BYxcss0hOgnwi2TUA7qoNqo5J/iN8ZlXOyLwtn5iFUDDcWbS790i80vu?=
 =?us-ascii?Q?YMDedCu3rqz5Q3raDb/eLsziYiLUFVsU2oVMHSCvBxn9frzlUoRHU2sKczPO?=
 =?us-ascii?Q?TDQUCNUgr6jld/KUt5j0FnAYFPWto0slMeBX8doHQKHKj4kd3I5LYF10TM5d?=
 =?us-ascii?Q?PXl/Na980itVRHpSNKZFFz3qShyX7v+B4O+d+Ob6YL41CnlmC0018QEoclFA?=
 =?us-ascii?Q?XMJwi+T6A9ZQ1RexgTdQlUeq92BDroNLGVQmKlpyZ9hHhJhhs+OUKXD86hrt?=
 =?us-ascii?Q?1jjdX/mmFDbYTPxN/0ihQjbhMV32ZzOJRBsgeJT0ynN6A4iQGITA/DLeb/hE?=
 =?us-ascii?Q?jbT711s7gwW74V2cFqUOL5+pQH4AlGuY7TRYR+kQ0SxJERsmYzwE9aK/bU7R?=
 =?us-ascii?Q?TH8TbThn4kdaELrNaDpogEGJb62dI1qUYeTofPwA0CJjchLw5F4Yx93ppWn/?=
 =?us-ascii?Q?sWkGLFDSOCwtTp9ZnJOeyaFmhTC8FKyKBW73M6ZFF8TSoSKCFI3Z5qLv7bVZ?=
 =?us-ascii?Q?AmwDrBVD8sly06KXrP4JoYlOhLg99LKksiQl9NrGunWtD7s8uymbN1Syn/Ym?=
 =?us-ascii?Q?UIzJ/T/c37fkI4/XlYicDYKtJWce6YEugyCP3SZvPQ5gmBNyWmI2veefc/YI?=
 =?us-ascii?Q?zdj3MA17AsV3yJitUsUuswhQyOwBKWRXTutMqhcqUMNZ1KPaq8cAHp6TvJCH?=
 =?us-ascii?Q?mN9sXAKkwLAkXaBdk6COm4KDGOi3QBInwdkN4aUleHlrxmwZGxjNp/UPuJai?=
 =?us-ascii?Q?iR30/mF5Jl91L0RI8TDf7iuKRh/YlH0miztStD1AlbY4dOUKvp1ooroa1D/r?=
 =?us-ascii?Q?LVFGIkPAqRTJLt26BJTdD3EnC1yghCzVf3IPIgaSyfXBrVLhqPqJz1dKqcsY?=
 =?us-ascii?Q?XdHniIwCeBPDctTPZv7UTFNUGSPfD0LNPDg0DiP/jHimXivTA26ndRNpGCJL?=
 =?us-ascii?Q?4TZdgm7n+zepIqcmW+NYRNDlCirIbCLllSxTUBt9c9Vl1kUszK8qi7AMr4L5?=
 =?us-ascii?Q?SuBcHJ4AJs1JvizIqO1XeJPFi6euSLib6jyVr7JV8r4ryv7WA/fTLSCOoiE+?=
 =?us-ascii?Q?5DIyGBQYU5CMPtCeQFaMT3CvSBAw793Sebu20WY7j60NKjN1jLjY5YNk9cLL?=
 =?us-ascii?Q?ByNrCep/oi2BOmUtld6T7Cv53nu4QJ6QfOxGh5Zvs4ATGaIGX488csYeUZYO?=
 =?us-ascii?Q?s1PqOwtb0UbIiJcug4sbaPScIohB+W1tobqzRFnxo4Bos/n4WD8NIaqGEyAx?=
 =?us-ascii?Q?USoSA2ftPQlttwAU0aul2pQW0HNmJ4UuaZetovmcMvK61W518iD5ciapXsoi?=
 =?us-ascii?Q?PXEP5wu3fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98c373f-efdf-467b-c96b-08da26c76b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 14:25:16.2840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADg5MSbUpCZhxyPP8MKtfHVbjPfGz9690kcm/gPDL52zHeJQBvBPPxoXhLGCukTqJ4MArIII+3fEyRzgfvRVKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 10:59:25 +0800 Zqiang <qiang1.zhang@intel.com> wrote:

> The kasan_quarantine_remove_cache() is called in kmem_cache_shrink()/=20
> destroy(), the kasan_quarantine_remove_cache() call is protected by=20
> cpuslock in kmem_cache_destroy(), can ensure serialization with=20
> kasan_cpu_offline(). however the kasan_quarantine_remove_cache() call=20
> is not protected by cpuslock in kmem_cache_shrink(), when CPU going=20
> offline and cache shrink occur at same time, the cpu_quarantine may be=20
> corrupted by interrupt(per_cpu_remove_cache operation). so add=20
> cpu_quarantine offline flags check in per_cpu_remove_cache().
>=20
> ...
>

>Could we please have some reviewer input here?

> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -330,6 +330,8 @@ static void per_cpu_remove_cache(void *arg)
>  	struct cpu_shrink_qlist *sq;
>  #endif
>  	q =3D this_cpu_ptr(&cpu_quarantine);
> +	if (READ_ONCE(q->offline))
> +		return;
>  #ifndef CONFIG_PREEMPT_RT
>  	qlist_move_cache(q, &to_free, cache);
>  	qlist_free_all(&to_free, cache);

>It might be helpful to have a little comment which explains why we're doin=
g this?

Sorry for late reply,  may be add some comment:

Ensure the ordering between the writing to q->offline and per_cpu_remove_ca=
che.
prevent cpu_quarantine be corrupted by interrupt.

Is this OK ?

Thanks
Zqiang

