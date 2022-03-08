Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EA84D1CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348225AbiCHQMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiCHQL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:11:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3550B04
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:11:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 19so11198080wmy.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oR1I0j29FD7B60ybG21a3xvyI7Hv4VggErPMrErL0E0=;
        b=EtnJXIsNFwmVdSvAfZyYisQ2B9NsK+NizivkiRQROrcDMSlbkKyKE8R2Cq0mQ0wDfC
         G8KSNyWxz4AC431rn/c3ItQumYk+gODZDtVGht6izSdzp+Yb4Wy495QFImTB1Bs/XOV/
         sfm5TnVEn5n0xIGq1c60XskQyW53uLtQecCs8LENwhJpJ/kBz73auyIe7sN/Gf4r8UWC
         YYo3WtzaJt5A58txAorvFi1TC3EU9RfZOTn9kYsHlAWgA7bmuMC38UjwlWR3zjXUsds4
         0nPG+gzxGyEe7jTWFAfc7nZSYHnBztEcpcssYVCR/cE/Aqp+OK0OfPPmb+Zs8T7JaAGL
         D8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oR1I0j29FD7B60ybG21a3xvyI7Hv4VggErPMrErL0E0=;
        b=t9WiZlNBEIuNveBw/JlUBaiBOm0tgsG5ebpNqwuMfhDwLw9Mr03TrmgqAGDNRLIAOa
         sH5r/ABnC0wzKdw5uG1tvlAjvZCq8Uvi+FcXNnl+TiuUirekf+mP8nRG2qaM9z+sWdUE
         M7L7eEegMJfLhOCdRy9eQiMcSLfU1UUE63T/ic7zqO36eYHTQBq3YRWDfbw6LdQYTZpa
         06/QPjlLmX7j+UncoFWyvmznmefKcn/Lp8LKM/m9+fhcAtsVJ0P4eA3gq2Xj/DJuiw0u
         tCpnz2QF6zO9A7i8z+ed8tzLTYgBRs2HCsm+Ww7d7sUu38unJkTAx2QlNy5wt/pAKADh
         Ztow==
X-Gm-Message-State: AOAM533AkcBsXiE5fTG0b+rjZqRE2NPEnre7TYdVWivU/QJLRthaMzD8
        TgXjx/orALHy58/tPsljf3VyOw==
X-Google-Smtp-Source: ABdhPJzAve1LVkuh6cQToviXcGeCSgvLcohwkWt1xoYUKo0PaVMt1yJXrSASyYYPQWyiU7Nur3M3sg==
X-Received: by 2002:a1c:f315:0:b0:381:1f6d:6ca6 with SMTP id q21-20020a1cf315000000b003811f6d6ca6mr4211928wmq.25.1646755860806;
        Tue, 08 Mar 2022 08:11:00 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x14-20020adfffce000000b001f1dfee4867sm14817258wrs.99.2022.03.08.08.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:11:00 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:10:58 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configs/debug: Restore DEBUG_INFO=y for overriding
Message-ID: <20220308161058.zuuze2jvhbiq53xy@maple.lan>
References: <20220308153524.8618-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308153524.8618-1-quic_qiancai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:35:24AM -0500, Qian Cai wrote:
> Previously, I failed to realize that Kees' patch [1] has not been merged
> into the mainline yet, and dropped DEBUG_INFO=y too eagerly from the
> mainline. As the results, "make debug.config" won't be able to flip
> DEBUG_INFO=n from the existing .config. This should close the gaps of a
> few weeks before Kees' patch is there, and work regardless of their
> merging status anyway.
> 
> [1] https://lore.kernel.org/all/20220125075126.891825-1-keescook@chromium.org/
> 
> Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>  kernel/configs/debug.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 07df6d93c4df..e8db8d938661 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -16,6 +16,7 @@ CONFIG_SYMBOLIC_ERRNAME=y
>  #
>  # Compile-time checks and compiler options
>  #
> +CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>  CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_FRAME_WARN=2048
> -- 
> 2.30.2
> 
