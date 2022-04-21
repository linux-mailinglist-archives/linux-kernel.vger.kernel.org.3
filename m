Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6046050A255
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389288AbiDUOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389296AbiDUOaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:17 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB53EA93
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:26 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e4so5799593oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wBmsFVzEWJfGZC3JHUok0FZewd7QYZ1lS1g/dkDHsM8=;
        b=m4nQDoRRgo1EGi3vObPuMc9P6s1GI4+JfoLzVLmBoQ/srs+fDrLvKMpL3JHhgvnlGW
         VuTI33JYOKagO7UWTrPdUycIUx+mWf+v68ytJUr6HT6LFGUxa3h3eXt/IYn+fAi3bDn7
         p4CVVNE7qw6d83k23OQCg+UGiQObstsWScPIEEnjNPv7DEqOVFP7lVF9A9PesIdLp592
         1s9hIhWsizRQRTK2PG+ywNwYAfo4D/kj7BiEx13JYCcLNnvC7JHLMvHW6iAP5m3Xxx2n
         Np7yJZAmX9MHURqzkxRZ3010V57ayDlVC9aJvw4f7UCkuGDX7NKWUR1JK5DE1NjztlUX
         LIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBmsFVzEWJfGZC3JHUok0FZewd7QYZ1lS1g/dkDHsM8=;
        b=iuFNLEsDeJK0ShWDE7g49wtGlaSTUotBHXqJ6f6KL6kSLkruPh/JgK4sFIcY3oW16l
         CidO4y57pf8G/znAj7Na+dTWvzJxogCqr5OWqyidwHuR7Tar0yrHznk3Ldd1Ywk7hVOx
         8h/wdfWQeoVpY7PixED7Qj0f5LP+WykJS/RW+u1wYFiwzlKGGhLSNyStEr+sSY2EFmp6
         dKgwJFeVu/HLrHu1GXo3nWSFumXcaATWuZGFZARq6ZPTz23a9TBteF3gM4FLhLIgB6xv
         9tELkn/MsH0qbz8pJBx5cPAeDWr7Kj75KXfSzkDi2mYsf2YIjEntDdGe2jUpb3os6iW7
         Ps3g==
X-Gm-Message-State: AOAM533SKFr/wOUZQjHa3S4VKs19ALaJGdLYBqG281p3csG3Du2IB7FG
        fjzdooRsni6DW3WuvULXOZVsZQ==
X-Google-Smtp-Source: ABdhPJypE9dR4sblVTuBxzilcegBNIX9pacHy/1gcpgiP8HxFJHk6RD3TPfpYfzjrT/3t37cVEBphw==
X-Received: by 2002:a05:6808:1144:b0:2ec:b290:80e7 with SMTP id u4-20020a056808114400b002ecb29080e7mr22237oiu.26.1650551245383;
        Thu, 21 Apr 2022 07:27:25 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2] dt-bindings: soc: qcom,smp2p: convert to dtschema
Date:   Thu, 21 Apr 2022 09:27:01 -0500
Message-Id: <165055095990.2574292.17902569355793925836.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411155528.502889-1-krzysztof.kozlowski@linaro.org>
References: <20220411155528.502889-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 11 Apr 2022 17:55:28 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Shared Memory Point 2 Point bindings to DT Schema.
> 
> Changes against original bindings: enforce only specific names of child
> nodes, instead of any names.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: qcom,smp2p: convert to dtschema
      commit: 5f9e72a4025b232ef0ddd5b6e4189e81091322fe

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
