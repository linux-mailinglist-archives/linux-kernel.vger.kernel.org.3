Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B264EAC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiC2L3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbiC2L3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:29:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C61E95DC;
        Tue, 29 Mar 2022 04:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AAEEB81729;
        Tue, 29 Mar 2022 11:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F24C2BBE4;
        Tue, 29 Mar 2022 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648553241;
        bh=piwVVdYs2LHs80wP8h8ts08gX4ejhzvyQIEHQLYlrPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V13WDO7VGOrJpHQKL/UjGT5sy5JOWCtLm7IIOOjhIYfFvNfBsd8OOIfzbcxvPZZFE
         qxWIapAKDvIU8XJtqVD025UOxaFqDfmJySE3r6Dde2QpJyiiY58ufzmFTAhyVB4Kt8
         sAG1FA9XeYCArt3NTL5Xia1nZ1ohkg3q2qjk03IU=
Date:   Tue, 29 Mar 2022 13:27:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp,
        bvanassche@acm.org, cheng-jui.wang@mediatek.com,
        longman@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        peterz@infradead.org, stable-commits@vger.kernel.org
Subject: Re: Patch "locking/lockdep: Avoid potential access of invalid memory
 in lock_class" has been added to the 5.4-stable tree
Message-ID: <YkLtF5m86AVdUkwn@kroah.com>
References: <1648553018206182@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648553018206182@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:23:38PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     locking/lockdep: Avoid potential access of invalid memory in lock_class
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      locking-lockdep-avoid-potential-access-of-invalid-memory-in-lock_class.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Oops, nope, this breaks the build in 5.4.y.

Cheng-Jui, if you want this in 5.4.y, please provide a working backport.

thanks,

greg k-h
