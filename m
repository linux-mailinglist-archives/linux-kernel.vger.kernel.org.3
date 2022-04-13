Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9EF4FF6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiDMMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiDMMfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:35:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED72FFDF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649853206; x=1681389206;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uKXYId4oeyUvS0odSH7vXFddeDqo6s8dSY4Wdoinod0=;
  b=AOF1kidHPzFYx/8syaaS7RsZZKgJEbmOKC7pjkOdF8BU79DCnvuXvEJF
   3qb+C7U3HVkeSvl3haxXiuBBwoTRVKKsnC8uIye9XtbqccyNw+viW91SD
   cs5aTB+3RsQ6K5JUtrQNTldRUn5aBTd9X6FySIluq+sskA4ht3NVzJ/dK
   a46PcirwONmsGUcAC1eAnpNyVaHQlj+udQ1ryiAb7cxRDeD5uUQYQOH1d
   S15sqB9kELTFa7jt3AEgr11feXUX/9kbY+cV2JWz/DOZl63Nj6lDfc6LM
   F7wUyZouXQCAlnU7jSw6tQb9Z9tajtiC839/O4aOosOqieXPioh5AmqH8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261498799"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="261498799"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 05:33:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="552184164"
Received: from psoltysi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.149.160])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 05:33:21 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/34] drm/i915/gvt: cleanup the Makefile
In-Reply-To: <20220411165121.GA26801@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220411141403.86980-1-hch@lst.de>
 <20220411141403.86980-6-hch@lst.de> <20220411152508.GH2120790@nvidia.com>
 <87zgkrha7c.fsf@intel.com> <20220411165121.GA26801@lst.de>
Date:   Wed, 13 Apr 2022 15:33:20 +0300
Message-ID: <877d7tgo33.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Apr 11, 2022 at 07:11:03PM +0300, Jani Nikula wrote:
>> > Up to you but I usually sort these lists
>> 
>> Yeah, please do. Otherwise matches what I sent, so ack.
>
> Let's just merge your 2 patch series ASAP and I'll rebase on top of
> that.

I rebased them on top of current gvt-next and resent [1]. Zhenyu, Zhi,
please pick them up if you approve.

> What branch in drm-intel should I use as the base for the next version
> btw?  Or does gvt go through yet another tree?

It's yet another tree... Basically gvt is developed on top of gvt-next
(see MAINTAINERS) and Zhenyu and Zhi send pull requests for
drm-intel-next.


BR,
Jani.


[1] https://lore.kernel.org/all/cover.1649852517.git.jani.nikula@intel.com

-- 
Jani Nikula, Intel Open Source Graphics Center
