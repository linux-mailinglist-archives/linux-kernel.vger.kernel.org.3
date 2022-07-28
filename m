Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BD6583E85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiG1MSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiG1MSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:18:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6CE6D543
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:17:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w18so1785725lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vTHkf3PkQuEgWJCGVwet40bcBQOgfr43zzOgeagd0v0=;
        b=DrB888e8pgeDAoMhrEqBNUb66SA6IcaJUsXBFF5IlGsk2uCCbZekR1kwgl3aEJ26bc
         1jNfUJm4fIzr8GBhbQcg2hRDsO2Y2tL3avvUyMynyGj610ogrHFX2ygpX8G408ESIfbB
         KxIfBvfxPNvSDWH3LMIVnqvHC+Xzl45CXdtvtN+47GmWkNbUXVYTufPdCTUvNI4jMmbc
         4V/bkz5hJu5XwxkgENOnMxmt9jNR558hunrovhY1W8Dr+JXrhi0bPajNHa77QPAPnhCW
         fjeaWrZ6iNC8gwKOGfCdhldVm8vmQJ3GKrBYXu9+UkMnrtL64h6qxMSPb7SXmhZy3gSh
         7TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vTHkf3PkQuEgWJCGVwet40bcBQOgfr43zzOgeagd0v0=;
        b=JPnAUCqcnttCmtoV6swGwgUOhSRRygv2VqUzMo8wJsSRqIpGTQy47otkPMZdaDz+9/
         oI0DXf2eXFENbr8u3M6hEcRSJ+3/PCk2sUMnh3U2Pv2Dv7oQDMLKs9/et/OGw3CkhNaJ
         JrmiFLQNm60cxf7epgR23mHJ/giiE3ZdNzmbRfErvdIGpNDuZu36H0q9CUo7NjB4zuVi
         voCJlkPTGGacCGsgjLTLg8mT9DvFVoqOUtdUJjh4smqW729+cR2SXCaZ+J19f9SVv2vC
         jMh5uz9QYA0BEwl4bD7knb+YmGiaT8dCswbsgAALqkT9juCsNyRy+GoS8EJFNawXP4eN
         jpOA==
X-Gm-Message-State: AJIora8VsY1eGqfPTMhmWqDb/kwdS/s6PN/T+m6voyr4Wzr6JOx/v06F
        MDUlmAoSjxpsbLhvpeQz1MMScg==
X-Google-Smtp-Source: AGRyM1vNyLPheoEf3KZBupmIsZAAYI+VF8waTXPJlh0mdoKFxZ1zqu+EszKS24/oZeb1UEHCkEQOTg==
X-Received: by 2002:a2e:a315:0:b0:25e:2e8f:f5c5 with SMTP id l21-20020a2ea315000000b0025e2e8ff5c5mr597979lje.145.1659010650856;
        Thu, 28 Jul 2022 05:17:30 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id v22-20020a056512349600b004795d64f37dsm176194lfr.105.2022.07.28.05.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 05:17:30 -0700 (PDT)
Message-ID: <1685ecd6-cfe7-c2f1-add5-6bfff055fa06@linaro.org>
Date:   Thu, 28 Jul 2022 14:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/2] drm: panel: Add novatek nt35596s panel driver
Content-Language: en-US
To:     Molly Sophia <mollysophia379@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220728023555.8952-1-mollysophia379@gmail.com>
 <20220728023555.8952-3-mollysophia379@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728023555.8952-3-mollysophia379@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 04:35, Molly Sophia wrote:
> Novatek NT35596s is a generic DSI IC that drives command and video mode
> panels. Add the driver for it. Currently add support for the LCD panel
> from JDI connected with this IC, as found on Xiaomi Mi Mix2s phones.
> 
> Changes in v4:
> - No change.
> 
> Changes in v3:
> - Embed the support into existing driver (panel-novatek-nt36672a), as
>   these two IC are similar with different initialization commands.
> 

This does not go to commit msg (---).

Best regards,
Krzysztof
