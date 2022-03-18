Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2601F4DE12F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbiCRSkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbiCRSkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:40:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ACC1C886D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:38:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so18591139ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVqxXsnsA1LY8cZh5HtidQZ6OjQlcer9+l/ndoFCZzY=;
        b=0GPHb7LYcRvV0cYr619kgGkNXh29aZ1bBS0X1XqBJg22GVMGqMop/Fmcw2gghkOpLI
         TH/jF2MknNS+B7o+jM3fb31Yo/4amEjdUwNBwk6EwZxK4vP7a85oGidUknXa3fJrTk/N
         oSOlY4bYnplz7A11froxUMvRPhprEFwnN3F86raLG/Weq+cgRvZfTyCQprFm+rBApJCz
         SlbdZjwh7/y2bn2qlGW8+B4BdIvsZpj9qMtGugd4vQ1RIxIU7pbFhElFAe7r2OwNadgc
         VN+gIgADqpI2L5zSE+49UxIRfq50gAMqTWWITfBLv0MnFZjfMgFAcnn4mgbqSeSVgY2+
         Heug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVqxXsnsA1LY8cZh5HtidQZ6OjQlcer9+l/ndoFCZzY=;
        b=i2uY6kJ/E0X5BXD34evBC9mYQ0pD8Zox7jnsTSbyIU//YWLN4dVv1jbRWUjlhR6OFT
         vKDzg9RAoo4VAAD6gN+7h6gwHDum0O3yeaqJYTac84fvrYCHjNkLVqUyU+9DC1RGMTrU
         5Jy/CUzkKUgldHOseTBtM0jO1x2nzGfCuR33n/pD8rWlkGGEhhOdYFORTEk4qgzxibxY
         /UbeX6HIhZXaJqX8VCKMkZze8tLCDt42r7Re3aVT3y8+Ae+WeOf7yJd3gzLkSwNcnyXn
         KXzBfBlK+26byxSwG42oP0vqxq8SRnD6GTkHdJ/q2U/CKrkdHArG92o4oiDIq4XPBY5n
         IV4w==
X-Gm-Message-State: AOAM5310HbGHv7nTkjMQ6Ma1Oznooby/RTy9MDCah5LJNgy6q/mdind7
        EV0HV7bT+C2WrR/gczxvqkjkG5Fu/k8IlA==
X-Google-Smtp-Source: ABdhPJywc4UWZRd2+eQ+ys6dqt33WizzTPKOjPNdHSD5dskGiUT2AQqDpKCVX60LsFEPTMhbHNqHyg==
X-Received: by 2002:a05:6402:5173:b0:415:f1e2:8d53 with SMTP id d19-20020a056402517300b00415f1e28d53mr10822200ede.95.1647628225727;
        Fri, 18 Mar 2022 11:30:25 -0700 (PDT)
Received: from otso.arnhem.chello.nl (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id y8-20020a50eb08000000b00418b114469csm4567551edp.52.2022.03.18.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:30:25 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 0/6] UFS support on SM6350 & FP4
Date:   Fri, 18 Mar 2022 19:29:58 +0100
Message-Id: <20220318183004.858707-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for UFS on SM6350 which is used for internal
storage.

Luca Weiss (6):
  scsi: ufs: dt-bindings: Add SM6350 compatible string
  dt-bindings: phy: qcom,qmp: Add SM6350 UFS PHY bindings
  phy: qcom-qmp: Add SM6350 UFS PHY support
  pinctrl: qcom: sm6350: fix order of UFS & SDC pins
  arm64: dts: qcom: sm6350: Add UFS nodes
  arm64: dts: qcom: sm7225-fairphone-fp4: Enable UFS

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  1 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi          | 79 +++++++++++++++++++
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    | 18 +++++
 drivers/phy/qualcomm/phy-qcom-qmp.c           |  3 +
 drivers/pinctrl/qcom/pinctrl-sm6350.c         | 16 ++--
 6 files changed, 110 insertions(+), 8 deletions(-)

-- 
2.35.1

