Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C159D143
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbiHWG0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbiHWG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AECE606B5;
        Mon, 22 Aug 2022 23:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA3226149A;
        Tue, 23 Aug 2022 06:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFF3C433D6;
        Tue, 23 Aug 2022 06:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661236007;
        bh=Q7vLxtIDKxtCXjU6HAkTItasd2FgQsnEtDJYozoQIoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zCplgUpBJItOrLKag+nd1ERhg0xJGMLHrUwt/VFLJgW4G/uuNwdm9o5MxCaIoMK0U
         44Asdtol9eu8vYb8Vd1Rip7D7P6Pwxvamp25bLd3kS5YOa16GXvrKXZGw0oJGwUa99
         ynyUKm7ZHyr5FIEssv8tSEp2KAQvNssBYDNFCisQ=
Date:   Tue, 23 Aug 2022 08:26:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christopher Carbone <chris.m.carbone@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: split multiple assignments to lines
Message-ID: <YwRzJN5yORAtq8md@kroah.com>
References: <YwQGaLoBHH9C0aXN@valhalla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwQGaLoBHH9C0aXN@valhalla>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 06:42:48PM -0400, Christopher Carbone wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: multiple assignmentst should be avoided
> 
> Signed-off-by: Christopher Carbone <chris.m.carbone@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index dbd1159a2ef0..6f4c31635cc4 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -386,7 +386,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
>  
>  	ret = lynxfb_set_color_offsets(info);
>  
> -	var->height = var->width = -1;
> +	var->height  = -1;

Odd spacing on this new line.  Did you run your change through
checkpatch?

Also, this is a new version of a previously-submitted patch, it needs to
be called "v2", and the changes you made from v1 listed below the ---
line, as the documentation asks you to do.

Please fix this up and submit a v3.

thanks,

greg k-h
