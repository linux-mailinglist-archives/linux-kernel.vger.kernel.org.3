Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B68570C37
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiGKUzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiGKUzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:55:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A15C35F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0630AB8112C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA3C341C0;
        Mon, 11 Jul 2022 20:55:33 +0000 (UTC)
Date:   Mon, 11 Jul 2022 16:55:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] trace: atomic64_read(&ioc->vtime_rate) is assigned an
 extra semicolon
Message-ID: <20220711165532.10476a0b@gandalf.local.home>
In-Reply-To: <20220629030013.10362-1-kunyu@nfschina.com>
References: <20220629030013.10362-1-kunyu@nfschina.com>
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

Jens,

Want to take this one? Or I can if you don't.

-- Steve


On Wed, 29 Jun 2022 11:00:13 +0800
Li kunyu <kunyu@nfschina.com> wrote:

> I think this semicolon could be deleted.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  include/trace/events/iocost.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
> index e282ce02fa2d..6d1626e7a4ce 100644
> --- a/include/trace/events/iocost.h
> +++ b/include/trace/events/iocost.h
> @@ -160,7 +160,7 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
>  
>  	TP_fast_assign(
>  		__assign_str(devname, ioc_name(ioc));
> -		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
> +		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
>  		__entry->new_vrate = new_vrate;
>  		__entry->busy_level = ioc->busy_level;
>  		__entry->read_missed_ppm = missed_ppm[READ];

