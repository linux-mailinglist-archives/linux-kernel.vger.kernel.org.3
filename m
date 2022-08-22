Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0AF59BF62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiHVMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiHVMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF666177;
        Mon, 22 Aug 2022 05:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC686112F;
        Mon, 22 Aug 2022 12:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD6C433D6;
        Mon, 22 Aug 2022 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661170698;
        bh=XFUaG+OdF42ahHuoyaxoXrWbqONRNSgJLOvnAojCSro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/fqAf99ZA0xT0XJsyFC8OFOe2StPNMI8ydOFiWIYt0CocuQ2mPDK6nJNS3+aLtFi
         psVKfxlMSMVJHoVdgCaTiYVLwRSYTpb+R95LNrgRQuG2d7XbegW2a+zUP9iQwKuGUQ
         9VTXnVTs1n2WOyzIPfHZ29G+OWMVhqwkikZPU5A4=
Date:   Mon, 22 Aug 2022 14:18:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     jirislaby@kernel.org, jason.wessel@windriver.com,
        daniel.thompson@linaro.org, dianders@chromium.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH] tty/seria: fix repeated words in comments
Message-ID: <YwN0B+CgNj6j6q6y@kroah.com>
References: <20220822120633.16753-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822120633.16753-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 08:06:33PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'as'.
>  Delete the redundant word 'the'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Your subject line is incorrect :(

Again, post a patch series, not a random set of patches with all the
same subject line, not reflecting what file you are touching.

I would recommend learning how the development process works first by
contributing to drivers/staging/ and not going out of that area until
you have some experience and know how to do this correctly.

good luck!

greg k-h
