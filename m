Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D64E7CAB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiCYXpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCYXpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:45:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E930F4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:43:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t5so7818728pfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjmE0PbFYFwWsKdcKDF/bNsV7kfL0yBtHChWwZZV2Nk=;
        b=dhVDiHy3cwzTU6EjTh2wHXrFp0f8La0Hlxx+1p0r179QsSFa8KVV/LXnf+8LnUD+cs
         ehIKJvFujRCsjw73ryJQAX41ewUFVELwvHzXKCpuoKQWXroZS9Rb6t3QQ8xBsmU1AGGh
         xE+iI0xyGF3EX3dUWyVAQie47EkrOZEVE1T4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjmE0PbFYFwWsKdcKDF/bNsV7kfL0yBtHChWwZZV2Nk=;
        b=NnxX64IL2XvbKalZzuuQDPGnnjW7DXdkOiBQF8Enh+UWz9Vm9d2mMyffs9oq2ggx4m
         a85PUmV8EKNPVOjBiom7J3scQ20FiMYtWOdZBkRhEAMSFtvrm6njPFsoFwcGsFfPI9Bj
         cGuDcwHGF+JczyvD/FQdp5UFRHqxuKAv9f0ReywFLOf6+I08ozCyfD+ODTzhm4iRjLEu
         LWnZs2qA1zM3EJzIKAdlbt4y/Kyihe+LfKyXQoibkQYa+MafOoMiyQX7eRJHFhmwY+j1
         mjNddVEQQ4RMkTkGeRCSC3doi996yeOGquGR4V/HDPaq5oeyzeGlrhniOd9Y6upICyZi
         0uRA==
X-Gm-Message-State: AOAM532cH0cGPxfjyD7FQu3of44n6zHZTtBu1nBhqab00ds06uRsedya
        ULSEyjVMEk075QcJMuW08Qm5LA==
X-Google-Smtp-Source: ABdhPJyJWNcZYXWBiuyLykebWFydaiBJILXDLPfP7ZK5bmsAj6FnDcCpFLely8OGk2KReS0kGJOMuQ==
X-Received: by 2002:a65:41c3:0:b0:363:5711:e234 with SMTP id b3-20020a6541c3000000b003635711e234mr1494243pgq.386.1648251825790;
        Fri, 25 Mar 2022 16:43:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5662:afcf:5e0a:c3a5])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm8684525pfl.70.2022.03.25.16.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 16:43:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Joseph Barrera <joebar@google.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sc7180-trogdor: Simplify!
Date:   Fri, 25 Mar 2022 16:43:41 -0700
Message-Id: <20220325234344.199841-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a couple patches to simplify sc7180-trogdor dtsi files further.

Stephen Boyd (2):
  arm64: dts: qcom: sc7180-trogdor: Simplify trackpad enabling
  arm64: dts: qcom: sc7180-trogdor: Simplify spi0/spi6 labeling

 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 9 ---------
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 7 -------
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 7 ++++---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 6 +++---
 4 files changed, 7 insertions(+), 22 deletions(-)

Cc: Joseph Barrera <joebar@google.com>
Cc: Douglas Anderson <dianders@chromium.org>

base-commit: 52deda9551a01879b3562e7b41748e85c591f14c
-- 
https://chromeos.dev

