Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36835477A9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 23:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiFKVSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 17:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiFKVSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 17:18:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2648B56383
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89D2DCE09B7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922ADC34116;
        Sat, 11 Jun 2022 21:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654982308;
        bh=f+BBbnadECTW48EghM2NBCLoC+C8btrrrPx6BzWAz50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H3FUnd0gCNjutWOiPTNkyMKqzKmTYUT0s2hVMNe038IWwO6TYoiSVC0NmSt2gR+eR
         F5JrUT+pm7ZOJqaUXU4oHQFWeSay6tvqFH1uWOi6WZK61176xaKXKdO/PvftO/dodn
         FIXU+gG/QKjmkBeCbmXevkWj4X12IZc3KeCft6vw=
Date:   Sat, 11 Jun 2022 14:18:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: kmem: make mem_cgroup_from_obj() vmalloc()-safe
Message-Id: <20220611141827.51d663b8285cac7d4789ef0f@linux-foundation.org>
In-Reply-To: <355332ef-838b-3847-5a95-de5017b0301d@openvz.org>
References: <20220610180310.1725111-1-roman.gushchin@linux.dev>
        <YqOJBy2kHRJj/uLB@carbon>
        <355332ef-838b-3847-5a95-de5017b0301d@openvz.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022 07:10:06 +0300 Vasily Averin <vvs@openvz.org> wrote:

> > this patch is supposed to fix boot issues on arm introduced by
> > the commit "net: set proper memcg for net_init hooks allocations".
> > 
> > But as no I don't see this commit in linux-next or any mm branches,
> > so I'm not sure if it's in stable or not. So I didn't add the Fixes
> > tag. If it isn't in stable yet, I'd just put the fix before the problematic
> > commit.
> 
> Roman,
> Andrew dropped "net: set proper memcg for net_init hooks allocations" few days ago,
> but I hope he will re-apply it again after your patch.

I did.  Thanks, all.
