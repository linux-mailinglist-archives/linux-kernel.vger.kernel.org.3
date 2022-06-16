Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5254EB61
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiFPUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378196AbiFPUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:39:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F555DE66
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:39:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g8so2170769plt.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=BBmUYzK8f9SnovKoa+NZytnW9BcbD9Pk0ULgGxv2bI4=;
        b=rYfpldiYa2Gue535MVTLTOD1x0t7UtoovpEyoFz/741wAYWRL2XYgKvczyDgx+9vtN
         9p/GmBWldaycFlKIOVV23dF1oVi2KdLDOCUpPy4XdbPsHNIdmHUZkmv0ae81XaIxwgAK
         kA3NWrgRAao+mWdvNxhBTa8HczAGyIWxCpHII/Q3KQaT9ujGGQ8REOm4zaJazrAHS6Jx
         NeGmE4GEOTbGQwfa9OCbgT83EEwcqnKqvfzDJ/wgfviUgdm8teTFOJZQTtur4JiexEPC
         rVhne+W+zsnUvg1YsdQQjJ801tbd2hwd9soM/nk0EFYJLKJCgB8EfrF1XUCf8ricSW2i
         UCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=BBmUYzK8f9SnovKoa+NZytnW9BcbD9Pk0ULgGxv2bI4=;
        b=ryoP9Os4LQT09PjAMEtLnGOpMRapMK6xHVXp4IsSty2hcsuOGgFSADLBvXXh9S+Wux
         +PA4AJ21eYFgsR2QELQJ3+JJ9NUTE9Wh1+bIaIYKFqKSGx6ksmazuVV+eQGDg/gE1fQe
         NpZ8C5wCbwOoRSh4GiApPU3LfHdbl8aPKGE+W9DU/5+uQyj1aFzsi2S4FRRGPcDhvrWY
         ckygHjSofs1+JEf6HDTd+8gOg3AkGr12rNPB+6uZXIkM+VxJ0l1xZzauCs6nhyY5aoqd
         LETb7oMiiIuzPCjXh5Rk0TLxVqL/57yHiKuCPPPQNft/a0qa/OmoR4AovJ/X522hUytX
         oQRg==
X-Gm-Message-State: AJIora87oeqfakLXSo9YaKoqYJUhlnmaQHVVVDz/qgnyfEqD2o8qN/OI
        REwhRomCkkuM0YEFZs1ykqPcQg==
X-Google-Smtp-Source: AGRyM1tMt0yXd5H9eQZJu1TilhIOEDsCnF3M8D8EuGKgWb7ezGwyekiJ5Fm9htKWuGLz4mewvPcHeA==
X-Received: by 2002:a17:90b:388f:b0:1e8:57db:443 with SMTP id mu15-20020a17090b388f00b001e857db0443mr6846943pjb.52.1655411970316;
        Thu, 16 Jun 2022 13:39:30 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b00161f9e72233sm2036781pld.261.2022.06.16.13.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 13:39:29 -0700 (PDT)
Message-ID: <ba0ae6b9-c66d-81a3-f324-79efb4455ea7@linaro.org>
Date:   Thu, 16 Jun 2022 13:39:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: adjust whitespace around '='
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
References: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
Cc:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 13:41, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Output compared with dtx_diff and fdtdump.

Hi Nishanth,

Are you ok with the patches? Any comments?

Best regards,
Krzysztof
