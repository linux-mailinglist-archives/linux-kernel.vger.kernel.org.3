Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD848CC40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357009AbiALTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357630AbiALTp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:45:59 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545BC06173F;
        Wed, 12 Jan 2022 11:45:58 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b127so4594540qkd.0;
        Wed, 12 Jan 2022 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+42YiBAnbZbkfyad9QQejqVpSSOXhpqv+ey5KP1Xed4=;
        b=NQfOtKxk27bOpbI7EDPAnoA6GYnOEnpeasDwERnK9xmhhb7RicEJTB4wbrMzmyUnC8
         SaAjmBffMcHw9IRsDJN2xHHS/nZgNOhzpmBC9NP3s2cSGDU877EqZJeuiIbqoupAlziy
         KCBRyXvSPJInf+kzzoLj2py0B8V+7QiD8dSbtWcsfbs4mlUmPNj0PBjalZBwWLt8LxzB
         ysX73bjnv3okzWReDwXEmVbR+794Bn5sqfWxtaDxKgqx+UdP1SefREI/QSIoVE3jDB4h
         VVODQy4kY3rWj6eRWSOdcXyUamM1XEE0au7PkHNcbYjCstnT1H0Zi9mFe1/UJLmyqKxb
         pzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+42YiBAnbZbkfyad9QQejqVpSSOXhpqv+ey5KP1Xed4=;
        b=wz5HclnJVsqTgWo0q1rXHJ4HtGUC95cCyHWHDTPgyg0eYf/L+fsQ0yiqm+VfAHGf8q
         HbDU2AGmh/yUVnTlYyHqarSJGfajo+pW2HvegkMUCG9ziXVlDcBhWBikOuS1d6hpzX8F
         aC/jUhYSFZwOztrfcMYjQZib9QjF/7UIj7/jLlxunHCktCclyDPbY/qy8NidVeByXmOf
         GA5xQJ+70zqTxaFMri5IfWXOi85egDXKZacskA+7gquYf3WS1xfRwlXRRVDGeBZhlSLg
         rCr/ryV2A723oUElGSY3LjV96cIQ1fFvLX5THQvvVnZGMLg9RIKXpdb6KG8332L1iZO8
         VfKg==
X-Gm-Message-State: AOAM530G0fl4RLs2prCGyr4hdakFlW9wl+mhtiX/EZQlFVyMix+dKVTY
        MJVsFnzcki9dNLZKYkrk4pU=
X-Google-Smtp-Source: ABdhPJxZcTT47G4GxAyhyeMYObNE+7u/I0aQKJqJhJng3pe8+w5/8ndyIq2LW9OvjSe3QpspeK9zXw==
X-Received: by 2002:a37:aa8d:: with SMTP id t135mr782641qke.152.1642016758068;
        Wed, 12 Jan 2022 11:45:58 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id m20sm562947qtx.39.2022.01.12.11.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 11:45:57 -0800 (PST)
Subject: Re: [PATCH] scripts/dtc: dtx_diff: fix documentation for redirect
 workaround
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112101441.23088-1-matthias.schiffer@ew.tq-group.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1f4e0d22-efea-e2f7-4c85-78953c142c0f@gmail.com>
Date:   Wed, 12 Jan 2022 13:45:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112101441.23088-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthisas,

On 1/12/22 4:14 AM, Matthias Schiffer wrote:
> dtx_diff suggests to use <(...) syntax to pipe two inputs into it, but
> this has never worked: The /proc/self/fds/... paths passed by the shell
> will fail the `[ -f "${dtx}" ] && [ -r "${dtx}" ]` check in compile_to_dts,
> but even with this check removed, the function cannot work: hexdump will
> eat up the DTB magic, making the subsequent dtc call fail, as a pipe
> cannot be rewound.

Thanks for catching this.

I would rather just remove this first workaround entirely instead of
changing it to use 'diff'.  Can you redo the patch to do the removal?

Thanks,

Frank


> 
> Change the example to use `diff -u` directly.
> 
> Fixes: 10eadc253ddf ("dtc: create tool to diff device trees")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  scripts/dtc/dtx_diff | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
> index d3422ee15e30..f97eb83420a4 100755
> --- a/scripts/dtc/dtx_diff
> +++ b/scripts/dtc/dtx_diff
> @@ -62,7 +62,7 @@ Otherwise DTx is treated as a dts source file (aka .dts).
>     may not work since \${ARCH} is part of the include path.  Two possible
>     workarounds:
>  
> -      `basename $0` \\
> +      diff -u \\
>            <(ARCH=arch_of_dtx_1 `basename $0` DTx_1) \\
>            <(ARCH=arch_of_dtx_2 `basename $0` DTx_2)
>  
> 

