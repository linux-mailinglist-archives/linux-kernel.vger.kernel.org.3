Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B175955C6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiF0JRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiF0JQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C706144
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ay16so17782146ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2Fqyg9C0YVFzyK1iMgVUn7n3ab05J1+6/AOtaaEs2lo=;
        b=BLQB6PAt3wDY+OC/w8s4493IlGzY/KsudGbyfBjPFbbgzAN8ZEXS9zIPttVQQGpVsR
         uTjVVNHnC3gugqjPUCG7YGXwh1WUkMEanidhBYU7j9WM1mMd8/CVX5NhT0+2SDWcRMcf
         ugruGVhZKfe7xr4Q8j4Gj7XPksXGzutTApWgUhCtjrXZ3NxsvoxSbi21girOBol9Rizo
         yCeUHo/0QIdOGuRUkXhrlpE3XocbsMa1QSiTLG8DyoNVB65MoBF4Gu8qMiN9LeqYBEl9
         oUxoV/b2a0bqFYHMw/DMKo9Z6Np5tr650bA40EbAYyF4DDQPZOYuw/GeftOv+3o5wTMq
         3yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Fqyg9C0YVFzyK1iMgVUn7n3ab05J1+6/AOtaaEs2lo=;
        b=xIy5UrAjAD5mxthyA+u2TWXrrTxGzYYDtUH1AotzSCdwcdmkRPwf2CPGXE+wSgtjnc
         gvQlImC0POCAOKIU7VHWPLKCmxvkpX3AWfhA21IdY8JrHWqwiuFX8L8nREGWcvqX71nO
         Pp7s4cQ4Uc3m0+10xN4Y9CgFDDrAk8SDV/2nhATnMFjGJuI3UTqirt7kmdyyfJEA56/5
         G9XI4KctKt4ePEyiPDbN7kChQrYssG77pXOcjGeJ0PMuIH1qsoP00gSrmVQoZixMNk/x
         MO8TUa1l2xMkl7DtrsPRPpTnyJnWVVV50FdGAYUNy9p5GkpbHyEcz0jVyvp9ugIvAplp
         a5iw==
X-Gm-Message-State: AJIora+AtIJJ0qaSSF9SoCaZZdAo4MMt5fGFELlWwLrtFcZ4iPfQU+2V
        ynTKmTpu5RnbuYkz70Xj0cHLIA==
X-Google-Smtp-Source: AGRyM1ve80Csa3fctAzzt6e06uZVxxk20Y9k2+j9/VcyLhE1hqdWUtICp2LkmhKpII7QnT3IxcayBA==
X-Received: by 2002:a17:907:3e11:b0:726:372b:6c32 with SMTP id hp17-20020a1709073e1100b00726372b6c32mr11930678ejc.157.1656321380448;
        Mon, 27 Jun 2022 02:16:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        arm@kernel.org, bjorn.andersson@linaro.org, olof@lixom.net
Subject: Re: (subset) [PATCH v3 24/40] arm64: dts: qcom: align led node names with dtschema
Date:   Mon, 27 Jun 2022 11:15:54 +0200
Message-Id: <165632135505.81841.3254747322278026841.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-24-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-24-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:53:17 -0700, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> with 'led'.
> 
> 

Applied, thanks!

[24/40] arm64: dts: qcom: align led node names with dtschema
        https://git.kernel.org/krzk/linux/c/365f7c26080fefc78a6d76ee4ba29e33a5a270d5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
