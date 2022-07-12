Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52A5718B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiGLLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGLLkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:40:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A41AB7DF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:40:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r9so9516680ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=btM9O32CpBgf9kJSlQ2/qg4sExAM4lqY12hcCyew4L4=;
        b=MSCNJZqcyi8mLKBEVZJlWmSCppOBNhhpRe7h6+H3HIUBdpTsEKsK8mE5lh50C9J1Lm
         nT3Sb3CrPfGsF7hhOqdObCgxyuf40G6SkLrrzycPIIWYXKQ/S0uMKOGEJ0WP85Jy2nzp
         KTxPhM0jb28DNnO4QCy4HOR3X5/TDpTaes+UCL5HTlPYxYsteyyGf6yq+kGfALyQWjct
         o6A/37JpMnq5+fbbpQWIxPRnyX8GOlFS4Gg/cHxvhfpq5fGc/JSG+g/aePLYU6JxTIdp
         FaB7vxwy79asmV3Ip80BF2VnDIVY8722PywUdxDhQR0Y7ueS5HfAc5SnSta2p4ozEqWr
         UNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=btM9O32CpBgf9kJSlQ2/qg4sExAM4lqY12hcCyew4L4=;
        b=D0Ao/Qf45mv+iez1CaIXKJ/bm3U4jzopYMi6+9DV9wPQyKnMCvtlqB7tlebMV1aJJY
         cOwGgb1PF9OMDrY3I6PcDVNI2S7wGyN3nivjUyjnHckmv7ZEmAL/mjdPuBKP64Fe1cbr
         gru5Y1ITyAagzuMlnYF3bBTLnwLKz8G2c6CjEPRFtfANdonmYbxo2HxuomSODF/qb0Cb
         VEMTWbxwksu2wSwibMyak6VLIvTRgfCcFAclwmhg5KUWEx2aKVZy2elBDj9HWFyMcRe4
         Jm0lAFdro9c7mKQ1FAzw+v98+A9masqTClzHgbcQBONBplyh5gre+b8ba4uqJRTJPNux
         6OSg==
X-Gm-Message-State: AJIora8JpY14Ph7gwHcmU0Z8eHrKL0eqmwyW7F+BMm5biZp7E//djxPP
        8Q9Cp0tx1XHwAkvDtoZVztM=
X-Google-Smtp-Source: AGRyM1uQru/cEAVmqTHTRN/afmY9LzWQVOeKtl+D8TNLyBugv3x8OQlAUpU8GfP7IvUNZtddlTr0Ag==
X-Received: by 2002:a05:651c:545:b0:25b:c791:816c with SMTP id q5-20020a05651c054500b0025bc791816cmr13015642ljp.161.1657626017605;
        Tue, 12 Jul 2022 04:40:17 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ee07000000b0047f7fc29169sm2135412lfb.223.2022.07.12.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:40:17 -0700 (PDT)
Date:   Tue, 12 Jul 2022 14:40:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ntb: idt: fix clang -Wformat warnings
Message-ID: <20220712114015.uosuteetstheqhgj@mobilestation>
References: <20220711230148.2130871-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711230148.2130871-1-justinstitt@google.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin

On Mon, Jul 11, 2022 at 04:01:48PM -0700, Justin Stitt wrote:
> When building with Clang we encounter these warnings:
> | drivers/ntb/hw/idt/ntb_hw_idt.c:2409:28: error: format specifies type
> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
> | "\t%hhu-%hhu.\t", idx + cnt - 1);
> -
> | drivers/ntb/hw/idt/ntb_hw_idt.c:2438:29: error: format specifies type
> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
> | "\t%hhu-%hhu.\t", idx + cnt - 1);
> -
> | drivers/ntb/hw/idt/ntb_hw_idt.c:2484:15: error: format specifies type
> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat], src);
> 
> For the first two warnings the format specifier used is `%hhu` which
> describes a u8. Both `idx` and `cnt` are u8 as well. However, the
> expression as a whole is promoted to an int as you cannot get
> smaller-than-int from addition. Therefore, to fix the warning, use the
> promoted-to-type's format specifier -- in this case `%d`.
> 
> example:
> ``
> uint8_t a = 4, b = 7;
> int size = sizeof(a + b - 1);
> printf("%d\n", size);
> // output: 4
> ```
> 
> For the last warning, src is of type `int` while the format specifier
> describes a u8. The fix here is just to use the proper specifier `%d`.
> 
> See more:
> (https://wiki.sei.cmu.edu/confluence/display/c/INT02-C.+Understand+integer+conversion+rules)
> "Integer types smaller than int are promoted when an operation is
> performed on them. If all values of the original type can be represented
> as an int, the value of the smaller type is converted to an int;
> otherwise, it is converted to an unsigned int."
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for fixing this. Definitely
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
> Note: This patch silences the -Wformat warnings for this file (which is
> the goal) but in reality all instances of `%hh[dux]` should be converted
> to `%[dux]` for this file and probably every file. That's a bit larger
> scope than the goal of enabling -Wformat for Clang builds, though.
> 
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 733557231ed0..0ed6f809ff2e 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2406,7 +2406,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
>  				"\t%hhu.\t", idx);
>  		else
>  			off += scnprintf(strbuf + off, size - off,
> -				"\t%hhu-%hhu.\t", idx, idx + cnt - 1);
> +				"\t%hhu-%d.\t", idx, idx + cnt - 1);
>  
>  		off += scnprintf(strbuf + off, size - off, "%s BAR%hhu, ",
>  			idt_get_mw_name(data), ndev->mws[idx].bar);
> @@ -2435,7 +2435,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
>  					"\t%hhu.\t", idx);
>  			else
>  				off += scnprintf(strbuf + off, size - off,
> -					"\t%hhu-%hhu.\t", idx, idx + cnt - 1);
> +					"\t%hhu-%d.\t", idx, idx + cnt - 1);
>  
>  			off += scnprintf(strbuf + off, size - off,
>  				"%s BAR%hhu, ", idt_get_mw_name(data),
> @@ -2480,7 +2480,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
>  		int src;
>  		data = idt_ntb_msg_read(&ndev->ntb, &src, idx);
>  		off += scnprintf(strbuf + off, size - off,
> -			"\t%hhu. 0x%08x from peer %hhu (Port %hhu)\n",
> +			"\t%hhu. 0x%08x from peer %d (Port %hhu)\n",
>  			idx, data, src, ndev->peers[src].port);
>  	}
>  	off += scnprintf(strbuf + off, size - off, "\n");
> -- 
> 2.37.0.144.g8ac04bfd2-goog
> 
