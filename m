Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478164A3E96
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbiAaI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiAaI3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:29:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B476AC061714;
        Mon, 31 Jan 2022 00:29:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62BD7612B9;
        Mon, 31 Jan 2022 08:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A37EC340E8;
        Mon, 31 Jan 2022 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643617740;
        bh=XCWdqulN3JL9ysh10FOnVn5HdCs77p5Ov7H5JSc8yvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wxhvnybhc0JI1J0SyAPg4ruKf6y5TZAIS/zd6vt+qpA2E854XnX6+pKGHVILivyxr
         5zYhKxS/f1pSIYQGLoRKRmotVH6Ic4BCxEOvh4bQ56jrsvkBkC1Kd90kpT5vhPDez+
         FXrXl22k4mAAprxS5K4Ly0fncavyHfdvMCxlecMI=
Date:   Sun, 30 Jan 2022 20:35:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, liuhangbin@gmail.com, lucien.xin@gmail.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "ping: fix the sk_bound_dev_if match in ping_lookup" has
 been added to the 4.4-stable tree
Message-ID: <Yfbona3a6us2jupN@kroah.com>
References: <1643570456126145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643570456126145@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 08:20:56PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     ping: fix the sk_bound_dev_if match in ping_lookup
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ping-fix-the-sk_bound_dev_if-match-in-ping_lookup.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Sorry, no, it fails to build here and on 4.9.
