Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD23B4ADD60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381882AbiBHPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381833AbiBHPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:48:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD4C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE186164A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DDCC004E1;
        Tue,  8 Feb 2022 15:48:07 +0000 (UTC)
Date:   Tue, 8 Feb 2022 10:48:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jeff Xie <xiehuan09@gmail.com>, mingo@redhat.com,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20220208104806.5272f2ea@gandalf.local.home>
In-Reply-To: <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
        <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
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

On Tue, 8 Feb 2022 23:08:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Thanks for updating the series. I've tested the patches and confirmed
> the objtrace is working :)
> 
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for the series.

Thanks. Just to give you an update on my own workload.

I'm finishing my last week of on-boarding, and hopefully, I'll have more
time next week to look at more things upstream. And hopefully, I'll be able
to get to looking at this series then.

Cheers,

-- Steve
