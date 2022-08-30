Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032A5A6212
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiH3Lgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiH3Lgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:36:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43771BD;
        Tue, 30 Aug 2022 04:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7396B81625;
        Tue, 30 Aug 2022 11:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE75C433D6;
        Tue, 30 Aug 2022 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661859210;
        bh=x37WWGK6ZK1GESVvhlxDTHmfP/06owgD+RlfqNBq3PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUruHVqQDrYlogvWcGXb9PTi+PMEhjcSgpjJXizVZmjyz7kfMC1NKGBTVPFgooCxw
         RroN4Ye87o+CWkh+Rjey96+2mAkgKSsct8dXSVHYZ7aW+BOnHd8LxDgQXEoEOSvQ+I
         aQYnmoIPYguJQYBvFpL72aKPrO0pPQxMKEK7TPfo=
Date:   Tue, 30 Aug 2022 13:33:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: icom: Fix some indentation
Message-ID: <Yw31h38pq9WZNmKM@kroah.com>
References: <037fc7510ff88945e3f0a5756de4cfd135c59849.1660565015.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037fc7510ff88945e3f0a5756de4cfd135c59849.1660565015.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 02:05:50PM +0200, Christophe JAILLET wrote:
> checkpatch and smatch report some code alignment issues.
> 
> So remove some unneeded leading spaces to fix the warnings.
> 
> While at it remove some {} around a single statement and convert some
> spaces into a tab.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/tty/serial/icom.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
