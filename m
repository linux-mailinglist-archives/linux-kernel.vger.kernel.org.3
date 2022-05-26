Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16AB53540C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiEZTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344646AbiEZTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:40:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F25C85D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:40:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n10so4902085ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7ygqT9lGigZJ/CYDT7+D7nz3BZboq9zllaPVSGj/rjk=;
        b=kr28vZGN05blbS66YlpNx2nb3IVkqa31qxAEgv0noWSbShQdN5UUR0xe+oDYnEfX6b
         0z3vZLZXg2bg/sWgVE2Av9TV7LT7w/8P4OMs2fEI9eiTvGBy9MJ9+amKUGFrLvzWv0hT
         YhlXtusfcb+U+TPQ1SvifFdL4o31sCt1Tsj8+86hoSdSUoFBZof0KkbmSqyVTIOMbPKu
         C0rzU7nqA4dyfgZ8UTYRdpXN/FphI+tBRvw/DCSQp2daBE65+eCy9fegsttEK79X7Df7
         jCENFKDrhpY7vZ7c9J46vp/I23uWnrSHGevknJ3glPEMzNtAEWe5xM+FaViy6wUXwl96
         X3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ygqT9lGigZJ/CYDT7+D7nz3BZboq9zllaPVSGj/rjk=;
        b=XZwP6geEdQyAYEXPFn79rbi3AuEqpea8Q8kuTDL0L2EnRM5LPCM+Qz/UkB7PA7zfB9
         Of1ta67bAeGFajmWciL66k3UK5s8LcYx4gzJ0g3is9DGk859Z8aUjovQN1AHUXT112Vo
         r1XmOqKiBZJ0YR9VKI5/W7RslV0epTRpZ3gvl1Qj0CWeILaIP8ZRFif9XKjVJsLZMVZa
         gqODA7s9CtEJUNuenobIutwkDW5v3UYa/U8MwbamtAlW82wsJO8adMb+2NpjYQ1Zj7M6
         UK1bIIE/UgDdaR7FwjN3aDhqPf1zJvbLFaQvPD7GAuvBWfAeEFkNqpwmtEgvRKDiO7T4
         vbvg==
X-Gm-Message-State: AOAM531u8Ee2IhCMrDVUyokFp0y6jgVnKymyvoPvxN/gAfUxg27fiBEZ
        vf4o61cgrJZ/TQCUBy+aIEOm/A==
X-Google-Smtp-Source: ABdhPJzpn7MDzb5XTatBFzqgrCKJrOtisDCPplYuF02V+m3GksAs5ItkZu1/nhHfsTh6eV4c6Vue2g==
X-Received: by 2002:a17:907:8a25:b0:6fe:ff5b:81f8 with SMTP id sc37-20020a1709078a2500b006feff5b81f8mr14939322ejc.184.1653594041435;
        Thu, 26 May 2022 12:40:41 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s20-20020a508d14000000b0042aba7ed532sm1160010eds.41.2022.05.26.12.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 12:40:40 -0700 (PDT)
Message-ID: <66eb1ab4-efa6-8c3f-84c1-ed8bca0a8432@linaro.org>
Date:   Thu, 26 May 2022 21:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8916: Fix typo in pronto
 remoteproc node
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220526141740.15834-1-sireeshkodali1@gmail.com>
 <20220526141740.15834-3-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526141740.15834-3-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 16:17, Sireesh Kodali wrote:
> The smem-state properties for the pronto node were incorrectly labelled,
> reading `qcom,state*` rather than `qcom,smem-state*`. Fix that, allowing
> the stop state to be used.
> 
> Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>

Include please acquired tags when sending a new version.
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
