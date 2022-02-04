Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C876D4AA340
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351266AbiBDWhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351201AbiBDWhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:37:47 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B0DDEC0505
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:37:44 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id i5so10251900oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 14:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrPLdOb0ywA5n4FsTGhx+oWZMq1l74LPEC44v8CHjgg=;
        b=WktAdZCGgZ6Zn/cahPUzCB7h5BfAfaFgynQFGLDjzy8k8d0TqdDeOUkmuYYwwyLujI
         eTRG9gJmpDPFV+C32XuFeYODE5SIl3rQYtKfD/EOaot3/vWxNDS25P0zqWTvxEWkQhtb
         NSc5So7jd1HLveq0PdVp9B9eBKtMtaXBlgOsP6aN7z4iDbHJysXA/frI1a0AX6MWQrKQ
         ZlqbGjcCqgSfKAubPoY2IlhrHYx2GwikXAMMchLg4JO1XC5G3kHcoF5uqDUPK4TNgp7n
         4qc9fD7gpLCxaJaVNq9PjzevWyAnJcRSAUNoAGbgCe64hmaFJgvcsygk8PD/VZfDFg5w
         d0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrPLdOb0ywA5n4FsTGhx+oWZMq1l74LPEC44v8CHjgg=;
        b=73LtFKJ91+loheJsKEOTLXnuQgT86mynSlCFXdjCwu7+50ozWWB9/rs0O4xrPrAyEP
         K+RVyxX5FW/KTeMQ2fY1z61TwB67ROPvnDOB+fnGxPo/U1vOdwp/5LxT/4iuR+rrvj1J
         /VEAA1lmHBG4C+jrgedmPohe3POlAt0yA3I/HioRiNHpLS84t9+NIpvkeVMasjmtMFBs
         ELWF4RXTNk1tDd64CHm+mevbHjrvkH7qjJo22a3CQVIb3ThGaswgT+sd3oDsgu0D/cQR
         HLsPmEe+vZKTsKviJjk5WdupyMUFC+zVkp4ylFYkc8DQbgFsBdl2ggvFapXAY3+3d4Ic
         MtoQ==
X-Gm-Message-State: AOAM532jueRY8tAJs5gpN1CMO/G3g2leY8+RFEUlaV4fv9ubqUFuJbLE
        E6MCmGYVBHt8rIilLzYUQiqcZg==
X-Google-Smtp-Source: ABdhPJzZTuDshfNIfsWjWiFB1PJVauHPWjhBEN/CJdnDWIbo0tNrXwppyzGYkV+sqquaWnZL+oCwIA==
X-Received: by 2002:a05:6808:3096:: with SMTP id bl22mr577705oib.280.1644014263728;
        Fri, 04 Feb 2022 14:37:43 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 71sm1263073otn.43.2022.02.04.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:37:43 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document SM8450 HDK boards
Date:   Fri,  4 Feb 2022 16:37:41 -0600
Message-Id: <164401424604.3413232.13684740891173293910.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203090031.3128702-1-vkoul@kernel.org>
References: <20220203090031.3128702-1-vkoul@kernel.org>
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

On Thu, 3 Feb 2022 14:30:30 +0530, Vinod Koul wrote:
> Document the SM8450 HDK board
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Document SM8450 HDK boards
      commit: 42d3ce71ebcee2233f8a21adb44cb707f2ea3a57
[2/2] arm64: dts: qcom: Add SM8450 HDK DTS
      commit: 067b2b3616cd5ed924b51064bcaab23ea1ffd18b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
