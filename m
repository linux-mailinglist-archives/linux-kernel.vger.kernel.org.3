Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EA650F77F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbiDZJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345731AbiDZIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:47:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71E939C4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650962262; x=1682498262;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ONb1+pbjsyN5bPS7QVDkoCEdqnxPTHDoI4mJoSKiDE4=;
  b=ffaFs7LanfozTwJmHsyFDX5OYUWtZ705r4BwxCLvFXnZIWzQX03H0/w3
   zXYWYtOALafClzLRY3xsg07ct47IZ0ahtmAb+0O2IUgzJCPkHozthEqSf
   LJWu/sslIf8NTtgJcGl3AU/V5sdMgh04eTmsPvUJURetpsouQTefv5xts
   kAGuufdXhgyB610GL6kch8wLqvOqX5sLJkP2tFPb0pQ0ymUdsAS98ufTg
   1fskmnbgoqDLuFcK9tqgj+5fMyn2tFC7Ry43ok3GYHw49sHH01rUf2UQ4
   AeTaWodEboKAISfE/Y3CYRCdFDePZDyrNHgTia7gURjLD+0laVBQ6+YaR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="263093173"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="263093173"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:37:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="532551364"
Received: from vhlushch-mobl.ger.corp.intel.com (HELO localhost) ([10.249.132.136])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:37:36 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PULL] gvt-next
In-Reply-To: <c5cf6773-e7a2-8ba8-4cde-0bb14007bc6b@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <c5cf6773-e7a2-8ba8-4cde-0bb14007bc6b@intel.com>
Date:   Tue, 26 Apr 2022 11:37:34 +0300
Message-ID: <87zgk8tf3l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022, "Wang, Zhi A" <zhi.a.wang@intel.com> wrote:
> Hi folks:
>
> Here is the pull of gvt-next which fixs the compilation error when i915 debug
> is open after the GVT-g refactor patches.
>
> Thanks so much for the efforts.

Pulled, thanks.

BR,
Jani.

>
> Thanks,
> Zhi.
>
> The following changes since commit 2917f53113be3b7a0f374e02cebe6d6b749366b5:
>
>   vfio/mdev: Remove mdev drvdata (2022-04-21 07:36:56 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/intel/gvt-linux tags/gvt-next-2022-04-26
>
> for you to fetch changes up to 2da299cee780ea797b3f72558687868072cf5eb5:
>
>   drm/i915/gvt: Add missing export of symbols. (2022-04-25 18:03:04 -0400)
>
> ----------------------------------------------------------------
> gvt-next-2022-04-26
>
> - Add two missing exports of symbols when i915 debug is enabled.
>
> ----------------------------------------------------------------
> Zhi Wang (1):
>       drm/i915/gvt: Add missing export of symbols.
>
>  drivers/gpu/drm/i915/intel_gvt.c | 2 ++
>  1 file changed, 2 insertions(+)

-- 
Jani Nikula, Intel Open Source Graphics Center
