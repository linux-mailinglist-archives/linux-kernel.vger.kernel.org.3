Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F223C4AE768
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiBIDDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359805AbiBICyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:54:00 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41BC0613CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:53:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c3so1017579pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 18:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3uOgLe/RVQ0Vs20wfvHEbpezYoxPnv0Gf+KP4+9Watg=;
        b=HCh/v6d1iQTxKf/TmU0YnImgzK9mb60Zao0AqsI53+ExsYAnUw0cOdNCowVxQvP38A
         xXq9TonHkNwdZJSC8OGZJtrn5SQ/04GBMcX79l4H6r57jaYSUO/rXOk5vIzz1WnanOcE
         YoxVQKXTUa9Eulq85GwqXOoTo1mDpuULbp5EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3uOgLe/RVQ0Vs20wfvHEbpezYoxPnv0Gf+KP4+9Watg=;
        b=mjgypOXvMBA0c36+2/wOf0bX7+MNNHpNKUN/qFtV4dP16n7urv8D8v4FOi/5oh+3ky
         Lvi1G0CH57hiQFhF9MCCYSqk7O2Dr+3wuZ7jRxcDSOJkuvgAu8LskYyTMdggPfoEIX0r
         XzwVhUK6TcfG+U5R8FOULVLQ/NKAw1HDmI+azYbvqdthAVP5CGCPy4uQp9aFNqacbygp
         memQVe+Louwgy5DYYpdkTp0kR9OEmlNS5KibUxFrBlKQ9f1RvGXChSbsfAzkCFQ7jrse
         Q+Xm/28AT4a9Jg4HoH/8QfngdJcRttwgJPqaJ6OIt1d0XVKXvtgewID7M08V4Kxh4S7e
         4sTQ==
X-Gm-Message-State: AOAM533ZFlwoeYvC5LioR1P3Lep9W813FptJsZvlrWDS3H8n9A2257qS
        GDJbEIOkIBlxFuFi1WoNSolwE+FQy+Dx9A==
X-Google-Smtp-Source: ABdhPJy5PzatkkErIC2tiNV2a6nOTPpNdrpLG5LJn92XJLQonky4qxwZ0slr4Qo5CdpmtWQElk+MsA==
X-Received: by 2002:a17:903:24f:: with SMTP id j15mr126492plh.16.1644375239308;
        Tue, 08 Feb 2022 18:53:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s10sm17930181pfu.186.2022.02.08.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:53:58 -0800 (PST)
Date:   Tue, 8 Feb 2022 18:53:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] MIPS: Malta: Enable BLK_DEV_INITRD
Message-ID: <202202081853.B4C45735@keescook>
References: <20220208191726.1304731-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208191726.1304731-1-nathan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 12:17:26PM -0700, Nathan Chancellor wrote:
> This configuration is useful for boot testing malta_defconfig in QEMU
> with just a simple cpio initrd, instead of a full ext4 rootfs.
> 
> This results in an increase of ~164KB of vmlinux (with GCC 11.2.0):
> 
> $ diskus vmlinux.before
> 11.19 MB (11,194,368 bytes)
> 
> $ diskus vmlinux.after
> 11.36 MB (11,358,208 bytes)
> 
> This size increase comes from the fact that usr/Kconfig is sourced when
> CONFIG_BLK_DEV_INITRD is enabled, which defaults to supporting several
> decompression algorithms for compressed initrds. This seems like a
> reasonable tradeoff but these configurations could be disabled in the
> future if there are complaints about the size increase.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I'm all for having a regular way to test all defconfigs. So, FWIW:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/configs/malta_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
> index 3321bb576944..3456ac8ded6c 100644
> --- a/arch/mips/configs/malta_defconfig
> +++ b/arch/mips/configs/malta_defconfig
> @@ -4,6 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_LOG_BUF_SHIFT=15
>  CONFIG_NAMESPACES=y
>  CONFIG_RELAY=y
> +CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_SLAB=y
> 
> base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
> -- 
> 2.35.1
> 

-- 
Kees Cook
