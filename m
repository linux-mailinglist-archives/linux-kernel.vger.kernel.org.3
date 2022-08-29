Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC85A4C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiH2Mun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiH2MuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:50:19 -0400
Received: from outbound-smtp31.blacknight.com (outbound-smtp31.blacknight.com [81.17.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20141835F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:36:45 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 67F24C0DDE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:36:44 +0100 (IST)
Received: (qmail 2562 invoked from network); 29 Aug 2022 12:36:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Aug 2022 12:36:44 -0000
Date:   Mon, 29 Aug 2022 13:36:39 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] sched/fair: remove redundant check in select_idle_smt
Message-ID: <20220829123639.orhg3swn72u457zd@techsingularity.net>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-4-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220712082036.5130-4-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:20:34PM +0800, Abel Wu wrote:
> If two cpus share LLC cache, then the two cores they belong to
> are also in the same LLC domain.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Reviewed-by: Josh Don <joshdon@google.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
