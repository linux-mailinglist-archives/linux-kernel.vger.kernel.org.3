Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC974D0CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbiCHASi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244050AbiCHASf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:18:35 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE332679;
        Mon,  7 Mar 2022 16:17:39 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id l12so22803279ljh.12;
        Mon, 07 Mar 2022 16:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7qQ2UPHfggKLpoo8clS5DCRvOxKGuJ2u7/O95gt+nh0=;
        b=Y9AaF3vYVObdlV4tqCqvgbtaR0uL71cSaqkRVD+gxb2eCEgILGeNhcVW8uRAGWUUPO
         TVMYPo1IVe3FiXArgYU2moX9ZDWQjHAOuR3YCQDShx9bYEstZmGIdL34uUZH+kzzElbg
         Yxxjl2PFuGlWbwdL/Yy7/6dnlx8IU+pbYOhe9FsDVqJ2fsALFXOq1pKYDAvLtesx+Vb4
         WAzQfrnRgK6RT+I3dFnBXKKKB0evXXuPKaWktqmXoavI8JIio+Pl/W6+wBSp5vDU/rBo
         Ob3ajld012Ydpm8yCLSBFZYOzAcfkIouhIgecEpreY7yHtTkcEcOdcmnxD8R5SVJRtb1
         Rw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7qQ2UPHfggKLpoo8clS5DCRvOxKGuJ2u7/O95gt+nh0=;
        b=s6/LOd5iZdDWGN0LRy/0R9ewdEXJoCqoMmHERF6V6pgEyJIiOxp5t3ijWcc1BvSPud
         w0Z88xp87QmopROH8S2JFRPCJPRNW8unhpBiuKXQHsbnEe2bHae6iRwRLNNitpjsgLXC
         71i+d/oN82rFaJXMeBS5p6UFMYX8C0qKfpcPqaemgNCRsSBHDG4FYoAuUkIUd6rnpTZz
         NGw7nqEjlEpgCUczT0IKBDAN+jDtt+wYdiyY1IU5jFkBCG4RxYetsXthpVP+MyANMq3w
         Hfj9Vj7wnqmnYd8LIlCuVsB9yuGxL7VOXVbdU+JMCDypFqt4SquiRaOyUyx+0YxP3+ne
         p9jA==
X-Gm-Message-State: AOAM530395qdSjXnKHWa+1TXaPqbD7MEtDS+begkCQbKwZUNyhal5obX
        /Mx6z3EqWBTJ+GAtecJuw3k=
X-Google-Smtp-Source: ABdhPJz8gPXv9lQFUT9LaedMm8Bcu4wn9HEFRG9bGBjyz9H3VvAx/T9d+5sXFOG+F6ZFqKyK6qeqwA==
X-Received: by 2002:a2e:7a1a:0:b0:246:210:65cd with SMTP id v26-20020a2e7a1a000000b00246021065cdmr8974169ljc.99.1646698657231;
        Mon, 07 Mar 2022 16:17:37 -0800 (PST)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id bq42-20020a056512152a00b00447431cc768sm2764256lfb.170.2022.03.07.16.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:17:36 -0800 (PST)
Message-ID: <e3c8078d-0e1a-6332-fbd5-6339561cd24d@gmail.com>
Date:   Tue, 8 Mar 2022 03:17:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MAINTAINERS: rectify entry for MEDIA DRIVERS FOR NVIDIA
 TEGRA - VDE
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220307145935.13178-1-lukas.bulwahn@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220307145935.13178-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.03.2022 17:59, Lukas Bulwahn пишет:
> Commit ccc3016261ed ("media: dt: bindings: tegra-vde: Convert to schema")
> converts nvidia,tegra-vde.txt to nvidia,tegra-vde.yaml, but missed to
> adjust its reference in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file reference in  MEDIA DRIVERS FOR NVIDIA TEGRA - VDE.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Dmitry, please ack.
> 
> Thierry, please pick this minor non-urgent clean-up patch.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05fd080b82f3..2b96a22cf5ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11964,7 +11964,7 @@ L:	linux-media@vger.kernel.org
>  L:	linux-tegra@vger.kernel.org
>  S:	Maintained
>  T:	git git://linuxtv.org/media_tree.git
> -F:	Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
> +F:	Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
>  F:	drivers/staging/media/tegra-vde/
>  
>  MEDIA DRIVERS FOR RENESAS - CEU

This patch will have to go via the media tree. You'll may need to rebase
it on a recent linux-next soon because the driver path was changed
recently, otherwise maybe Mauro could resolve the merge conflict while
applying the patch.

Acked-by: Dmitry Osipenko <digetx@gmail.com>
