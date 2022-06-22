Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3E5547F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354718AbiFVIg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354358AbiFVIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:36:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E938D82
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z11so16679517edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vZGB+vVdn0hfE2AUTUuqmKMT3+8b9V2vIFB2a1YVBio=;
        b=XCNrCiRdSKlX9Ud5k/iV+HhrNFyTB7nloc6Ul1NBrUIDqbsbVEr8WK80YCW9DZgZ98
         U8rSp3zmxrxGWaJiZeEYSu+EvwMgE6ldR8TwcrPlESi516HT+WodagmYm0dItc03IT/q
         NSz2GK5f8xanGJJkdV3l0GhNVsF5OxqeUC9GoN0nsK3EByAUJyWPTG86qyNC52LhTWUA
         J9nv/HAfUs4Ef1YD/K4YVPIZeqFK7b/SKKb2wYAM0NOOZ3xc1m5fnAx8ZSMGiScs+vbX
         LrzcGjJ3WGt1B2Jgi0Aiu0sqDge5EcHZ2T83J5bsFxc4oul6n7jHDWXS8oEJe6Eu7uTm
         IG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZGB+vVdn0hfE2AUTUuqmKMT3+8b9V2vIFB2a1YVBio=;
        b=18vXyi4vlijKKm5fbG84hHmgXca4sfPmJpVgSsiV0OE5qix7VBwS5ZjNaSUcUdXfD4
         qukFYlwR2kiHENdEYXoCJmcxp36gU72kqDCxHa1QbBC6jQw/O/NP99s0jWTBBWv/szc1
         xV/qs5vcZfOmfGGIg6WK+EEQMlLb/1LCHwRQJOuyarye5zi+57Vb7nUlBZSunrhNKHoe
         Mi63oegSnM+3wyX+QDNBJx7p0ALqDYzI8zzSGP9T0WDMN/lmNUF8qS6Bb9eFxcU8RLAC
         lxaEm/u1Vhu2X/UkSlUnNi+DyMW7IxanIxy68COA5oQBYbUx03vjS5i9HhyglnWq9+ct
         jcYg==
X-Gm-Message-State: AJIora9XBkwHIn7A7MLrmn0umDEzTWwAQ+zoG6o6wa1UFit5VskMkRZh
        54XmiHXB4AdW14hRE8cqfRnloQ==
X-Google-Smtp-Source: AGRyM1t2tV2ubcU3htJwFgUp8Qkan7+fLynGlxWenkV2LjmczNdCBN2h35/UHDcR51ua+zZomFvWWg==
X-Received: by 2002:aa7:c7c4:0:b0:431:75d6:6b3 with SMTP id o4-20020aa7c7c4000000b0043175d606b3mr2727346eds.280.1655886950802;
        Wed, 22 Jun 2022 01:35:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b00722e603c39asm1979733ejc.31.2022.06.22.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:35:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH 2/6] ARM: dts: qcom: use dedicated QFPROM compatibles
Date:   Wed, 22 Jun 2022 10:35:36 +0200
Message-Id: <165588692598.15720.8614069769896116011.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505113802.243301-2-krzysztof.kozlowski@linaro.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org> <20220505113802.243301-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 13:37:58 +0200, Krzysztof Kozlowski wrote:
> Use dedicated compatibles for QFPROM on APQ8064, IPQ8064 and MSM9874,
> which is expected by the bindings.
> 
> 

Applied, thanks!

[2/6] ARM: dts: qcom: use dedicated QFPROM compatibles
      https://git.kernel.org/krzk/linux/c/ed07c2af405fd6f7508997a3b55a74e1d16f467c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
