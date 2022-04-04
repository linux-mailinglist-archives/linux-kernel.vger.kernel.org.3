Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7E4F1EAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377538AbiDDV57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379393AbiDDREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:04:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADED40A23
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:02:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f18so6828980edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/p+WLNXUI5URczlcIPz1GEY0wJAQj0mnV+4JMB7lqlo=;
        b=BmdxHiK7k94C6Aa24uQsBO1PPJFFU5ov8NdL0rGqw0M5yeUxzrwb6IaZ+rE9b385Bf
         JQosvScc4VRXQe5Lr/uLZkYmOZQlKXPTmVZhFiWsiOZ2nbhmEAg9O3+3S8Di0Yk4acOR
         IZzNQz3PxZ3LpBaNoDDAw8u/1+uTVBVLKWhZkKdXT9RVCxU51RGFZ5nUgahZ1ECPrNA5
         SmkccAmDuEIF+5ibk+/zYy3sGMg/wyFlEqz2EQBKz0mv6/qBFpQl8SVs8sObsCmwbXtN
         VorJKnSgo9b/cFfjLNyIh3X3AV6qM729p5t141sHICz68ssz9RPIFX/cT8w211EvrlGe
         BB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/p+WLNXUI5URczlcIPz1GEY0wJAQj0mnV+4JMB7lqlo=;
        b=cfHyJUvdOC7Zar+Y1gaF7ztFwCkwhrJ7OF/fhoInWVQvmgJnmoytzDRedz0A0iI0Gu
         YcELpM7Q4GVmH/56M+2e2JLaoS7gVHWwTfii/igwHd+dnJJ7jqcCda4nA36+sLVT5wfH
         LklFSQtR4fROiZ9ijJS4QCo/ULtDF3ddMuXkDlE1g4mMaYvXBe1oS3LI1x1yhQNNobQy
         wecDhz/BltNM91BxmQGpdg+0p9DMQEmDC/qN5bGk4LEi7CDGRmbRTaXsv5HtTKsid+eu
         63tgHfPUnLPiQVhqSU+iUrtocgn6/mdP4jFk/pQq/ymeo2albVKfw/9//A5RngqQa8cH
         CauA==
X-Gm-Message-State: AOAM531WhwmMeQNBuHmTjyQ+HnlUYzktSNiT1/dqB0RdlfxSnmX83mpQ
        AJLn+wmMImhk4swtX/ptntPKHA==
X-Google-Smtp-Source: ABdhPJxD2eBoIbkXILLZ9KRSfUZ3rClQVNQQ/eUgdwSQJWKc8yH4C442dv0oSfAnGSVVUqE22Ht25w==
X-Received: by 2002:aa7:d553:0:b0:416:4dfc:126d with SMTP id u19-20020aa7d553000000b004164dfc126dmr1140735edr.213.1649091746662;
        Mon, 04 Apr 2022 10:02:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfdfdac005sm4588927ejc.174.2022.04.04.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:02:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: move aliases to board in Exynos850
Date:   Mon,  4 Apr 2022 19:02:23 +0200
Message-Id: <164909174137.1688710.12339580855506130725.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220221075219.10827-1-krzysztof.kozlowski@canonical.com>
References: <20220221075219.10827-1-krzysztof.kozlowski@canonical.com>
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

On Mon, 21 Feb 2022 08:52:19 +0100, Krzysztof Kozlowski wrote:
> The aliases for typical blocks which are disabled by default in DTSI
> (like I2C, UART and MMC) should be defined in the board DTS.  The board
> should add aliases only for enabled blocks according to its specific
> order.
> 
> On Exynos850, move aliases of enabled blocks to E850-96 board and remove
> unused ones.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: move aliases to board in Exynos850
      commit: f4324583cd4d4979ff2e885a44b8335eb4c4bfa3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
