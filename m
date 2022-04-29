Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7451545E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380261AbiD2TXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiD2TXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19280C74BA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9134624D1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380D9C385AF;
        Fri, 29 Apr 2022 19:19:54 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     rostedt@goodmis.org, mingo@redhat.com, tglx@linutronix.de,
        will@kernel.org, mark.rutland@arm.com,
        Chengming Zhou <zhouchengming@bytedance.com>, ardb@kernel.org,
        broonie@kernel.org, dave.hansen@linux.intel.com
Cc:     songmuchun@bytedance.com, linux-arm-kernel@lists.infradead.org,
        duanxiongchun@bytedance.com, zhengqi.arch@bytedance.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 1/2] ftrace: cleanup ftrace_graph_caller enable and disable
Date:   Fri, 29 Apr 2022 20:19:52 +0100
Message-Id: <165125998856.375450.16591731765661717766.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420160006.17880-1-zhouchengming@bytedance.com>
References: <20220420160006.17880-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 00:00:05 +0800, Chengming Zhou wrote:
> The ftrace_[enable,disable]_ftrace_graph_caller() are used to do
> special hooks for graph tracer, which are not needed on some ARCHs
> that use graph_ops:func function to install return_hooker.
> 
> So introduce the weak version in ftrace core code to cleanup
> in x86.
> 
> [...]

Applied to arm64 (for-next/ftrace), thanks!

[1/2] ftrace: cleanup ftrace_graph_caller enable and disable
      https://git.kernel.org/arm64/c/e999995c84c3
[2/2] arm64/ftrace: Make function graph use ftrace directly
      https://git.kernel.org/arm64/c/c4a0ebf87ceb

-- 
Catalin

