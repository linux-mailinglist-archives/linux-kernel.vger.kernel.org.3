Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AFF4EE257
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiCaUJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiCaUI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:08:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285A235853
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:07:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so612838pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wzm/1eal24ONK0OnHL9CiOdHzhiKLpVJA5LMtDpu4OY=;
        b=TDT1fYfRXfdGXMeXm1G1YLKFlkLJFrjEQa9wr1nqZu3IbFMKUSmK9n2PfQnpbYfuR0
         rBmhbwGe/TcXBdpRdlt40JabNSGAcouC4/1yOrvfFso3W/3hqGd8JHnGGUAQ9L5ad4Kd
         w8qmw1jQgO2EJ6X5a2FE5zNHgEL7UubMK/ZcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzm/1eal24ONK0OnHL9CiOdHzhiKLpVJA5LMtDpu4OY=;
        b=rJazVNr8G49pfy6/UlN2/2EAq11zYxONSHpKU6Itwt+O/SC7Y2WpPvqIpGBs/aENE0
         gDaaKrqpv6QvrvSB8cut7IwqZi+PlHNg75Kt6t8bfjNFHHDAnHA03SRs5PT2/FToLNbY
         wKOjSKNalBU3QLYR6+7ddeJHFyvHWouDQXbdUgUdphJZnjfwxefhA8eac8xOT8RcWe/M
         WRSgw6Fp6DVw8FiwqzylntqXpJfmvhzqWclsRmb4LW3u3ykt/1ddHWWzlwQl0RDqsay7
         xCM3r4KNeQjJBpSKJN+2JcMKQk16Ynxll0WrxlBFmoprTiAHv0eU6cU8KT3rEgdXRk9I
         zMAA==
X-Gm-Message-State: AOAM530CXyxNSKIqqFnYGWkA5+0NKrSVoVnnqyW3+6f7b2LAvK3TuBok
        fcXp6JDew8EXhN/zU3e3bRuZPA==
X-Google-Smtp-Source: ABdhPJwccwSskxChZY0E3ekuDrO+PNPY+D+4hqXBQ9tr8RCkKnQ7sNQBFzNHFKAzWpODAxQjRBK/KA==
X-Received: by 2002:a63:3648:0:b0:398:a0c9:7c58 with SMTP id d69-20020a633648000000b00398a0c97c58mr9852590pga.201.1648757229848;
        Thu, 31 Mar 2022 13:07:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm10710218pjl.39.2022.03.31.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:07:09 -0700 (PDT)
Date:   Thu, 31 Mar 2022 13:07:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Gustavo Silva <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi/linux/stddef.h: add include guards
Message-ID: <202203311307.F9BCC6B1@keescook>
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

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
