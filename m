Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5755492F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354917AbiFVIgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbiFVIf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:35:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEEF387B4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g25so32575853ejh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=G0Hew8NxZ+rzy9l9as3KKPwHdsdjYlzvGwgcXr2LH00=;
        b=BcIyMAqpTNkDoo1XApOY053yAeXaSUhlI7fzokSMjFeU6AllHlkI7IQ4OlYSwhqyya
         fJsQL6VPGirPj9al3/TxwtClMi6+XngGSVdhR5evPEHCuCNkQW2wkGNuMSkmxi0t3fzm
         H8C09MwAJ9UsqZo55e60f774raPl/kKDDbzD77GjVp3AdVZnREaHQhnosOgFIcBxXRGK
         cOSvS8HpaUjVPv/L9qRYSCajQaGmJ5peMHZerw5NQ89mLXjpBswwloDbZ2X/Kq0dyl6C
         4JVPq7a1PQsL5xKpA7fmIRKQsNfRXdVUor7pZmQUi+VukpyLJYvpNmJPBy5JrTF/aYyL
         o7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0Hew8NxZ+rzy9l9as3KKPwHdsdjYlzvGwgcXr2LH00=;
        b=cVjQFMsfV+cAXHFL0Tjj/ucZKty7EOcdNO6FH3iszMhVZLp+WuxFZMAoJLRSSiyM0x
         9e202edLMYpgaY42ga8AAUBEHMJn94+oU5FrpW3lSr4h6CXuKdN7xGLpXaROJ+gao2AA
         SckWKEHxNPPORo4+lWLOsIBPOzgNaqVxsvJt3r/SN/S1bg7HkHzse2PjW153znaV6AEn
         c3y1Wh7zFr+NFoRjbh/1OXfT9nSYjO+YZD4FwzT8eN+SWrKDmS5bEn4EWaIiyqAS54Im
         dnDpcYELCsKM5MZqES3T39GagAmNTq23gmWFP8LcZoUz6qmmhFDjA8W+zrSZwl5vbXh/
         uB8A==
X-Gm-Message-State: AJIora9rsEKSOIw8FVl3VzCohgUcqcDTYFxSNfS15RJjuZz6LwlGvhhn
        nikkZ3gKEx+97AOeQmaJpzBMUA==
X-Google-Smtp-Source: AGRyM1sKRs7A8ZkcEm66QHBH+ciBgyX+iGWt6byWOyH/I1Qi4wshCcN8/ZO+HJgP5jFh9IiEFs51oA==
X-Received: by 2002:a17:907:3f02:b0:6f3:5c42:321a with SMTP id hq2-20020a1709073f0200b006f35c42321amr2021301ejc.521.1655886946975;
        Wed, 22 Jun 2022 01:35:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b00722e603c39asm1979733ejc.31.2022.06.22.01.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:35:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, agross@kernel.org
Subject: Re: (subset) [PATCH 11/12] arm64: dts: qcom: ipq6018-cp01-c1: fix Micron SPI NOR compatible
Date:   Wed, 22 Jun 2022 10:35:33 +0200
Message-Id: <165588692598.15720.13159853484796429500.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220521164550.91115-11-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org> <20220521164550.91115-11-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:49 +0200, Krzysztof Kozlowski wrote:
> The proper compatible for Micron n25q128a11 SPI NOR flash should include
> vendor-prefix.
> 
> 

Applied, thanks!

[11/12] arm64: dts: qcom: ipq6018-cp01-c1: fix Micron SPI NOR compatible
        https://git.kernel.org/krzk/linux/c/a8e40323875c6a2dfe151eba56b2065744536777

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
