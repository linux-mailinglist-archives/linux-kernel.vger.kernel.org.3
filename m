Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5994F4685
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbiDEUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457006AbiDEQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133AE8853
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:26:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w7so12366058pfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nlcDYyeczHYZLKKspnEu5slcPvr1pfijlItskO0pzK4=;
        b=WSNHXs0W5TvbEOpBlw4zJj47ZPJYMlXRx38aBCLgqNH7+XypYFRt5yKXe0RB33UwAd
         9GXSl3H2QZdgdjjw1DVmkeiCWy7OFsGJxQ9AIJDl9xWsI3LdmBemt/xfgkP0ylPygVwm
         6dp/v+CS1pNAxhx9s0/pxXqeNriszfYAbVUQ5CwEq3s+78WvdQuOKuIeQZuQwSj5Y39c
         apKLZoESUXrIz+8bjtHnRzregsiWaIWvOv2Pfh4CT1FccGCCM7kG/UwKr+4UY1KooFuR
         Uweewlazq2UY4f4rRh3J8byLQIKBjp3zMT9N77YtIfQnlBye/0nKv4vcd73+az/yI7+X
         xY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nlcDYyeczHYZLKKspnEu5slcPvr1pfijlItskO0pzK4=;
        b=Q3zsbFFxe+ytYWMDGl6uuKw7huqhCpqA3Aon7FBcwtrKR8E2fXLgEDg1WMIrdMQxQ0
         K2DKBEm6qckAkvqaw6n21GaPmgkyTkNdULP3RNEHiOT5PnWZqy47plp8y8WlM55h0JFs
         Tsq1MDdOnY6G7k6lVLKM7ts3D+PSlBe9U3nbYU25ZZ8goZIsSDDi9nGGMVhUj5nGORrT
         a8BfBQDhQZGzUcXhgHX+L46Vn8o/Lm5vqIzhh2CTe16pS8nAW2d5lH9GyOyjGygqmhOL
         1KFXg/RCyRNJ134zXc/cfzB4Tn0meucUmQBpTAsE3ILRp05TolOls1hWgHh7aK9lvcMn
         UwYQ==
X-Gm-Message-State: AOAM530H5U/c9jZaFUwNDKqR6JIeev6MdupCe8u5tUERlnWDDCZjAVT9
        ZE9rTl1QSMLigwWaHlioIhMjCQ==
X-Google-Smtp-Source: ABdhPJz7yF6N9ZNXE6NMcS2CsOkoYIqxjjYdWdWKVmamt8X+07AjeWC8YH9Zx5T3RQEHz4C5J9vmJA==
X-Received: by 2002:a63:a902:0:b0:398:cdd3:f85e with SMTP id u2-20020a63a902000000b00398cdd3f85emr3358626pge.122.1649172360274;
        Tue, 05 Apr 2022 08:26:00 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i6-20020a633c46000000b003817d623f72sm13886071pgn.24.2022.04.05.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:25:57 -0700 (PDT)
Date:   Tue, 5 Apr 2022 09:25:55 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Config that had RPMSG_CHAR now gets
 RPMSG_CTRL
Message-ID: <20220405152555.GB4147585@p14s>
References: <20220405115524.1020499-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405115524.1020499-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:55:24PM +0200, Arnaud Pouliquen wrote:
> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

This patch is missing a separation marker, i.e "---", just above.  Without it
the text below is also included in the changelog, and it shouldn't.

Thanks,
Mathieu

> 
> This patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
> 
> Update vs previous version:
> - remove "Fixes:" tag in commit, requested by Mathieu Poirier in [2]
> 
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> [2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 50aa3d75ab4f..3f8906b8a2ca 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1053,6 +1053,7 @@ CONFIG_QCOM_Q6V5_PAS=m
>  CONFIG_QCOM_SYSMON=m
>  CONFIG_QCOM_WCNSS_PIL=m
>  CONFIG_RPMSG_CHAR=m
> +CONFIG_RPMSG_CTRL=m
>  CONFIG_RPMSG_QCOM_GLINK_RPM=y
>  CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>  CONFIG_RPMSG_QCOM_SMD=y
> -- 
> 2.25.1
> 
