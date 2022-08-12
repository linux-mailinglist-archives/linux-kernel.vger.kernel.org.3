Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB09590E84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbiHLJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHLJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:55:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9911807
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:55:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d14so625149lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=T5iIzTCDVHqt30FHfCBf7QyCkBoOs7GPL9+XgJpnyHY=;
        b=wzhT+buoDcE5KBLNi6WAqq2oLZi0r2AKjAMCS+H+73hksv87Nlik8u7vCpU7xCGkTK
         dbcrW/+mteB6uMRvRmsI/DfdobEjH2Wnom7i3hOCWUTPkbQCBZ01C2nVnEWWndW0NNX8
         Vy6PYOdE9cf5pXDtLm/MlNkuiIWbd0qZoFH95l7i8aeyMi+DqpKI7NWazSRwg/JaR+nT
         We4m8IRm5bg4qOtwNGwEJFJHVoCaxIxqbxEL6jhbnsDmXV59L6FIK8eCm79/6gaSy/gl
         +/amH1RU58cCY2dclZUCOu9cHem5YidgDAH7eR9xifYlXAWe2F1zdLwHZYXBJWMCNc4o
         OxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=T5iIzTCDVHqt30FHfCBf7QyCkBoOs7GPL9+XgJpnyHY=;
        b=GhZ13LXZQne3rjeuD9GwMRCkew7hjocttprE3gVzcmG8IFjIPeKbzzItWw094FaDBO
         OdBt2H8xupFGHkXyF/uSHFkYP+CED3WiCYOPJJ3Qu9sbC4/XKmfkEt4DSPW+kdINe/f5
         YTOm2tNz6WUkMhnEwVWw7L8dUlVtKhKGww8jSjbEi7dlGZse6H+D9TJ4nARxY2BalZbO
         M9Tr8/p7buoq4mOOeC2IlY11CsrQ1mUhjjK4wQwGP6veMQ6aCTO9xn4JYyG8SaL/6My6
         8Cg0wLQI6WZQ/S3UFKbEXivTwnm4aoQzLkSRD1hCC/tVx7V21iBZjG5EZwh2RwWu1Evn
         EUAg==
X-Gm-Message-State: ACgBeo3oCF+AERnUo+AU9So+trfqC++R5nLz4/d8w/4R+KXid0U2YsP7
        dDmMz6YYuRK+xEzz9Pt6H+9T6Q==
X-Google-Smtp-Source: AA6agR7+AJPeAcWzIKKPAUQqUNDiGibnaRRiY1ldxGkU5iEvz7Z8KODNoh3VQbhU39rSPYcKl7QjEg==
X-Received: by 2002:a05:6512:1585:b0:48d:158:7013 with SMTP id bp5-20020a056512158500b0048d01587013mr1116184lfb.536.1660298120968;
        Fri, 12 Aug 2022 02:55:20 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id s12-20020a05651c048c00b0025e4ed638dcsm301594ljc.59.2022.08.12.02.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 02:55:20 -0700 (PDT)
Message-ID: <af463efe-1656-5638-b41a-5daea3099812@linaro.org>
Date:   Fri, 12 Aug 2022 12:55:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 7/9] clk: samsung: exynos850: Implement CMU_MFCMSCL
 domain
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20220809113323.29965-1-semen.protsenko@linaro.org>
 <20220809113323.29965-8-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809113323.29965-8-semen.protsenko@linaro.org>
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

On 09/08/2022 14:33, Sam Protsenko wrote:
> CMU_MFCMSCL clock domain provides clocks for MFC (Multi-Format Codec),
> JPEG Codec and Scaler IP-cores. According to Exynos850 TRM, CMU_MFCMSCL
> generates MFC, M2M, MCSC and JPEG clocks for BLK_MFCMSCL.
> 
> This patch adds next clocks:
>   - bus clocks in CMU_TOP for CMU_MFCMSCL
>   - all internal CMU_MFCMSCL clocks
>   - leaf clocks for MFCMSCL, TZPC (TrustZone Protection Controller),
>     JPEG codec, M2M (Memory-to-Memory), MCSC (Multi-Channel Scaler),
>     MFC (Multi-Format Codec), PPMU (Platform Performance Monitoring
>     Unit), SysMMU and SysReg
> 
> MFCMSCL related gate clocks in CMU_TOP were marked as CLK_IS_CRITICAL,
> because:
>   1. All of those have to be enabled in order to read
>      /sys/kernel/debug/clk/clk_summary file
>   2. When some user driver (e.g. exynos-sysmmu) disables some derived
>      leaf clock, it can lead to CMU_TOP clocks disable, which then makes
>      the system hang. To prevent that, the CLK_IS_CRITICAL flag is used,
>      as CLK_IGNORE_UNUSED is not enough.

No, same as with ISP these are not critical clocks.

Best regards,
Krzysztof
