Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455364E7EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 05:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiCZEZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 00:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiCZEZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:25:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4D23158;
        Fri, 25 Mar 2022 21:23:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so10181152plg.5;
        Fri, 25 Mar 2022 21:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulOaJmtU0f3Hym4G5EnQj0YV6X55io78YUGEVVMz4JE=;
        b=jBbaFJI2M/l5BzrJV3JHQjKp6X1LzoBHLjuaaTa4hZ+9RakfDXSI8szZ/YB4yw/Ovy
         xypyI9UP7DXzeMaWedLVe+2vBR7kg9+NegIKTZNJES/IUUiLOeeSLUWTsp4pCFg4eNKE
         MDVD3XRngIaY5BZZzEG8NuwiQLV18/W+ZEaqQPKnIAxRHnCiwzfJxqrZOlvFkqatEj/j
         RkZpvIePHpFFq6f8asvbBB9GVvYOapMeuU5EeQZF/E4CrfH/joY6Dtq4MiBUUSFso3Cu
         5A7RH3LLLLZM7hA/ijPtlj67zevuCSr7iMGdioCrwXIxImJqqJLJbJyfoK511DtZTD9e
         YNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulOaJmtU0f3Hym4G5EnQj0YV6X55io78YUGEVVMz4JE=;
        b=ZNlZwELc0SZHvMjqYu+pNQyVql4Wk/A22Ppsx3OJzGq6MCzYspYFrjvDK3CpWG/fve
         z07iDBLWl4Ox18RXGGptBGSxoKbRgQxGQN5TBGEF81N3uC4Y5nEy7fpkMhWUgzxWtfQC
         5C7/Wut/7LXo1UEQWIXBPvcCse7DWcdHzGovONYmwMS0j5BC1Coh3yu8ls4EL8Mt+iAX
         3c9Gyc1KsuQJozeZemvLJPqA8wboOn973nSLJAgGobWruh8CGETUIwmXfnh7PsQph/1P
         uvgG9wZiX68U/VSqrs+INL+kqE1U4OehonTDyR98MEGRu+ypbYLf+ZYNcdAHwT00ROvV
         WiDQ==
X-Gm-Message-State: AOAM53363GmNPUIkzDj9fFyW0QqtOZQHoZA9uuIjuTvQWZW9k7fKJ6wE
        6dWXNv9T/Wcv860n2nJ1p7lZwMiPinA=
X-Google-Smtp-Source: ABdhPJyONeebb7fgSiCEMPtB/xgyTFs2zG6tNuj0TO3Ey8zXXE87Pk+w/VF/tfN/AjzPB636kCkX4A==
X-Received: by 2002:a17:902:b612:b0:155:da18:9ce8 with SMTP id b18-20020a170902b61200b00155da189ce8mr5574021pls.8.1648268618076;
        Fri, 25 Mar 2022 21:23:38 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b001c75d6a4b18sm7457544pjb.14.2022.03.25.21.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 21:23:37 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] DT updates for dma-names ordering checks
Date:   Sat, 26 Mar 2022 09:53:08 +0530
Message-Id: <20220326042313.97862-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset attempts to fix DTs possessing dma ordering issues.
The motivation of the series is taken from a discussion done before.
Link: https://lore.kernel.org/linux-devicetree/20220323175920.93155-1-singh.kuldeep87k@gmail.com/

Just a quick summary for new visitors.
There are few DTs which require dma ordering in order to resolve below
'make dtbs_check' issues and this patchset is in direction to fix that.
dma-names:0: 'rx' was expected
dma-names:0: 'tx' was expected

Kuldeep Singh (4):
  ARM: dts: spear13xx: Update SPI dma properties
  ARM: dts: spear1340: Update serial node properties
  arm64: dts: ls1043a: Update i2c dma properties
  arm64: dts: ls1046a: Update i2c node dma properties

 arch/arm/boot/dts/spear1340.dtsi               | 6 +++---
 arch/arm/boot/dts/spear13xx.dtsi               | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.1

