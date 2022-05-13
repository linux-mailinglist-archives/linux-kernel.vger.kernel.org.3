Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA2526D27
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377091AbiEMWv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiEMWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:51:23 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E12175693
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:51:21 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id bm18-20020a056820189200b0035f7e56a3dfso2979358oob.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/NkuoBvgXYvzbAWwDOMbCfFkUOSLZa+w7ZV3Xisx9Q=;
        b=q6a2UCZsF6tRfpudX73+ygATvEqE3U/hHfuBCYlGVgjWXvCDSW/ooU2SkKFmpaOLS7
         YPpH0IJZTg6k1W03pYag5iFNAVKNKh4v7OCFnWiYnxn3CaPjUEKIvSM6bxQDufFc6f9/
         GD6o2mcO0TrehK8pAaOFj0Tg314Q26WSVg9rvleROfG4P43JYbhkvNiJiWGcBrLCW3vc
         AaetJgKnbR2vO2uUMIKppHQshRWUF8XugOfLyni+kHaagH7WdeNaEF7qmXo1w+oFY1Ov
         lIngYXjfhjKfXDHnctftngoOo3V11HEGeUk7Fo0gzYlrigRN578xuJc0pfTAIBOIUdn7
         NJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/NkuoBvgXYvzbAWwDOMbCfFkUOSLZa+w7ZV3Xisx9Q=;
        b=Zcrf1CoHrUKsOtnxRl60GWA/q9BmIi44m+SqAafydGu5CrtnX4SmhkDUQcefn5CDns
         V6yuq9m4BSIijRo9XBI80xWKT0IEPzn8/g/xMBsKeWOAjo1rGTWqNsg6BrJFO7izX7DQ
         snrdt+/7HiAIA1yfXAl31I8Lxuf+yy0NYu87/dsmAdqbN0T3WHNhtxyA1ij4cgIfdwdy
         smvmLZA6NpcfXfbx0+D4KcoUVYCgDh/7+nQgEdnb7/mw1K0HyBCBenBvnk1cXSZjGvJZ
         39pF8EXQm+LRyJ8lIubwaVZvgiVrpjxoJIOVJxDix7+Vgt60bgG74o48hIERFnKnxKQc
         u+nQ==
X-Gm-Message-State: AOAM531N9t6lW5DtUgS1WxQ9ObwlSZNbiaDbDis7OMSOBGh2LAZUx4DT
        EG022CzmhYYBVopeiGrpqg87Yw==
X-Google-Smtp-Source: ABdhPJzMxFG/WXvLdVMsesmbtKJjSkP4lUdqfhD8ANxWOAUX1Kn0kFoSk2IBFcRPKM7kdFvPu67Axw==
X-Received: by 2002:a4a:a602:0:b0:35f:2658:f34f with SMTP id e2-20020a4aa602000000b0035f2658f34fmr2737335oom.17.1652482280733;
        Fri, 13 May 2022 15:51:20 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l9-20020a4ae2c9000000b0035eb4e5a6d4sm1592679oot.42.2022.05.13.15.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 15:51:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] phy: qcom-qmp: Add SC8280XP USB3 UNI phy
Date:   Fri, 13 May 2022 15:53:45 -0700
Message-Id: <20220513225348.1671639-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

The SC8280XP platform has two instances of the 5nm USB3 UNI phy attached
to the multi-port USB controller, this series adds definitions for this
PHY.

Bjorn Andersson (3):
  dt-bindings: phy: qcom,qmp: Add compatible for SC8280XP USB3 UNI phy
  phy: qcom-qmp: Add USB3 5NM QMP UNI registers
  phy: qcom-qmp: Add SC8280XP USB3 UNI phy

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 138 ++++
 .../phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h  | 617 ++++++++++++++++++
 3 files changed, 756 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb3-5nm-qmp-uni.h

-- 
2.35.1

