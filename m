Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221655684B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiGFKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiGFKHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:07:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E2E25597
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:07:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s1so21308660wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QObgdcNgPMmmkDUAL9Gi7pEY5BpJMOpSGHFLHn03yYA=;
        b=zOd9ffccl9iKPwv8bkny3QSt1yff375lo1GN7IGSjUfvbUmcyeTzsHRpUc/NyUkGGc
         j7JCVoFIc+YsJwE+f6oUfsOy+mfvfMiEGdKppg2/x8GwobRAF12Hnab4zqYiAqWxiQbn
         c2G88/YUPhZ932/+NCrv33WzT5/NBLuTK9RNtnEgSyvqVnWYGFFEhO+G5NFDDA6qtqww
         Y7UYl38YzOTDB04Hj6iMVDwEwuU6zlGhReg5DoHiwOqtlUW91WMnzKdqxc9tuMN5hjDD
         aohUAYA1lzTSJ8H+Fh4wLc3+zpNjvqnJDqXRiM4bPcVWpE9eqMApo6tZywHA7cqeb1JM
         YMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QObgdcNgPMmmkDUAL9Gi7pEY5BpJMOpSGHFLHn03yYA=;
        b=NjUi2dolfmxt0bJva9cc7xMB5rj89OXzOUzdlYF7Mo1mOiPCPhM4wkYMaOFjpX8mad
         diRYAWXeLnu4ln+Fj9Nlty9Do64Nhj7zVbMUa5XkMkE+Sdyqq4HdZYRe07Jfi/CvMzcg
         lPMYCZ8Z1BkgSQcj/HAAEBixHs5MI7MFsMpgl3tp3mtCntxwpvWjG4zZphsjZzLIcuBi
         3Zc9oKvD82hV76XCFy408Cte7hwDgO3mBKsskea4F7lBKM8MJpZ2h+rOPn+zU7rafRQH
         +VrJRAtoiKJZ3jncipxVeNj7MITh2s97CUJU5D62sv8fsA0y7k4mK3CikkvLqou+mr0F
         xvvg==
X-Gm-Message-State: AJIora8ufSqE4ZSgoEz0y50GkzMxjvYdeOrpQI4YsSVwNvUqC3hOzDat
        8bzntk8HAVSQIRUauMrXD+855w==
X-Google-Smtp-Source: AGRyM1sjNYc1LtO3TTtCWhgBsef9MokUhndxvevofnCl3/UmI5h7ZLG1LXPoJC1T5ZRpWDJkpL31qA==
X-Received: by 2002:a05:6000:1683:b0:21b:93b0:898f with SMTP id y3-20020a056000168300b0021b93b0898fmr35871674wrd.662.1657102047194;
        Wed, 06 Jul 2022 03:07:27 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm24678143wms.18.2022.07.06.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:07:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] nvmem: patches (set 1) for 5.20
Date:   Wed,  6 Jul 2022 11:06:20 +0100
Message-Id: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi Greg,
Here are nvmem patches for 5.20, which includes

- New MicroChip NVMEM provider
- updated bindings for MediaTech to include new SoC's
- An enhancement in mtk-efuse to use devm_platform_get_and_ioremap_resource

Can you please queue them up for 5.20.

Thanks,
Srini

Allen-KH Cheng (1):
  dt-bindings: nvmem: mediatek: efuse: add support for mt8186

AngeloGioacchino Del Regno (1):
  nvmem: mtk-efuse: Simplify with
    devm_platform_get_and_ioremap_resource()

Chunfeng Yun (2):
  dt-bindings: nvmem: convert mtk-efuse.txt to YAML schema
  dt-bindings: nvmem: mediatek: efuse: add support mt8183

Claudiu Beznea (2):
  dt-bindings: microchip-otpc: document Microchip OTPC
  nvmem: microchip-otpc: add support

Lukas Bulwahn (1):
  MAINTAINERS: rectify file pattern in MICROCHIP OTPC DRIVER

 .../bindings/nvmem/mediatek,efuse.yaml        |  89 ++++++
 .../nvmem/microchip,sama7g5-otpc.yaml         |  50 +++
 .../devicetree/bindings/nvmem/mtk-efuse.txt   |  43 ---
 MAINTAINERS                                   |   8 +
 drivers/nvmem/Kconfig                         |   7 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/microchip-otpc.c                | 288 ++++++++++++++++++
 drivers/nvmem/mtk-efuse.c                     |   3 +-
 .../nvmem/microchip,sama7g5-otpc.h            |  12 +
 9 files changed, 457 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
 create mode 100644 drivers/nvmem/microchip-otpc.c
 create mode 100644 include/dt-bindings/nvmem/microchip,sama7g5-otpc.h

-- 
2.25.1

