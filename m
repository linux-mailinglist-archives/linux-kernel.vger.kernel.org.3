Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA65643FD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGCEAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiGCD7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:59:22 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF9D131
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id be10so8929459oib.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWWrox9hbzmFQQNMV8H7cGw9tE6JCuANYb16JPAY5RQ=;
        b=TdY2m1xMXxLALttKFVMlVbyvrcKTejEmqAwOmgnBbsPpPmZNWzR+q/bL8vllZ72vpd
         v0V8my75dJ5j+moDx6ItsY3xWyrKIjRV0Je3nHpGDNLJRrtJJwlP4Gc/FDYxDkKowb8x
         DqMHQDHrtt74DnyQ2SViB4uKS+6yxoYd8gvbdoIwXxAYCfjQP6iwOGrw3ZgGSdO4R2XS
         ZqXr8a2NexwPDBjO/SNXxJbthBYJ5tko2yJ5itGuIfD3VOmZBx3HvcgWry7k1selTRTJ
         zh/Zc1mKtwpEXIcRJXsvRNoiOol4RQC0X9ai5uWWbuMLfZPEI7+fRRPwSRNJeIOFGPdu
         LV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWWrox9hbzmFQQNMV8H7cGw9tE6JCuANYb16JPAY5RQ=;
        b=4rP7WroNIaCMVxlKRWIWqdxVXyZ1gMbFM1en4GF1Kw6u5s6bIm9cpJeYlwuuyqnrht
         GhtEaSAHMaAw1mzOhYMBmM4C2aeOE0J/CfPSJiqA0AAaPuevbVzZoOf78V01qzd0Ypcb
         zK6HkbruNXnkKnEh9MGIDlLd4FIm6EfdELGpvKy+oe9P+Bl3zRrNswLC5twdSnLfTfNJ
         E+vZHOgHxwCxtB/wn5UtaQ6mRUXDo798s4IVIB0hK5n/LtkgaF6UOsbphnXB28YuTbc0
         aE/DdjpDOJKkpWwvp8g7jIYfA0ZCi8Maet1sRVbEggPv8rgloB6QmkDikWeBH5KiHK3D
         iadw==
X-Gm-Message-State: AJIora/QBelbafaubkq+D9SNXKs99K7K3i820+/i2WsLzzm1awhFi453
        UNrbee+rU9vLLYpYS09FrqGV8g==
X-Google-Smtp-Source: AGRyM1ubjkJj6s1/WK9aIWGEp+aBO1KZKIPK2Sgn/OfwZN2vq7LhjJI5f7iMuHm2ojMEPTZo9CG/LQ==
X-Received: by 2002:a05:6808:2113:b0:335:510c:eec8 with SMTP id r19-20020a056808211300b00335510ceec8mr14417125oiw.152.1656820666793;
        Sat, 02 Jul 2022 20:57:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:46 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     maz@kernel.org, tglx@linutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/3] arm64: dts: qcom: sm8450: Fix the IRQ trigger type for remoteproc nodes
Date:   Sat,  2 Jul 2022 22:56:40 -0500
Message-Id: <165682055970.445910.5187142422707164042.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220530080842.37024-3-manivannan.sadhasivam@linaro.org>
References: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org> <20220530080842.37024-3-manivannan.sadhasivam@linaro.org>
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

On Mon, 30 May 2022 13:38:41 +0530, Manivannan Sadhasivam wrote:
> The watchdog IRQ trigger type should be EDGE_RISING. So fix all remoteproc
> nodes.
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: sm8450: Fix the IRQ trigger type for remoteproc nodes
      commit: 20402c94721a05fe3e581c1bfb88f0b45452766c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
