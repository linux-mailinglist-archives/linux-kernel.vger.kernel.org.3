Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39685734E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiGMLEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiGMLE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:04:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA32DCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:04:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bp15so8942055ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2vdEBeueCC46NEWMBS7OX+jq1Oi+DQhvA6z4iqsUEA=;
        b=DNDAHNKEieUFuTtZbUpAgzPTvaU9lShge8WP4TdpH1/bnKSW8AbZU2J525O6YlOb9m
         m0lzulZG0vQt8+Bl+68l04hrV3SS1kqsnQ9FrxWI+P1zN8TKS/2gCQBEOfph8EypdSN0
         W4VDX2EBJ8aJ9WrLsvZRCqyYQwseX+UAqXn1dzDLrTrv/7cBzegBwueApqcQjEDwlZrh
         6rLT/RyXjfcihoM/k6HEwUvbnQ7McrD/3nWKx4XcldetGFZLKA/izPR98oMslejGz+s/
         CsCJD7jDiIR1OMRuidWoKJG2mBhGwyHztJNgln111Uh1SMvcb7t3Dqp7/djGiOJ8B70g
         QF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2vdEBeueCC46NEWMBS7OX+jq1Oi+DQhvA6z4iqsUEA=;
        b=r56B2eHpU5HvmUMNJ16sdR9/0ZBcXz7Eu7Y+CUbzFgURIqFvd/mhq4cWPMNchuBjN8
         H5H7HNGzDZeQl1C0mrGq9rh98KfxLAmiFQreGwd+RYdVLDmETMi/+W26Q3eVXirRR3LD
         o6+U3hPAc4oMA5tYTguZ3lJAtY1Xx7lPLQmxjinuGWaMmd7hxmRxMAIzVku9D8z2TIgV
         VWS6Pu3Gg5RLv1ZvfKLFVagtNWQKpiev9puvB1/YpTbw137NfWtR0q1+8TRxNd5Y4FNM
         Lt/m1YffwlNUa19qsPZjKXCFW/anbpTtmknrlkhaeHx3O4x6Lc7aFd3MO7K7S96GyNZB
         L+7g==
X-Gm-Message-State: AJIora8BMfqcSFlL451UD/LZLsWd6d4KG6qg5Y0HnkErkLg6dyW/g6OY
        4nL+OR0IRMRJULX3DwGlTOeSrg==
X-Google-Smtp-Source: AGRyM1siCcodgLk2eqCklipBMPlX8f7MouuAxxO8N52rGtleY3n6Ljnokw4lELEJvxBEQlLbcxH1nQ==
X-Received: by 2002:a17:906:9bef:b0:72b:40d1:4276 with SMTP id de47-20020a1709069bef00b0072b40d14276mr2760266ejc.360.1657710264871;
        Wed, 13 Jul 2022 04:04:24 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id c9-20020aa7d609000000b0043a75f62155sm7801152edr.86.2022.07.13.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:04:24 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/2] FIx compile-testing of Venus
Date:   Wed, 13 Jul 2022 14:03:49 +0300
Message-Id: <20220713110351.827446-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Hello,

Here are two patches to fix COMPILE_TEST testing of Venus
driver on x86.

The first one is fixing Venus compilation. The second patch is
fixing unmet dependencies seen on QCOM smem driver when
dependent driver (like Venus) is enabled.

Comments are welcome!

regards,
Stan

Stanimir Varbanov (2):
  venus: kconfig: Fix compile-testing on x86 platforms
  soc: qcom: smem: Fix compile-testing on dependent drivers

 drivers/media/platform/qcom/venus/Kconfig | 4 +++-
 drivers/soc/qcom/Kconfig                  | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

