Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AEA4E2092
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbiCUGU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiCUGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:20:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE964D6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 672CEB8110F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89980C340EE;
        Mon, 21 Mar 2022 06:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647843566;
        bh=8uoRtoKXCeCpNYXdmYccpDz6NOr/VtJy0AId3gFL7j4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szRDlN5MrIp79RTykQNrfoh8AnpekEdlHBB7DsWtc+IGxOwwKMmSKj58Rv5lZnLSn
         ri3CFP2XRBRHOV1ubq1r0N8BqhG+uRojcLIuZQB4ZNwleIPwMJkCRyAvQmk4FxbeAa
         4qKL08SF3UYyT2sUu6VAdYg6DP4rOaimzTPayOyo=
Date:   Mon, 21 Mar 2022 07:19:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: Re: [PATCH v8 2/2] drivers: ddcci: upstream DDCCI driver
Message-ID: <YjgY6ofchgfyI3VI@kroah.com>
References: <20220321031438.14762-1-yusisamerican@gmail.com>
 <20220321031438.14762-2-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321031438.14762-2-yusisamerican@gmail.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 08:14:38PM -0700, Yusuf Khan wrote:
> This patch upstreams the DDCCI driver by Christoph Grenz into
> the kernel. The original gitlab page is loacted at https://gitlab
> .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> 
> DDC/CI is a control protocol for monitor settings supported by most
> monitors since about 2005. A chardev and sysfs interface is provided.
> The seccond patch in this series provides a backlight driver using
> DDC/CI.
> 
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>
> ---
> v2: Fix typos.

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

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
