Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63827576C0F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiGPFnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGPFn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462642AFB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 22:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C757160A52
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 05:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51503C34114;
        Sat, 16 Jul 2022 05:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657950207;
        bh=BOL2j3rZb5NlREe/JvfciHFNTef891SKXDuu2MbGEtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDXx1SY/5YqjbotpBAADf/rXNbhzMpbzLXMdDeErpgGYtd94xf5rCalwUIiXVRUL5
         O0UVLuqYqIPFtCpS/0zN7ZkDOVE7euP7NYYjz3QgqJsrRoGwXIbRfPxgeP6JanFHb8
         RsTmLbd8XUryA46J1BEX9VQmsYzCrG2TgC6UsY38=
Date:   Sat, 16 Jul 2022 07:43:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: remove VR41XX related char driver
Message-ID: <YtJP+k5JBbqS5QgY@kroah.com>
References: <20220715142437.137411-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715142437.137411-1-tsbogend@alpha.franken.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 04:24:36PM +0200, Thomas Bogendoerfer wrote:
> Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> for MIPS VR41xx platform, so remove exclusive drivers for this
> platform, too.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  drivers/char/Kconfig  |   5 -
>  drivers/char/Makefile |   1 -
>  drivers/char/tb0219.c | 358 ------------------------------------------
>  3 files changed, 364 deletions(-)
>  delete mode 100644 drivers/char/tb0219.c

This does not apply to my tree, what tree did you make it against?
Nothing has touched the drivers/char/tb0219.c file in a very long time,
perhaps you might want to wait for this driver removal series until
after d3164e2f3b0a is merged into Linus's tree?

thanks,

greg k-h
