Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937C35A4C60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiH2Mu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiH2Mu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:50:27 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851B6567A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:37:05 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id A362EFAADE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:37:03 +0100 (IST)
Received: (qmail 11672 invoked from network); 29 Aug 2022 12:37:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Aug 2022 12:37:03 -0000
Date:   Mon, 29 Aug 2022 13:36:59 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/fair: avoid double search on same cpu
Message-ID: <20220829123659.xoeerauu72nrs7x4@techsingularity.net>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-5-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220712082036.5130-5-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:20:35PM +0800, Abel Wu wrote:
> The prev cpu is checked at the beginning of SIS, and it's unlikely
> to be idle before the second check in select_idle_smt(). So we'd
> better focus on its SMT siblings.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Reviewed-by: Josh Don <joshdon@google.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
