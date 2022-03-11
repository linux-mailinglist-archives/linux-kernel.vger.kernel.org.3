Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301F94D5E95
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347601AbiCKJjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbiCKJjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:39:08 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930D9BB85;
        Fri, 11 Mar 2022 01:38:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id h2so3425247pfh.6;
        Fri, 11 Mar 2022 01:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4UdACirxY0xsWd1veLmX7WNmlz8Y4QUFgsG8QaePNhI=;
        b=agrL8Vmm1KeqiI6nEnTVDa1ZDOK8ULV8iyMijEcu7zlaHK/lViw8aOiuYCHluRe3Qi
         oI2maBBIeOnqNHMah24Rs+m8zgWKzTMpYvDbNT30bnfLtUj8FirJYsb4Odg1qG6Pox7K
         HITnTQoW3KUSvStsl7JahidRqX8hYxPZ2DdoiPtxSAQMtWbPJ3wxFPLjfzLDA/naZp2B
         U+NT8mxtT8Cn0PyuSyh7R+PoimjJHsvqsQv+gGcBk2rZL99FfWbB+HhTDtH0Wl8ocVB3
         n2I9viEraC7mJBkzRsFBEQ0rsBriRXbD406YQvHY/rOc53ejhYsjL7V2p99pkn8/Ghvz
         jenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4UdACirxY0xsWd1veLmX7WNmlz8Y4QUFgsG8QaePNhI=;
        b=mwgx6+zl0qGHxEIoCHBoJ0h7tTpS1XqXP6ia37u7ao7ab1fHf2dzi8c1lUbdLvLbCY
         f6yjfO5t9ahEfWTqK6nFjywJTCHv4oPDn12IbkapSlZvsyW5bzlYT02AEyDomEv1dDhM
         z1GNsOPzc+g5hfeLVHezEdNR8lMt4DCmw8OR7rWz5rTwXIEwr0whiWVFOZbf8dd99xMi
         LR3AiOrjPksAdjwPtw2saXipKbiPC3gbDJrUqDp1QlD0hr6Bzm7JLA3BK1dzgSrx6aU/
         2ijrn4r49PkroM00nnJNvBNgp9DJyHIQxqUpaFyBRrDkUG7qMyKKf0FohD4vNj7u3KH9
         JurA==
X-Gm-Message-State: AOAM53137hVcV5CvW10kmoxnaqs1FI38YP/uejklb/40D6DwydSbdR0z
        RXyP83UTFcTPClM84HC6x9fi3hekslipDw==
X-Google-Smtp-Source: ABdhPJwi+/lQ+Rkkt9up1U51/sxroO3UN6n1mL7YQhZ1PnzaQEQ/lsj9lpDBsMDW6DVKszVkq0Sl+A==
X-Received: by 2002:a63:d758:0:b0:380:fba9:f6e5 with SMTP id w24-20020a63d758000000b00380fba9f6e5mr4125220pgi.330.1646991485433;
        Fri, 11 Mar 2022 01:38:05 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm9011011pfk.26.2022.03.11.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:38:05 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/3] PL022 DT fixes for seattle, lg and lpc platform
Date:   Fri, 11 Mar 2022 15:07:57 +0530
Message-Id: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
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

This patchset is an attempt to fix DTs which are not compliant with
pl022 spi binding. Please note, there are other fixes required also
which are sent from other trees.
As git trees for these platforms are not available, Rob advised me to
seek help from soc tree maintainers.

Arnd and Olof, could you please help in reviewing and merging this
patchset.

These patches are base on
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git, arm/dt

Link to v1 below:
https://lore.kernel.org/linux-devicetree/20220311025932.GD54098@9a2d8922b8f1/T/#m734e470b3be87b7591b3e6d618e4c777f8e61981

Patch1: Fix spi clock for amd seattle platform
Patch2: Fix spi clock for lg platforms
Patch3: Fix spi clock for lpc platform

Kuldeep Singh (3):
  arm64: dts: seattle: Update spi clock properties
  arm64: dts: lg131x: Update spi clock properties
  ARM: dts: lpc32xx: Update spi clock properties

 arch/arm/boot/dts/lpc32xx.dtsi               | 8 ++++----
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++----
 arch/arm64/boot/dts/lg/lg1312.dtsi           | 8 ++++----
 arch/arm64/boot/dts/lg/lg1313.dtsi           | 8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.25.1

