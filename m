Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61353ACB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbiFASX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFASXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:23:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA25A501B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 005F6B81B73
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E66C385B8;
        Wed,  1 Jun 2022 18:23:46 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     mark.rutland@arm.com, rostedt@goodmis.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        lkp@intel.com, kbuild-all@lists.01.org
Subject: Re: [PATCH] ftrace/fgraph: fix increased missing-prototypes warnings
Date:   Wed,  1 Jun 2022 19:23:44 +0100
Message-Id: <165410781675.2447468.10949115313631969215.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506032737.23375-1-zhouchengming@bytedance.com>
References: <20220506032737.23375-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 11:27:37 +0800, Chengming Zhou wrote:
> After commit e999995c84c3 ("ftrace: cleanup ftrace_graph_caller enable
> and disable") merged into the linux-next tree, the kernel test robot
> (lkp@intel.com) has send out report that there are increased missing-prototypes
> warnings caused by that commit.
> 
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 \
> 	O=build_dir ARCH=sh SHELL=/bin/bash kernel/trace/
> warning: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
> warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] ftrace/fgraph: fix increased missing-prototypes warnings
      https://git.kernel.org/arm64/c/ff979b2a9d97

-- 
Catalin

