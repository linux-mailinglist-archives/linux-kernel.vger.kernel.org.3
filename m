Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2E50B857
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358938AbiDVNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiDVNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:24:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FDD56764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:21:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r83so7346278pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zF0nX3s3N6IwcPGME9n4tmBcuFVHyEKtz0zQOLiN7XU=;
        b=KuW9QMCsD9egy7UVKqnRR+9C1Zclk2AmmkgDRZIrU9XsIt3mSpYiApeH6tsQAF8zNx
         SovhEeYx52032GXDc8mY/tIb/IYnkycwm0hJstpkMTYSdSk7/Uc3YBEH+acwc17XKtNN
         MY52ObTt9w8PCTqoGFRpaPQbgRh4cmYk5OBhctY5f+dUKcIqTSBZY3f6SekWgX2iAXbb
         XeGmgJU6etFP8AcQeR0SmrucTCz+i96dcGzeXv5NTFLmxtLxF2Nm5o3/jNVBEWcKyTRe
         VSYoGtAKj1W+o2sqC2/EXcVGqymo1Mwczzlcr99O1I/KCtvKJGqf/tLlMCUqo9XLqqbG
         DcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zF0nX3s3N6IwcPGME9n4tmBcuFVHyEKtz0zQOLiN7XU=;
        b=hw3KdcrUAMwCV29gd9/ucaQyCb1bIMnWiuc4D99ZfkXP4SusU1AwYqs1168soHV5zd
         vyZlYe+/KNuAO5jqZi2fgAUb1ZPkb5G6aYAvf6xabdm0NQh4erogn366sURyU7H+t6dV
         qecFbLsNTedDJBLFTzW4WoOf0LAoNK4SOZojMTXhYHgwSnTKYVbthoMBFCv1s6/AcS7H
         lJQauvTctS1x3z0loFm/PwVvJtYczxjutcofRzJ1HkBTfgB4B2lCabfXtI8ZTuP/2qDq
         S4QQmYNfBJ2vroCCay4DBzMyz8qPwVb9NNSwwKvB7mrx39gXSA8wz1T26NIh3Xdi6Wv8
         fdEQ==
X-Gm-Message-State: AOAM5333MAIBBqNKDAUAmk0AhIFiHtIPSuU5O/dHxyJhN4LW5/zovKks
        R0Cxcop7TopbmGjbqpDAs93o
X-Google-Smtp-Source: ABdhPJwGBdH1kJzOwxticugXo7nn+HgwWgTys7PUHRPSPiw/RGwuym1yyWo1xpGANGN/w+FJ66KIOQ==
X-Received: by 2002:a05:6a00:1781:b0:50a:94f0:661d with SMTP id s1-20020a056a00178100b0050a94f0661dmr4980663pfg.10.1650633716680;
        Fri, 22 Apr 2022 06:21:56 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id g13-20020a62520d000000b0050a923a7754sm2586840pfb.119.2022.04.22.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:21:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Qcom UFS driver updates
Date:   Fri, 22 Apr 2022 18:51:35 +0530
Message-Id: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi,

This series has some cleanups and updates to the Qcom UFS driver. There
is also a patch that removes the redundant wmb() from
ufshcd_send_command() in ufshcd driver.

All these patches are tested on Qualcomm Robotics RB3 platform.

Thanks,
Mani

Manivannan Sadhasivam (5):
  scsi: ufs: qcom: Fix acquiring the optional reset control line
  scsi: ufs: qcom: Simplify handling of devm_phy_get()
  scsi: ufs: qcom: Add a readl() to make sure ref_clk gets enabled
  scsi: ufs: core: Remove redundant wmb() in ufshcd_send_command()
  scsi: ufs: qcom: Enable RPM_AUTOSUSPEND for runtime PM

 drivers/scsi/ufs/ufs-qcom.c | 43 +++++++++++++++----------------------
 drivers/scsi/ufs/ufshcd.c   |  3 ---
 2 files changed, 17 insertions(+), 29 deletions(-)

-- 
2.25.1

