Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6DA55781B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiFWKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiFWKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:47:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335374B1E1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55BB1B81BF7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A597C3411B;
        Thu, 23 Jun 2022 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655981241;
        bh=2twmGbFjhEE910dyPuHx5o9RdSwIy2ho4kre3nVoo2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRkSghKzbTsd7Y/F7letXdNHTMDWpiSYAWRESJktQuV+QXJ5urLkavnDxFxp5+Rmc
         kPbKoQ93y+tTaRJ1hlYY53KQBbtVwHs2I+7IvZcvrZaGBZBkD757bAbuMBOZ/EwMYA
         TtwlBsLczcunuwsaTRmZ4KiTIoReEatxIcRt3xc8=
Date:   Thu, 23 Jun 2022 12:47:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Staging: rtl8192e: Safer allocation and cleaner
 error handling
Message-ID: <YrREqyGC01YIB86o@kroah.com>
References: <AM9P190MB1299A41E3A9B2F9C0916A260A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P190MB1299A41E3A9B2F9C0916A260A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 12:05:54PM +0200, Felix Schlepper wrote:
> 
> v2:
>   - replaced kmalloc with kzalloc against memory initialization defects,
>     thus also removing a memset
>   - made error handling more consistent
> 
> v3:
>   - Split into smaller commits so that it's easier to review
> 
> v4:
>   - clearer commit messages
>   - added missing kfree
> 
> Felix Schlepper (3):
>   Staging: rtl8192e: Use struct_size
>   Staging: rtl8192e: Using kzalloc and delete memset
>   Staging: rtl8192e: Cleaning up error handling
> 
>  drivers/staging/rtl8192e/rtllib_tx.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> --
> 2.36.1
> 

Why is this not properly threaded with the patches itself?  Please
resend so that our tools will pick them all up correctly.

thanks,

greg k-h
