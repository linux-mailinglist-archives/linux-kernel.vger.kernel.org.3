Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5853B532FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiEXR34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiEXR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:29:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5617CDE2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2F7CCE1A8C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC65C34100;
        Tue, 24 May 2022 17:29:48 +0000 (UTC)
Date:   Tue, 24 May 2022 13:29:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Use strim() to remove whitespace instead of
 doing it manually
Message-ID: <20220524132947.03582de5@gandalf.local.home>
In-Reply-To: <20220121095623.1826679-1-ytcoode@gmail.com>
References: <20220121095623.1826679-1-ytcoode@gmail.com>
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

On Fri, 21 Jan 2022 09:56:23 +0000
Yuntao Wang <ytcoode@gmail.com> wrote:

> The tracing_set_trace_write() function just removes the trailing whitespace
> from the user supplied tracer name, but the leading whitespace should also
> be removed.
> 
> In addition, if the user supplied tracer name contains only a few
> whitespace characters, the first one will not be removed using the current
> method, which results it a single whitespace character left in the buf.
> 
> To fix all of these issues, we use strim() to correctly remove both the
> leading and trailing whitespace.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>

Added to my queue.

Thanks,

-- Steve
