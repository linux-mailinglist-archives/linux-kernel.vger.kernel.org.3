Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD24C1E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiBWWfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbiBWWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797F61B7B8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d28so218331wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2wT2wp0Dqe/UC5dsCDp4Poe46PzygawpRfXKGd6REY=;
        b=EELOsVpiV08H4dMvWjA9ZvvoX/dUscSpyUv6VPASYb9+Ghyeq0Tgs2Oj1HEwbhsg39
         KL9n4O7DGonSviWuTuKssuQbV6+vc5BPL45T8S/787vyeXoYxlSTt6f9GfGF88C31nef
         aZRV2ZjOT0mgsnnOKSLImwEHLraC4Snl7FYZhhDupQ/qtHLLcxZ9oqF2ERb19S657hSp
         ocBSxjdaOq5JLUnW3WxysulzOE50SKAgQs/P3WgFONJ8ZbtO1YdNtbvlQxv3mWWHAa1u
         lK7Ti+YCZ/kX8kG9lwCeAnWbPa23JlHXIfPSzi/ivdQZ9sgTaqTzIF555fNGt4OS5sIO
         oDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2wT2wp0Dqe/UC5dsCDp4Poe46PzygawpRfXKGd6REY=;
        b=LwtuGrQFODR6kFPcJ1mMBtsUVxS8TCiQUG7vnegTx6WIQ8q1l9rrSy4JJzdxt5XhTg
         Zi30o4iXtoBpo+jlg2xQL+enHUIJx8Dc6xqTwXhYzCffDIEEPemudzVtonoA//ZjtBzA
         lMNDayJcneSB+CWwnogGDufdyesHIpbOivxrq9fK/tK37SaCZTYwa78uW7rlN4Q1JjlQ
         CWhbWAxMJB6MVnLz3dsZ6+aYmoqO6BbRL4dPEPFmA1OmHnldFY87LWKqwNJNvh2fM84R
         lwOpI8+6QdIloSRzRWb8IfaUoJjboOPXtQmo/xTbkB5f7x3ekbvIGh2hgUtiN93bMK8Y
         Dm4w==
X-Gm-Message-State: AOAM532xv0PnA3XNWaG/cgpfIJnFbNg82SkrLPcZ2Z9qHpyIPk8Krf0H
        t36b5yci8BTGzJ/i57T9bkcSOw==
X-Google-Smtp-Source: ABdhPJyGSclnhDIlU4hitCqZ3Plyf4xaz2JIVGfITwZMQP71T38Eivskr4UwG8iKgv8Hm8Iqd/wNXw==
X-Received: by 2002:adf:e5d1:0:b0:1e6:1109:5a11 with SMTP id a17-20020adfe5d1000000b001e611095a11mr1206023wrn.641.1645655706032;
        Wed, 23 Feb 2022 14:35:06 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id c9sm729435wrn.51.2022.02.23.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:35:05 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] nvmem: patches (set 2) for 5.18
Date:   Wed, 23 Feb 2022 22:34:59 +0000
Message-Id: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
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

Here is final set of nvmem patches for 5.18 which includes

- Add new Sunplus nvmem provider and bindings.
- fix in qfprom to increase blow timeout.

Can you please queue them up for 5.18.

thanks for you help,
srini

Knox Chiou (1):
  nvmem: qfprom: Increase fuse blow timeout to prevent write fail

Vincent Shih (2):
  nvmem: Add driver for OCOTP in Sunplus SP7021
  dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver

 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |  86 +++++++
 MAINTAINERS                                   |   6 +
 drivers/nvmem/Kconfig                         |  12 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/qfprom.c                        |   2 +-
 drivers/nvmem/sunplus-ocotp.c                 | 228 ++++++++++++++++++
 6 files changed, 335 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 create mode 100644 drivers/nvmem/sunplus-ocotp.c

-- 
2.21.0

