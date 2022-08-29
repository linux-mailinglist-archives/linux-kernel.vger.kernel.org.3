Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0555C5A4C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiH2MuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiH2MuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:50:03 -0400
Received: from outbound-smtp18.blacknight.com (outbound-smtp18.blacknight.com [46.22.139.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35622861CB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:36:17 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 4E44C1C3A74
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:36:16 +0100 (IST)
Received: (qmail 8212 invoked from network); 29 Aug 2022 12:36:16 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Aug 2022 12:36:16 -0000
Date:   Mon, 29 Aug 2022 13:36:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] sched/fair: default to false in test_idle_cores
Message-ID: <20220829123610.iooaxujglh2l43x6@techsingularity.net>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-3-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220712082036.5130-3-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:20:33PM +0800, Abel Wu wrote:
> It's uncertain whether idle cores exist or not if shared sched-
> domains are not ready, so returning "no idle cores" usually
> makes sense.
> 
> While __update_idle_core() is an exception, it checks status
> of this core and set to shared sched-domain if necessary. So
> the whole logic depends on the existence of sds, and can bail
> out early if !sds.
> 
> It's somehow a little tricky, and as Josh suggested that it
> should be transient while the domain isn't ready. So remove
> the self-defined default value to make things more clearer,
> while introduce little overhead in idle path.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Reviewed-by: Josh Don <joshdon@google.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
