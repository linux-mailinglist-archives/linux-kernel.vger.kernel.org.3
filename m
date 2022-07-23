Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6D857EF28
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiGWMnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGWMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 08:43:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08491CFF2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 05:43:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y9so6538593pff.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ReiBAAOfgFnloPVte6r4tHNGKHUp1kRjmGGIHVuKdbw=;
        b=i8BJrGCsQ3WZJI2TVFnQ4ARVI0OUYZP08MKFayK4E9aTiMUhTJG6Q5267xqRbOEREW
         /4peAhKCXe+N850DtC30mW66r8swYQIvluw9f2pPBcruZYi+ITTWkUQVMqq/h1lzcJ86
         qg13L2cJsNfWgITLKH8IvKmjL+Ox1LuJ665Zez0O4iWN+zNuO3ezbhPANXPPJ7PYnjJi
         maVSmZoQY3Ns3BDsK+yCJ2ZNOQJUCSbHMgmfUsCfQ6iZuFzuZYEBvVobMPBQvRcUA3Mj
         EqYuF92WcVd1MfbTNI4gcGzD/gfOJHShDPBlvFzsVOwQKVX/y4WrqUM0TLszUypwQJeG
         s8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ReiBAAOfgFnloPVte6r4tHNGKHUp1kRjmGGIHVuKdbw=;
        b=jZo6q6Hkw9r02vFmKW0xeJrjw0ZQpovu7Mi++7B/jctbLoG3oCw31UFt52LRxyCySX
         mT5fNHOyDn9FHRrRm10MMfANwUoI4ZW11GATkT8byUAhO8q4eeT1OEqBY7JkbFn9G0LT
         Eef6Dw45dnp9/eRmGwlAbj2lgskWlKVKL4pB1yLcKpyjbXhrTvLnRQ3kOmPNlQOL7RPQ
         2115z1ernvSmJf/bWwRmDmS4Zl/3Ccqx1nstMr0rdlvdi9YzYC+fd6wIqrbSV12kRPM/
         yzK4env/BPVYOTBtmliaZ6DPz335TODqJPN3l32HLYpjdfJSiVv4t43e0WkXxa5dbrc6
         qPcQ==
X-Gm-Message-State: AJIora8qPuS65SP6GFJ1xR3632+XamhSBQosqwkEdkNjLm5rvFtbVZ2K
        wakXAEzIqfiussQ5+gUvw1/jEGBFJqoS9w==
X-Google-Smtp-Source: AGRyM1vbJUPTuqJWkVG+0vq/JWI6qv3IpJUOS3swpO2q2RR4mE/fGoX6PyPd10s4p5N3a3OjoeGogA==
X-Received: by 2002:a62:ea18:0:b0:52a:c12b:9313 with SMTP id t24-20020a62ea18000000b0052ac12b9313mr4504191pfh.49.1658580221399;
        Sat, 23 Jul 2022 05:43:41 -0700 (PDT)
Received: from ?IPV6:2602:ae:1549:801:2d4f:84b3:76fd:8a95? ([2602:ae:1549:801:2d4f:84b3:76fd:8a95])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b0016cf8f0bdd5sm5578609pln.108.2022.07.23.05.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 05:43:40 -0700 (PDT)
Message-ID: <8c0ad12a-6101-8ba7-f3bf-0be6a9e6054e@linaro.org>
Date:   Sat, 23 Jul 2022 05:43:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: Update Richard Henderson's address
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220722211854.802252-1-shorne@gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220722211854.802252-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/22 02:48, Stafford Horne wrote:
> Richards address at twiddle.net no longer works and we are getting
> bounces.
> 
> This patch updates to his Linaro address.
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f679152bdbad..e64ca0ac6db7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -797,7 +797,7 @@ S:	Maintained
>   F:	drivers/staging/media/sunxi/cedrus/
>   
>   ALPHA PORT
> -M:	Richard Henderson <rth@twiddle.net>
> +M:	Richard Henderson <richard.henderson@linaro.org>
>   M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>   M:	Matt Turner <mattst88@gmail.com>
>   L:	linux-alpha@vger.kernel.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
