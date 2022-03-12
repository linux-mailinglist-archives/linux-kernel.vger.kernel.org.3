Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1FC4D6FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiCLPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiCLPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:16:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC21318C0F0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:15:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7519660FD1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF54C340EC;
        Sat, 12 Mar 2022 15:15:26 +0000 (UTC)
Date:   Sat, 12 Mar 2022 10:15:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-ID: <20220312101524.5d23c258@rorschach.local.home>
In-Reply-To: <20220312155358.d6bc78866f4ca31e9a37e23a@kernel.org>
References: <20220307184011.GA2570@pswork>
        <20220308163600.3109f19854c7b051924f262b@kernel.org>
        <20220308174829.GA2471@pswork>
        <20220309170124.82dcfadbcda6f8ab6ed51797@kernel.org>
        <20220309190651.GA3735@pswork>
        <20220312155358.d6bc78866f4ca31e9a37e23a@kernel.org>
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

On Sat, 12 Mar 2022 15:53:58 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> OK, please try below patch. You can embed your bootconfig in the kernel via
> CONFIG_EMBED_BOOT_CONFIG_FILE.
> 
> 
> >From 7478a8fbfe4669ee61fcb12b85b36d7e36f992ba Mon Sep 17 00:00:00 2001  
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Sat, 12 Mar 2022 14:59:30 +0900
> Subject: [PATCH] bootconfig: Support embedding a bootconfig file in kernel

I'm going to try this out, because there was a few times I could have
used this.

Thanks Masami!

-- Steve
