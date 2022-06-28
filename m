Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06E355D24C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbiF1Ahw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiF1Ahu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:37:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DAA13D21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:37:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x138so7840468pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WTNG3z1MrUyxvL7UAQDTN+O62H0agMHqunU14S/ptwM=;
        b=hhocxqSdC6zt/X72YVNhrC4Izpj6zT6NwuR7oH5SWCdKYj3vDTIaTq/73pUv4nIZCk
         1nVvOmCmFxtMMMZWie2lc3OEVmqDBfSFW7ysYt1t8mvElbtw4mIHfHmnyNcoTGkHJiSV
         YCEyT/tfECs4lK3RXhcIfgZ1hS6cuLCbyVqatszIJe7idcDlEYp5x+Q5XBWyhiNraMku
         QKtgu5MbvZFC5g3ZcElmT/i1PDlMxe12u85pSuSuUVoJg4KTWTu5JX8jY2wsFadZXYjR
         r3XVwm0OaoiP4beB3MfX4+h/2K7v/Hsq4fZ/qQaU8lS2I8JNganG3ZAU2CNrIK62CQbx
         ZHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WTNG3z1MrUyxvL7UAQDTN+O62H0agMHqunU14S/ptwM=;
        b=C7QRNrVf2BrjPTm/JMfJ/zVvda8sAzSRvfDPk4BbU+5drlPn2eyrm0Z/jr8y4RqCrQ
         jQlOtVuxJuG/hH+PJ0L9bYAW1Q5QeNui8F0hjut3QPWQvCOvAQiSeSJ1+C6m4WySjo7M
         Fz8w4UyEZ1Ucqb8u/yZuCMO1wHZnJT/WVZ0QMAB8inrD//52JJdN0euXxwrZ6ct3z4jP
         KkurPP3AX2gNm+3SSoSI0Pg6KBcUwx5B8Kl10iG/ZB/beJZHBcNRotR/MDItuKxRFK68
         F27YtjCFpHsdjtIcsw+QsgoswvZK91UxuhZJw0XJWdDun3j9HNWJj5Wku3LSGAk7+tQf
         sa3g==
X-Gm-Message-State: AJIora8w+6z1ACfajzVAT2hbDLGEq+86NfO5vBn7yp0BdXXV51t7M8Mu
        LDDE1q7K7gCqwARagyRyJJuRe5xJx7Q=
X-Google-Smtp-Source: AGRyM1tXLWLExWaF3rho6vquGXKFaLiWxx+kW8N1Jw5PU6QD2iuAv2WMGy5jKkMrvusmVrYLCgiIzA==
X-Received: by 2002:a05:6a00:b43:b0:525:2a02:8bdc with SMTP id p3-20020a056a000b4300b005252a028bdcmr641976pfo.28.1656376668788;
        Mon, 27 Jun 2022 17:37:48 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id f10-20020a631f0a000000b003fbb455040dsm7670803pgf.84.2022.06.27.17.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:37:47 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:37:46 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: Fix syntax errors in comments
Message-ID: <YrpNWjLqHZrcrhl6@antec>
References: <20220602085350.12741-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602085350.12741-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 04:53:50PM +0800, Xiang wangx wrote:
> Delete the redundant word 'the'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  arch/openrisc/kernel/unwinder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/kernel/unwinder.c b/arch/openrisc/kernel/unwinder.c
> index 8ae15c2c1845..c6ad6f867a6a 100644
> --- a/arch/openrisc/kernel/unwinder.c
> +++ b/arch/openrisc/kernel/unwinder.c
> @@ -25,7 +25,7 @@ struct or1k_frameinfo {
>  /*
>   * Verify a frameinfo structure.  The return address should be a valid text
>   * address.  The frame pointer may be null if its the last frame, otherwise
> - * the frame pointer should point to a location in the stack after the the
> + * the frame pointer should point to a location in the stack after the
>   * top of the next frame up.
>   */
>  static inline int or1k_frameinfo_valid(struct or1k_frameinfo *frameinfo)
> -- 
> 2.36.1

This looks good to me, I will queue with 5.19 fixes.

-Stafford
