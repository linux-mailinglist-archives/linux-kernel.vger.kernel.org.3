Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6457D52FCD3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355000AbiEUNWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347867AbiEUNWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:22:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05B60075
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5DD72CE2817
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC733C385A5;
        Sat, 21 May 2022 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653139364;
        bh=aWo3a2H7LYTYOMCGEKVsCqEZ05aoIGdClx7ZrIixapI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baHBvrlPftLeN5g2fp0+azMY0rn2oED+jFZdTRXSdeYWATTrX1kJjRbJD47fQQPw7
         ppG+EDiIUJTYDZYfabWotJPA6dh0K3LzR6mlSalz3cQGGd6HmZ5E1sYKYbAno8azi1
         1GGhHPKvdIiiFEnUdCj1Pk3pHllWp7qA+4IbdojM=
Date:   Sat, 21 May 2022 15:22:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.19
Message-ID: <Yojnof1ekJg3yjwu@kroah.com>
References: <20220521115325.GA1965670@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521115325.GA1965670@ogabbay-vm-u20.habana-labs.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 02:53:25PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.19.
> We added a few minor features, such as support eventfd registration
> for device events, and the ability to scrub the device memory
> through debugfs. 
> 
> We did some refactoring such as adding a centralized memory
> manager inside the driver for allocating mmapable memory and tracking
> it, so we can remove different code paths that basically duplicated
> that functionality.
> 
> And, as usual, there are multiple bug fixes.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit cafada1fe932ce761d6c0bc1d56967e27abe4cff:
> 
>   Revert "speakup: Generate speakupmap.h automatically" (2022-05-20 21:07:05 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-05-21
> 
> for you to fetch changes up to 93f742b13260b070a695f44d6b6ff696cb5cbcd8:
> 
>   habanalabs: use separate structure info for each error collect data (2022-05-21 14:42:17 +0300)

Has this been in linux-next already?  It's _really_ late to be adding
new commits to my trees as 5.17 is about to come out in a few hours :(

greg k-h
