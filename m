Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A424BCF64
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbiBTPQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiBTPQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927D34BA7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id w13so7651400wmi.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhmHRloVk8iyLFx7jCTlJoNIa8BDXogScb74+fYaJGg=;
        b=khRPbNjoBxocQj3koQxtbM6YHKTnTE0J6YZ9YB9/iFBKERF0gZphsHArQzJg8EbSxd
         784NhvDxoS7yh++vX2WlBUnOiCij3z4P3KIeUV/3eqZHi+a1zEJx2Z9NnorEIc16Fh58
         Ctglnp0bBDInTRu+4+vGIo0mvqhVr6MnUFtnJKg6ijEzCygpYjlIJw98/JYNY+6FDGaY
         miNj052T48t71WD87OVkDHD0Se8MUqgUg11HsqD35kQpHZKh7gAOsC+vl4C0+tPGpb3r
         YzatSYkl/PyDYgTKM9XVUF9MOOZ7NYxB1la/vajtUfVhFKIZR9rnRZ2aAKZe3+Ksjece
         BOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhmHRloVk8iyLFx7jCTlJoNIa8BDXogScb74+fYaJGg=;
        b=tdO/R13VbWzZz0kaNNiX4L2kFZW5XZr+hpTEK4GUslHXhbCFFsACe7yE6OMwRYj0UC
         ILX0csTaUrcyprie40qnvn53HZPJKilPAs//iV9FZrGLIaXWDMZadBGoQqimMFrdLEiM
         tZMU12zf1cdiGSvWvlekax5Wbb6UDNoTu+MPHa27+eOmwJZdcGj1921/2SDb7c3sWzwT
         qmFgyDGKCe5tE5dayJoNVV9mA42/JrM4LILYCfXsC9HJcbBaBJ9SkEHYjiWPsYcggD2y
         2w4d/Zz3dtYI1NWKFiyxz6JAmcrZZaz1uUT6W37zLc+J/aWnU28UovvYiYX472T9Hsdw
         gO9A==
X-Gm-Message-State: AOAM530vyxZBzZVnX80EPZlt0Xde1kLtGmGhvqrQKh4uFzhyLikjXh0a
        Ds2PxgzutWb+EdDEvZrfmgOceQ==
X-Google-Smtp-Source: ABdhPJxtcT8Nov2qDc7SD9beKLHMFsbPlM5beYeOSEXu5RmqyVWyPJkNwbyxK+8ZM3sjGRwXUxtkyQ==
X-Received: by 2002:a05:600c:228e:b0:37c:2eef:7bf with SMTP id 14-20020a05600c228e00b0037c2eef07bfmr14303213wmf.73.1645370148828;
        Sun, 20 Feb 2022 07:15:48 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/13] nvmem: patches (set 1) for 5.18
Date:   Sun, 20 Feb 2022 15:15:14 +0000
Message-Id: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

Here are some nvmem patches for 5.18 which includes

- removing unused devm_nvmem_unregister
- add NULL check in nvmem_unregister and remove redunancy checks.
- add new Layerscape SFP nvmem provider and bindings.
- add support for D1 variant of sunxi nvmem provider.
- fix and update documentation with new examples
- and few minor kerneldoc warning fixes.

Can you please queue them up for 5.18.

thanks for you help,
srini


Andy Shevchenko (5):
  nvmem: core: Remove unused devm_nvmem_unregister()
  nvmem: core: Use devm_add_action_or_reset()
  nvmem: core: Check input parameter for NULL in nvmem_unregister()
  mtd: core: Drop duplicate NULL checks around nvmem_unregister()
  thunderbolt: Drop duplicate NULL checks around nvmem_unregister()

Michael Walle (2):
  dt-bindings: nvmem: add fsl,layerscape-sfp binding
  nvmem: add driver for Layerscape SFP (Security Fuse Processor)

Samuel Holland (2):
  dt-bindings: nvmem: SID: Add compatible for D1
  nvmem: sunxi_sid: Add support for D1 variant

Sean Anderson (2):
  doc: nvmem: Remove references to regmap
  doc: nvmem: Update example

Srinivas Kandagatla (1):
  nvmem: qfprom: fix kerneldoc warning

Xiaoke Wang (1):
  nvmem: meson-mx-efuse: replace unnecessary devm_kstrdup()

 .../nvmem/allwinner,sun4i-a10-sid.yaml        |  1 +
 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 38 ++++++++
 Documentation/driver-api/nvmem.rst            | 28 +++---
 drivers/mtd/mtdcore.c                         | 13 +--
 drivers/nvmem/Kconfig                         | 12 +++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/core.c                          | 47 +++-------
 drivers/nvmem/layerscape-sfp.c                | 89 +++++++++++++++++++
 drivers/nvmem/meson-mx-efuse.c                |  3 +-
 drivers/nvmem/qfprom.c                        |  2 +-
 drivers/nvmem/sunxi_sid.c                     |  6 ++
 drivers/thunderbolt/nvm.c                     |  6 +-
 include/linux/nvmem-provider.h                |  8 --
 13 files changed, 179 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
 create mode 100644 drivers/nvmem/layerscape-sfp.c

-- 
2.21.0

