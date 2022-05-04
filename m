Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78CB51AC23
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376263AbiEDSGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357890AbiEDSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:06:09 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A173250047
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:21:22 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id s11-20020a4ab54b000000b0035f0178dfcfso299438ooo.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D67xxsOmDc+8e4U34erMwd0+oeSj+9iMffLFWurK75A=;
        b=pFZ5gsS+V2/McNEzMjJ2PCTzZUOkiYFbx54V6u+Tr2/PZrUNGJkbejK75hV0iZmloX
         IK88gYrwWOlJVubbzPQakaGtZg038E/SmTi32VlOmN66/DPude/cCIouLuivjBq0Ik5+
         MzbLSVtcdX+0/V0G3Qe2izfxTyq/ZYJlH08NjAup5yQ+wV2Er/cKTIMFN0bsglk1X3kN
         8XePRSJL1djOrAGlYh3/+fi1gOVqm2cRCC39lamBtvaL9+/7r6+TFzI9MKPxtsktESqQ
         67rDAxrguBdCzRFJVlXDzeaStnICAeWXmZjYyYvXrqNkjrBGLDhSOwzjXlVhkYnw0Pqq
         tXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D67xxsOmDc+8e4U34erMwd0+oeSj+9iMffLFWurK75A=;
        b=M8p0I/yZwDDioRA15L8USONlWMBiA/g8nQ38ZD+aVUSic8zS3XDQIKxIcOrV2xX+/J
         CBrxRvS6oxTeOSV74pcGe8YiXfHBuG1zKEYE99nHOHSQsJ5Bw5YnzPWm8iFiiV58l4ly
         rlOl8cgAXdPjfqp63og0aUFjWaycV3hAcvbQGkqR1Hd+4T2GVxG5I4PnvGO7UsoaZA3T
         AcYxi5PMIVAQc/WCzPQDx8oZTqbbuOL0M6JYC8TgiOSWWfLJvimJkwyd9r12+a69kjtM
         YjDaPfWsa5DSm+hmOBXp6h0qc152gK3+0sxt5onQnYd3msPI2ooQODenxMj31bwj++wY
         VK6Q==
X-Gm-Message-State: AOAM530H8STPOLwCnRm9nvpKo0zejB4bMYsDuWS7FqOu4JDgojfpNwvs
        Xz2quPm0e/Sk+XkYR0agFVgJQg==
X-Google-Smtp-Source: ABdhPJwlLU2uM3Rne7tAPGdFSZ0UBcyawiH2dokXvMOVV8bbrcEMMP7yfPfur/DaCD5gO9wtPD3OeA==
X-Received: by 2002:a4a:d48c:0:b0:35e:aa26:b720 with SMTP id o12-20020a4ad48c000000b0035eaa26b720mr7601735oos.12.1651684882013;
        Wed, 04 May 2022 10:21:22 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b000ead8b89484sm5785452oal.5.2022.05.04.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:21:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] soc: qcom: rpmhpd: Add sc8280xp and sa8540p
Date:   Wed,  4 May 2022 12:21:07 -0500
Message-Id: <165168485226.3730817.13906711801851498920.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
References: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
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

On Tue, 26 Apr 2022 16:35:05 -0700, Bjorn Andersson wrote:
> Add compatibles and power-domain definitions for the sc8280xp and sa8540p
> platforms.
> 
> Bjorn Andersson (3):
>   dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains
>   soc: qcom: rpmhpd: Don't warn about sparse rpmhpd arrays
>   soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains
      commit: dbfb5f94e084287f0a3f23d14ef6692c43c98855
[2/3] soc: qcom: rpmhpd: Don't warn about sparse rpmhpd arrays
      commit: af77132e9d2bc8ca477003fef15e2c677ae958b1
[3/3] soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains
      commit: f68f1cb3437d338ee88a9fc05acd19dacdb9aabd

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
