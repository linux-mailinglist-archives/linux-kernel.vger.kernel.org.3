Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6558D535
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiHIIPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiHIIPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:15:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3213F0B;
        Tue,  9 Aug 2022 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660032901; x=1691568901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3JDx6TFGT40gkTqEwvuzmwPmBxgSImcOzsLBl1Vl4E=;
  b=EtZbDNg+GcahPXaEsYFaHQWiEiCevgsgvp3K+DWil0wHa13SxPWpJ7k3
   /uTsTAIKmcORsR8g3suPlDoEZb4g0Nj81WAr2Qk6l2OWnMGPde/g82+In
   YRzx/OfYQdYg5aGHWkbLO2IA7PSnHi9Gn9EMSQ96DmmsBGP82DE/Ew+l4
   MHyujqyXa/K1kE9cb3TCSQswECBasUe41C2/21H3MQS83PMeGBmXYMQm1
   T3YKS4UQPBOHAihPbECFhdxFTeU2VGxqsUu1SzXTXehRIQnwaS1zlLFW4
   SDEdWeZoNJ22Um3Hs+8xe2FFc1tZQz/NaNYPaG8eSezZuLPnSh58z1SBd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="273832883"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="273832883"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="633244724"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2022 01:15:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 01:15:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 01:15:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 01:15:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5lnVl+pz72HNo7j86K0EMO39sj4tAW5zQG52psHnrthiTY+ch1/tqgQKk+a0J2/6cVc5Cds/96HSidxNdgBfar1Oi1BYQh2EfBtISAE0KRo4pzp2RceMYjLyIT4nF2BpbAPkpHj2xCyDrPgdx08Hmtc188T1j0WkHFC/vVU5lEFlAegn+aHn4wf4DUm1cIronY/amO1WXmZXjbaqcpzezJ7P/sR2SfjftRNoJ+IDq/5ixeQ0LrXtPv1fz2J66oKE07Kpsz2H7NXzicHK+a4+ivwkHKNdsNCTw20qahEfYaUuT5LNXpFmwa8afvEnYqsW7Qp7awsasbkzheauWl73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZQ6Tasw85jFUGTOD95nUiN/jAv/33rvSWNMXzqYe6Q=;
 b=iIHhbgGSbcqY/RWIEo8ZmWY5Dtibh26tAvd53GJ1XY/OixCMNUx6/Ilih2glaezNyRlsva+t/wfvsEvDbC+IKPBlVLgpz8Fph19c2HCCddEjhIDJ3D9kh/xDO4AkdSzhvMgl/PkJ9pv3aq0yjZ4kULQX8yqlBKeMoJuU7q4yqevWB1WZ+/YvqQaZUhnIHVXZjfc2h0CHiN6p8uLWYhVLe2JtwiTbPnJwHQCl3OW/0ZZCITmDr6l75WFshyFHPYbT0U7rjz89I/YM0BuVkTzONab4IM8VLZcNKLTm8bKsuoh3pWpECzGqn4cM2FXNXzQhI2obOHfevVBrU/upwkGlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BYAPR11MB3718.namprd11.prod.outlook.com (2603:10b6:a03:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 08:14:57 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::2d74:9016:374d:f7e9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::2d74:9016:374d:f7e9%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 08:14:57 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Reduce the frequency of triggering irq-work for
 strict grace period
Thread-Topic: [PATCH] rcu: Reduce the frequency of triggering irq-work for
 strict grace period
Thread-Index: AQHYqs6KNi68PZQn+kKHJWXoPIwv9K2lTKGAgADtMAA=
Date:   Tue, 9 Aug 2022 08:14:57 +0000
Message-ID: <PH0PR11MB5880C5906E72063CB39CDBB0DA629@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220808022626.12825-1-qiang1.zhang@intel.com>
 <20220808180311.GG2125313@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220808180311.GG2125313@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31ed9a67-0149-4426-621f-08da79df3f8e
x-ms-traffictypediagnostic: BYAPR11MB3718:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1B0bEgzeUIPLxaZdwuH/xgpPkYVnkQJuI23jo9yeQ/D8G6hn2fC7Qx+pDY9MKDhvRoi2eiDIcnrCm052FCWIT8res15FqNyXtOUV8HJhYx9e+MkQTr2+2C+xaZpJK+FlopibrtNrKLhh1VLkbHZyzhWJf6KWJGgDT/IPitDmosmLVbcQSlrTSfc0g2gps0TKXzg+jMZIdatGat53RCEgVbxoR7jJneztlEyC2PdnQJwefAEkdq7MUGPHLWLadnAWAhrGDeIHViHsQ+gZO0H5PLvfe5ks2cXcaQDGk78UYn8Tp65B2ngZk3+SdlqScN8ywNGt3omK7yPERRzQVt5+YbsuSNkUD0nH5Nc2uGaLWtOneBbeL7Vu0Nc1hihGchex2LA9pGnRFRtD2QoP3Sb0rBSt4lSW/oQZ5PySASx+gJDvFs6dIM+/jlS+ZNYHSNE3ATfsWw4VtYQq2SZ+H3tsiRHYMKxjoUv+7ZrpTg9FDAj/ouXoStWycoaidzyC7D0tV6rETNUI/atXjLZvO1X8nlDRUP5ExDoFvuL6CGzA5rj7tFs2cm9uY08l6HKWFOS5q1xd1jCFqlUFDh81+hbpMAxAYKMsnjZb16wno3rA4h6pMcaFzBA8yXMqLZ/1YCtO01ECOxSV8QZ7+g76ENE2sRVtIXxa7jILBnk86zFBdhmekOUBkfqkxHIw78vkmIIynWjyizTSIh82w9SsItrt1Ao5sytGZ0NqrZfOTA4l3Z8J3ltMEesK0mUmmq0GaSoJ8mDpi7d2NYEityDlmX1XjU50sUm4mKnm/8pjg4OFXU8LubfzHXrOezMrx4G7C+pAuxyA0/MZ+r+eAjray9+egA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(39860400002)(136003)(396003)(38100700002)(38070700005)(82960400001)(186003)(966005)(26005)(66574015)(41300700001)(71200400001)(9686003)(6506007)(7696005)(478600001)(86362001)(55016003)(66446008)(8676002)(4326008)(66946007)(6916009)(66476007)(66556008)(64756008)(5660300002)(76116006)(316002)(54906003)(2906002)(122000001)(83380400001)(33656002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?45Fmtntqx3OhC8jMP9Xz4dZI8uLaKZg5rfvYhRZIg8xUt33xMRzcddBN7HK7?=
 =?us-ascii?Q?mQkq82x2mit3ZAr1qBMKIXlZ/pDcyUZcp7XhWTkSg5CZe9HX8NviZBGAdZxr?=
 =?us-ascii?Q?C5EFkJNj6I9W1VrCwZnEptHg7yBDTzQrCaUp8SBHhXMM7SF2ik+4yjSznqC+?=
 =?us-ascii?Q?GjI20Fnx/3v1Ei6EWcdqwA3tRS7Kv5CmKKm2NbPLePDyU7f3lJeVNvQMaS8a?=
 =?us-ascii?Q?lsCb0lapUuIoOgmatxRphH0xUwSgi1Sik0VFyBgZlg16ItqAYLziP4bO43fS?=
 =?us-ascii?Q?jEgJ2k4zp/gKaNSgSpFCAkocsOtJCjQPtGgEzdUc2dYRo9C9edzmqntnK1iG?=
 =?us-ascii?Q?xtzlN3ui+MA+YHLbQojw28W/rL+udsFWeXEZiVV4/r0vHOmYqYN4vLLJEjcj?=
 =?us-ascii?Q?Gwtc9NM8jLPcYGfJREBeloyV4MSL9sHukMsj4yNyjkN7R1ffTtMa5xNWPXVS?=
 =?us-ascii?Q?lyTPF2eJtdpr0wcb2kG3aoWJNPXCXNlLkXgNI/htjKwMhAZaAeM/DpkEmfbU?=
 =?us-ascii?Q?jgLrJqD1iedZ3JCUOqM8DH/k8QWmTtPVtAstU8/sUsKVIh0VQfkpfP0ptYQR?=
 =?us-ascii?Q?vCfib8tFjYzvMiZk9lA4O/3+zGo5FMpJPJpKpy1SC/l9tAle5J+8auEbccVZ?=
 =?us-ascii?Q?vt0Grf+57S90ei7SUTmlEtuQuDxgDLQY1uIuLQmlG7kgUghMg9Etvv5PdyPc?=
 =?us-ascii?Q?Qvp5N1XlLFJ0hh8u/JFQecuOOQq/3/5/n2opscNBhiJ+Nhed0UfWVpTErdXu?=
 =?us-ascii?Q?vl7RVcWaq1Nn89F2frTuazemCERRZa1cT4DHejkBJZLRgkskwzW6jU7ZZ66n?=
 =?us-ascii?Q?uoXNeZZwsNhpTrKziyx5iebcnr4TMDdPuU0FFXy2O2sxR6TDFqfCdoCsLHNC?=
 =?us-ascii?Q?TH02ZaxEkKKRP/B0ZUio9I4IIN+8RfGFvLjA+4J/Fjk0IKruzAHpWQiF/SLK?=
 =?us-ascii?Q?TmU6hsBZrFm8n4/4xX791K713Xvr6HSMNUBI642gUeEtZkpR66vF1E/FATcZ?=
 =?us-ascii?Q?Cj1Xx8HVrrRQn3gVMYTgmJg7t/Yb1ymwhWMAiElKkChsvvylg8uOpIDU1tVq?=
 =?us-ascii?Q?XBmZYYW29h2xaOPM3dONMrgvqakFuBXq5/Hb/K5d+5sI+TG486Pd97dWJbx6?=
 =?us-ascii?Q?GsJU1YL0M/E7RGwgzTUJhwwiRjzkJ3R8Jwrj0iNPiF5stCVcnzVTN7WgqkCF?=
 =?us-ascii?Q?Udg1YBTqkNp3ssEVNNzQNbFiQTTp89LFMdOZ2bwcGvIVfP0SMGtpKkkKIlIB?=
 =?us-ascii?Q?uC1+n2vyiU7pE+liEV2aAiQnvrCih3zxiwxs1HLGImBow9Zf3DI3QII5fPVC?=
 =?us-ascii?Q?9vZ5qIsDO4XLUZc2HjosiyWxfwr/8Y2CSu4AdJ/7gHlTtawWghL84Mw9wZn2?=
 =?us-ascii?Q?I6kj8xAJDVgyr/VG98yBBSadlJ/qNW97oq3ikBeh0Fuv8iDdd0NchqWLhFea?=
 =?us-ascii?Q?GGKY4ZpU9uj5saKlZ4vzswdyvXjIwWCJhlEmj8wzj86RimuSKE+7cYjzAGAj?=
 =?us-ascii?Q?oYRgXau+KyOD585ip5xuGsJv1+TDUSBCiQDXYxzbSnDPQ4LvHAxMRNldTbrv?=
 =?us-ascii?Q?aSkt9ngXusf5jIexVadoug2E6/zUv73BrQ/c0CNa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ed9a67-0149-4426-621f-08da79df3f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 08:14:57.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COU9S1XHpjZvz/LmmqLYn2orYvxSAPBHvV6tpFPkoqTZ4iAa8MZhHb4HduDapsvgEidTd2/Fnu7Qwf00TTNyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3718
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:26:26AM +0800, Zqiang wrote:
> For kernel built with PREEMPT_RCU=3Dy and RCU_STRICT_GRACE_PERIOD=3Dy,
> currently, the irq-work will be triggered by high frequency to make
> the scheduler re-evaluate and call hooks to check whether there are
> qs need to report when exit RCU read critical section in irq-disbaled
> context. however if there is no gp in progress, the irq-work trigger
> is meaningless.
>=20
> This commit reduced irq-work trigger frequency by check whether the
> current CPU is not experiencing qs or there is task that blocks
> the current grace period for RCU_STRICT_GRACE_PERIOD=3Dy kernel.
>=20
> The test results are as follows:
>=20
> echo rcu_preempt_deferred_qs_handler > /sys/kernel/debug/tracing/set_ftra=
ce_filter
> echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
> insmod rcutorture.ko
> sleep 20
> rmmod rcutorture.ko
> echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
> echo > /sys/kernel/debug/tracing/set_ftrace_filter
>=20
> head /sys/kernel/debug/tracing/trace_stat/function*
>=20
> original:
>=20
> =3D=3D> /sys/kernel/debug/tracing/trace_stat/function0 <=3D=3D
>   Function                               Hit    Time            Avg      =
       s^2
>   --------                               ---    ----            ---      =
       ---
>   rcu_preempt_deferred_qs_handle      838746    182650.3 us     0.217 us =
       0.004 us
>=20
> =3D=3D> /sys/kernel/debug/tracing/trace_stat/function1 <=3D=3D
>   Function                               Hit    Time            Avg      =
       s^2
>   --------                               ---    ----            ---      =
       ---
>   rcu_preempt_deferred_qs_handle      841768    191138.6 us     0.227 us =
       0.024 us
>=20
> =3D=3D> /sys/kernel/debug/tracing/trace_stat/function2 <=3D=3D
>   Function                               Hit    Time            Avg      =
       s^2
>   --------                               ---    ----            ---      =
       ---
>   rcu_preempt_deferred_qs_handle      828243    180455.6 us     0.217 us =
       0.004 us
>=20
> =3D=3D> /sys/kernel/debug/tracing/trace_stat/function3 <=3D=3D
>   Function                               Hit    Time            Avg      =
       s^2
>   --------                               ---    ----            ---      =
       ---
>   rcu_preempt_deferred_qs_handle      810258    189158.1 us     0.233 us =
       0.023 us
>=20
> apply patch:
>=20
> =3D=3D> /sys/kernel/debug/tracing/trace_stat/function0 <=3D=3D
>   Function                               Hit    Time            Avg      =
       s^2
>   --------                               ---    ----            ---      =
       ---
>   rcu_preempt_deferred_qs_handle      302373    67434.95 us     0.223 us =
       0.001 us
>=20
> =3D=3D> /sys/kernel/debug/tracing/trace_stat/function1 <=3D=3D
>   Function                               Hit    Time            Avg      =
       s^2
>   --------                               ---    ----            ---      =
       ---
>   rcu_preempt_deferred_qs_handle      307174    68398.34 us     0.222 us =
       0.002 us
>=20
> =3D=3D> /sys/kernel/debug/tracing/trace_stat/function2 <=3D=3D
>   Function                               Hit    Time            Avg      =
       s^2
>   --------                               ---    ----            ---      =
       ---
>   rcu_preempt_deferred_qs_handle      250910    56157.42 us     0.223 us =
       0.002 us
>=20
> =3D=3D> /sys/kernel/debug/tracing/trace_stat/function3 <=3D=3D
>   Function                               Hit    Time            Avg      =
       s^2
>   --------                               ---    ----            ---      =
       ---
>   rcu_preempt_deferred_qs_handle      279902    62644.64 us     0.223 us =
       0.003 us
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Looks good, queued for testing and review, thank you!
>
>Please check the version shown below for the usual wordsmithing.

Thank you for a more detailed description.

Thanks
Zqiang

>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
commit 1e5aa3d5d53a6b38718510cce2b91a8199303891
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Mon Aug 8 10:26:26 2022 +0800

    rcu: Avoid triggering strict-GP irq-work when RCU is idle
   =20
    Kernels built with PREEMPT_RCU=3Dy and RCU_STRICT_GRACE_PERIOD=3Dy trig=
ger
    irq-work from rcu_read_unlock(), and the resulting irq-work handler
    invokes rcu_preempt_deferred_qs_handle().  The point of this triggering
    is to force grace periods to end quickly in order to give tools like KA=
SAN
    a better chance of detecting RCU usage bugs such as leaking RCU-protect=
ed
    pointers out of an RCU read-side critical section.
   =20
    However, this irq-work triggering is unconditional.  This works, but
    there is no point in doing this irq-work unless the current grace perio=
d
    is waiting on the running CPU or task, which is not the common case.
    After all, in the common case there are many rcu_read_unlock() calls
    per CPU per grace period.
   =20
    This commit therefore triggers the irq-work only when the current grace
    period is waiting on the running CPU or task.
   =20
    This change was tested as follows on a four-CPU system:
   =20
            echo rcu_preempt_deferred_qs_handler > /sys/kernel/debug/tracin=
g/set_ftrace_filter
            echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
            insmod rcutorture.ko
            sleep 20
            rmmod rcutorture.ko
            echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
            echo > /sys/kernel/debug/tracing/set_ftrace_filter
   =20
    This procedure produces results in this per-CPU set of files:
   =20
            /sys/kernel/debug/tracing/trace_stat/function*
   =20
    Sample output from one of these files is as follows:
   =20
      Function                               Hit    Time            Avg    =
         s^2
      --------                               ---    ----            ---    =
         ---
      rcu_preempt_deferred_qs_handle      838746    182650.3 us     0.217 u=
s        0.004 us
   =20
    The baseline sum of the "Hit" values (the number of calls to this
    function) was 3,319,015.  With this commit, that sum was 1,140,359,
    for a 2.9x reduction.  The worst-case variance across the CPUs was less
    than 25%, so this large effect size is statistically significant.
   =20
    The raw data is available in the Link: URL.
   =20
    Link: https://lore.kernel.org/all/20220808022626.12825-1-qiang1.zhang@i=
ntel.com/
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b76076014e126..1514909cf905f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -641,7 +641,8 @@ static void rcu_read_unlock_special(struct task_struct =
*t)
=20
 		expboost =3D (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_=
tasks)) ||
 			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-			   IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
+			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
+			   ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node)) ||
 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
 			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
