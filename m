Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA9506F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbiDSOA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiDSOA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:00:56 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11C38DB7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:58:13 -0700 (PDT)
Received: from workstation5.fritz.box (ip-088-152-144-107.um26.pools.vodafone-ip.de [88.152.144.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AC8923F773;
        Tue, 19 Apr 2022 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650376692;
        bh=9TNFholiRJXqbGHcOH+prBcFcS5rnvuKQv52QUBJe7U=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=hVFPWrPbONBJB2tlLgQ2nNkvJy1NRd6M41wxLPj/RxKiK4EkPj2WPZGLsEbMzRDTb
         y3csCsWnCAuzFo4w2aDHEyB+NGzo4Z7pUowo7f58YT2d7ZWV6vAwGgmF95g4kpQOne
         pxvc4Os4g8wJKmEdacpsYkM8bXd70hP0pmiXFHb68SylREa2lMvezcm8aNbMEJm9/A
         Q36YCkYZ8eBvCOopTyEzWUA/nPOxwyJnyQIIX+8sEBy95NEEfMI7KeRnDwtT4Rm3Dn
         EHySt2Nwno2k9q8xvUhkW0ppRfnhfiU2Z49cNu+zSUY4T+1tLLrKzLcaIRcf1YUPzH
         v5uEVfomjlbUw==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jens Axboe <axboe@kernel.dk>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] RISC-V: defconfigs: add VITESSE_PHY
Date:   Tue, 19 Apr 2022 15:58:07 +0200
Message-Id: <20220419135807.164266-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PolarFire-SoC Icicle Kit uses a Vitesse VSC8662 dual port PHY.

Enable CONFIG_VITESSE_PHY by default to provide network.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 30e3017f22bc..12908aa7766e 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -63,6 +63,7 @@ CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_R8169=y
 CONFIG_MICROSEMI_PHY=y
+CONFIG_VITESSE_PHY=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-- 
2.34.1

