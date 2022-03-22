Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4733E4E424D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiCVOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiCVOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB658565D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C27E9616D7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD113C340EC;
        Tue, 22 Mar 2022 14:49:57 +0000 (UTC)
Date:   Tue, 22 Mar 2022 10:49:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mark.rutland@arm.com, mingo@redhat.com, tglx@linutronix.de,
        catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, broonie@kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com
Subject: Re: [External] Re: [PATCH v3 3/3] arm64/ftrace: Make function graph
 use ftrace directly
Message-ID: <20220322104956.42203163@gandalf.local.home>
In-Reply-To: <7807fc23-c6c9-b6a9-62ef-e34e8beefdea@bytedance.com>
References: <20220224093251.49971-1-zhouchengming@bytedance.com>
        <20220224093251.49971-3-zhouchengming@bytedance.com>
        <c8b7508b-ce2a-c7dc-92c4-ca5f17992844@bytedance.com>
        <20220322094100.73dc3ad0@gandalf.local.home>
        <7807fc23-c6c9-b6a9-62ef-e34e8beefdea@bytedance.com>
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

On Tue, 22 Mar 2022 22:14:11 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> > You deleted ftrace_graph_caller above from entry-ftrace.S, if we can get
> > here with some options, wouldn't that break the build?  
> 
> The above ftrace_graph_caller deleted is only for CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> and I tried using a low gcc version that doesn't select HAVE_DYNAMIC_FTRACE_WITH_REGS,
> it can build success.

OK, I didn't look too deep into this.

I don't have an issue with this patch, but it needs to go through the arm64
tree.

-- Steve
