Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02684ED180
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352438AbiCaCFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCaCFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:05:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51968DEB9;
        Wed, 30 Mar 2022 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648692210; x=1680228210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2u2jFNf347IkYVOaMmh1M3apgMMCqeUIuAgUnas7vYo=;
  b=hgG72KIFpeBTg1rgrgzdwGdO8ROxM5UTAepxGEMs0IFVbjXeGSzFc9TW
   r9ywHDKzNGc4rwlL8oQOR7/wsk6w81MxUuiaMS2R8p++4SPijp3O/ej5r
   z19ItdSlbMzRbwcFmZtcJwz1cp33/GEo8sCvDml2m7rkgOi3A5YhDDqaN
   loeA5txfJ/LOtpY2MjUom4BInZ4iyDylS3dJjL+Zn/T1kHg8wLv1kzeUo
   ouftzdjjJrs0mT9AM1GNJas78ri8mNIH0u930fMI8kYYOnQyooUmqSgZx
   i+F+M8FgSuYvoKw58H6zlkOR38IgDklc+2zom+o7C7T6peeAOTdW2tTap
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239618201"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="239618201"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 19:03:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="586224725"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2022 19:03:29 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 19:03:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 19:03:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 19:03:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 30 Mar 2022 19:03:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO1GGev3k/k4vvCv/KHp5XqXJoxn7zlLNNPLl4/6BtdtcakE6ASwTDedy/KmdlAi3e0gQVVCnRMTBlLodboCaNpBD9z0ZQZTpCCPeEBTR3sk0Wt6M1DDbDIzqXg6A4Vbr7axcOzlsb22FEfbhVBRd/FRU6nufekGSXPpH3w5untruUkokEsZ6doM+MX6I4UBH7y6B0odlK3V2S8MhLIRdYgC9UvG+r7/GiNAqWcTdGrNthjPoZMV+6Cr/cCdmJSm64MogJSZ5chGHbF7K3l8HYwClSc96CRMPlJIb4niMPSv7eL7ILSMOhoZMdtrWlq2m+r0UXKAc3rWgx+eOR5vLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+Rd07/iDKs4WHbTB9OfU+zwcat2pqoYbQ9eb0kBZ6c=;
 b=hvWNb6tPLAim5GQi/nHkKzcN72/7V4z1A4e4Sy3am8rs/GxcE4fdB4WdwmW1EaDEGnZQeY5xJ5ttYugzFrJ6WnDIku7aMHXg3dtfWb7GQX0dLbJ+5wqwon6N0VNBGdsC/22uofQFKl5/l6ZNVGwM6iJoJmcnNu/sOG77Xjip7JmF5Q5XAaIaNTViY4nKODAlNkRowKGNOeLfgXKYIO+EUVTaoNFTJVkDtVlWIaSz2+InOjmQU0VboEm4JzAFH/Wlqk+MvYD3mK+m3p7S0k1g9JSI2yLWT+7GNmlMLC4S7qFWWXz1adFDcquSmMS+/4KCb0BQMURdMglgfwyIpqTITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 02:03:26 +0000
Received: from MW5PR11MB5858.namprd11.prod.outlook.com
 ([fe80::99:5f29:6f55:dd7a]) by MW5PR11MB5858.namprd11.prod.outlook.com
 ([fe80::99:5f29:6f55:dd7a%4]) with mapi id 15.20.5123.017; Thu, 31 Mar 2022
 02:03:26 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Check the atomic variable
 trc_n_readers_need_end again when wait timeout
Thread-Topic: [PATCH] rcu-tasks: Check the atomic variable
 trc_n_readers_need_end again when wait timeout
Thread-Index: AQHYRCgbTB0vKm9Y50G6+1/r5OpdTqzYSg4AgAA0FUCAADoYEA==
Date:   Thu, 31 Mar 2022 02:03:26 +0000
Message-ID: <MW5PR11MB58585FA7332315F46FA36CD0DAE19@MW5PR11MB5858.namprd11.prod.outlook.com>
References: <20220330112014.2587148-1-qiang1.zhang@intel.com>
 <20220330190556.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880D6B11469266144C58032DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880D6B11469266144C58032DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 9860910c-7314-4be1-95c8-08da12baa4f5
x-ms-traffictypediagnostic: PH7PR11MB5916:EE_
x-microsoft-antispam-prvs: <PH7PR11MB591687F39D4E2690BD15CAABDAE19@PH7PR11MB5916.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qg8OooihZLZlWC1gRfGyqlQvMpo9vP6S5GLalbohD1BbAapLZxsbe3KY+zNBXXzrhwPzu7A3NtliprkX34eUUu7DNXXY/eZIs8Ts7b2CSS4lSkxtrg8xvddgjXWIMdkUq71DFtD1iI/PRhkqO3wnikX/w2WMWsWdEmpuqSNmnz05R3L/Uhff4RvbeLfcnvtoCzjfqzG7BrAdlgnOl3YSWrDGz2DeET7BaqHP9ca6s7nxDT7SxAHe+iipXObVQEz6WJlBuxIVIjCi8NjBs+bgOrbdql/K3nlLI6sK89ChhlVkkqT0i+RCEumG8/K3MCeKYvtFBOwDeSmkREVc3Hz8BWUEiAa+AK6YGC/OyCKja16/JuQI0xK88BPwIu7u4t3S8jKUH7Q8JpBXFjfoen06vTIPVb6bjALx80XC+K5z6b7wrYgzBdWWpM1K1RpF7MJSe14P6StNiEW9r0e3wNwu+x0Sp9iugiu0hHY206GyUXMLleGmBGCTkj3hseaQmXgY/mvOESNNYMB/3eHc8q/YQWvrpzYdlWgNQJCflEybHLVb/kJ7xnzIijEEn6Z8NS75CaRxijMCr/BAIX6pARnbG3MWRQQsR2VvNAU9oq1p5igrCPEX31mO8VRpcaGPnupNzPQ6Pst2SoMCRmonVpoz3Ppuf0/ScpD89Ie5/OHgteBQh0ulVgWN/9QSUzssdHRhV2W4M+gMDzuQRqrzZxZTyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5858.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(86362001)(6506007)(76116006)(33656002)(66476007)(26005)(66556008)(52536014)(186003)(508600001)(5660300002)(8676002)(66946007)(66446008)(83380400001)(316002)(71200400001)(38070700005)(54906003)(9686003)(122000001)(82960400001)(8936002)(2906002)(6916009)(64756008)(55016003)(38100700002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vwhO272z2TuYOfbaqqhaZQBP6rcF7amQvf87x0kkyPg/kqvDklPwbQot9Rqi?=
 =?us-ascii?Q?y3I12Bri8fmA2TTlm3hKOsk9PcwAPs/USyFL/SjC1B5maDYny3/x15Ugc26d?=
 =?us-ascii?Q?dyh4OXbSIJi+SM/Guh7KAWMjzbAomchR4knwjKAxzPbRmKOPRUieIZSltpRb?=
 =?us-ascii?Q?BtQgm67XVqs3ipxjRH4lPIyMQ/NZUDtGPynW8+qixJRp1nvpet0nY/RM2gF3?=
 =?us-ascii?Q?eGD9g8+82jziWS8ozuYusN0hlcukT6okVeNwCaFHtTsTF7VZXfgyXwan0OTJ?=
 =?us-ascii?Q?4/2+FOwOAj5kY8/+ptcvOIwJR1AFEytthGpn1lKuXbm8MAJN/JzbhEj22EB3?=
 =?us-ascii?Q?+TGlrXigCRqLqSILHvB2G/Ah8DTpBqEVQCI/2/JKTY2xTIU5UnCjZ5kgDcMF?=
 =?us-ascii?Q?RmdHX5SL1/FJ6p1gySeT+2D4aTWD9/QeLWdGph89Cl10GJKawBmgZVzH/vxB?=
 =?us-ascii?Q?77KR5JKgtURuF/KDN4qG/fGwz/OjuUsxiAMQb9UpWo5vCioSmgETZYxhz9zU?=
 =?us-ascii?Q?EqCSrlcdkSakLu0C2/ZH8b5K7Ua/G0oR/BvuupbZgEKxTWs+UG9B2qv6VS/O?=
 =?us-ascii?Q?/ZPTfmizykkyETyQSXP0tX342aBD7Syj49k+XtIfXKb0sXJX1OaoyUxGTpP0?=
 =?us-ascii?Q?7vXP7oI2exJWad2Uv+jtd54JAmO/ul3NRm8rsHUPkhgFFMFCtB9WkorFymjH?=
 =?us-ascii?Q?QZVDHfqI8VeZ0jkUbOn/K877LE5FD4Sn1wmAnjPHqvP+kSDIqOcXV+tTzt6e?=
 =?us-ascii?Q?ns8WGxZ7cWxyhNfDTjzuXeF3TAs5bBHue8sHKIp5+mw2EA7QQ30naLNWWuGW?=
 =?us-ascii?Q?SY4zt+icAeA+QYgrnrKO9/NfwdguIWogNYEXEK/GIixQ21mA0alcyAZUt/zC?=
 =?us-ascii?Q?/8cnEMGhaPrFLvUgd2b0KEh4Tm3TwlSvSUybhyoqQkM03CIHwsQG9WPzbMqd?=
 =?us-ascii?Q?v77khs1ohJjHcFZG8SxJfJgjhTbUf72EJOo5ScXbZaRgAjq+ubJ3J5XFLgvR?=
 =?us-ascii?Q?0Ris/lCE4gG5WMBPtSkFMh/qjLi1QrKajpUn3sXG9tSmUTWwxDGyETiVfO7l?=
 =?us-ascii?Q?lVHYH94Q9cMfQXjx3q0fptXl9bc+fX7qdr2BrZvgzBi1FMZ+AdJ+N982Ijgp?=
 =?us-ascii?Q?pruUN0tCbf4Ne2vKp5lyhEuGzxmh6Wi6iv47xJuY2L/Ra9ZlMM4oQn0UEzZQ?=
 =?us-ascii?Q?UNI+OecAuWz2rPBDUOrUcmSj1qmPb9EShqo7dKtRBrok3UHDkO+zyQWaNwXy?=
 =?us-ascii?Q?P9K/miwS+L7YKCpoEi5UYExt7nw0//vNLgh1c+aN9qX7vtQZIgckUxVT5Rkr?=
 =?us-ascii?Q?ZIBHfG53nRcgdgzjSbeekWlQQLOkyebkuTmnx1PP5O1lftaH3VP/LZgKYIjQ?=
 =?us-ascii?Q?NikdsAjpJWRzeJ9XjLETZpUZz+xycnjzpGGTXXsZmTD8Owgu/nzpYydQsfvk?=
 =?us-ascii?Q?MCokAhRt6OQbz13+ykN/8/y4/GHfOWNBI1PJuB0Kvs0kBsbw7bR0MrU98Srs?=
 =?us-ascii?Q?Ws7mBBPXV2r9qNaVVOD876ftdwnpRKm6YW8UaULHscCl2k/e6URnIXaT0pnG?=
 =?us-ascii?Q?qJQeNueTnwA/LHuBhl6Sy71Njg82ep25hWWG+/WDf5Uj2EuQ8mn9mqXdFjG/?=
 =?us-ascii?Q?aeha+PimqAhfl05TL5OuoHbdPI4mkFTcJ4MTBIHzu21Kgcd9NfEH2tPWqvFL?=
 =?us-ascii?Q?Nix8r6sLBwy1hyTzSHeMgVaPb+/s0jl/XWv9Wi6D0uha6t0CJClKL344hlGu?=
 =?us-ascii?Q?W+BuYcAXDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5858.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9860910c-7314-4be1-95c8-08da12baa4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 02:03:26.5967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8K6gbx/rL4zKxI51xWKCQD8ybbRYTVPZPUi9i/PX/6rTsLoNdwK6rnp7HpmEdMA1vVI7GMLdsuYizXw4ZwoJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 30, 2022 at 07:20:14PM +0800, Zqiang wrote:
> When the trc_wait waitqueue timeout, the atomic variable=20
> trc_n_readers_need_end need to be checked again, perhaps the=20
> conditions have been established at this time, avoid invalid stall=20
> information output.
>
>But are you actually seeing this invalid stall information?  Either way, p=
lease seem my comments and question below.
>
>Please don't get me wrong, we do have similar checks for normal vanilla RC=
U stall warnings, for example, this statement in print_other_cpu_stall() in=
 kernel/rcu/tree_stall.h:
>
>	pr_err("INFO: Stall ended before state dump start\n");
>
>However, the approach used there did benefit from significant=20
>real-world experience with its absence.  ;-)
>
>							Thanx, Paul
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index=20
> 65d6e21a607a..b73a2b362d6b 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1544,7 +1544,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks=
 *rtp)
>  				trc_wait,
>  				atomic_read(&trc_n_readers_need_end) =3D=3D 0,
>  				READ_ONCE(rcu_task_stall_timeout));

>If I understand correctly, this patch is intended to handle a situation wh=
ere the wait_event_idle_exclusive_timeout() timed out, but where the value =
of trc_n_readers_need_end decreased to zero just at this point.
>>
>>Yes,  this patch is intended to handle a situation.

>If so, please see my question below.  If not, please show me the exact seq=
uence of events leading up to the problem.

> -		if (ret)
> +		if (ret || !atomic_read(&trc_n_readers_need_end))
>  			break;  // Count reached zero.

>Couldn't the value of trc_n_readers_need_end decrease to zero right here, =
still resulting in invalid stall information?
>
>>The value of trc_n_readers_need_end decrease to zero right here, indicate=
s that the current grace period has been completed.
>>Even if we go to print some task with condition 't->trc_reader_special.b.=
need_qs' as true,  and these task  will not affect the current grace period=
. Is my understanding correct?
>>

Is my commit  information not clear? Is this description more clearly

When the wait_event_idle_exclusive_timeout() timed out, if the value of
trc_n_readers_need_end  decrease to zero just at this point
this indicates that the current grace period is just completed at this poin=
t,
direct break  and  avoid printing stall information.


>>Thanks
>>Zqiang

>  		// Stall warning time, so make a list of the offenders.
>  		rcu_read_lock();
> --
> 2.25.1
>=20
