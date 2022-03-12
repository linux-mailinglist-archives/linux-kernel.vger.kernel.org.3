Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689724D6E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiCLLkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCLLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:40:06 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20871D981A;
        Sat, 12 Mar 2022 03:39:00 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 132so9647094pga.5;
        Sat, 12 Mar 2022 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbMwWLdeFpytda/SuyMy6a3U6z6EORwEzk+ecuTxS64=;
        b=JhTAiOQY+dP2Zl+oj6gEka2qN8UYhLaLWGsv8z6R4jdqoT/SovX6mL856zxx5hcO7E
         ByZN30S31eblbz9vchNtGkXE7tQV1SKF6sEp8Ter+EomArVjA1OnGFMP+T/qBQolU/hG
         ztRBmatrXj+w6XWsYxVh5r6PXkGRf1GqpALrwsdQyWPJ2UbWwa3/ceIGhLRuoCjspity
         IgmohA+9Kqc2kRuOxSs8d3eDxF1Js16JhKLnKsVUqmn9BCCbGL4H0Pwz1VSzA/v1XGGU
         X/XZ2/xiv8TcOU5Whr0lcHPeZC5kxRHZYdCssa1/p4QLAXnLMPdp0aQVJmVRlasFaOkD
         uiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbMwWLdeFpytda/SuyMy6a3U6z6EORwEzk+ecuTxS64=;
        b=v2ti/Bv08klANjdLOSUqVIT0I4IgBkgzYONN7WHOOBFb4TOP7rWjgO8WMEVzv5SLaE
         MVJ7FuuCgnh6EH8x1letVb6F9A3ZwID912Dx2FLLsPs00JsHAZ5EkIfdGE7abtaFFQ+f
         UPqHC3MR0yt65m8YIh5YTeesozq2SNI8yEmKcWYBm+qoZjfJzCk+LPjvTYesz7lQA600
         b4vjBVLy0idt/RYhSLJNoXA0v6ao8F5eUHHbs6oN+qds3KvSvfdHmq4sWLy2KobOAbBH
         7nQFdf4sahmK7eICkvowhjnsWp/E5Wrt8SVZB+uWOGkSAlbGSGhzAbbcrXC2ezOv86se
         Au2w==
X-Gm-Message-State: AOAM532kJ/A2LEf2DBk/MHoHkzBxMTH7UMHlIhA5gNR0m+JV0CeaBIMg
        QpzJFqOfUiRvZryXMnJGZVA=
X-Google-Smtp-Source: ABdhPJxM95Ms2pBmwEbJ5W4IEqk507Y4QMHA9fPLH1HLUjT6YonxouNAeYeTJdkP2/3c7PI0tZzo7w==
X-Received: by 2002:a63:447:0:b0:37d:b683:2c06 with SMTP id 68-20020a630447000000b0037db6832c06mr12291129pge.16.1647085140223;
        Sat, 12 Mar 2022 03:39:00 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm11065191pgc.8.2022.03.12.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:38:59 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] DT fixes for pl022 for arm platforms
Date:   Sat, 12 Mar 2022 17:08:49 +0530
Message-Id: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
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

This patchset is an attempt to fix device trees and resolve binding
warnings for pl022. This requires updation in clock name to keep
alignment with other platforms and spi node properties for integratorap
platform.

warning: 'sspclk' was expected
Above warning got generated after binding patch got accepted from spi
tree.
https://lore.kernel.org/linux-spi/164703017513.264521.4229870520812086440.b4-ty@kernel.org/T/#m0301ae2addf60781a956d94c2b192aa26db42074

This patchset is based on
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git,
master

v3:
- Reword commit message for patches 2-4
- No functional change
- Rebase to top

v2:
- Remove alias in ste platform added in v1
- Split patches as per platforms

Kuldeep Singh (4):
  ARM: dts: integratorap: Update spi node properties
  ARM: dts: realview: Update spi clock-names property
  ARM: dts: versatile: Update spi clock-names property
  ARM: dts: ste-dbx: Update spi clock-names property

 arch/arm/boot/dts/arm-realview-eb.dtsi    |  2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts |  2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts |  2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi   |  2 +-
 arch/arm/boot/dts/integratorap-im-pd1.dts |  4 ++--
 arch/arm/boot/dts/ste-dbx5x0.dtsi         | 12 ++++++------
 arch/arm/boot/dts/versatile-ab.dts        |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.25.1

