Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC1520805
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiEIW6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiEIW6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376B22A2D0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 015DB60BC5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 22:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B47C385B3;
        Mon,  9 May 2022 22:54:49 +0000 (UTC)
Date:   Mon, 9 May 2022 18:54:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix possible crash in ftrace_free_ftrace_ops()
Message-ID: <20220509185447.0e2b6a39@gandalf.local.home>
In-Reply-To: <CAEr6+EC+Kg4AJ=BFxrOSQV+KHj5WSm=1FtYCAPrn1gFnZUk-fg@mail.gmail.com>
References: <20220508161827.1014186-1-xiehuan09@gmail.com>
        <CAEr6+EC+Kg4AJ=BFxrOSQV+KHj5WSm=1FtYCAPrn1gFnZUk-fg@mail.gmail.com>
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

On Mon, 9 May 2022 09:33:44 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> I am so sorry to bother you, this may be an invalid patch, kfree can
> return directly from null. ;-)

Yes, and so does free() in user space glibc.

-- Steve
