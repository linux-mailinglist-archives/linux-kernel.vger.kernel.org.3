Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D605144DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiD2Izf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiD2Ize (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:55:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6B96C42DD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:52:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8A7D1063;
        Fri, 29 Apr 2022 01:52:16 -0700 (PDT)
Received: from wubuntu (unknown [10.57.75.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853D73F73B;
        Fri, 29 Apr 2022 01:52:15 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:52:13 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Phil Auld <pauld@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove sched_trace_*() helper functions
Message-ID: <20220429085213.43wytbmn32m5ohlj@wubuntu>
References: <20220428144338.479094-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428144338.479094-1-qais.yousef@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC lkml

On 04/28/22 15:43, Qais Yousef wrote:
> This is a respin of the patches Dietmar sent a while ago
> 
> 	https://lore.kernel.org/all/20200907091717.26116-1-dietmar.eggemann@arm.com/
> 
> I moved the sched_tp module to use pahole + DWARF/BTF to get the definitions
> required so that we can maintain these helpers more easily out-of-tree within
> the module.
> 
> Thanks to my colleague Douglas Raillard for helping with fixing the alignment
> issues in pahole when using BTF.
> 
> 
> Dietmar Eggemann (2):
>   sched/fair: Remove sched_trace_*() helper functions
>   sched/fair: Remove cfs_rq_tg_path()
> 
>  include/linux/sched.h |  14 -----
>  kernel/sched/fair.c   | 117 ------------------------------------------
>  2 files changed, 131 deletions(-)
> 
> -- 
> 2.25.1
> 
