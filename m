Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1F53F98E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiFGJYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbiFGJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:24:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B4C4F9C8;
        Tue,  7 Jun 2022 02:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A55FB81DA6;
        Tue,  7 Jun 2022 09:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7274C385A5;
        Tue,  7 Jun 2022 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654593845;
        bh=DdNFbVgj+RerkJzb/e0YuyvLEVDENII8I/0PFtZOPtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2EJCwNMFvohw2zeZUDxHA/u6HOOzIVka5AmAScjO0LSy5pz7vB8LmRFFAU6jZI7/l
         rBKrrstYNqZ5eOhUA+LKrxh3IgkIDOCPwgtojw8N1kSMKh2iZEr+MYDEackD8IRu7g
         o/rRqICu6IrcvIhhmbDwapfuda7ixiPkhF8mCsOY=
Date:   Tue, 7 Jun 2022 11:24:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, stable-commits@vger.kernel.org
Subject: Re: Patch "Revert "random: use static branch for crng_ready()"" has
 been added to the 4.14-stable tree
Message-ID: <Yp8ZMJ/X2b2OmQXi@kroah.com>
References: <20220607084005.666059-1-Jason@zx2c4.com>
 <165459326824547@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165459326824547@kroah.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:14:28AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     Revert "random: use static branch for crng_ready()"
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      revert-random-use-static-branch-for-crng_ready.patch
> and it can be found in the queue-4.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Oops, nope, it didn't apply here, sorry, scripts went crazy for a
minute...

greg k-h
