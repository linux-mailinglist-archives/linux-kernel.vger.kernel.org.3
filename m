Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E34511524
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiD0KuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiD0KuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:50:08 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2436251E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:20:54 -0700 (PDT)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id DBAC4C8E9A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:44:01 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 88F3C200006;
        Wed, 27 Apr 2022 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651052546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Os8UmEkM4YAJJt2iMunVLmf9fDm4xLcC8Rb9y57nPU=;
        b=ZHQ5jcKugqfvVn8sQ9TnnPwi8XcY0PlcsLpmyZAgzkTOMz2XiJ+2ZGWconG18qOLJpLv/G
        8KhzIMo6nqHuzu6v9kvZuXAWRv8QQdYJieYZ0MNekrMLfp5j+IeTYwEqKAsjLVxMwgOttk
        097KYO5ODV+XOYh54EnZCmDDnYwquf4DR7Kiy/iNqOetPddvZ9QQK2xigVnTIV68RDSkmD
        pKhF2TanEAuIY/qE/6cewZH/dAII/mMGXB3bDAnZHesbEUVaQW2qP7ibCNo1EqWnfXLftj
        FgPF8bpubKeSjGuwEr7bqjK/e3N+t4/jtPhsnCbCNwZodZ+pWyNJkHuVMDQ6Zw==
Date:   Wed, 27 Apr 2022 11:42:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 5.18-rc5
Message-ID: <20220427114222.75209cb3@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is a fixes MTD PR for the next -rc.

Thanks,
Miqu=C3=A8l


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-5.18-rc5

for you to fetch changes up to ba7542eb2dd5dfc75c457198b88986642e602065:

  mtd: rawnand: qcom: fix memory corruption that causes panic (2022-04-21 0=
9:29:07 +0200)

----------------------------------------------------------------
MTD core fix:
* Fix a possible data corruption of the 'part' field in mtd_info

Rawnand fixes:
* Fix the check on the return value of wait_for_completion_timeout
* Fix wrong ECC parameters for mt7622
* Fix a possible memory corruption that might panic in the Qcom driver

----------------------------------------------------------------
Chuanhong Guo (1):
      mtd: rawnand: fix ecc parameters for mt7622

Md Sadre Alam (1):
      mtd: rawnand: qcom: fix memory corruption that causes panic

Miaoqian Lin (1):
      mtd: rawnand: Fix return value check of wait_for_completion_timeout

Oleksandr Ocheretnyi (1):
      mtd: fix 'part' field data corruption in mtd_info

 drivers/mtd/nand/raw/mtk_ecc.c    | 12 ++++++++----
 drivers/mtd/nand/raw/qcom_nandc.c | 24 +++++++++++++-----------
 drivers/mtd/nand/raw/sh_flctl.c   | 14 ++++++++------
 include/linux/mtd/mtd.h           |  6 ++----
 4 files changed, 31 insertions(+), 25 deletions(-)
