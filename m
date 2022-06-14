Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC74254BCAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbiFNVT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiFNVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:19:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D535C4ECCB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:19:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id x38so17264510ybd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0pe/7jZrdd4wA9KSKjRVId1XeZmrdKxUsF6jrAi1z9o=;
        b=TgovzMs4TKHp7QCrRx5ht9Sl4xwsIf7ncFERmJDn40Zeu5Qb+8aao1rzSn+Q/z7H5D
         0cNDgb6FkXe0RHzt68CaEh38mcjws3v9CbBGI/mZZnS4Trs0mYSZevof6SdFRcm1sXm8
         4PmvuhJbd92Ns3GOCvkZSTW9Rh5PQAjjunJYEQRubOEPkTm5LpqbaBWwLEI9M60sCG6B
         qg/sap2Nvy3Z+BrKB3kGZgf5iOsXbX2qQC4EZ7GScU9H2CuwnC2qRFbaCvdvacToW0bP
         DOUJP3ZzXRzMqa+r1/U8QJFxD60EEi3NWRo8ZCk9gXq/rLbNp8zTc5Hp9v0eEzni18Pb
         ZbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0pe/7jZrdd4wA9KSKjRVId1XeZmrdKxUsF6jrAi1z9o=;
        b=1pZ+HEALKs521lDfNibqZgs9uzlBCpwlwYo4np3WOQM+pY+fRh5erP37OhweuRSsNc
         7WuiSLR852YKGtlbZz6lJj9lftQOe7F38CFx7W0yufD2iCqwZ98Wpp8BnDieqpfgiM1p
         ZQ0j/Ss1YTmBsK3YdAN+D1fWed6hrIuA42VgyZ8wA4yltcLdBZznNfTvExd0LHLUvl0N
         mdivYAiy2/hJ7RKQ/KDTP19s2xBn1cYgI3joLFnFvWUy4gkF6jonR1df0V61jjm208Fv
         sKxdvIzeH3yHfqz7upwqUXWZyrQdgMMEncsOxKyQpFxyy5B810XSaHSSaU2fHtTUVQFb
         vYDw==
X-Gm-Message-State: AJIora/OslWDCEP+KuJNvRXoWrpqV5OV6kGshS0nezQytqIyybamtQ27
        WmSFj8NlqxEjNFN3DfnS00FrNyq2nKw0/779y5roMVbamymU8g==
X-Google-Smtp-Source: AGRyM1ujTcRYf1QhEgbwhq2UxYbzHPM1wCsUxk2r/ecN8hXJGuS+HdqinfwfW57GaqHYU8vFGo1aOKGcDTBYjA2MYWw=
X-Received: by 2002:a25:d913:0:b0:664:67a5:29e3 with SMTP id
 q19-20020a25d913000000b0066467a529e3mr7363860ybg.592.1655241564154; Tue, 14
 Jun 2022 14:19:24 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 Jun 2022 02:49:13 +0530
Message-ID: <CA+G9fYsP05V+bVoZsPto-ZdZra3Mo4unBjNqyk1dOjfMEK1XWg@mail.gmail.com>
Subject: [next] arm64: db410c: WARNING: CPU: 0 PID: 1 at drivers/opp/core.c:2265
 dev_pm_opp_clear_config+0x174/0x17c
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash reported while booting arm64 db410c board with
Linux next-20220614 [1] kfence enabled on this kernel.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
---------
[    0.850420] WARNING: CPU: 0 PID: 1 at drivers/opp/core.c:2265
dev_pm_opp_clear_config+0x174/0x17c
[    0.850447] Modules linked in:
[    0.850459] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.19.0-rc1-next-20220610 #1
[    0.850470] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    0.850477] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.850489] pc : dev_pm_opp_clear_config+0x174/0x17c
[    0.850501] lr : dt_cpufreq_probe+0x1e4/0x4a0
[    0.850513] sp : ffff80000802bb00
[    0.850518] x29: ffff80000802bb00 x28: ffff80000ada1c30 x27: 0000000000000000
[    0.850538] x26: 00000000fffffdfb x25: ffff00000311f410 x24: ffff00000389ec90
[    0.850557] x23: ffff80000a9eea98 x22: ffff80000a9eed00 x21: ffff80000ada1b68
[    0.850576] x20: ffff00000389ec80 x19: ffff00003fc41308 x18: ffffffffffffffff
[    0.850595] x17: ffff800009f21700 x16: ffff8000080955c0 x15: ffff0000031c2a1c
[    0.850614] x14: 0000000000000001 x13: 0a6b636f6c632064 x12: 6e69662074276e64
[    0.850632] x11: 0000000000000040 x10: 0000000000000020 x9 : ffff800009006964
[    0.850650] x8 : 0000000000000020 x7 : ffffffffffffffff x6 : 0000000000000000
[    0.850668] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[    0.850686] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 0000000000000000
[    0.850704] Call trace:
[    0.850708]  dev_pm_opp_clear_config+0x174/0x17c
[    0.850722]  platform_probe+0x74/0xf0
[    0.850735]  really_probe+0x19c/0x3f0
[    0.850745]  __driver_probe_device+0x11c/0x190
[    0.850755]  driver_probe_device+0x44/0xf4
[    0.850765]  __driver_attach+0xd8/0x200
[    0.850775]  bus_for_each_dev+0x7c/0xe0
[    0.850790]  driver_attach+0x30/0x40
[    0.850799]  bus_add_driver+0x154/0x240
[    0.850813]  driver_register+0x84/0x140
[    0.850824]  __platform_driver_register+0x34/0x40
[    0.850835]  dt_cpufreq_platdrv_init+0x28/0x34
[    0.850848]  do_one_initcall+0x50/0x2b0
[    0.850861]  kernel_init_freeable+0x24c/0x2d4
[    0.850871]  kernel_init+0x30/0x140
[    0.850884]  ret_from_fork+0x10/0x20
[    0.850897] ---[ end trace 0000000000000000 ]---


metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 35d872b9ea5b3ad784d7479ea728dcb688df2db7
  git_describe: next-20220614
  kernel_version: 5.19.0-rc2
  kernel-config: https://builds.tuxbuild.com/2AYbNeAYdcbtKeaEoYNvOAwsMQf/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/563047963
  artifact-location: https://builds.tuxbuild.com/2AYbNeAYdcbtKeaEoYNvOAwsMQf
  System.map: https://builds.tuxbuild.com/2AYbNeAYdcbtKeaEoYNvOAwsMQf/System.map
  vmlinux: https://builds.tuxbuild.com/2AYbNeAYdcbtKeaEoYNvOAwsMQf/vmlinux.xz
  toolchain: gcc-11


[1]
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220614/testrun/10154254/suite/log-parser-boot/test/check-kernel-bug-5169280/details/


--
Linaro LKFT
https://lkft.linaro.org
