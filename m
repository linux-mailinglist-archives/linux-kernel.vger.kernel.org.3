Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378AE571EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiGLPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGLPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:20:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49650BFAE8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D41FB819B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3C5C3411C;
        Tue, 12 Jul 2022 15:17:31 +0000 (UTC)
Date:   Tue, 12 Jul 2022 11:17:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        zhaohui.shi@horizon.ai
Subject: Re: [PATCH v6 2/2] sched/rt: Trying to push current task when
 target disable migrating
Message-ID: <20220712111730.50f4a758@gandalf.local.home>
In-Reply-To: <20220712150506.632304-2-schspa@gmail.com>
References: <20220712150506.632304-1-schspa@gmail.com>
        <20220712150506.632304-2-schspa@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 23:05:06 +0800
Schspa Shi <schspa@gmail.com> wrote:

> When the task to push disable migration, retry to push the current
> running task on this CPU away, instead doing nothing for this migrate
> disabled task.
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
