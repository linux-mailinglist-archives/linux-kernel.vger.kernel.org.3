Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C504FC178
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiDKPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiDKPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:53:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB54DFE8;
        Mon, 11 Apr 2022 08:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E82FCB8112D;
        Mon, 11 Apr 2022 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AD3C385A4;
        Mon, 11 Apr 2022 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649692266;
        bh=1Urnl4ijqna1jFj9WFfDBiOsh1n0FMzKm03TQ5KGyws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y8n8BaqP4VbFWH0qurxbkoYPdA33gv83EpY7JHnReFvC1h35fPxnv9LAZtYRhRym7
         mqP4Cl5yWDDl3NP0YUFVke1LjruskTT5LDUgHr+PFYg0cLsUVntP0C05tN4xz3GiGv
         bfXzl3OBiITjfn9KNvKOaCExyWP7F7OBeprSbokg=
Date:   Mon, 11 Apr 2022 17:51:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, rostedt@goodmis.org, talumbau@chromium.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "sched/core: Fix forceidle balancing" has been added to
 the 5.16-stable tree
Message-ID: <YlROZ0MY6pSPvC2q@kroah.com>
References: <16496920121528@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16496920121528@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:46:52PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     sched/core: Fix forceidle balancing
> 
> to the 5.16-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      sched-core-fix-forceidle-balancing.patch
> and it can be found in the queue-5.16 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Oops, no, this breaks the build on 5.15.y and 5.16.y, so I'm dropping it
from those queues.

thanks,

greg k-h
