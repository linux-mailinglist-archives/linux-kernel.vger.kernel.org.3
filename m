Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5E4D6FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiCLPRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiCLPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:17:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0D1B401F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08EA960FD8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AF1C340EB;
        Sat, 12 Mar 2022 15:16:07 +0000 (UTC)
Date:   Sat, 12 Mar 2022 10:16:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-ID: <20220312101606.41a9fc64@rorschach.local.home>
In-Reply-To: <20220312101524.5d23c258@rorschach.local.home>
References: <20220307184011.GA2570@pswork>
        <20220308163600.3109f19854c7b051924f262b@kernel.org>
        <20220308174829.GA2471@pswork>
        <20220309170124.82dcfadbcda6f8ab6ed51797@kernel.org>
        <20220309190651.GA3735@pswork>
        <20220312155358.d6bc78866f4ca31e9a37e23a@kernel.org>
        <20220312101524.5d23c258@rorschach.local.home>
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

On Sat, 12 Mar 2022 10:15:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Mar 2022 15:53:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > OK, please try below patch. You can embed your bootconfig in the kernel via
> > CONFIG_EMBED_BOOT_CONFIG_FILE.
> > 
> >   
> > >From 7478a8fbfe4669ee61fcb12b85b36d7e36f992ba Mon Sep 17 00:00:00 2001    
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Sat, 12 Mar 2022 14:59:30 +0900
> > Subject: [PATCH] bootconfig: Support embedding a bootconfig file in kernel  
> 
> I'm going to try this out, because there was a few times I could have
> used this.
> 

Oh, and can you send this as a separate patch so that it triggers my
scripts?

Thanks,

-- Steve
