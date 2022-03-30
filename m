Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01A14ECF15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351391AbiC3Vvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351389AbiC3Vvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:51:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC855491
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:49:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i11so21735798plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nhYycKDaYaepMkq1EZfGZ6ePOr1ca8m9Ak4B8zEOVkg=;
        b=I5iCn6Gb2jwb1z/g0JOktQtNx06pt+qEdYcW59EHkQAHBXTLbLkrX9kq+B950MGpmb
         00TciPPmZuluH9fDq/4FVuK3h4/xOMs4R0RPT0ltXdi2qxxaXe5Hn2ZOFavz1sPi9nfi
         lgZ8AcODgGeL2yTwO9n8esDGc3YTkUmsLOU1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nhYycKDaYaepMkq1EZfGZ6ePOr1ca8m9Ak4B8zEOVkg=;
        b=cuSvS5us/+5vBuQFlV+btPHAO4/kDSS9JfHH2qCRX21VEiF4pkKX+EyfGjCnJThyEq
         g8MQZJ0jvlX78JyBvKhstdDAxciQbhGh0Ygr24HMECQTtgs+jcI3h964S/IB+aDSFECZ
         v12pU17V87xOrSS9C0LiLT3d5cRtgOtueMDflWozhBJCB9gjFlsy0ACzBIWOl2z2whcO
         fY/N0aIGkQu1Er0VzpAfDa8xxbHtmTu5tSl8ZspBMFCccd92p/CJeRv4WNR4HhleN29e
         ENkPLrDqPVhsShUSuz0HLMO2KcEpEJemuDh38qFus8sVEPMnmu1eeBY6uvqSRn5x7fhR
         67mQ==
X-Gm-Message-State: AOAM532GC4u7xW2Byv0rdTEf9HlSuCWdAwPjc6peUrBH8gG02wkVJQYG
        DXMSXPhxEFIxcTlg1EjUtdsPUg==
X-Google-Smtp-Source: ABdhPJw7al1PDKtBFEANEm2J2ts8wAQOMcYVDT1+uxS7xqlWlFOmY0E3yLq+cyIKX/b650xwVefZqA==
X-Received: by 2002:a17:902:b705:b0:154:a806:5325 with SMTP id d5-20020a170902b70500b00154a8065325mr37485594pls.30.1648676987223;
        Wed, 30 Mar 2022 14:49:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090ad59600b001b7deb42251sm7179640pju.15.2022.03.30.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:49:47 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:49:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Gustavo Silva <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi/linux/stddef.h: add include guards
Message-ID: <202203301448.31FEB0D2B@keescook>
References: <20220329171252.57279-1-tadeusz.struk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329171252.57279-1-tadeusz.struk@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:12:52AM -0700, Tadeusz Struk wrote:
> Add iclude guarde to uapi/linux/stddef.h to prevent
> redefining macros.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>

Hi!

What was tripping over this? This isn't a new file, so has something
changed with how it has been included?

-Kees

> ---
>  include/uapi/linux/stddef.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 3021ea25a284..7837ba4fe728 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -1,4 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_STDDEF_H
> +#define _UAPI_LINUX_STDDEF_H
> +
>  #include <linux/compiler_types.h>
>  
>  #ifndef __always_inline
> @@ -41,3 +44,4 @@
>  		struct { } __empty_ ## NAME; \
>  		TYPE NAME[]; \
>  	}
> +#endif
> -- 
> 2.35.1
> 

-- 
Kees Cook
