Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE752BCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbiERNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbiERNti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:49:38 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9451A6AC8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:49:37 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ff53d86abbso5856197b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/uSQZYQC48Xh2e0RFjJ15gMwehueueWJuEM4ni7IAqM=;
        b=Y2aFu9K0BTRGI2n7MUc9dau75LbpGzCHltRngu7vm4TRJI7KDwyOikctoIx09chBDB
         EH984hCxhjYrvvVXreT5fVZCvK4DcaQWYChptfXZTcjWaWt/EbarmXO9Qnofcy2h+Po0
         PjpGQrEkp66TixNwSfA3n8O25ono7XEPD+via+Tw0azVa2ylNFq4znhj7giywdE8KceU
         aW7+glvKjdRki5uALy6kEeuIQ6zsE1QjDEjw2GtcoknnH1QeRKlMmtPLbM+ufy6mA+iz
         wqnjiae5Km04nHv6MxSDrU9p1hTK1Tbv/kLbp3lFKUDTGRK5EvAD4djqLu0TKAD/NvSy
         VuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/uSQZYQC48Xh2e0RFjJ15gMwehueueWJuEM4ni7IAqM=;
        b=4cVvOizKaH/fTh54fj3lkN8NLjO4vn45lUltL3Mis/WI9QP8Eeq9HfC7aYptcktv/A
         rJugELkiOlmmdEIfUHoryp6AAUAJ4q38oB4eDYC5fBkxwuB5Z+cMGVieamaV26XR50oX
         T8RMm5msXWnqxmmyZHOV4AlHvMPGAHH7VNeo06sWvIbyRK0aBa6sojaTSOay7ucgQFbC
         D39dBCDtselXaRCFJ4nCSyzQjJvjG+tLdk6tOTyKd9loSan8xNrm85LE1Bir8CbSnuXa
         Oo4avhQwq7HdcgddiS8sjFZfFOGKW0mnrnsCsZVIji3v7VfyVUbcaEo0sRyTEn/qr7w1
         pMdQ==
X-Gm-Message-State: AOAM533m03TNDWIAJxPN/KQzaOiwoBT5+TLQFXp/4p3t0SjWihT83O2V
        Qcv/ptxFmyanCrqdIY95pdlCBsCnpQcN3fQmKk10/Q==
X-Google-Smtp-Source: ABdhPJzw1z+kfHZISgByJwPHuHAXbNlF06gRJA5E1r7mTarvzL0wb6gQ289QrQYAKn8Bdtg4HI5xklVJIACphkx4MJo=
X-Received: by 2002:a05:690c:443:b0:2fe:eefc:1ad5 with SMTP id
 bj3-20020a05690c044300b002feeefc1ad5mr17673105ywb.199.1652881776372; Wed, 18
 May 2022 06:49:36 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 May 2022 19:19:24 +0530
Message-ID: <CA+G9fYuCzU5VZ_nc+6NEdBXJdVCH=J2SB1Na1G_NS_0BNdGYtg@mail.gmail.com>
Subject: net/ethernet/dec/tulip/eeprom.c:120:40: error: 'struct pci_dev' has
 no member named 'pdev'; did you mean 'dev'?
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, eike-kernel@sf-tec.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux next-20220517 and next-20220518 arch parisc builds failed.

Regressions found on parisc:
 - gcc-8-defconfig
 - gcc-9-defconfig
 - gcc-11-defconfig
 - gcc-10-defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=parisc
CROSS_COMPILE=hppa-linux-gnu- 'CC=sccache hppa-linux-gnu-gcc'
'HOSTCC=sccache gcc'
arch/parisc/kernel/vdso32/Makefile:30: FORCE prerequisite is missing
drivers/net/ethernet/dec/tulip/eeprom.c: In function
'tulip_build_fake_mediatable':
drivers/net/ethernet/dec/tulip/eeprom.c:120:40: error: 'struct
pci_dev' has no member named 'pdev'; did you mean 'dev'?
  120 |   tp->mtable = devm_kmalloc(&tp->pdev->pdev, sizeof(struct mediatable) +
      |                                        ^~~~
      |                                        dev
make[6]: *** [scripts/Makefile.build:295:
drivers/net/ethernet/dec/tulip/eeprom.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log link,
https://builds.tuxbuild.com/29HszOsHU1On0kNlZbdJBfNWstp/

--
Linaro LKFT
https://lkft.linaro.org
