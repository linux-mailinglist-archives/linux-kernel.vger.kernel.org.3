Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0B5B0E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIGUtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIGUtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:49:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00425CE14
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:49:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so190761pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VILwDL/sIUZC34sszkWtJPfoLU5yiUkOiwtDL7IE2b0=;
        b=ClFo6oZego6igRhj/tOJY4x+HLqCA3i9nMX4KM0+Ag+rW9iC/gWlE9ZAyqzTQ4iqE3
         B2sP2BYHvX4v3bo4jjmvnSWB9pRtI0U0DfznyhuIDVSYZBukRj9fEVBD2ySXsnKW5m2q
         vIn6wNvPqNg4Ks1scp3jRgPLQMl9Hn13YAQmYf5vR1SZsjb/1hG59nidUzJkCBf5vBYA
         ri3feTAswyIQRKCZ619KqiSAMkKHUiaMMjAxyxJb05vZJmh0xQ+4JB6Q3H8nkpq7ZwaN
         Par5PHOTxOOac20WE6/B9l0FKuUeML6jF34zkqdwkJ/XSPH3MDgudonPiEfKBp6iw7m4
         yhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VILwDL/sIUZC34sszkWtJPfoLU5yiUkOiwtDL7IE2b0=;
        b=Iv+z5lVK3ZvXgwtqeBI220f2dCtn6eQASka/n9/PdIZd/MsLisDPcbBi4iPbKSpUjY
         du3UO+zRLQlWl4blvMTj7HKdoGIac4BU4fYPlqHJLZjY1+2L03j+i34o/wbPLikj2LDb
         LD1UUVF1QWraFSa4kNtIH/swW+0khyURBVGtXxcUmqaJpPoqcQq8kuL4E5lXhoI8SDY7
         hL7QTMjYQOqUaqy2Hy8luH4A8JZdrfPAlOyqLknhGj2F9eX6rHNDNsKxT/H8W+hma0F6
         XIIxOdkMKmURACdFh4fdPnd/zI3AWvgQZWKamfdgluRjUdYDxg0wVX37PL4FkO9Q2rYC
         g7xg==
X-Gm-Message-State: ACgBeo1u0PKLGzJLMMDQo616gC8nQovwHlOJddPScrTqXt1PTfwoDlyl
        FSudyM+4lfxk0Qtk0gpAm3n4MQ==
X-Google-Smtp-Source: AA6agR7mirZmtO2FC7GgkTq0WIz+FVoIZ5otVGbaluywI72PpIdKKFO3WQhD7jyObY6RKdBYtMAFJg==
X-Received: by 2002:a17:90b:3c8a:b0:200:b874:804 with SMTP id pv10-20020a17090b3c8a00b00200b8740804mr342150pjb.151.1662583777293;
        Wed, 07 Sep 2022 13:49:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001712c008f99sm12795140plh.11.2022.09.07.13.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:49:37 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 0/4] dt-bindings: net: Convert qcom,ethqos bindings to YAML (and related fixes)
Date:   Thu,  8 Sep 2022 02:19:20 +0530
Message-Id: <20220907204924.2040384-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
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

This patchset converts the qcom,ethqos bindings to YAML. It also
contains a few related fixes in the snps,dwmac bindings to support
Qualcomm ethqos ethernet controller for qcs404 (based) and sa8155p-adp
boards.

Note that this patchset depends on the following dts fix to avoid
any 'make dtbs_check' errors:
https://lore.kernel.org/linux-arm-msm/20220907204153.2039776-1-bhupesh.sharma@linaro.org/T/#u

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Bhupesh Sharma (4):
  dt-bindings: net: qcom,ethqos: Convert bindings to yaml
  dt-bindings: net: snps,dwmac: Add Qualcomm Ethernet ETHQOS compatibles
  dt-bindings: net: snps,dwmac: Update reg maxitems
  dt-bindings: net: snps,dwmac: Update interrupt-names

 .../devicetree/bindings/net/qcom,ethqos.txt   |  66 ---------
 .../devicetree/bindings/net/qcom,ethqos.yaml  | 139 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |  16 +-
 3 files changed, 150 insertions(+), 71 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/qcom,ethqos.txt
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ethqos.yaml

-- 
2.37.1

