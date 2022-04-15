Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9575020D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347101AbiDODFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiDODFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:05:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16065B6478
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649991766; x=1681527766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Bxq4agOJcCUEVLjqBJuZa2lgEaxt53JyUGPsfJVi4o=;
  b=gRqMt1ObfbQe6setHcNFcyqJf3Yga4fgkcxQkuzuOYfgKf6zsL5J6kJI
   ebBPchdjVuIxDq0dc/twJvchtV6IVMDqLK2XkE6h9DYAukqbYyoiiU5aC
   fFJUjXV4SFkhJkr0w76USEOix+FLzhslQlldzy1mDVQbEtAYf5BvnBEur
   DVRDmXs/lrA43Z4pewgU4+IZQoZRLcpTMXdE/jCCaCTkCb3xnkU0WU0jn
   Xl7tnVUQ+HdmwGN+68njNUeVo4yMgKbUZbo1ciG54Oi5tYSuyxKDaO8aV
   yKvwW/gwK0pBFNYFCO7rCUWtTW1rhXHKmKWOOSwVpQh/1VFfwJsT39ZhJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250380547"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="250380547"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 20:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="725614668"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2022 20:02:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 20:02:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 20:02:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 20:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRVjX1j8YjB6/eU50eP0YfFefjE9M4KwifmHkInIfFprvVYtTmhalGRuThCYOb0Gj9UR+T8yJ9V2iVNxwNpKT4xsb7bxOcKeJV2OngN7n+TyLZqsCqdckxKRJQkIwFz304ORpPL8BBlRBvsb+/CfF/TM3bXpxCNxYOfw80avbddH+rhbQSBX2sfo2S/+R6pyNFfaQyPhIL6IagRrXYhXld4XwcEuoltjbgynTXvoKQsbp0eDgAmEpQMVZPvK7lwJLCYiFxtVP+9EvokalqG/g5j+bxmP+iZHavnztZF+kWYd6mZmGFFlpQbu8fKnQja/C4cYmGGWxqc9jtgQhM2jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKaJIrsczurQJp5i3UX2+1/qSjw/fioakRkDRJLSOSY=;
 b=LmBeLJwd1dDNijuyewZPbBcnZ9LnrWfiBvG3tSzEuHlHj09qGhZ//S00141INQCSC/jiuwYMFZoCSJmBgR98Z/OekwCoepY2KvnATIrkDTzIAWi48wzmBrIaNJtk/SPW/hCMYSrUAKA5fJVj/H1xHfciYMqG+tNGTW5x3kMFu49CGaoRPLaUczGSDDCQ7CX7CsAMNv3YwQNKQszGLl65Wx88lzBLL90nwOcLJF7vVtBjz+S0lFyX/mo4/ZTkXH5JkEsXTr42JW/v1o/+wdzr6xsvsnhiiHRN5sfEShtqhA2tkOhJKoHqU37rOzJc5FvxEzgxcLkKK3Qo/9/wfBeMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BY5PR11MB4134.namprd11.prod.outlook.com (2603:10b6:a03:18e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 03:02:43 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%7]) with mapi id 15.20.5144.029; Fri, 15 Apr 2022
 03:02:43 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] irq_work: Add event-tracing points for irq_work
Thread-Topic: [PATCH] irq_work: Add event-tracing points for irq_work
Thread-Index: AQHYT8pATG0NrCtQb021NYs63/f6NKzvbMAAgADcZxA=
Date:   Fri, 15 Apr 2022 03:02:43 +0000
Message-ID: <PH0PR11MB5880E763AADA0DB42865FFF4DAEE9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220414063829.2472251-1-qiang1.zhang@intel.com>
 <87h76vepzp.ffs@tglx>
In-Reply-To: <87h76vepzp.ffs@tglx>
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
x-ms-office365-filtering-correlation-id: 26b44a3a-c035-48a1-1f42-08da1e8c68fd
x-ms-traffictypediagnostic: BY5PR11MB4134:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4134DC13F52CBDB1E2BFB972DAEE9@BY5PR11MB4134.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /WR7/mLTPy8oID/JDw2AP+R76bYK9PC1rNDPnR3BjI+cCwjkCM7uun6oLrvp0mplkxvEw37f/7RZF4BYF2IMJvmYkwJeDUlsV0la1tVJRFd4eHyq2gt532pAN19Txp2/NHEwqVLL427P5ubFSvDQNRVbkYKHbS4ULHnjjprIAAVEQcqx8TqdT+Gy3TlUFogdaCoiTarHTpopMvx8WF0OkNwYz9dSPsmMIChUkk1cU+c/PtuLkLF+U8nayYGJ83scmOUpjoYxDW4kA1oRnzckE0BQH9w69WZ0Ny1n4Lg49h0/uyncP4F5e0Zc9dJo7r/PDA7imi09M7Jam7RRDtq78gPZDe1SqBSZ/KrTmtrHKeVg2or3Sk3mIIxBxN/INHr8wGL/PAv1VeMEpaCIqzsRodtCC+r/LkOvCuIyQOXUEfvGTGHQTP/eLXIsRrODpZ9L3p3UvfFfDc1Ga1e0R7CDafpnEYPC8PcVa6mAC4ui/RKSQQd0psULq3mBUj1lQVrXua07k8ChuOBM6huKeD4gb9uI58nWp9pk/5JRa71o3Zz/AZpR8lNhvvqTO7ljLQQq8PIlvVtsUg7OaMlJZC6myxlpNikuxOfEX63SOvcPLa3KiZiFSo/qu6AnQ8sdMTbrjCI9PLF6ZtQUp+Y1IseKUWnInbU5XFPiJP+6eAXIwOoTKAP/7rHVrdeXY+Nd+ob7ccc1fVg94wyHEpR3nRZvgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8676002)(4326008)(71200400001)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(86362001)(2906002)(6506007)(7696005)(9686003)(52536014)(8936002)(26005)(186003)(4744005)(5660300002)(33656002)(122000001)(82960400001)(110136005)(316002)(38100700002)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JtVd0WlbDAe2I6giQeOQ2C6OpoaKiiwWXyX55Gf4ZMRC9S38yiP/Q7w7cc32?=
 =?us-ascii?Q?ZgrH1q++UfnFWxgo93j6gJEMPwsESpdgjIU2GdqeDUkTLZCTvTKZcWdJE6sC?=
 =?us-ascii?Q?eBp2eWxyaVv6O3fBNIgHoYTgBr/En7XAU8PNgz/eH7T12yPd4hyIyxuCrrK3?=
 =?us-ascii?Q?MUSt3CqkRuJ1ohLbRBJSjoERoQ0OpEHR3b6XmOlJifOMsIUckurJ/rId6g4P?=
 =?us-ascii?Q?lCmG59MhG5IqEs32HnZ0Rl8oVONMnxvpuPXjzJ0EpOUpn2dVk+c2sDI+6DSQ?=
 =?us-ascii?Q?aUjqG9XyRXaIHUmUhA5/dnMbkC07Urzvh7LswGekSSZN3rv7gK5ni04ECs/D?=
 =?us-ascii?Q?soJR+Pe1wKklkVQ1fO4q9Kvue7cG3MQiVmxtX4Wbx+F0XKR/HJBXwLO1dz8e?=
 =?us-ascii?Q?zJzOJx2IfRUTRUXYqWZUwNDYweBHyMZBdE+ycBFBoeVYjwP4+QJf5DxgGkxG?=
 =?us-ascii?Q?Mk0X46Q/NOIclbhpgV53xf5vJbIZxAs3pnCJLvQGjfLlxf3fhviJrCqUrF79?=
 =?us-ascii?Q?pWauIsgbphpABzIfHn5e5UHju4dsVkA9RqvMI938HQielYhWR7YTJY84Ujac?=
 =?us-ascii?Q?YZrgS6QGmFPaDLhtaI1zf9bF4QULJCw0Ht30ScoQXr5HlpL61ElQ/sUybkxO?=
 =?us-ascii?Q?ZVZWfpnnyyuYTm8ckCz8i97Vs9RFI5c7H9zMlwAPGHhd1j3pHbpTedYWUz7b?=
 =?us-ascii?Q?k6R0F1PBsbrYRaxTX9RG6eKh4CB86hFs5O28VhG/k9piSGOcRkIyqrL2jPwV?=
 =?us-ascii?Q?eHbtnb9fn+QbnNC7eTz0KQw1IJ6Cd2uenIbFWbFiju7JvaHpiI4pCEAyuIvt?=
 =?us-ascii?Q?pxCgr41N5kvaTv0TMYL3epOhE4/ngGeWJ2edavDz2e1Zma+gggXtpjg92zAK?=
 =?us-ascii?Q?uXtq1c8AAB46AJaIZmtyDJPifaoH2E64xrG+GI+hhHlbEBKntgi785I+2yny?=
 =?us-ascii?Q?sPFStLZhnuBjKjOiY167gnM9+akbEEPZ5GCTJsY3PjYcmKT1K/VUVSwRvAkU?=
 =?us-ascii?Q?E/IgCwhAQl1UktPhjc49uUqHIICbfI6aMIjB/GyUF0z3N93WJEGbIM8wzgTz?=
 =?us-ascii?Q?Yh/kLSmZCqzAvf5EWC2XWM6/Ah8Qjoz+BWfxZKrgCO4oLv0Pz5aI4JtMbZqQ?=
 =?us-ascii?Q?Bhk34j0J4DFopmhcM0PjqzcuCwNRNQe4leawCGI9HRKeUFVUK5viddEpo8AO?=
 =?us-ascii?Q?AaQpTm+0/+qWs2QOty2Z+VVna2NznxnXmJGt+KRMxXwV+UEAZ2sSRC33V39R?=
 =?us-ascii?Q?t9Ghl/tNgVdZu0yYdUN2fPvKlyMwvXGj/+F5Kc9sdkui/Pc5tNhkr6xBc3lv?=
 =?us-ascii?Q?W89eVwHj+tjWKe9h1wfTUVhtVh/215koy863+RNmrnvJ9OCR8pncG3UKipQ+?=
 =?us-ascii?Q?/5OENMK/8lNYWSUNJFsHSxyJaTYdQc0O5RQUjPfgKktFJoDPNbhtsCjzPpC2?=
 =?us-ascii?Q?ocyAM95nvOGkNTNfAMGLzZiRvWkQWa6mpU7SAmATukAEQlYby2IWouZUKM3U?=
 =?us-ascii?Q?oglVTVGePFdjU6brh25Xa8LveJVVfp8ywePAHhACEaywXa+J6SUwQTp8Vilv?=
 =?us-ascii?Q?3Vohsjhzp44LCizfgoth6BmB4qKud3nEL2PeHkcTDQbzXM5QFAeZGIL1hUPW?=
 =?us-ascii?Q?Gy+bFq8n7yawm7vx7ZW9XciVTpu42zy3F70TlWqHiOocBNUw2YoBLPfOilgP?=
 =?us-ascii?Q?pnw77WlwqBuKswfXf7zvCV5H+N2p3TAasVn6Y5pxyAybzutmPcN469VXdZ2r?=
 =?us-ascii?Q?6XawNoMbVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b44a3a-c035-48a1-1f42-08da1e8c68fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 03:02:43.1082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYOqEKhg8PheeJFiIl5qivVlASOMqiGsvJIssAEdtFHcw9OXMeElbF1rs5BtiJvReKdwjXToEtC7DXxSzyG7cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4134
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Apr 14 2022 at 14:38, Zqiang wrote:
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/irq_work.h>
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);  static=20
> DEFINE_PER_CPU(struct llist_head, lazy_list);  static=20
> DEFINE_PER_CPU(struct task_struct *, irq_workd); @@ -81,7 +84,9 @@=20
> static void __irq_work_queue_local(struct irq_work *work)
>  	bool rt_lazy_work =3D false;
>  	bool lazy_work =3D false;
>  	int work_flags;
> +	int cpu =3D smp_processor_id();
> =20
> +	trace_irq_work_queue_on(cpu, work);

>What about work_flags to see on which list this ends up?

The tracepoint have been record 'work->node.a_flags'  through check it to s=
ure=20
this irq-wrok is queued on which list

Thanks
Zqiang

>Thanks,
>
>        tglx
