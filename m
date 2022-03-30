Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1432E4EBFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbiC3LqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbiC3LqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:46:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852FE0CD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:44:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j8so10036471pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8lckiXNzARQSsA5+P/eLEEqntgliL300hVemOzydqT0=;
        b=BcCY/okiNv4nvroo/RehDacagqp6ijf9QG0AK66fHOu0TcCz+gSMghwri6btjZ1g2O
         3e7LlTfZUkVTtk+PYwuTbGlffH8XBhgNWegxBQMltpuqIKfIWzMwx9OT1pcTp4lWkNEm
         8BtwW+yiSdQ1qhDtlBoLlzcnn4nKWFbCij/HSpKfhIj3Y+bcAOaza/s1H/EQQJSfGAUe
         HrAVQ2S8TxOliuanBnGJqLOR6jHwxri0hdfpCPm6hN4FIF1B67nZBW0VGJRQIBBmlcv/
         DTghRTwCs6qkpgg788zoXAAqZynonbhb9MKwQGf2UAVTy3Z4WOU9aVUJHbFcgaoQzWb0
         AiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8lckiXNzARQSsA5+P/eLEEqntgliL300hVemOzydqT0=;
        b=YV9/tMG+Nyry5EU5k+gEd9uPMDsNZMcqeiRImgUZwdPZScP7vtRvjIpcKVXgJoLk2T
         sXGpfXx4zEEaPwWr/Nf5RG2/CT1ulQ+pRdveFjJ4K2t8Fzoe3ulTsE2mwatfTt2Cy9qb
         uoXUdXtJathHbChQ6iIGV34DxrExm4lMDzjmurHeikMnPc4UKmZ29Vap/iBx5QhtADju
         gNGjiaMpXl4U8aMGYBP9H5nptsNVVfwSYOSPt5mhuH6i7+RRqby5kV4ceDJ6cWqt/nYN
         Hd5K4dQXfi6itBapqjjc/B0AmepHtvdnWT6rNgFWSYEZUU6yeskXQmCASEv0xYeRKqdn
         59ig==
X-Gm-Message-State: AOAM531BuuSt09LD7aGDGBUGEovaSD+XRRSU0Qwnx6Nu1uqHpsneJrZT
        dZMLCbfLO/HxZZQv/1YUzAU=
X-Google-Smtp-Source: ABdhPJxz08oIGuuPHgSabWWR+HU0osSYrZ317XvUxeDLmeeWLAribPM+yHmgVXt646LrtfQBak6+Ng==
X-Received: by 2002:a17:903:40cf:b0:154:6a5f:95c5 with SMTP id t15-20020a17090340cf00b001546a5f95c5mr35283737pld.100.1648640667163;
        Wed, 30 Mar 2022 04:44:27 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a680a00b001c7bf7d32f9sm6083421pjj.55.2022.03.30.04.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:44:26 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:14:22 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] spi: dt-bindings: qcom: convert qcom,spi-qup to DT
 schema
Message-ID: <20220330114422.GB51417@9a2d8922b8f1>
References: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:28:58PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> The DTS patches are independent and silence warnings pointed
> out by schema.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (4):
>   ARM: dts: qcom: ipq4019: align dmas in SPI with DT schema
>   arm64: dts: qcom: msm8916: align dmas in SPI with DT schema
>   arm64: dts: qcom: qcs404: align clocks in SPI with DT schema
>   spi: dt-bindings: qcom,spi-qup: convert to dtschema

Acked-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

-Kuldeep
