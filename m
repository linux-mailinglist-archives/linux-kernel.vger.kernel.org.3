Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C24EEDDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbiDANMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbiDANML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7751E4A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F9F61AD1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF73CC34115
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648818621;
        bh=P9ZhR7N1viBzotu2vdeWyox7uE2LN4xP8NqmOkrbUr4=;
        h=From:Date:Subject:To:Cc:From;
        b=YBrV7TUdDolB/L63TQK7DvcAPWYC88Bz9OFtE+dri0xfAfs2sLhPlyA52REKnLIu/
         vGfOu2+jW7i/bqIrb4YHeMuECz+xVg3kQ0nXVEwwqejfvZKmd9tRlhx4EzaMgJ3OHT
         XgK1rVLr1n0NzoujiTRJvwVQJl/a6Z4NgG9zHmh06fv162BsKbo+VEN8acQq4ZFiPB
         y4ps0G3QLupQqLIiDof++HSzpFEUhe6fOOjdIcP/kCrKVcAVv3VhGB225KQwEA9J5T
         7jhZSAm823aUFtvNo53hIDjnr6VWYoPt2HVmL15AnKwwIsLdHcPHfRzhZ0YdMmFlAA
         ELtjBjNCu73dw==
Received: by mail-wr1-f42.google.com with SMTP id w21so4234376wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:10:21 -0700 (PDT)
X-Gm-Message-State: AOAM533ECBMqH0t52YH8/Y8yape9+gVKm5JOlbYMzyuQZHVIfXuAnnwn
        sFYkRwQnt38xUIirZe9iq0hj8SR1APX6zvKf+fw=
X-Google-Smtp-Source: ABdhPJw99tqRh5/BCNmXbUSAVVkd/no1GF/8VM4w7S5Yll4lyL7myiblVKszmPf1mW2iZeHkzmq0sEetSTNfyW2LKsE=
X-Received: by 2002:a5d:47a5:0:b0:203:d4fd:4653 with SMTP id
 5-20020a5d47a5000000b00203d4fd4653mr7952577wrb.229.1648818620111; Fri, 01 Apr
 2022 06:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Fri, 1 Apr 2022 06:10:19
 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 1 Apr 2022 22:10:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8ZoLh9tAaoXjhRk=8o4Q=-S=puQG04Wsr9p=hg9r9x6Q@mail.gmail.com>
Message-ID: <CAKYAXd8ZoLh9tAaoXjhRk=8o4Q=-S=puQG04Wsr9p=hg9r9x6Q@mail.gmail.com>
Subject: [GIT PULL] exfat update for 5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.18-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit f443e374ae131c168a065ea1748feac6b2e76613:

  Linux 5.17 (2022-03-20 13:14:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-5.18-rc1

for you to fetch changes up to a4a3d8c52d952ab1f5c8b8b67b57f2e01936628d:

  exfat: do not clear VolumeDirty in writeback (2022-04-01 10:51:03 +0900)

----------------------------------------------------------------
Description for this pull request:
- Add keep_last_dots mount option to allow access to paths with trailing dots.
- Avoid repetitive volume dirty bit set/clear to improve storage life time.

----------------------------------------------------------------
Vasant Karasulli (1):
      exfat: allow access to paths with trailing dots

Yuezhang Mo (1):
      exfat: do not clear VolumeDirty in writeback

 fs/exfat/exfat_fs.h |  3 ++-
 fs/exfat/file.c     |  2 --
 fs/exfat/namei.c    | 55 +++++++++++++++++++++++++++++++++++------------------
 fs/exfat/super.c    | 17 +++++++++--------
 4 files changed, 47 insertions(+), 30 deletions(-)
