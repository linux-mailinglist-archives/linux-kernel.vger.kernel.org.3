Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA2E57691F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiGOVmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiGOVmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:42:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F787C1C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657921319; x=1689457319;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iIZd3knQDszKoLSZtijFXnjcvW8bgZj2uK5ZzVxysSo=;
  b=jZpLZcoWeCD5NJYMzpLXDUk4jQ38uv4JWxTFTfog0yYBF2+FmCctwA6U
   WCsoxiCIkUdvXhvhkjRJ+HkKb1VcJuP2a8Sqg+ouUSUeptTDVYaO3mlCo
   2WUSl6bJIbCYmCpFRs5wfV4bnB0aW8w4MOajgzBkW9hns4n4YKJ93TX5C
   uzgqhCPpj1JNe6SpmWxsQCWuBPWh2fU8G4r99di6E90QUNdNxEwMs05/F
   bb1DF+C6fO6GeFB57x6wv2smTdStv2FwfomT6wd4cI4elrDIuSPChSvqS
   +m35oPv+IhLDThEXboJKBr7ImgKLnUcxMxiHqSKL2Eev/3u78R9unQhVC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="349868371"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="349868371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="654513245"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2022 14:41:58 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 14:41:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Jul 2022 14:41:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Jul 2022 14:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqCIarpsL/sPuOsc+tEwunmJUmbJlw6tR3psl8o6MKOh3ZkQblB5oHwq1IJPOlDLIVFv7Zt1iM9eaHaEjrTOWSIi53Mcz6oVeasPHv5oiw/ahFq/0+hJa3YL8ULC2QZmSEtCLNttr+m8FP1je1tcx32061Q+3Szt+4zu+D8Ev0sVItU9VIVe6Tmrw5DDmh0KTM6glysB2wxUQOmwXVSqXOO723N+WiNyexnPfz/iD2WJPotMWjzn5tlfN0iLqdteq9/ArjApIYMIJoyBWn9lRkV7S9TBwTqnKC1jbzIQ4znYfhFPkLNaXmrCvqM/4nlgL3yEGer+8SIXfUOa6Z1tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMDW6Ys8GJFFyghjdhu+kBTO/2f/OvcjwaRJDX8cB+4=;
 b=b83I8KKV6Yu+PRTbBCKePKBLFVi1w9IaeBvRHSj6KN38qM2Iq9CHTnoP9Xrp4CVnq0TUDrCxJeciPuru27BiYZVtNmluCYWGsiZOuzYL2vKlb1jfztgAb101mJ1h8PWetK5dSfWhcdU7g2IVxa1DB3yHjmSvnmrFnqHPqotM+OzxpWyjXjQ6g6tQ0hZ7Fd12tL07cB7fy7/X34N/0+0JCCs97GFn8z0rPDIJMNcRYb1wCCWiAaCSV5S7E0n7woGVWYJVdXJL6MUC49MTMOktXyV40DzPLe2zbSdYOw/GJs1ZLi9Pz+ZovJKTT1LI2uAvAr89qOSxoAL1F/H7Dwswvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by MN2PR11MB3615.namprd11.prod.outlook.com (2603:10b6:208:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 21:41:55 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::8053:3c59:9f5d:b615]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::8053:3c59:9f5d:b615%9]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 21:41:55 +0000
Date:   Fri, 15 Jul 2022 17:41:51 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 23/39] drm/i915: dvo_ch7xxx.c: use SPDX header
Message-ID: <YtHfH9OEoVlSaHae@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
 <b033116e345deb3b0a86acb7cddded1d29f9629e.1657699522.git.mchehab@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b033116e345deb3b0a86acb7cddded1d29f9629e.1657699522.git.mchehab@kernel.org>
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f437f9-3fd8-4b55-b131-08da66aad668
X-MS-TrafficTypeDiagnostic: MN2PR11MB3615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9tUra0WVIEAWyy4Q997BYi+qkCWS/GUaN1yYcduLfOWFTk971AJ4eQ+jXOuCS1RbgmtJmH9Mpwbv0pPxZn4Gqgg8QOhSVyg55S+MyfJQ9fWMyV+2uuRM9vWGM4w6ooKmPxLXepdhmqtbqcxUH0WZLz7JllSjWbrS6NK84vkC2GDeLh8hKCBi8X1OtBoLVZiPZcG0e/YncD2IxZtd0eNKU4N0H4c0qi5YnG3YfHRx6l+oepIWB4uR0c5qRZm2DapW4O1G3hS6pkjgxAFnH6X7w1zsZ2CBr1xqm97sXjFabZ9G3P0EXGmr04DtYOfugRe32mdl/twqvs9ppBBl6NILDC/prXM3x6dGanFAdYzdsBcD1wWp1sFqPdLkbaYJuuPEN0oJ8R+Svijv/hVBD0qu4S1DrmJ6DjKUPjdUyErKNqsZ8iYit/2HaqiaJWEgokJZTo0UUdHNw3P6vdquJDY/it5WvrMdjK/EP0/z7qoyrO9023wF5GPGPV8wc1NCSEKd5WFJ5hpJkoGh5NKu4onoB0MU4flmydnMJELHlDUThvMG9DMbPkjuTuFkBSPL8rb83cL5Mu8g3j8sWDgLb68+UuEfCZl+rlO9bjCJRYrB1OKoO1bfM5H4ZyzOdjN4Cvms70OE6a6woj7tlzxt/7Zf6XsVIy6q/bqJ2lULqCXwHWhraBIcdyzooSA/vLKQeo4B5A3U9V1tacafB0Rg81zFAAmCUFxzSE+/BFLZG4h/acF7aq5QrG99NoDnYCV8PbdmzH06Fh4vqo/lL9MDYHLf0utNZDs0pRcNwG5dUoQEis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(376002)(136003)(396003)(5660300002)(2906002)(8936002)(44832011)(4326008)(66476007)(8676002)(66556008)(83380400001)(86362001)(36756003)(38100700002)(82960400001)(478600001)(6486002)(966005)(66946007)(316002)(54906003)(186003)(2616005)(6916009)(41300700001)(6506007)(26005)(6666004)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vbM6dWMq/x+rv8BMuYUbz8jjxVzZP0urKJ1ps+L9wyFhwXYQrEq6NMKwOd?=
 =?iso-8859-1?Q?N4h8zEhWCG1MANkcWfHMkez3qAo4qLbfRnJwL7wGgCif3i5TvHqdib4R3i?=
 =?iso-8859-1?Q?aR7PzTfNs6IBqsvVu60eqoA4Zh0AO8gY1Ei3b//sOYa2dvYGkY6wq9KgyO?=
 =?iso-8859-1?Q?YmGMXQmK1JWIU9thPMCaMpZkMQ1n4B54FpB8jgcME09bPM6YQWJh4WgdDR?=
 =?iso-8859-1?Q?7efssm60grhtezU3v6kZCZw3G1Z82Ug9C2ZiDYXuKDNGCyBtuoa/tlmRn2?=
 =?iso-8859-1?Q?OedW295sRzpdp3/5xxXdnwN0hYUuYcnqLYSvnzh/2s3Ve2n5EWjA/ER2+Q?=
 =?iso-8859-1?Q?VzyjJgwSxxp1y8ZXX/MQHGYwNU3rF8w2yujz0syYteoS45rIoslW6R/BOd?=
 =?iso-8859-1?Q?5eT7IhvQmdCLH1YUVn6YOkCwayuUvcv2dnBkOA2zV0X7geiHq1TkTOAzqm?=
 =?iso-8859-1?Q?kvXOk5osr4TXEEFfQfMEhY7EWCIDsSoLJwdkVD7d6yr/LeCR/vLUmMnLvx?=
 =?iso-8859-1?Q?O1Dd9GF52z+RlmnlsmP97ENMkiWIII33lK98BcLE79LXlCyl3ZQ2KpCbJh?=
 =?iso-8859-1?Q?6ZtOk2dUsg9PTJvjVkPZhjJIP3UbIOoU+AzlyiqyrF8BON2APn3AyZTEjy?=
 =?iso-8859-1?Q?mcsKrTyoMQbIvlZBOV1TyylFoCCu+sUy8/lUT+d1rK2UdPOJNCv22XuRPW?=
 =?iso-8859-1?Q?XLXeZ+/z/OkoylJ8VzCp7gbq7c0QLLwA0g36N3Z02MhkGhe/Kb645qYqMD?=
 =?iso-8859-1?Q?rC0+XScpI4oXwJEwo8VYfDzfO6ZEfKHyN/53KmGeYkrXJ16YkeOquIGNtJ?=
 =?iso-8859-1?Q?3NJRAYgHP1fEn5R7qvz7YtW7iJicJrFn/x4NXwLNuwbI0fLOZPGwY76YBE?=
 =?iso-8859-1?Q?yT0Vt34TeBtAOgRKUuk0lN0FuA613HkfeqcgWvA4AGLMAsTMTDiQRa8r+J?=
 =?iso-8859-1?Q?lmbJkLOR1NU5W5ioGmYfhpa/ibKPQ2Gjbh27sro13hQ0wEumISAOayg8o0?=
 =?iso-8859-1?Q?w+MsHqAIB4QMV2TPXcAS2ClNaoRZsQ+kffTsPxa02ZC7tHd/nenWMbK1Kl?=
 =?iso-8859-1?Q?6xbtV6wFf8sC0a40zwg6ju3Keh6w1K6DpHvUqDgpcXbw9+gCdAZaZ27Sp7?=
 =?iso-8859-1?Q?eU0iP3IbzH5d6nSBimIJZgPAV7c7UniLMMNqvbS4Oq0GogrokN6kKQqDrI?=
 =?iso-8859-1?Q?MAVUDpa0tJTA8JK6RLgKK9WRO5OHSKtmmktI/FEsrwQZqTz/2cNZh237Rk?=
 =?iso-8859-1?Q?L7sVwSO+B55Z66wCxGgZdecVSgbsacg5xwDvu1LB0Qlay0f1ZFXQ0U4i4c?=
 =?iso-8859-1?Q?aOh83Y19AMxEwm783mB3qgx4J35j3/qheySCgYkAviaZhZsahbYEsyK3Ci?=
 =?iso-8859-1?Q?5qJZ44djkPsYxD/gxN+x4f6B5iQ7ECa+q6qdaUbQ9TRuJ297Af8rKPyFC3?=
 =?iso-8859-1?Q?vtbMLxL0vTfFWyqhujxv8R7ELGXBt573dScvmcy3aojYe8EinKzOCe3Erq?=
 =?iso-8859-1?Q?ULFYDyAWmYDXt4hQYfQhcTKluNiOpxZ+LSEr1gRQhz1GkN+Xvcs8CUROEI?=
 =?iso-8859-1?Q?x0B/qdYUIarl+uNqeIfoRpFvGi/pHdQFEeVYCm9mj2q0K9IjnqjtgHxO92?=
 =?iso-8859-1?Q?WE/Xl+a689/TVlAQYb8WMXmiBohwgI3G8MhiW6Dr9EMiLlThnSbdKa8g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f437f9-3fd8-4b55-b131-08da66aad668
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 21:41:55.7754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b0fO9+DlLNgWs874XK2IK/YQJ1hlGvwDj3SgdHC+3LYIZPbw8B9UEeOwDRIr4VLbETwXVl3XHFZ/Jf06YU/RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:12:11AM +0100, Mauro Carvalho Chehab wrote:
> This file is licensed with MIT license. Change its license text
> to use SPDX.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/
> 
>  drivers/gpu/drm/i915/display/dvo_ch7xxx.c | 33 +++++------------------
>  1 file changed, 6 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/dvo_ch7xxx.c b/drivers/gpu/drm/i915/display/dvo_ch7xxx.c
> index 1c1fe1f29675..b4d94a565fdb 100644
> --- a/drivers/gpu/drm/i915/display/dvo_ch7xxx.c
> +++ b/drivers/gpu/drm/i915/display/dvo_ch7xxx.c
> @@ -1,30 +1,9 @@
> -/**************************************************************************
> -
> -Copyright © 2006 Dave Airlie
> -
> -All Rights Reserved.
> -
> -Permission is hereby granted, free of charge, to any person obtaining a
> -copy of this software and associated documentation files (the
> -"Software"), to deal in the Software without restriction, including
> -without limitation the rights to use, copy, modify, merge, publish,
> -distribute, sub license, and/or sell copies of the Software, and to
> -permit persons to whom the Software is furnished to do so, subject to
> -the following conditions:
> -
> -The above copyright notice and this permission notice (including the
> -next paragraph) shall be included in all copies or substantial portions
> -of the Software.
> -
> -THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> -OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> -MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
> -IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
> -ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
> -TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
> -SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> -
> -**************************************************************************/
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2006 Dave Airlie
> + *
> + * All Rights Reserved.
> + */
>  
>  #include "intel_display_types.h"
>  #include "intel_dvo_dev.h"
> -- 
> 2.36.1
> 
