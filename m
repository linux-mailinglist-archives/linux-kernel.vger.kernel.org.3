Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04217579229
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiGSEsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiGSEsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:48:18 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFBC3AE47
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:16 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10c0119dd16so29317169fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wbp2fuBno9esANRvIn9wa5tE4/NKiQFOj5vJk98QBAs=;
        b=tIIkYz63j5xwHjD3zjRWjbswJpIZjPdJQPscGvHsbgmpnw0kQcFGzUO+6Cb2NhXLWb
         XdOvtH5gbce5JAQORHVtgjBXEBaSfpmcBBXh7Kt5/JGWsK3YEgKObaCIccFX6Y7mDfMP
         2VrsUHZ9nYZeSNWXZryEsD/HJdjIbZ80LcWzK/pSS1uVBctRAn37p1IHgzRutNkeW6O9
         7aUU9xXeOelNzX6lUckY3/E5r76FCyEqkoyT7ZctsjiS9gF0V0DPAj5kKPxWAxxfXMDo
         KWC5RhV4sAfAS2JiraAHPrXGmnhfXhZgkUEBQkoQE1FDzJvTG+/6Dyp2vxvlEGSP8Kr7
         GkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wbp2fuBno9esANRvIn9wa5tE4/NKiQFOj5vJk98QBAs=;
        b=FH5syS9D6iuYTw5uiQGHqklWv905/YKNbyPVgJGCYzEISX12MuWc+S5vuagd7XIc0S
         Y4R2ivCAgCdIFUDJbzp5r7jdAQmkbxNuVJbshxCWJepHkIjCgXC/3wiPNWISW8W09rk4
         eag/vatpdd/IlNi1mjTtf0xArMsYjEGC7A9ZTFI82ZB8xuY5DVbH/HAsRY7s+i1rtptT
         pzV7B2shZ5pApw7owDoMRlBmMV2O2Px45P8bzYzF5f2KfH/7Yy5NSnYjGLll12DmB7UY
         nPhJWIOhG+9bNVKwJqEXIehnkeDZf6VD0oTBgkHnmvG6cm8hyeOLbQ7RjASTm73S/54W
         pQmg==
X-Gm-Message-State: AJIora+5+jAhCZF8Zuh7MlaZuSma/bJAgdp3U8QtMWymbvdVJT8Hf84U
        lMLkzRIMwgKHF/EdkcWlT5dmAw==
X-Google-Smtp-Source: AGRyM1vB4t5z5nqhClDDscDct4bWWW5EQcNmA8dhUgjfA1OxSGmHP9+RNxf0fOqtZqPmBKctNoOywA==
X-Received: by 2002:a05:6870:2423:b0:fe:4131:6db9 with SMTP id n35-20020a056870242300b000fe41316db9mr16008796oap.75.1658206095762;
        Mon, 18 Jul 2022 21:48:15 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d70c9000000b0061c9bbac1f9sm2803209otj.16.2022.07.18.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:48:15 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     steev@kali.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sc8280xp: add missing 300MHz
Date:   Mon, 18 Jul 2022 23:48:03 -0500
Message-Id: <165820608070.1955453.14185366783743753020.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220718225714.8074-1-steev@kali.org>
References: <20220718225714.8074-1-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 17:57:14 -0500, Steev Klimaszewski wrote:
> When booting a Thinkpad x13s, we see the message
> 
> [    0.997647] cpu cpu0: failed to update OPP for freq=300000
> 
> So, lets add in 300MHz to make it happy
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: add missing 300MHz
      commit: 5969d3290fb5daaa40446c8610b1fbbb78ff42dd

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
