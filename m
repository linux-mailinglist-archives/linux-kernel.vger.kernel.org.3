Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3960D485114
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbiAEKWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiAEKWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:22:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F28C061761;
        Wed,  5 Jan 2022 02:22:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C74616A5;
        Wed,  5 Jan 2022 10:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24275C36AEB;
        Wed,  5 Jan 2022 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641378120;
        bh=mW06j2hxqFMqXudDRRj2DVrggQagAxJIuH+yqgiM7vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1+vCUS6bLmpXKKoQMLDZ7GGaR+wjagLgJ9xV4ol3E9sDRhgun/zHnllkE05mhajs
         d2UQa3ylja+/6F9esRM7J5XwqdocZebzNXXM00Wv28W7g4KX30+k7s7yGvtSk+zH9T
         QIlmvES1D3nW/xL4sdvCwpKSgSY6LM0c8Xlbqt2k=
Date:   Wed, 5 Jan 2022 11:21:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Check for null pointer after calling
 kmemdup in icm_handle_event
Message-ID: <YdVxRewPaS2MqqaO@kroah.com>
References: <20220105082634.2410596-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105082634.2410596-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 04:26:34PM +0800, Jiasheng Jiang wrote:
> As the possible failure of the allocation, kmemdup() may return NULL
> pointer.
> Like alloc_switch(), it might be better to check it.
> Therefore, icm_handle_event() should also check the return value of
> kmemdup().
> If fails, just free 'n' and directly return is enough, same as the way
> to handle the failure of kmalloc().

I can not understand this changelog text at all, sorry.  Please read the
documentation for how to write a good changelog text.

And most importantly, how did you test this change?

thanks,

greg k-h
