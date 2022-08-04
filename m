Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926F3589B28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiHDLlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbiHDLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:41:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451115A3C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:41:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CA66A37787;
        Thu,  4 Aug 2022 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659613291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUDd759nyfPHNNs6z4ky1y+mdVcSWImwhSAlY6MSN4A=;
        b=V17fhE6dyub9kEiUhCATJ5pjwPQxBilirWz8NSKJUl77hFxAzyt3mP9NjM+U9eqcKGHVz8
        X0PEu1Sg+o92AH6+xIdxXhOHDw44CuZWWAOzZbmaZn5dPTbGxV1/M52QdR1aLB8sqlTSgL
        O8/y2lj6euHpsWClmcaXTEztp2wto0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659613291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUDd759nyfPHNNs6z4ky1y+mdVcSWImwhSAlY6MSN4A=;
        b=xNoM3Zvo7P7AnKrxbt0miIN0IyIk+e3NIB7BydbdZQGaynh10pFXR83Oomb0si8o5+A+rB
        Yj1JDow3HzI4SQDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A04052C141;
        Thu,  4 Aug 2022 11:41:30 +0000 (UTC)
Date:   Thu, 4 Aug 2022 12:41:28 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] sched/fair: Remove unused parameter idle of
 _nohz_idle_balance()
Message-ID: <20220804114128.GH3493@suse.de>
References: <20220803130223.70419-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220803130223.70419-1-jiahao.os@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:02:23PM +0800, Hao Jia wrote:
> Commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")
> has been merged. The parameter idle of _nohz_idle_balance()
> is not used anymore so we can remove it.
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Mel Gorman <mgorman@suse.de>

Just note that with the merge window open, this may not be picked up
quickly and you may need to send a v3 when the merge window closes.

-- 
Mel Gorman
SUSE Labs
