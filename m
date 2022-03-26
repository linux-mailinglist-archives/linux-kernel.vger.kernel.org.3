Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7684E816D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiCZOgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiCZOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:36:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C16421
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 07:35:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so14330833wrd.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=ZJdxWqv2uR1AzZ5ZAvOn0AHFRoukcFllmzLT/jZd85o=;
        b=Q3d3/gaMocLtA0yl3krrrC5cHE19wv25QxUOljibGRSKrpFhe1tWgMYlyapqen5rn8
         rMI585PYrlGMp5zuGr2yXbBLZIvbSMu5h6cue9zrNArk+rRYcpRbz/52IsdqfWlmi096
         fl5y/c4tnRkZ2hLfh3QZnWATx30iekWtW/qFMXldLvDh0ZmLvo0Ene/enw5rVg919o8U
         Gdso0dp8AFZC2akDcTdICGiIFDhdwL4y6mCIkDrih+QPnsOQuzBG81EiPcmqu/fn8keV
         FzQfwjn3X5b4pLfsmMvXeqP8PiEhsC2EswneyMW/z5Oq9Znb4i2fvXN8Scg2P3xTswIB
         l3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=ZJdxWqv2uR1AzZ5ZAvOn0AHFRoukcFllmzLT/jZd85o=;
        b=QujKxRelAlLt0NXdjaRQsHz9i3NGF4BhA02nqK+DIs/g6DzGkv6oHGUazKCPbB4ejs
         79d+fJ5PGsmd4xzjhcFK/pivu/tCpFQGnQswGHoP6c1nPSOmlN6yuoRUP1MSOfqkn9rF
         LrfwziSsQ5TT3HUSK2wXethw7ynZsMAha9gMmfO83ZrblAGbLqaAbUDkGc0k9wpN7ZdI
         EiIjkAQSW+UIPjBhS34ifd1ZjUAQEydWhs0jxEmpgYQ+jMGK2hnkAqcAf/4Yekv9ECm3
         ipjE2VQzJ4a2AxsQJAQ1ORzsMS11oMi2QDcEQe3JuosCklMJZO/kX68aP3ggQQXcubvc
         lwSQ==
X-Gm-Message-State: AOAM533woLnssSaNuuPb13S83YYpjA79v6i1WawenvIaC0fUTC6Tz15A
        VGnLtt8Pag4VMJX3/FwsyV3HCQlLWqk1rA==
X-Google-Smtp-Source: ABdhPJz8AyBvrkcnM0Bw+mJAiG5+foM97TjWHMj+yhWYBSgfmLUP1RRAfCgvLNXM2nM3hApiC0Mffg==
X-Received: by 2002:a05:6000:2c8:b0:204:f83:ba35 with SMTP id o8-20020a05600002c800b002040f83ba35mr13806339wry.539.1648305299263;
        Sat, 26 Mar 2022 07:34:59 -0700 (PDT)
Received: from fedora ([41.95.50.200])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b0038cb98076d6sm8064758wmg.10.2022.03.26.07.34.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:34:58 -0700 (PDT)
Date:   Sat, 26 Mar 2022 16:34:55 +0200
From:   Hatim Muhammed <hatimmohammed369@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Kernel 5.16.11 r8169 ethernet module do not build
Message-ID: <Yj8kj23N6ugwnpFY@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone

I'm Hatim, I use Ubuntu 20.4.3 Kernel 5.11
I downloaded kernel 5.16.11 and installed it as follow:

make defconfig
make
sudo make modules_install

and now I can't connect to Ethernet
I tried again (make defconfig => make => sudo make modules_install)
But before make, I (make menuconfig) and set r8169 to <M>
and tried again, But no, it did not build, there's no .ko file

Actually when I (lsmod) I see nothing, NO MODULES ARE LOADED
I'm must be a fool to think things will be easy, but why r8169 driver
refused to build?

Here are some diagnostics:

$ dmesg | grep -i eth
[ 1.000377] r8169 0000:01:00.0 eth0: RTL8168e/8111e, 9c:8e:99:47:c7:0d, XID 2c2,
IRQ 26
[ 1.000385] r8169 0000:01:00.0 eth0: jumbo features [frames: 9194 bytes, tx
checksumming: ko]
[ 1.538290] r8169 0000:01:00.0 eno1: renamed from eth0
[ 4.182471] RTL8211DN Gigabit Ethernet r8169-0-100:00: attached PHY driver
(mii_bus:phy_addr=r8169-0-100:00, irq=MAC)


$ ls ~/Desktop/Kernel/linux-5.16.11/drivers/net/ethernet/realtek

8139cp.c
8139too.o
Makefile atp.h
modules.order
r8169_firmware.c
r8169_firmware.o
r8169_main.o
r8169_phy_config.o
8139too.c
Kconfig atp.c
built-in.a
r8169.h
r8169_firmware.h
r8169_main.c
r8169_phy_config.c

