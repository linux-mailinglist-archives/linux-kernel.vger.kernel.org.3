Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6279E508493
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377066AbiDTJNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377060AbiDTJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:13:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F7A31903
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:10:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l7so2220451ejn.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sqol68HqvgykQP0mBplsih5xwUcq0N0BeoEU6Izjsrg=;
        b=A616bAmDABOaqD1AFXlQ2NC0J1otij5nJ6AlSdyIH3dWmMP24eT+rasB3Ha9EjoWq2
         2BDShFBwFP7HsvtgFQujpyIcWmocDrS96+8/5QQj61juuiprcJK72Qm8XDEG/E2+F9SN
         MVLHeNmPXpqNQ7CgrhhN1p2OF3/6r3lr9dkTMvHsyo2XpXjX1jtMSAqSEGtp/QhkNiz1
         2Pt9tmdJWArBwKwwm95F8G6kht1cQDFfqj4XF4DkZ1zF7bOtEInL3fd6+CUsNPzCtyVd
         PpcRxCUtBHz0ePSsdBIcHLQ8JvmtQHXOwaUwBvc3G3b7Uk/+4cR2SQhSITu0MD0Irie5
         sbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sqol68HqvgykQP0mBplsih5xwUcq0N0BeoEU6Izjsrg=;
        b=SkCgeLeV1dEGTYagD3Vs6PSyx6aNe3Hh0YwaNBmCHRdbcIl29taSI4n4JdqKpZyUkU
         BVOz55Y7TK5/3W9i4oLkB4yzPklwYf4O3Lrq0c4s+1vm0W+mB+/ZHMrue6XzRzytgMFN
         KKHDB0Jdq9sbQKBu4rwt90p3V6+gLLypimJr//H6/TdImf8gqMl+vJ/nsQSTwkgiIp4R
         odYuCITU02FXxyw0eqZ+MRcO6QS3NsMe3R0lweSn4MhCQ94+EkBUKMUn1JhCnUB78mCf
         UrISMK356wF6k6u5tKk+1gEPVFVmHuxpx1RKj4AVAV27UbzJ0Ideu8DsRVFgzd/mX229
         8f7A==
X-Gm-Message-State: AOAM531MRNnV2oPck6fQxooZH5TSTAofGv2lmMIjQsu/KR11jv+cUS6p
        OImVTlFNYEbgAbebFWdz4gtmFw==
X-Google-Smtp-Source: ABdhPJxG92rPSC3hNtQHBpaG7HiZnIUs60MNNSFnIks9tTPwIDOBQYMRSTrb6KzJ4JTHbkzpA/IZQQ==
X-Received: by 2002:a17:907:d06:b0:6e0:e2f5:4f55 with SMTP id gn6-20020a1709070d0600b006e0e2f54f55mr18000749ejc.618.1650445827173;
        Wed, 20 Apr 2022 02:10:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7d583000000b00420a8b66566sm9727057edq.97.2022.04.20.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:10:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: mt8183-kukui: align SPI NOR node name with dtschema
Date:   Wed, 20 Apr 2022 11:10:15 +0200
Message-Id: <165044570803.75184.17759035800452933385.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407142143.293740-1-krzysztof.kozlowski@linaro.org>
References: <20220407142143.293740-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 7 Apr 2022 16:21:43 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> 

Looks like no one wants to take this, so let me take care of it.

Applied, thanks!

[1/1] arm64: dts: mt8183-kukui: align SPI NOR node name with dtschema
      commit: 4e3ffebd69e0aada1ce6bf4bf832e14a3c4f50db

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
