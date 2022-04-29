Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1972E515125
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379315AbiD2QyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379309AbiD2QyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:54:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD5D95F4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:50:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so11505083wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15i8wXg775LCpDsiDqm1caXT3KwnTX3p11E0a86Tbbs=;
        b=EqxTxlbXOZF3OFaslSBd4lFokATVzlkSVOfMMsN7tnAp7T/PiB7crYl0Hfad0Fd5qv
         U9BV3rZIdWXkmwuiAsVReEFbBvv7tcXNf205AEg1pQYe0QI07CzO/RYO4PphGYhivXVW
         vBIEfczg4x3QxsGqgmtofdN2Vo9/3KfV8NEs7I06qJbjwd1VFxSwe/qZ9VStZlCu8xWG
         KQbXUF2nfG/FrN9ZUaqbA3VO1QlCnzltyaECQ0ObU38cG5MMJRJ625U5cZgE8mu2cz5c
         XeiPStGexJ0Rq+4HRrMk7TVV4fF96mzQ0DaE0PjmVBSsWQZiLVBa5AYUOb13fMT63ZES
         q55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15i8wXg775LCpDsiDqm1caXT3KwnTX3p11E0a86Tbbs=;
        b=HW/NQwjgtqDY/T9YBAOK96lWN8rVb1OyGaOn2g2QxjrDGu/EEKqL1pQEWtjGUh4wGG
         dFZETFp21+64EwhP9MFiVBrxDeEAeAewYKEhAoMT6KRv1mr36EEKyiGarVu15Rd/mdF8
         Rl436aVLKXo8SgqeyBDHQOjAJOaUUsZS7zmYk1otpls+IDph4p8SCLY6lI389zUX956l
         RoK2XgUaOTgKFcSE3xcHm9HJ+y94FhcrSBy9eSqu1D/9WrJCUbfnMjUMFXYf0nPdWe8H
         twgHiaAQSWsmqSyUxFc+dmIXCwYpDOIQUKHUkfvL9OFHOrr7AtVYKg+G5xo72OVUAaY6
         whwQ==
X-Gm-Message-State: AOAM531TaUNM+/QhzCBNKb+donwzyMEXMN9RvG0PT4RZzPRBYTGuraK+
        gGl0p0rG/pb0tvmewlaOF9Vz+Q==
X-Google-Smtp-Source: ABdhPJy3cmE08b8ZCZM2Tbg5grVaBtONLX91dBq6wDqfGROYuReQClwtm/6HsKgjeIz8DqX2xC+WIw==
X-Received: by 2002:adf:f6c1:0:b0:20a:daf6:9bd3 with SMTP id y1-20020adff6c1000000b0020adaf69bd3mr5172wrp.425.1651251055758;
        Fri, 29 Apr 2022 09:50:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00207b5d9f51fsm2848941wrf.41.2022.04.29.09.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:50:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: patches for 5.19
Date:   Fri, 29 Apr 2022 17:50:49 +0100
Message-Id: <20220429165051.6187-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some trivial SLIMbus patches for 5.19 which mostly includes
cleanups around get_irq.

Can you please queue them up for 5.19.

thanks for you help,
srini

Lad Prabhakar (1):
  slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the interrupt

Yang Li (1):
  slimbus: qcom: Remove unnecessary print function dev_err()

 drivers/slimbus/qcom-ctrl.c     |  4 +---
 drivers/slimbus/qcom-ngd-ctrl.c | 10 ++++------
 2 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.21.0

