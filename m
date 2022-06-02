Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA753B85A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiFBL4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiFBL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:56:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD7A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:56:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so9465290ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=76Z8GE3DXJmJTcdOCuvjsGl067PCyvdg621Kp6ZPmOs=;
        b=nUnvwpnm2CqgoJOzy34iiNsE1itMvFN21EvwIuCSxDwNGw0jyxQ1rzM+4WrXS2Ag8I
         y6aBaxCFy3E77H9l4yz46Zb1fWqbZUTDDr0/u1UX4Bnbitm0VOyS5wgkAqc93PtC4hre
         mcAiKyRFx8lRdzXpzTyElp/0BtVPnKslt1enerbapdAz7UGcLTabTuvVLldT+/rSIGSH
         jmwhhd8qX5IrZ4JZT7/8xFwkh872hVAVjaD2KkSdr3QOKLpIiK3fqornp3oHmC/wXh4P
         9W/cf8o0+pBH7r1U6ki8OZAWEeDvt0XZYFt4FR/SVjXviKzAB6HMwM3vCA7+3ULweaSK
         kVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=76Z8GE3DXJmJTcdOCuvjsGl067PCyvdg621Kp6ZPmOs=;
        b=NnkUl+tzKZc57G9sTtI+MpRV12kaaTMDfsoJh0t7t1MuRSxWz1HyCzMvhw08BVCjh6
         hSWbs8KKAF8l9WzCogLfjoXTtvIgGJ58mOBmqCqsyrZzNfuTPA7y1gxtCkFt1oL6nnRs
         HuhxmAwiz/JM4E569HYotmyDY6N0aCuPl+ZiqV90HFWniLhlfMegjb4MK7PVnTLtQn33
         4OXiTEx3Bx7heH/a9SY3y3T2zVdBcjVIkMdVTqcxr71byKLgQaBMwfLavVFE0KM3jMpA
         vOtR+w6SIzJWF7SL5Baq9jGQ9yxwDQ0+x8LX0Lx+op4KjIzxfdjXa3/1323nkJegXaVq
         MseA==
X-Gm-Message-State: AOAM532peMiEu8XpRGN2JhCbzkoqfXtHct8SWmEqoRMB7grVlKQb5n6T
        mAA4COIyrU0EMXuYsYt8DYA6nQ==
X-Google-Smtp-Source: ABdhPJwkIrW4IiXzbJNiiaa1czY5sxTCu1ZzTseRaTcDWYufg5PWlgXL3tXanVdD7LyyCYQ4rFY84Q==
X-Received: by 2002:a17:907:3da5:b0:6ff:31c2:22d5 with SMTP id he37-20020a1709073da500b006ff31c222d5mr3740125ejc.509.1654171003292;
        Thu, 02 Jun 2022 04:56:43 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm1686576ejp.19.2022.06.02.04.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:56:42 -0700 (PDT)
Message-ID: <a0d848eb-c312-ea66-c62f-b4bdb982a66a@linaro.org>
Date:   Thu, 2 Jun 2022 13:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/5] clk: samsung: exynos7885: Add TREX clocks
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220601233743.56317-1-virag.david003@gmail.com>
 <20220601233743.56317-5-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601233743.56317-5-virag.david003@gmail.com>
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

On 02/06/2022 01:37, David Virag wrote:
> TREX D Core and P core clocks seem to be related to the BTS (Bus Traffic
> Shaper) inside the Exynos7885 SoC, and are needed for the SoC to
> function correctly.
> 
> When clocks are cut from TREX D Core, the eMMC and the framebuffer stops
> working properly. Other unknown things may stop working as well.
> 
> When clocks are cut from TREX P Core, the system locks up needing a hard
> reset.
> 
> Add these clocks and mark them critical so that they are always on.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
