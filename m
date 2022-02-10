Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE04B06B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiBJGye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:54:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiBJGyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:54:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B0D95
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC37261CF4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5E3C004E1;
        Thu, 10 Feb 2022 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644476072;
        bh=DhUQV8COkLoX5QbWCqlM8fUQmYHjxuccXfoupZIDKbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2XOzLuKl8Eygkfa4Gl7rzNLNs0U2YlFHJdn1RweW6Vm6lA3df/gIh8QBsS0bLBKxR
         6SX14NBduMYuXQ//N7bd8ThInMEYqCaCQAFX1Li+sVurrJagh8hC9Ts0BamDDCgXHf
         XGG0abg2gUcMsnzyfV1B7ideh/Zp9XJKnxMvk/Bs=
Date:   Thu, 10 Feb 2022 07:54:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leonardo Araujo <leonardo.aa88@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: core: Comparisons should place the
 constant on the right side of the test
Message-ID: <YgS2o75JuAfD2HK7@kroah.com>
References: <20220209202015.29156-1-leonardo.aa88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209202015.29156-1-leonardo.aa88@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 05:20:15PM -0300, Leonardo Araujo wrote:
> This patch fixes the following checkpatch.pl warning:
> 
> WARNING: Comparisons should place the constant on the right side of the test
> 
> Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Also you need to properly cc: the relevant maintainers, as
get_maintainer.pl will show you.

I have dropped all of your pending patches from my queue.  Please fix
them up and send a patch series.

thanks,

greg k-h
