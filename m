Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1258C54E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbiHHJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbiHHJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:11:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC8ECE30
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:11:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a9so11705719lfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Iy4CL5K2OokXeqBXhaFI2AbIzjldyqsqMvK3rAqocug=;
        b=T8BpQb6xqOW7NMhoShq5JlXbvLIu2vgOgB+87tgBv3EjE6VX8fES2rWMDTiDKsbuuz
         VcoOa3oT+jUdsMNGeuQ0OiU4jvAb4iSq9x4a0NAJ8sMhoqLmRRSIAThTLKav2+oxU+jz
         jgVnrksKVpJHJrfGnESsNGUHp/j5WwXOMES5Gy91rMlPDnWDltDxWwYCZhw4xq2G4c9g
         vhNA0VSiXZT4tZWAAI0i/zmJlHg6PGsg/jPWZee2DX6NvCVscEmzTBc0ps/VB2Qv+iQ/
         +oTbG3lzSOQGZ+c3Cev6NE8GBXpk444mLfYkcJ0VkoNlHGC3CzmilIxkGI9it+zlxZ87
         GAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Iy4CL5K2OokXeqBXhaFI2AbIzjldyqsqMvK3rAqocug=;
        b=FuiNZqKtHan2qVz/WO5rS9dqhph2Yfc4S7bmDFJrjrMkGjTWYszEAIveNjxOtZDuna
         9ywKDXh6xA/9mVOT7qYsXef2a6nwn1ou8MJpBzeeszzErE/oEwdx4Ak/xckcJ3jBYovB
         C2kkxOF5+4cY/p3qB+i3XyMYnzXJVi3T82UFhO5T7Lm9ioBZde9HVk5iK9T82cSzVBnU
         RMao7wZWUFtqAmkrx2itAJsLGCG7SLFDKp10uKP1J0M3aruJfNAk8ixUQ69IaV0ev+iw
         xpy7eDxEYRPrVJQWEbo8u3bOR4xPewNEpWjQQaEaCszZUoyiResJhsE55iR4ez/MSWG4
         tNfQ==
X-Gm-Message-State: ACgBeo3Kf1gMp2Z9pyROxdh1MRuI5bjO6MkowF2PN+2AnMuUruuc1WlG
        myJ/Xj+8rkTH4N0b38YU46pCzFciayyyCoi+
X-Google-Smtp-Source: AA6agR59Z/Lr/JTQPXRmaLLqQNPfvVLatmN7oTOu5XKc3YOIeqTU6vmKNL19yiHpjUdgemLdePIcYA==
X-Received: by 2002:a19:5e0a:0:b0:48b:f4f:d7bb with SMTP id s10-20020a195e0a000000b0048b0f4fd7bbmr6158726lfb.512.1659949881544;
        Mon, 08 Aug 2022 02:11:21 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id y3-20020a2e7d03000000b0025dd8b42c64sm1293598ljc.79.2022.08.08.02.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:11:20 -0700 (PDT)
Message-ID: <2c46fa47-6ea1-aaf5-07e4-341758affcc2@linaro.org>
Date:   Mon, 8 Aug 2022 12:11:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 21/28] mfd: max14577: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-22-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220807145247.46107-22-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2022 17:52, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> to handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
> 
> The advantage is then that these functions are now always compiled
> independently of any Kconfig option, and thanks to that bugs and
> regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Drop the address. Does not work.


Best regards,
Krzysztof
