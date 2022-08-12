Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5544F590DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiHLIsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbiHLIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:48:12 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC690A8CED
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:48:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j3so341955ljo.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CLzs8Hfa3KztE9SRqcc09r7QXqKpqOZdSYJ4jIsJilg=;
        b=xCFevfLM2/cMx2cP9QD81k3j/lVrK7HfRCBNvCrxz7RRLT4UB6TiIMGQh6ieXvEEUb
         8kbrWE3m44cFQhMqAglVryI/tOU2C9y4att8xgsDFCS2u5IO5Uj58XmwWA9qFhONt0nu
         0QguXU9K8MxTlPxkOq7fOgd9ugsbD6YH9ehPPQDOuMF/QbkPrfYyTdXp2cbayMDagKki
         GN3GkD+TGMU/dqxSuBAduniGOCZ0D3pQXBIQGdHzm8NpeMq2D9veDrm7PjVEG7B1kJqB
         nDh0Zi8oDixzPWF1y46OdSvBe/kbsxpS181gs4RuCf1IqoZFXuntHWDYFP7whCXpr1UD
         N9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CLzs8Hfa3KztE9SRqcc09r7QXqKpqOZdSYJ4jIsJilg=;
        b=YgkP4t9c90/R5J9oq2P48kYQcQ+ijaa4/W0thQ5u570diKGeKTGUDk0AG9EtNWHe/K
         xvjMe1Kg2Itv/p7l59WrdAQgOFzPyzHgWOwmTQ1OwR7dAihiesiB8dde3ica9h9KnhZm
         7y41pd1vFtdKHTKVv0OOQahB/7NjAqEZzk9AijeKrFgUzCrhFQfJrY0wmafrfPuKgxsw
         +g2QhbwAIUM/pt2LZlpBuviDx/r8rvGz6hUvP7idH7xL/hobsZI2tz4KXAgkB4wsxtjb
         ecvedIc644Jyx5WmeV/GAmkr8b/RjA/uWEprrR5AavxlGvrD7TZaLJHAJsB8Rf/c15/K
         1FnA==
X-Gm-Message-State: ACgBeo0cm/k6mLnSv3yoyGpd269zDYHgT+vFvwWgpYRWxsfY9zpS5QcX
        wy2CRSVZ4S4bfC9Vc4JykRbhBw==
X-Google-Smtp-Source: AA6agR4xHcNtBpe7saYoDXeMcEiTyaLBTd5Lxd8rdt6uwe2LTrvjTgNcL/mjitGy12LaGZQJryPJXA==
X-Received: by 2002:a2e:918d:0:b0:25e:c884:6a96 with SMTP id f13-20020a2e918d000000b0025ec8846a96mr904692ljg.157.1660294089278;
        Fri, 12 Aug 2022 01:48:09 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id t2-20020a056512208200b0047f72bf3c32sm140709lfr.77.2022.08.12.01.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 01:48:08 -0700 (PDT)
Message-ID: <e49dd22b-ebd8-609f-f181-8feae65e631c@linaro.org>
Date:   Fri, 12 Aug 2022 11:48:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 5/9] clk: samsung: exynos850: Implement CMU_AUD domain
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
 <20220809113323.29965-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809113323.29965-6-semen.protsenko@linaro.org>
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
> CMU_AUD clock domain provides clocks for ABOX IP-core (audio subsystem).
> According to Exynos850 TRM, CMU_AUD generates Cortex-A32 clock, bus
> clock and audio clocks for BLK_AUD.
> 
> This patch adds next clocks:
>   - bus clocks in CMU_TOP needed for CMU_AUD
>   - all internal CMU_AUD clocks
>   - leaf clocks for Cortex-A32, Speedy FM, UAIF0..UAIF6 (Unified Audio
>     Interface), CNT (counter), ABOX IP-core, ASB (Asynchronous Bridge),
>     DAP (Debug Access Port), I2S Codec MCLK, D_TZPC (TrustZone
>     Protection Controller), GPIO, PPMU (Platform Performance Monitoring
>     Unit), SysMMU, SysReg and WDT
> 
> ABOX clock was marked as CLK_IGNORE_UNUSED, as system hangs on boot
> otherwise. Once ABOX driver is implemented, maybe it can be handled
> there instead.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
