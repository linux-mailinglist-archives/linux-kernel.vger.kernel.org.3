Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03C4F8609
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbiDGR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346214AbiDGR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:26:57 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E04BF50F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:22:56 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id kd21so5500117qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fJ7ygznwMb8eMV9TQWtxLT1BB8Rhj4Ph1t5ZxtOvIow=;
        b=xn4+0Nos2g51p+lcpGJlZFvm2hai2DIrfj/tZa5rBsoMbGHHcl0jqvEukq1yEFPAbx
         w1PDodJoC0hLLRox2rQHwPcAayQykC8xbV8FwZm14KN2JU8qBdXv52Xg6WO+0BrQziyn
         LK/AOd+Hkih2906m5voLSl0tTLE4O5siC6Tp1MRI1bE9l5tpOQ+sCfq/1urT2wyqFAK7
         6qfH5BqO6RPzo+7eXpG8uWy4pif15V70nRaqlXxHO+0O1zcqj6/XSOODiE3BWASOHCsM
         qqMWWhAdJdpuZ/c0iA5DlAqDuHlV59iW32Jkm0Vlp9PESMOdrR7LIg7J1sXhRBVHiBdw
         kS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fJ7ygznwMb8eMV9TQWtxLT1BB8Rhj4Ph1t5ZxtOvIow=;
        b=TpfSNBAXHYPRboMGGYkF0f8lf62iK7bavEA0WUg45MGIEnESLVY2oRAzrgU+zEaKmV
         zqNL8wB+ArG82uyXC/d6vg5ldtsHeVF6EvuJDaQTqg0zopoxpffsPTHo41JTNQQK1tIG
         RS0Jzade1RocRA0NxUFVbJtb7EL/ewWVr/mZZp8R/DlASGUVoPMRPEXkvc7fZMnd/y1s
         oTmPJ/Mk9pDsatGRhSBiPd/gN8vmCcoAQre/X+DS0bT5wLBXtgDyB6FvBhQ6WMRC4bQb
         R/iJJjcuLRlUQEl5vFv67a/XKa/77x3aAJLA/orcQgvl5enE4/TAfPWMS63dY3lstNs7
         fGqg==
X-Gm-Message-State: AOAM531JKh4N4UQaQ21T6E6TaBo3mw6CDJ79lfLFXtrwR8XacrP1S6H9
        RhaXu28VrfknrVQrFoHLwhr8+A==
X-Google-Smtp-Source: ABdhPJxkctuq4Ghg/MMeyC6Ih/RKwTBtPHnXbwIvhrDACYUcVwAyr7lC4zNd8ddTKIr2HeEFhghXcg==
X-Received: by 2002:a05:6214:2388:b0:441:37e5:baec with SMTP id fw8-20020a056214238800b0044137e5baecmr12970171qvb.66.1649352175146;
        Thu, 07 Apr 2022 10:22:55 -0700 (PDT)
Received: from localhost.localdomain (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id g71-20020a379d4a000000b0069a029c7659sm1235212qke.35.2022.04.07.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:22:54 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: sm8450: delete incorrect ufs interconnect fields
Date:   Thu,  7 Apr 2022 13:21:45 -0400
Message-Id: <20220407172145.31903-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream sm8450.dtsi has #interconnect-cells = <2>; so these are wrong.
Ignored and undocumented with upstream UFS driver so delete for now.

Fixes: aa2d0bf04a3c ("arm64: dts: qcom: sm8450: add interconnect nodes")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2c18e1ef9e82d..90cdbec3cac99 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1663,9 +1663,6 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			iommus = <&apps_smmu 0xe0 0x0>;
 
-			interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
-					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
-			interconnect-names = "ufs-ddr", "cpu-ufs";
 			clock-names =
 				"core_clk",
 				"bus_aggr_clk",
-- 
2.26.1

