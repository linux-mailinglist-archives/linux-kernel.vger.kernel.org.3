Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6435A4319
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiH2GWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiH2GWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:22:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34822422C6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:22:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so7579512pjg.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=K1FjpVHqTZWuFBiFwdMThJZJFwYGDL27q7f57M6QvWk=;
        b=hHnOqJBKL6fGupKuQ70HKYcCKIrf88Jpa5GOcoAiec18PT+6BOQAZG5lU8E063Ol4R
         WhXREUHiYNoR9kRpVDChRILpi972ba/gEc8kMOPcSvZTdPkUkEQaAGgUrCPDcQ3Y81p7
         QhM0ETIGkm04agdrXZ1PJMwlCKT0cix3FnVmJ14EDfoW038c1cMZiwfZPhjyn08BKuP3
         SWXV5GKgw7zZW55DWtlEjIjig3q0w1e4RyyS+94gM/RV0KiJN83GT9Tx9HxTMnHEWYWx
         uhD8b7teD9aG9dAS2l/g1Ux/HPEs1nUhBKo95ghZcdLSEilKo/zrVcPhg4kLodEL5UoB
         9N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=K1FjpVHqTZWuFBiFwdMThJZJFwYGDL27q7f57M6QvWk=;
        b=ScMDoj8yVsPUKrPflent1eeuZnGG3RcJer7nh3feBHbopGZ+0CtkCfvwaiTXhbKxIe
         YqiNRxktDIwzgulplXnA/mWHUfJEr1cw4eMKLjdQsmrvPARRtaulpsaZXUWs/sg2CEXD
         t2StZ9TeQbkqYv3HFj90OQd7TwqTzEXg7JMiyx58PwT3HVLrfio10W/7Qmw9wmN6VPWh
         Aj7cFJcbM6x11u9Z5aXlKwYSkgsOU0eDjnd5rE/s7OBD4YFwe3fUTatJYJlpLlPBPz1s
         l8/Ckdk4XSuiBgYJBIuupt16mwRAkz8pVMAUWV0xJ8rln22RSkzcvIjNbNwpn96H6FjR
         6ZJg==
X-Gm-Message-State: ACgBeo0isyX3eNjc3v9hG8cWePkvwQk76yFvksKUb0vl9Osh0ERgVKYI
        DyRdq+qazVCp6eFs1ftmLm0mBg==
X-Google-Smtp-Source: AA6agR6wFV+N0b3bXUosUXzcWeejtIfnveQRomEYoZKiiyARyOk63eGmbSedst884SDdeCKlg7MwKw==
X-Received: by 2002:a17:902:a58c:b0:174:3c97:d9a1 with SMTP id az12-20020a170902a58c00b001743c97d9a1mr13616616plb.22.1661754129647;
        Sun, 28 Aug 2022 23:22:09 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id mp10-20020a17090b190a00b001f333fab3d6sm5817972pjb.18.2022.08.28.23.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:22:09 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/3] Rename sifive L2 cache to sifive CCACHE
Date:   Mon, 29 Aug 2022 06:21:59 +0000
Message-Id: <20220829062202.3287-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since composible cache may be L3 cache if private L2 cache exists, we
should use its original name "composible cache" to prevent confusion.

This patchset contains the modification which is related to ccache, such
as DT binding and EDAC driver.

Greentime Hu (1):
  soc: sifive: l2 cache: Rename SiFive L2 cache to composible cache.

Zong Li (2):
  dt-bindings: sifive-ccache: rename SiFive L2 cache to composible cache
  EDAC/sifive: use sifive_ccache instead of sifive_l2

 ...ifive-l2-cache.yaml => sifive-ccache.yaml} |   6 +-
 drivers/edac/Kconfig                          |   2 +-
 drivers/edac/sifive_edac.c                    |  12 +-
 drivers/soc/sifive/Kconfig                    |   7 +-
 drivers/soc/sifive/Makefile                   |   2 +-
 drivers/soc/sifive/sifive_ccache.c            | 221 ++++++++++++++++
 drivers/soc/sifive/sifive_l2_cache.c          | 237 ------------------
 include/soc/sifive/sifive_ccache.h            |  16 ++
 include/soc/sifive/sifive_l2_cache.h          |  16 --
 9 files changed, 253 insertions(+), 266 deletions(-)
 rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml} (92%)
 create mode 100644 drivers/soc/sifive/sifive_ccache.c
 delete mode 100644 drivers/soc/sifive/sifive_l2_cache.c
 create mode 100644 include/soc/sifive/sifive_ccache.h
 delete mode 100644 include/soc/sifive/sifive_l2_cache.h

-- 
2.17.1

