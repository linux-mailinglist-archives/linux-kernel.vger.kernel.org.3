Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897A9518D0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbiECTUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiECTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:20:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C7D3FBCD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:16:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i10so3923117lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wPTnR2Zu/nMupXPED8+6zfG3R03kfxI0ufpTxQT+s40=;
        b=tjQdxT++eBAtCciDu2vU3NoUP4QW6qBmdwluJN7ZqTxj5rCLdpDXoPA48gZOr5T9JR
         Te40XWsMzEhOWZumvQ0tidKpqGFo+dZmA84nwmchSTzMnxyLvAWfAxhk6KmTExqHOZ2w
         BNXaoBlUSVt/2a+kA8BScws+d2nLejwqepBJLd/c4n84GvLJRoqcAge0xcRpuNsjcHKC
         MKHJmMwbkmyHpazMg6NuqL52MS88IhStwuUzr6I/+6NP9KepZ1guoda30WFcSYGasBnk
         Z6MdIzaa3k9WdCnxWtr/DghvKxLTu8EFbc/vLdy5GHAALvnLBG2KuGJAvwIqoSo0QOZ/
         fbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wPTnR2Zu/nMupXPED8+6zfG3R03kfxI0ufpTxQT+s40=;
        b=r+ayzIDKpS0U1ZjN3TsNio5hjFgmTRwYLKCbqbQFdRFyR88E5909H0w2+QcVw9IoA9
         QxGWS8BY1hBMKxM7FDw3CnxB8OwrzYXiw+YmTe4bB9tD6E1guRuGrEn4VKJLFgByVMzC
         DgDvwqmPeedsDX2f+gjnH9hvruNXxf3cEfT+4nevE8qflfxuotXgtxpiRh3AabinKtRt
         z3gXWIWDPKcF6DcFY4xxnOZRleKOskZ5Vd19jW/BE3dREgo2zVKaNEEStHEYMBNHbc8d
         95pUem9DxDmFUfOiUy4aunujxkNifmL8wHWjWpGaEWkb7fhtsvoL9s6rFNWEMaYhfR9D
         yzHg==
X-Gm-Message-State: AOAM531+QvgR2bKVPI+S8beX6yalPFVMj/FHaHl18Ztg2+GZB67WtGtn
        W4tqmknYTez6esAkciyMUm6W3A==
X-Google-Smtp-Source: ABdhPJwPzzX7IVXeDUZKXs6KdmMPkgA7AOVPSzXGlSNues3oWyX7bzj63hV8upZvkAXNMXk0YzSTWQ==
X-Received: by 2002:a05:6512:3f88:b0:44f:567f:8715 with SMTP id x8-20020a0565123f8800b0044f567f8715mr11912202lfa.609.1651605389115;
        Tue, 03 May 2022 12:16:29 -0700 (PDT)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id d10-20020a05651221ca00b0047255d2119bsm1013800lft.202.2022.05.03.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:16:28 -0700 (PDT)
Date:   Tue, 3 May 2022 21:16:26 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE menu for v5.19
Message-ID: <20220503191626.GA3278203@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch which combines the config and menu for TEE's
menuconfig into one line.

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-menu-for-v5.19

for you to fetch changes up to a4b75fe8e1c15c96c4eb083e211ccbbfd56599f9:

  tee: combine "config" and "menu" for TEE's menuconfig (2022-04-05 07:32:23 +0200)

----------------------------------------------------------------
Combine TEE config and menu in one line

----------------------------------------------------------------
Jan Engelhardt (1):
      tee: combine "config" and "menu" for TEE's menuconfig

 drivers/tee/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
