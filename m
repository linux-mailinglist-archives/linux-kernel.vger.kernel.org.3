Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39CF51D1E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388335AbiEFHH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384172AbiEFHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:07:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D566F82
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:03:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s27so8209813ljd.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HgHALsyDDul+mc+1DSzMYml4J86Z9SHNWaoFWG5JUw8=;
        b=pCPde4mTdjwSTR8g1zQ4ksFClzTrlYZt7XTkR4bRFZM644CK08GuCtBjolZqqtxGKO
         Q4vYjkuM0GsP7TWXdkKKgbGziS8V8dNZ3KVNpdETSePgZsYIIW1EmLDENZtZc+IYL3HQ
         p5fVlyRK2rwtTFpt5me25KVbOdUH+xTVdOPIB8gH6cmWGnL4tgBc/POeAHlxG1BRvVHm
         C+I1IcAcUzTtcKqwznJNyFvimheXp2ECR4T6AsMW828Za3Y6/fK1A4Yzknm3rNRy/HmJ
         F/NPQzou+k2ZdWTK5BJ7ZssS0BrgupEb6w6cbHLo07DRH0Tg+gtqIM+WaU6Si1r+86iS
         PT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HgHALsyDDul+mc+1DSzMYml4J86Z9SHNWaoFWG5JUw8=;
        b=pNr0wXku8yAY1XSObg6TJJdYnpeqTKOl03Lp4nLSLMpkZeqj+31ddGnouYyM3ppEA/
         6F/mQ3LjdzB87dfjgtTo0lsy+5dWv7bCGslwVXMwUZ+m560KCsVawD279Z/XF36iOM55
         rD48pBrRTzj78yDU6biRwjborIy1Chuw62zVH4S54RC6KFHCKfN0geANxRntDahPhRp2
         7VMkVell+Ummwbjkx1r1fA0mIoDvUy7P05YwV2EGHFPf1xhAka8vG/smZjjq4MnuGt1M
         Y0TVZg951PZFJZBXuSaBGWCJT/+XmwHJX0IcJgcegXTkpTTPFzxyCx+SVmpFrDNcCD8Q
         2opQ==
X-Gm-Message-State: AOAM530tLXlbhOST8+eQpcVo20SIrtDIXv4Z66wgIU9s8qbf0uBu2Ygo
        pTndu25qkscIa9jzrtlJ2+9rFg==
X-Google-Smtp-Source: ABdhPJznUTr5ulzv3av1M+Wo2Zqt4M8NBLFPNb7kWBPw7T1LHaYWJFyPAFDg9gC5MayiDt0O4yFFjA==
X-Received: by 2002:a2e:b8c3:0:b0:250:6889:6782 with SMTP id s3-20020a2eb8c3000000b0025068896782mr1173664ljp.531.1651820611192;
        Fri, 06 May 2022 00:03:31 -0700 (PDT)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id o13-20020a056512050d00b0047255d211ffsm12960lfb.302.2022.05.06.00.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 00:03:30 -0700 (PDT)
Date:   Fri, 6 May 2022 09:03:28 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE Cleanup for v5.19
Message-ID: <20220506070328.GA1344495@jade>
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

Please pull these small cleanup patches which removes two unused and
outdated TEE_IOCTL_SHM_* flags and two unused pa2va and va2pa functions for
tee_shm's. 

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-cleanup-for-v5.19

for you to fetch changes up to d8fc1c7c4c9b705ce5f5bba772ad66a0137c685d:

  tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF (2022-04-26 10:17:03 +0200)

----------------------------------------------------------------
TEE cleanup

Removes the old and unused TEE_IOCTL_SHM_* flags
Removes unused the unused tee_shm_va2pa() and tee_shm_pa2va() functions

----------------------------------------------------------------
Andrew Davis (2):
      tee: remove tee_shm_va2pa() and tee_shm_pa2va()
      tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF

 drivers/tee/tee_core.c   |  2 --
 drivers/tee/tee_shm.c    | 50 ------------------------------------------------
 include/linux/tee_drv.h  | 18 -----------------
 include/uapi/linux/tee.h |  4 ----
 4 files changed, 74 deletions(-)
