Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A91F4D704C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiCLSHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiCLSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:07:29 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8810070CE4;
        Sat, 12 Mar 2022 10:06:21 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q19so10193765pgm.6;
        Sat, 12 Mar 2022 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvNq+45Cgx0F9RlJNbV6eVIGlsmW+8HM1hn3gRVvPWk=;
        b=BdFHcOFjPNbp1ClgSl4cyaGkb5MGKSVWZdY+OtHHZfGHtXKxN28jZZxVPQtkBFiS06
         GZEUZR1GSzIdkVQsh83Bixkp1BHYgQ6ZGzl/tIytqspcbY48Kf8UwKgCPmEHFn3pI97n
         REiy22FPkON3FN0ck3/jcmt9VssS8fG/wH4NA9Duxpsk5Itm5EgH2Pvq6MhkNLc4HG8J
         8rwHl/9WEGKrsvw02JwZ5GtUPV08BFaJ6/xMBbqobumoBuR8rox2TaDALeattwmyita9
         7opxYp+bS+wauBOBa0m8kurcBLW5yaFusZ8PhrG67B8Ei7bc/yZClni0yL9C4gPhlthM
         IxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvNq+45Cgx0F9RlJNbV6eVIGlsmW+8HM1hn3gRVvPWk=;
        b=QneDIVJQckv1qEf05FyvdFGX9hVJ82yNIij68bBFjCDLX7eYG9kzvH3gbVgDrfcrpX
         T6F42dwY7LGx1AmlBsODwjV3ojbkdh+4ARUe+hjIzulTe0IzS4qEk0toWu/LrX1qkVOd
         JIhb+j47pXCBOMRv22dGfMxU0C9v1RDp6ATLTnpj09y0RkIfg/ObhCq7al155lngifLe
         R6iPETStRA4TwQ0tAdKO/59mZ+T8olf7O97QbigNK5Wwt5c50FH+zLsy8BZYE91McUZT
         DnONI9Q/dKUWUwHpunRpE3PTc8ltmbZ0Kq2hmHFtRQJjkXNb5Ket8sAGDbrR/OAIFdC0
         ZHag==
X-Gm-Message-State: AOAM533tehFGpaflFGWh12AXbwt8CQ5XGMakdWAiQN9mXizuTLuMTqV9
        ZvVpyeRCYVSHUWRfQxt0dRbYos0e7hs=
X-Google-Smtp-Source: ABdhPJxyh0A25Tmu6u5SH/ooAqZ5mdXki0nzOSIzCUFbTtXvAoNYNvhzqX1hQjol5DBouIIcS5LXqg==
X-Received: by 2002:a05:6a00:2444:b0:4f7:73bb:7582 with SMTP id d4-20020a056a00244400b004f773bb7582mr14509995pfj.39.1647108380870;
        Sat, 12 Mar 2022 10:06:20 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id z72-20020a627e4b000000b004f70cbcb06esm14017951pfc.49.2022.03.12.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 10:06:20 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] More DT fixes for arm,pl022
Date:   Sat, 12 Mar 2022 23:36:13 +0530
Message-Id: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
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

As per spi pl022 binding, spear and lpc18 platform require fix in dma
properties to resolve dtbs_check warning.

Patch 1(spear): just reorder entries to resolve warning.
Patch 2(lpc): require reorder of dma pairs, and also within pairs.
In general, dmas follow below convention:
<rx,tx> = <x+1,x>
Keeping this mind, I updated entries for dma pairs.

This patchset is based on
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git, arm/dt

Kuldeep Singh (2):
  ARM: dts: spear13xx: Update SPI dma properties
  ARM: dts: lpc18xx: Update SPI dma properties

 arch/arm/boot/dts/lpc18xx.dtsi   | 19 +++++++------------
 arch/arm/boot/dts/spear13xx.dtsi |  5 ++---
 2 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.25.1

