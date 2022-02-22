Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECD84BFBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiBVPBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiBVPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:00:49 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8FB10E54A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:02 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF7364004D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645542001;
        bh=5q3Cvfs96FMgD3OViDSeZ+rSi5cV583JAJ+X+hKXLOQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nvdcbnQ/xZ0r/RwvKIgZjHzAx3TJAiFIdoDMzVLTuLmTgk2SudTNQ/zerpVZye1ry
         vbySq38AVmiB3qAKeGAdfUifhW6BlX1WZtmZ63fl0RCi7BU7C6jkNQrCjgAbcSefu7
         GKeafwVaWoWWMLyRqaM2hg8qZC4sPwnUSdtgTOTD1GLvFncixf+4o9dlUEHtSt7Cpm
         ZAR6q/fQ2IJC/OCvEu16LXK34c3BnlNGU0eQtQGD4iRB7WfYP3c8JNZF+HJbxft8wu
         vkBX0ZNmkTjcdZKVmsAFAObQqUoL1e4nMsCR7RRiAXTA+ytFjSszY5ZkGqxbB6ny+6
         NQxsD6tWpP4Rg==
Received: by mail-ed1-f69.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so12132335edz.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5q3Cvfs96FMgD3OViDSeZ+rSi5cV583JAJ+X+hKXLOQ=;
        b=vVoDjQ2BUjfQURgTpMsVp2YDyQhaUUSjyGPQmH2kBYL2/qTjODxlmypJUS8xR+VQmN
         OyQpN0I0C4E/xWuqpgGj/K3Xs44dvtJwV2PgM1Vwg5gQuZd94g7euddPa7qXFy2b3yGH
         P77lcv97HwNWqDFct86VX/XOU9n5iKPXhb+tTjj9k8co8W+7fgFZvGJe542VCjYNnKgB
         AluBtB5tU7gyvTB/pERvlF2LAIbs7DPB8y2XVWSR1m7Kekhs5tn5ChyajsboFdPJC1IL
         jnXQI+h+PP+bhPn+/aDEFfcOfMm9ji4Vi3h/x/zuhVLPKjF4c2T7PHwKsnrv88gTDKxc
         QMKw==
X-Gm-Message-State: AOAM530OCDIP/FSTRK5MspybNCN5oe23SAIzl2OW6TpikhWC0cxm16Ko
        woQSoQdzoycoOsb33VUaQzj9cd70H8jp+knYMkB2tkn95H1e0Ay5cAYK7xcI3g1JCGbQoH1Xijc
        3q3fnehzorNZR88O0q48KMqEoZijxJBhSXWPrZ1cOEQ==
X-Received: by 2002:a50:e144:0:b0:410:d813:92 with SMTP id i4-20020a50e144000000b00410d8130092mr26862692edl.9.1645542001202;
        Tue, 22 Feb 2022 07:00:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMw582wnovmDAi/CIh3lxLYM2LG2ODyt+mkZ0ZiJXVQxrV8hjaQpoxhGRnSRAJris1bHJ60A==
X-Received: by 2002:a50:e144:0:b0:410:d813:92 with SMTP id i4-20020a50e144000000b00410d8130092mr26862658edl.9.1645542000976;
        Tue, 22 Feb 2022 07:00:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m2sm2467960ejb.20.2022.02.22.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:00:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 13/15] arm64: dts: qcom: msm8996: drop unsupported UFS vddp-ref-clk-max-microamp
Date:   Tue, 22 Feb 2022 15:58:52 +0100
Message-Id: <20220222145854.358646-14-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property vddp-ref-clk-max-microamp (for VDDP ref clk supply which is
l25 regulator) is not documented in MSM8996 UFS PHY bindings
(qcom,msm8996-qmp-ufs-phy).  It is mentioned in the other UFS PHY
bindings for qcom,msm8996-ufs-phy-qmp-14nm.

The MSM8996-based Xiaomi devices configure l25 regulator in a
conflicting way:
1. with maximum 100 uAmp for VDDP ref clk supply of UFS PHY,
2. with maximum 450 mAmp for VCCQ supply of UFS.

Since the vddp-ref-clk-max-microamp property is basically not
documented for that UFS PHY and has a conflicting values, drop it
entirely as it looks like not tested and not used ever.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 7a9fcbe9bb31..3ade756e1cd9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -341,7 +341,6 @@ &ufsphy {
 	vdda-pll-max-microamp = <9440>;
 
 	vddp-ref-clk-supply = <&vreg_l25a_1p2>;
-	vddp-ref-clk-max-microamp = <100>;
 	vddp-ref-clk-always-on;
 };
 
-- 
2.32.0

