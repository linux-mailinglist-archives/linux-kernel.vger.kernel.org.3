Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44715564468
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiGCEBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiGCEAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:00:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA37DF1D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:58:01 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10be7325c29so1567137fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqyiAQCsv4kueiyTuJlZq5fJpSW+HSYtAJH6JI8iovo=;
        b=C29kVsdj8+lLuCNMCq6lYmN1qUMkNEmg4xF1CUfY/ILAWTdg++AUaW6nWmbAPXBEQ+
         eH1xOBFQhZHzzJyzk8917HpKSy8m482OV4zzDDcFGDC1sV6eTjJQVBCfCc71QZnblRAh
         HS9wLDp9Ts5d+qHY5lu2pYMvbpOJOKxBLoT56rV9UBqWOZAlNTiJ3bRTiX/NNNfDPon3
         mZ1S/vLK8JiyaMmvTneY3bOiLGSBLawwFQfakWxxw6qdcYAxbniLJdveO0jFeWv6vClv
         lANYwchkFmQmsfJav9RYJOzFMsTNQy2pEmcIRWwUPKGMVJ0K4FW4g0brT9d9MHeJL0He
         Bx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqyiAQCsv4kueiyTuJlZq5fJpSW+HSYtAJH6JI8iovo=;
        b=wD9/ECXh/gIXNT23sGPaiyg0X4nXORTWVW5uKldw/NjP+ybJoq0CQnPlXRKbR3xq2c
         u7AIU04xF+fm94mSBTRmRh5xFM4D/LILCn3Bs0ZmoujeIRPxMbNL4MKxJ0AOv/2zEUS2
         LrOoKYEhzCMLSgK2i6CgoFSjGjUXo/SByixxt1AKtFjkYCT/JZFEvMEvRdjbHq9Da3zo
         rxLbPyqhl7XX8i1PNOvMR83R1/1k06U+hZFwRDRY0aqb93qa4jEdUHkJqHlCcJVNpFQY
         POeb7+7iZk1W5GKVXcQu5Trs+7M3GLy+7Pqa4mq0sKIp8KUlttTDdtVxswiTN1cdXULH
         J7EA==
X-Gm-Message-State: AJIora+2a/u6yiQMETBsNl+NvIwtaPHYYTQOHjfcpEFG3shyOmd29L36
        jXM7Jz7JcL8OhvDNNpEqYjUPFw==
X-Google-Smtp-Source: AGRyM1t8c2qtTapQSIxKvoMHitxKKwB148sy9pCaK8nXcebTTvPDyyjc+hNYiwiIwPwXLPvbzz3kew==
X-Received: by 2002:a05:6870:349:b0:f1:928d:c803 with SMTP id n9-20020a056870034900b000f1928dc803mr13019501oaf.19.1656820680765;
        Sat, 02 Jul 2022 20:58:00 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:58:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: defconfig: Enable qcom ss & hs usb phy
Date:   Sat,  2 Jul 2022 22:56:53 -0500
Message-Id: <165682055972.445910.8675442257693920967.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628045454.621175-1-vkoul@kernel.org>
References: <20220628045454.621175-1-vkoul@kernel.org>
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

On Tue, 28 Jun 2022 10:24:53 +0530, Vinod Koul wrote:
> These phys are used for USB controller found in QCS404 board, so enable
> them in the defconfig
> 
> 

Applied, thanks!

[1/2] arm64: defconfig: Enable qcom ss & hs usb phy
      commit: 974db040c5190b5e925883600d023a9ecce8a840
[2/2] arm64: defconfig: Enable qcom interconnect drivers
      commit: 3d1188df789f777306756aeb201c8709eef6b627

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
