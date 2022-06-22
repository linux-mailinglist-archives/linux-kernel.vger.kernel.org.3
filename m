Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6F5549A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354780AbiFVIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354357AbiFVIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:36:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D78387A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lw20so10274875ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ff8K9wYmcpckkjag/EKcwkV0fZLbl5TDrCb2I2o5dFM=;
        b=L4tdK1664nj3aQaY/A99UtyriLW08gWv0q2jjjqGmgv+elv3QgNvhhn+e6h66T2pC0
         3ahvGA0waWh5zdgi6CruORoziImkQVLEmWFkqBHiVH9GNSDZRh1AuNJLoS5lzQRqCnW3
         L9VFMX5vskcyaT0Jh2JlNn+poy9vFv5W1RfeF2A1EKIBqGhpSftYqe5rn4V66d9z7SEu
         gsUOHM1ODP7y+EHbzUKvFCUrnJFqwsCXHq2Vzbi8WgQVOXhp2JTMvYrLHYFOFiP/Kkir
         NhehWvuSKlOeUvsl0X/tQWglAq98fegGf6eOAE0JTxnNR48fzrioTsYkMO0t5t91bXmc
         kQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ff8K9wYmcpckkjag/EKcwkV0fZLbl5TDrCb2I2o5dFM=;
        b=w7pmaExXLBLfLgjg8ojR8ZUr5cXoZjMKT1R16FWjpIGCiVm8tzDdv2G1VIjoyoCUTD
         5Npu3zWGSIIVGQlemsxPgD/2m8NYMSlO9K33f5gTIzvjz31B7+6kFfE7C6m6jNgoI0gt
         ov1lBWzJcFKDgEEbsVoHEJd094ZvrHFuDVuj3WPqL7VAmQ788TTnpSHwFL53Nd04nY/k
         N05jjVYkejwjg3INXEI5fpMIGUTsoWxkcq4jdo3E0Sdts17i5rrCgiaIdcIXZBx+j/FY
         LaA+kmEVTPC06/2mXr8DyEtzLDZVsPFnXA+Mgfa+pS1DZGukxIG14Avm3EILXKM9vW7/
         lGLg==
X-Gm-Message-State: AJIora/+1AIeXknnZvU5emNnzy7SS+aAxxdmyrV6ALpDnjm0A7mBR1Z9
        klxAgwHahi1i+NfG23bDaAFpOQ==
X-Google-Smtp-Source: AGRyM1v6nzKzrABu3SQDg6pVeU2UEbLG/0D39/mv3cqF992hAT7eWKUuWd4CDBjBYfczKbXdwye69A==
X-Received: by 2002:a17:907:7d91:b0:722:73d:445e with SMTP id oz17-20020a1709077d9100b00722073d445emr2047669ejc.690.1655886951974;
        Wed, 22 Jun 2022 01:35:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b00722e603c39asm1979733ejc.31.2022.06.22.01.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:35:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH 3/6] ARM: dts: qcom: cleanup QFPROM nodes
Date:   Wed, 22 Jun 2022 10:35:37 +0200
Message-Id: <165588692598.15720.16529569565049013574.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505113802.243301-3-krzysztof.kozlowski@linaro.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org> <20220505113802.243301-3-krzysztof.kozlowski@linaro.org>
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

On Thu, 5 May 2022 13:37:59 +0200, Krzysztof Kozlowski wrote:
> Cleanup coding style of QFPROM nodes - put compatible as first property
> and drop tabs before '=' character.
> 
> 

Applied, thanks!

[3/6] ARM: dts: qcom: cleanup QFPROM nodes
      https://git.kernel.org/krzk/linux/c/d7b50df0b8d12fc0742be4170054f0c87bedac91

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
