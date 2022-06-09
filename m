Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEED5455D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiFIUmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFIUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:42:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FDA95B0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:42:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so131930wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S78m/HToLKVYUdCMUpb8rjXXCKKli+oy2FiVRaWYDoM=;
        b=Lc2XA2kvQBTNpbMTy6vnVXSiAivZF+r6bVkqOSzMQU+zEPSTuTJgaoEEPM917VBxyl
         g9wmjNlYAF68Mu+Or0yjSvSsmKrm/MwWeSN/+MFlBKCHoL2tmLZDKb2GboXBd51VPR3d
         QfOhxS+ti3ntwyylu6eMoZjKbIHttYHWR+s87RxensDozIJDfpnYJjeyPVZR6I3wzMgx
         +fnY22H4phCPJUSdwcdsIoiqmUF1gpfhL+h6ER3va/8O45QuAVodSP1wMwVYPBzTsi5S
         S6T1mVX5MWOqn/sg/ac8z3kJCnC6deYfp4EaUonemED2jk1wdnqW7GzJ/GPcEwpClu8F
         TnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S78m/HToLKVYUdCMUpb8rjXXCKKli+oy2FiVRaWYDoM=;
        b=W/bvSOfHx4cU9nPBPCs8ErpJE+4siXzJk+SA2/YXOI0A7i7de2IVOrT2rxAsf9PI0t
         Oc4GkLiKCFwcRVGMQ55IV1Mor0cd5VyYRgKKUjxHs98EcVli+GyN9fOvofmMzRmkWc7E
         +vbBAt1RFQKUS1cRQlN8H+u4yFnr5MGjKAF/ruHTUaUUAN5+DRp1mShRxvPpQqm1fbRe
         U2UtMDY0pYE9WPwYkgja/CmHQ03J3c6hFKAeZiuWOfABzlccZcnfW8h7qWQorhKqmnd7
         HIIM0I3x+TXeFa5t8H4Q91cRWgSTChpHWG79rczS+EjOXazKezfvPcbpisTVizXtAVk2
         YfMw==
X-Gm-Message-State: AOAM530WH9YKNjLZh4s81kiqdtqn0rODPYHutaUy5L5lo3Z5iM/ygVCR
        UsIs7vo3wOAGPV3Lh32X7IuzwOkTGous
X-Google-Smtp-Source: ABdhPJy/CDTScaV+mn26sL54r0xa3l+rhDSLQP0/u7jaw7+xDgyMUa2jueJTHNkaQzk4YA+QNCssDg==
X-Received: by 2002:a05:600c:1d91:b0:39c:544b:abdd with SMTP id p17-20020a05600c1d9100b0039c544babddmr5118392wms.70.1654807350251;
        Thu, 09 Jun 2022 13:42:30 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.10])
        by smtp.gmail.com with ESMTPSA id l21-20020a1ced15000000b003942a244ed1sm350391wmh.22.2022.06.09.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:42:29 -0700 (PDT)
Date:   Thu, 9 Jun 2022 23:42:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, ndesaulniers@google.com,
        nathan@kernel.org, jstitt007@gmail.com, akpm@linux-foundation.org
Subject: Re: +
 include-uapi-linux-swabh-move-explicit-cast-outside-ternary.patch added to
 mm-nonmm-unstable branch
Message-ID: <YqJbMzUnzF2WEmU5@localhost.localdomain>
References: <20220609172933.D8187C34114@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220609172933.D8187C34114@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:29:33AM -0700, Andrew Morton wrote:
> A cast inside __builtin_constant_p doesn't do anything since it should
> evaluate as constant at compile time irrespective of this cast.  Instead,
> I moved this cast outside the ternary to ensure the return type is as
> expected.

> --- a/include/uapi/linux/swab.h~include-uapi-linux-swabh-move-explicit-cast-outside-ternary
> +++ a/include/uapi/linux/swab.h
> @@ -102,7 +102,7 @@ static inline __attribute_const__ __u32
>  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>  #else
>  #define __swab16(x)				\
> -	(__builtin_constant_p((__u16)(x)) ?	\
> +	(__u16)(__builtin_constant_p(x) ?	\

This cast is necessary.

>  	___constant_swab16(x) :			\
>  	__fswab16(x))
>  #endif
> @@ -115,7 +115,7 @@ static inline __attribute_const__ __u32
>  #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>  #else
>  #define __swab32(x)				\
> -	(__builtin_constant_p((__u32)(x)) ?	\
> +	(__u32)(__builtin_constant_p(x) ?	\
>  	___constant_swab32(x) :			\
>  	__fswab32(x))
>  #endif
> @@ -128,7 +128,7 @@ static inline __attribute_const__ __u32
>  #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
>  #else
>  #define __swab64(x)				\
> -	(__builtin_constant_p((__u64)(x)) ?	\
> +	(__u64)(__builtin_constant_p(x) ?	\
>  	___constant_swab64(x) :			\
>  	__fswab64(x))

These two aren't? typeof(c ? u32 : u32) is u32.
