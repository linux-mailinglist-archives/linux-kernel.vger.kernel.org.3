Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D415A4C61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2MvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiH2Mus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:50:48 -0400
Received: from outbound-smtp22.blacknight.com (outbound-smtp22.blacknight.com [81.17.249.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD83A15A12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:37:27 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id D6847BAC22
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:37:25 +0100 (IST)
Received: (qmail 4968 invoked from network); 29 Aug 2022 12:37:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Aug 2022 12:37:25 -0000
Date:   Mon, 29 Aug 2022 13:37:21 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] sched/fair: remove useless check in select_idle_core
Message-ID: <20220829123721.5xnqfrpcbdafwmcd@techsingularity.net>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-6-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220712082036.5130-6-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:20:36PM +0800, Abel Wu wrote:
> The function only gets called when sds->has_idle_cores is true
> which can be possible only when sched_smt_present is enabled.
> This change also aligns select_idle_core with select_idle_smt
> that the caller do the check if necessary.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
