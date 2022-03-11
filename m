Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B64D5FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347981AbiCKKho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbiCKKhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:37:43 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897AB1BD064;
        Fri, 11 Mar 2022 02:36:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id s8so7505128pfk.12;
        Fri, 11 Mar 2022 02:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kBzN94Gj0KOcRGxd4I/OOqJ85nYBgF+uxP0gTO4t5Y=;
        b=UFiTtRsJfjDTvCAlYqgGqw/G5weEItGfbOZgVXPSyHQJeJhX2QqWdqYNJ1GbQtpIvT
         cYYn4WOla5NACMF7HqK+uAEHMdfwhcjOzN4VjCzg7gX5+mSeFUOco0ETKEdDoIyCxfMj
         tMBI4JGAfiNX6raVxqk3xGnZz1XwQ9ZfEOBMvQYOetK5IGLUikMMqKL/k/n8q2xfUSJF
         HZAN8PgXRc8U6VoEbDxIShM/rpj72e+O/APaiYBYT/lfWIo6J4Ccd05rJfszWdj3I88H
         MrEXD1ejb1eG+TmZzpQV5Z/3aLyJUYqE+PZa9l+HUD6rlLX//PefWhcDVEQRu9TUWWKY
         olQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kBzN94Gj0KOcRGxd4I/OOqJ85nYBgF+uxP0gTO4t5Y=;
        b=0NIgFGZW74BmOzaiSxKgN+hSDK1ws7HexLLi29ZvHySCWjlIzohiz5Uffx+lqBVgTO
         8BjQJQ/RkVHXRQhAXPS4RCi6C2+aw+T7yjhRZMcALoYMnutte05hLx8498hBAsJzccB6
         tG0k91lYDBFc+q4e3T0urGZZEMOQGaiQQjZMc+33ZtjKRBT9kO2GiRTuZikQdG0TWQZO
         6qgytT9dEi0F630Jn9MwzWQQ3brc3YktVUM5jAl7gWz4KDRaQ9O6BvEjkfTg5F1xD/NJ
         EEP4q9EariKdyG/uAKX2Xhb06RDfjc16iqX6AMfDMfNLDkBxghmdJIIQKZH/2nYuD+1O
         FBrw==
X-Gm-Message-State: AOAM533Blvdseonhvvd4H/8d3LdZOA03CkgTlPnrQyzHVzgXQ7AspSmg
        wWYLBUCRARyDUFk03H2doe0=
X-Google-Smtp-Source: ABdhPJxgBKaFMppySfdAjdprz21nDoi6XvW07Go3KdVYfQ4Ly+lTlqIPizsUo6jX0RcmkJmpu5Knxw==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:786c:cce3 with SMTP id g4-20020a056a001a0400b004e1786ccce3mr9404991pfv.81.1646995000070;
        Fri, 11 Mar 2022 02:36:40 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm4445892pgo.6.2022.03.11.02.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 02:36:39 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] DT fixes for pl022 for Arm realview, versatile platforms
Date:   Fri, 11 Mar 2022 16:06:31 +0530
Message-Id: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
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
warning for pl022. This requires updation in clock name to keep
alignment with other platforms and spi node properties for integratorap
platform.

This patchset is based on
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git,
master

Kuldeep Singh (4):
  ARM: dts: integratorap: Update spi node properties
  ARM: dts: realview: Update spi clock name
  ARM: dts: versatile: Update spi clock name
  ARM: dts: ste-dbx: Update spi clock name

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

