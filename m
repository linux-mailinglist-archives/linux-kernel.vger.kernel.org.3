Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E342D56A6CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiGGPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiGGPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:21:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F624BFD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657207276; x=1688743276;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q/pjXdDJVfQkKD9KniiR6rCc9jSPhAp2bc75uNbJBuM=;
  b=L40M1ZuNHCXg2/uY4sWbs4uZq+huniW+Dwtp4X5qBdf+9ygOaY/iJuc4
   83a4oL8VZDeZ0ZXJiucCKA756ERDsbqN8PwmCqxjOqoygW1CHfDfXoXKs
   v6jRp038CD7pJhiGb1F2gJI8ZyuMFS5M8+tfLXPRqkreHQCBoiILK50xb
   ss/XDRVG9PQ6uZmyxIsVQeuS1SQ0TebKzMn4dJZcKHGD0lus+Z6VfNMTf
   MZCGh4Yrds8DsaBILChVwk/qNwWGDk2/8j2r2tyxTAtAki1AMfSUK5kDk
   3G+s8mWAcjFy5ksypj1Yfv1tNrlSrPWbKL8Zxsb+LTM8vIzLRLWpJIQU+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284074691"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="284074691"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 08:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="920627651"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2022 08:21:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 08:21:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Jul 2022 08:21:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Jul 2022 08:21:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/pjzJSsRE+2mJXlwB1FM5G0RbBIU3dCAvk4cm7A3qlqJR6HVrklQZcDATUC6/G55VFkqdY/xZ+ljAxdM+7cwONxnW9MxVLsemkSRpw9/27HvcLnZhPCfyFIiYMIp5ChOjhwx+gtl0oPP9296ek+7jE+dkH9F/AeUFIEmteun4VsU2HkCiFkvifXf8o+WVFUHlc50E0oHNUH0juO1MmyTCmjUEHpwHL0NdgVxBElSP7edmbcEgZ1wfWltO5D/xYfeigaCVwjcgbCgjrOxiu7UgrnrN3hn7+qvHxTbgOg5hI3frez4TF5iIkJqiY3cZVWd2FhtF/11NLi4t/UXwkORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+XBYWvX2tjnD1s8G8ivcd4ojML9ZedtOdi9iEkteMo=;
 b=nC9fX5z3Pn91hjG0cZw5eU23goNFXJis+kyeLr5iU2+dm1Hyzsp/ojbgsRN85CnTHKoVNhm1b3c+UX7Da7M9TI6mt0K/hHXV6SR64XBNOv131lliJUotNeKRGGic1i4ZGlGZi2dSWVoKtA2jWFSUCwpi4d2/TQH7t4J2Ag0I7AzFSqPlzmd8bODLZ08dK73lVeyS5oRiLKzWVoL7Bk0nb1dEi9lp3Zvep8xiPumrw660+t6U6XGfN/A82ypnNkV7Do28ulCRsIK/tL0I42LFuA2IaE0q9jdiwaiOezcWceWkN2kiXQKicCRYf3P2UkFqWSkEOOIkVVmtMbVxKBTmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by MWHPR1101MB2191.namprd11.prod.outlook.com (2603:10b6:301:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 15:21:13 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::8053:3c59:9f5d:b615]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::8053:3c59:9f5d:b615%9]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 15:21:13 +0000
Date:   Thu, 7 Jul 2022 11:21:07 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH v5 02/14] drm/i915/gsc: add slow_fw flag to the mei
 auxiliary device
Message-ID: <Ysb5464dRPxPrp0d@intel.com>
References: <20220706114345.1128018-1-alexander.usyskin@intel.com>
 <20220706114345.1128018-3-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220706114345.1128018-3-alexander.usyskin@intel.com>
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a82f9a36-fd26-40bf-9ab2-08da602c53c3
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2191:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmjk4O34CtwZwAPJhi1M6k97KI8WbNEj7Pz/LlWycqpIHa6krVNByY058peHnZ6k410qErPdTGq5D7OWcED/235NXZIwIhTgzQ2oQom6Jh9mCb5XRknbB2rtZ6zXj1GxZusnYlJZbZLL7704GZ2UCTQvNpogGWjFg1QZ90fdtymgDuWbQgy8wWqsf8YXIEXSyZ033oooqYbv9zbVvdsc/2eXSU4kmqiZXqgFOCII9bb2CcUW1qaAiu5l0UAsEKCB5b+6fl10RlJo2yOpkTxgeiu5ZLn0cm7l5IFWqgvb3Fu5VkOhPbmimetO7fB9Wu2STPimvQS5qQ+WmwWIBHap1Px8CA0m7CfASTfRuCODKJsjmsG09Tz/DTIs6V970ANVQgIhQdVKU5c+YRV1Y1zq34iMAHmgP1S0+MBjlIMJuABdeKLSInEN+1U6WfIkXz+ttmhQWEpzbldkwxawf2ERqPdxThNsOPuc//0rupnYkvaXlF3IWMOvlC8nSA42i7zAw5HZQvM5+3t8xcZt7omWy6g4NNGjCMvWYsNTTVgnhNbOG8HU88DtA8ls97IIqW2oaR7byAa/hPRUtWvIU+TGI8Jw3QgoHi5zLgwwAo1mzbifZIEQEJ/z9oLbKQefqh73eqJD6gaiIBVU8poIykKMsJjkHaVkUMsoB9/jtoxL/vfBHQg98k3msXbjDTJdW1VSbxny1TcYpfnxWtuO+YC1ba8TtitRrSB3KyD3+E1aFzv5n4bhKQEagGZNakI6fqPD5IU/78imysY6mybIVXd2zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(366004)(376002)(2616005)(37006003)(54906003)(36756003)(38100700002)(26005)(82960400001)(186003)(6512007)(6486002)(6506007)(86362001)(66476007)(66556008)(66946007)(8676002)(4326008)(41300700001)(6666004)(2906002)(8936002)(6862004)(316002)(6636002)(5660300002)(478600001)(44832011)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l21D2Lc8DdJJlATL3fJDspRwJISuldKGQCLe3J3DPGhpcLk4naFdfjBY2XP3?=
 =?us-ascii?Q?FYpfo7XvHKgKFn1xMczSfR4WVCFhXi5ZKbpZ7yW04k5wQG4++PWxff6xpWyO?=
 =?us-ascii?Q?IVWsBRd07ScyYZ3GSfYEFh6WiqI68Q/0UZX7j9T3SyK0P6ZMollzc4dybmzh?=
 =?us-ascii?Q?FGidRP8gDBztLojGCt6rIaV3ctEWaP5IDygiekcelZxCx91br/BonLZuCeqK?=
 =?us-ascii?Q?kaX2gwo+q/q5V7VFZRnHO506FXTvTbwWp8VbqSVVUcSUOzEtnGus9nqxvVho?=
 =?us-ascii?Q?DWI53QnJlw3RbtGxpfBw7koSTtaPMXZ8lKJbbKWjSrAVRbOmuVeZ1O8fs5o3?=
 =?us-ascii?Q?/wu42xHMuZKVj7DqwTMpBVpMAm9ovUOCyWoIGIGmfjQBNBF/Mb3unfmwf35+?=
 =?us-ascii?Q?Uh1MZHVvdSgljI9Ds8rnsNLPVxAT4oSoMKjWZzmVUvAEOhSsICXyvDKDP70B?=
 =?us-ascii?Q?Z4mpazeijdv0stbfA3Z3INlbz9a0TuAf8IFmHwh8YDQTWoMbytgRpn0I4ghK?=
 =?us-ascii?Q?Yd2b2NslGfv6WWMlmHTHpx4Hbkpx5S9OJyvruPrVNq7SnB0vKSryXmx7quFE?=
 =?us-ascii?Q?1F5cIkVCO71GZDX6eTsyt9sIEt1M5flSjhs8BrNSYXAxAstsHWmQzRAlB6k2?=
 =?us-ascii?Q?8cpyqth48JGY1xDCl/28zpUaa/8wnEVfJXbQYDoO7F1/BilP2n5BuPE5Yxx6?=
 =?us-ascii?Q?OO9GabAilJMhm+QY7ICRLHBghov5Kj0BR9/SeNNaQ7rR4cOMIndvbAJjRPXR?=
 =?us-ascii?Q?lRLKkTXxkXHXUfhNZfElyLq5Dz1gf4p2UecgVepxjNIUFmmev9bII85X3hz3?=
 =?us-ascii?Q?Q7KJla/VZCILheWjX4J0eBayg+yBIG0ttNSpx8sPmfWi7Axya9fg5JGmSvg8?=
 =?us-ascii?Q?V/u6w4U0l28Pd+4th09ozl7s4/r+n4oyOk7NQFj6rlGlpimGL1OzuT2ZtSR+?=
 =?us-ascii?Q?1IpaJ0WZgqp+ciPbqVj8PvOGCEdvKTR1lcXpTqQN+qeEV5rQzYboGWj7YLuF?=
 =?us-ascii?Q?62lrqhVr/4JO7uLEcFOzBMjVMBzIMTCvW8ObZUHhR6vH2YyAoOA1dSC1fhfn?=
 =?us-ascii?Q?rnoIoNLlSs6OX0uqFvpWtT4yjNnMCBSG1uZkR1w1ewbcE5x1+a1zTXG3Yz2/?=
 =?us-ascii?Q?H82/gRQMbIoku0ffOBmLLge9Lj/Fe//r1PSfR6IcW0at+gIuFudxEO0AaZtY?=
 =?us-ascii?Q?w7z3RV3nTqj6x0/xs0C7OrpEos0UmlKziVlAfDtnYqmUqIlW3sUQKEiX2tae?=
 =?us-ascii?Q?6vy5/h4D7HHuZDptfqZ3ftCVlMHmDSpj4Z1KDfbPU1YlKOKcRxmephuytL2q?=
 =?us-ascii?Q?El/5NzFXj24zU7Y/1Cx3yZL8yJFZkv7mBnxVzBKuEFYkTXMw9Su8Nncjgfxz?=
 =?us-ascii?Q?ZcIJwtk1mH3rH1GoJgctzJpgm0mGJfQrVRJ8HwYqRPxIG895e75/hZOlo495?=
 =?us-ascii?Q?H7//sxX+iA/QNbm7k76Kf8H4hQmW+LZHcrroNe40CvCowuUPbNjWjmYOQztH?=
 =?us-ascii?Q?t9a6C4hQUb1mSF0TxdXSeTz1Aup5qZBapJXUiZKYlz7FqM8ImrVzvEW4nChg?=
 =?us-ascii?Q?+yvPNhbpWoIXCwBk7eBDHUgABdhAEHFXWFT5Y7nWokwvr7eoL1S2jGTUZoVU?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a82f9a36-fd26-40bf-9ab2-08da602c53c3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 15:21:13.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBPbAR9afD/UrmnNd0DWtuOYAoTuxlVAr/wrt9aXnyFZveHAt0EEjyrg96V9+43E5H9emWb/AqARhvDlzunG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:43:33PM +0300, Alexander Usyskin wrote:
> Add slow_fw flag to the mei auxiliary device info
> to inform the mei driver about slow underlying firmware.
> Such firmware will require to use larger operation timeouts.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> ---
>  include/linux/mei_aux.h | 1 +

This patch has a wrong subject since it doesn't touch i915.

>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> index 587f25128848..a29f4064b9c0 100644
> --- a/include/linux/mei_aux.h
> +++ b/include/linux/mei_aux.h
> @@ -11,6 +11,7 @@ struct mei_aux_device {
>  	struct auxiliary_device aux_dev;
>  	int irq;
>  	struct resource bar;
> +	bool slow_fw;
>  };
>  
>  #define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
> -- 
> 2.34.1
> 
