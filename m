Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1594E5477EB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 01:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiFKXaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 19:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFKXad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 19:30:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1214F47A;
        Sat, 11 Jun 2022 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654990232; x=1686526232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ny4ChGZOl4Jfunw0RUeua1CrYadTAgk5Nua50/Hh1Lk=;
  b=NZDyfiGPKwOKafw33o9ivdOfmw8XxwY4RTXK9mq3kxObMJ5FvQJDE3/O
   oxeB4Z4Cc2ZpJ8vMeQnte23uDvmeLfzc6ST1P6hptlqDH7JAIGZDZvJnf
   5Y4/z+88yOw7nyXoXfH8Tzcqo6CKaAOvk1jjC5vM2gu9KaB27NqPNRnbK
   whS3YNIkn1ezsQzRZsyKJQs1fpBp/orrG83QUpWj7kvgJ8farw1MNpZSC
   2eU1qohBYddsltftuUv0nKHpBxMcr1iQi0HjTR/iYXR+ixaPm52+yCpak
   d7qOx8Nc9Vbb38+qGCjt+Lr8px86s0/iJg7ZK+veVfs8BA50X3laaLQLC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="266686907"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="266686907"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 16:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="672564391"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jun 2022 16:30:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 11 Jun 2022 16:30:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 11 Jun 2022 16:30:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 11 Jun 2022 16:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4L2RP3njFirwY2xZLknLB5HD3ysEV/7r69fQrrUWrzXF2BBkFNA9vG4+cQmMil0f2z2UpOuRa8cjtdnBvRV2dnBfP46Bw80sS5XkuxaxwKT0zPZRkbEYl1fThxySV0svcSqtYGWCraUwg8tKgcPw6pLf6SG48EpKo6qFSGPyI0NeIKlTPgcr9yWMNz7445ScIQ0oZYr3tpSsbT4HdU+TtOBjp5HBlG4J8G62VhsTDuCnXThGcWmQrgKnrfvjPm12/q0mgPgzrAZ0LGAtA5sgg6YR1au568C3Ntc/JNwMdMoCzQ/r2FiC9oaCiJnVAgbuBgx1K/xgkUE6SWN8PpZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKiPng5QFZHWod4ISgnNtFickYoOg8u18WH8wgW+SJs=;
 b=EB+AGgGiUOhBVeJjf7AJC15F0pGKiwmPcAiNzYBe/Y/nl8YOHaLko7SgosXy0EXR5fpXdGT7Wv501MCekXC7JUqqSUTP0/uMNIheiR1aqJ5LdasfCrQo+zSPjETJicTPCybUyrRJxMwEybrBMTz1cmpS3TCop65re7+q4/jOZord47sruPmJJX5+U2zURXUyw0viYMCq+0vl/nFckZmUJlLS6ecLjsOlMpxCLjxh74NOjry4n6x5VE7jTzQTzjbnVZp8Tf9ZfU52ACfrH+a0ncPdVa9H+027C36SdTHeCrkj4z+kZmbEZ2UFItOPBB3TlFXHSCSMdbIO8vCbF/y8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BYAPR11MB3303.namprd11.prod.outlook.com (2603:10b6:a03:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Sat, 11 Jun
 2022 23:30:25 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 23:30:25 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list
 is empty
Thread-Topic: [PATCH v3] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Thread-Index: AQHYfYKPaPBUmRiEV0qq31Yx1W06aq1Ka1wAgABpgOA=
Date:   Sat, 11 Jun 2022 23:30:25 +0000
Message-ID: <PH0PR11MB58801CB89F34F6BA878F5DC0DAA99@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220611110044.2999157-1-qiang1.zhang@intel.com>
 <20220611164918.GN1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220611164918.GN1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 8ffffe92-defe-444d-482b-08da4c025c75
x-ms-traffictypediagnostic: BYAPR11MB3303:EE_
x-microsoft-antispam-prvs: <BYAPR11MB33033E569D79BAE65113C498DAA99@BYAPR11MB3303.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UAh0dqvpdQKCr8xIVhmfI+985RFtOypbZZNsJnXogezWvjOJya1LqMI4GSXn5RmYbCVKb4maswbkIkgznHwZWHYX9yp8Ox/sHbQIcx0h1IB4mgdK4ypZmTgUEaLATQTuDBBc3njG4zV2c+3LJ0Rpu82tJn0bdfM09br6DkdSsWDRAqngHDNpk6t7JqddmyQ+0uJmDN0RRUl8A2Gy1KF6qlw2M0F/n6g3XJCwy/sVeDUAWRr0X7VXnfZIiThPxmb0k7Ynh5EYB1tRJQKTZjNwdIrbr0qnugY00PoXZbyoPxfGIOBNGdfDdAyseOpJA7Zon5RHbO/FHj5S6ku1ja33zPSEg+erUOhW44IB9Yh/5LilNJ7+seHrI2KTvZ+ctjjIza66NI85owtRogakfGOivFbSYCXXoACoSyDzmNIp31+yKHTcPRrlQh9n9+aXRI2LWnFjVCko46bHQ3MNnLQfL15+HcqwkB0Pc5jmoOWTx28R5KpNPgxWPgkSP5UaaDpPAyGsyBvC8Do3+ww3jkiEaipu970HwgFO+eD0XXUpxYXu3HmJbUV0LeV2mAdL39kSgWaZQdAzuRM5zRT0tQ4JD1opYC8dfxqcrwJlJJU3quoduet+WM7OW/lFLfHNAozJyRa7kHCeNilpkh+9BPFOfYX27TEzj7zhR137Wfl4ApJE1SJUvIxtRbb+JdiZjxgfwPUWQGaBO3I0foGSvitZ4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66574015)(186003)(82960400001)(7696005)(6506007)(26005)(9686003)(83380400001)(122000001)(38100700002)(38070700005)(5660300002)(52536014)(8936002)(66446008)(64756008)(8676002)(4326008)(86362001)(55016003)(2906002)(66476007)(33656002)(316002)(508600001)(66556008)(6916009)(54906003)(71200400001)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oTLMmvg0R14ATCCJTBr5l1lGeq/O9KWvmsfZKaRPd+djkU8aMY9dZruKn684?=
 =?us-ascii?Q?PJ2IcXBx2wNXKtbkXThj2q54Nf9euffKsk8gGQmpejOvvjQsJ3T8MNEs5WAw?=
 =?us-ascii?Q?aHjwBHDGcXiZYeTvfyl9eSQxjG8nhiB/YlKS/ouLI0j0G9G+OvFvarLxkrSU?=
 =?us-ascii?Q?H3rqGUVKzjvp6qPj1KeT317oueGVNnpHSwZAfpVx3nihP6FzsVqsd6rJUfyd?=
 =?us-ascii?Q?tmmdkAHgdpQHkCgBoPbzU6LRWvPbhrIb87SUqwCgTZAUSHV/x9/xRrMZiyMU?=
 =?us-ascii?Q?J/oZOsQydejyC22ySN9hUoqZvlWh3M5TzC8RkcXnzfKUwE159aivdw+jAMuA?=
 =?us-ascii?Q?rH0n1KAvnKb8PnkPXXGttV//WN+jjROtz89eC4X6cS8kRQHKziChTsgBNaq/?=
 =?us-ascii?Q?pBT8ulW+slbhdcBs59odsGVueO9NM3gj30v04cRoRPgBycETF07qjxHXkDer?=
 =?us-ascii?Q?Ob6XLKQUtwe7JDG8+8MC/Zj3XnUIHexgWwiJVnmP0YfOeqhuqxaun00yyFI8?=
 =?us-ascii?Q?BUMXyaiR8t1t8M3ayExkGrakXTRvSzIdQ8AW0FVYDJhuZ9yQBVZUpoN8SB+N?=
 =?us-ascii?Q?MryBgi4eclb0LKJQHovlkrXPD+UoRysYgyBpjdbzhlJzBPQJRGiFTLMak5nA?=
 =?us-ascii?Q?hvW0vS6rgWPMwJd8L+3CX1oSh7tjEKaTUrirRMxDuAcUDSnsItm5XaszFxMO?=
 =?us-ascii?Q?PBN4j9Ixp3n2G0hUPeRZDoMEmJ//bqpH/Si4qbVb4Kc9EqdOSkaSOBThxs4z?=
 =?us-ascii?Q?3BThbgHhl0/SnzV7thgdl+dL3L4TEaUw0yzBgfZkS3QXB6iOu79mMLA8Is8P?=
 =?us-ascii?Q?VPIGZayWwqSGYP5FKuVlPB3yaOXGVZIePMMycuElwwpDzq9Cg/HoEkAUqNk/?=
 =?us-ascii?Q?eX6q2VjIW1jsJZAgJyzEN3JJFiZDr+1Qj25cVtJC2r++te3VhlW5DTPPj1Dw?=
 =?us-ascii?Q?XTi1649Tr1xk+AUDQ8ofWcJbzZ1TCovWF+jHRDfa27LLo9JYMhnR7IwyuNQF?=
 =?us-ascii?Q?OxORuPNeqLFFDBt0nFIrrazP+cgDfq5cdQiIq9Uiyoa5+c00L5BmQF4umm0I?=
 =?us-ascii?Q?0i14NklffQ1av8gtS2l0Isuxo0kdBj4suEhx+W1prq5vZxfJrf5zFZOC7Pcg?=
 =?us-ascii?Q?DYvALDvRk7JriC2VR7qoUHcmZkoXc/SFboP464u4qKnet5gVtH3NvXeAodEU?=
 =?us-ascii?Q?V4uiue6l93jm4++8Y2s8yVwF3ISTVwzCW0VHC/Gmf2IMjzvYodedOeWpdZAQ?=
 =?us-ascii?Q?Kkdd4TtsDb+Lcwxho2Lv74dWYLCH02ZM4lU/cp6VFBdUgPJuzwEVDOeEJ2uk?=
 =?us-ascii?Q?kOoa6FOT/sppYJfnYJGpvxyVg6ryMALSZtps18KLv2G5wu6GAlpNXXENJpxI?=
 =?us-ascii?Q?E4035hdReNaVSQuJntAVW3hYRRUKMbxkLhna07YEkdKk4kB7n5vnCLBBBn0A?=
 =?us-ascii?Q?Xwl6Y/cL7ut179C39J8r0/dn15UmTHyQSvdYTlir5Ow8PPsaT4NjlZxS4wxl?=
 =?us-ascii?Q?blK/00eYGyPx1A4fY9mzN6Hp9B5MfKP8Jev0hc9x8a0kppp2aa6GuY5iUtQy?=
 =?us-ascii?Q?oVdno8jld/bMWJq4yzbAGukM/7G2qLipTQVJZ//g5rE1jXCm+62SLIu+5w/8?=
 =?us-ascii?Q?GhQFDv2z/XqiaUOsUDPC/Xr2n8qwG/FN/A82yhyhCH3kYjfOP/RYeBKNbAjq?=
 =?us-ascii?Q?mAtQ86vZseMvHJounitg4ZalwNW43vGrnbam9rftcwuKlVKS9b4feI+EdOcR?=
 =?us-ascii?Q?6ZO8hvlWYQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffffe92-defe-444d-482b-08da4c025c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 23:30:25.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYhUd+paX9D8I6P8lPnxZorK2RQDay3Ft+1v+zZua53P/Lp+798kx1T1GINZQeekN2tJVEgp4C8N+C0UvEJg7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 07:00:44PM +0800, Zqiang wrote:
> Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog=20
> kthreads enter polling mode. however, due to only insert CPU's rdp=20
> which belong to rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp=20
> served by rcuog kthread have been de-offloaded, these cause the=20
> 'nocb_head_rdp' list served by rcuog kthread is empty, when the=20
> 'nocb_head_rdp' is empty, the rcuog kthread in polling mode not=20
> actually do anything. fix it by exiting polling mode when the=20
> 'nocb_head_rdp'list is empty, otherwise entering polling mode.
>=20
> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

>Much better, thank you!  One additional question below.
>
>(And we of course need Frederic's "D'accord" before I send this sort of th=
ing to mainline.)
>
>							Thanx, Paul
>
> ---
>  v1->v2:
>  Move rcu_nocb_poll flags check from rdp_offload_toggle() to =20
> rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of =20
> rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set  the =20
> rdp_gp->nocb_gp_sleep is not used.
> =20
>  v2->v3:
>  When nocb_head_rdp list is empty. put rcuog kthreads in nocb_gp_wq =20
> waitqueue to wait offloading.
>=20
>  kernel/rcu/tree_nocb.h | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index=20
> fa8e4f82e60c..a8f574d8850d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -584,6 +584,14 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
>  	return ret;
>  }
> =20
> +static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu) {
> +	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
> +	swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
> +					!READ_ONCE(my_rdp->nocb_gp_sleep));
> +	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep")); }
> +
>  /*
>   * No-CBs GP kthreads come here to wait for additional callbacks to show=
 up
>   * or for grace periods to end.
> @@ -701,13 +709,19 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  		/* Polling, so trace if first poll in the series. */
>  		if (gotcbs)
>  			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> -		schedule_timeout_idle(1);
> +		if (list_empty(&my_rdp->nocb_head_rdp)) {
> +			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
> +			if (!my_rdp->nocb_toggling_rdp)

>If this "if" condition is false, what prevents this kthread from being
>in a CPU-bound loop?

If this "if" condition is false, (my_rdp->nocb_toggling_rdp is not NULL),  =
it means the offload action
be executed, because the 'my_rdp->nocb_toggling_rdp' will only be set 'rdp'=
 pointer for (de-)offload.=20
It also means this kthread  will insert 'rdp' into 'my_rdp->nocb_head_rdp' =
list. in the next cycle the
'my_rdp->nocb_head_rdp' is not empty.

Thanks
Zqiang

> +				WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
> +			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
> +			/* Wait for any offloading rdp */
> +			nocb_gp_sleep(my_rdp, cpu);
> +		} else {
> +			schedule_timeout_idle(1);
> +		}
>  	} else if (!needwait_gp) {
>  		/* Wait for callbacks to appear. */
> -		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
> -		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
> -				!READ_ONCE(my_rdp->nocb_gp_sleep));
> -		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
> +		nocb_gp_sleep(my_rdp, cpu);
>  	} else {
>  		rnp =3D my_rdp->mynode;
>  		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
> --=20
> 2.25.1
>=20
