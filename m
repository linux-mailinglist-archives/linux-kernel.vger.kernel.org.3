Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCDB53AF7E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiFAVR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiFAVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:17:55 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E1D6A06E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:17:53 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CCCCD1BF204;
        Wed,  1 Jun 2022 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654118272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yDUhBv6XHVz7aAD1gbDoff/7ZzVY1tgq3gAseNLUe94=;
        b=cfJTjSQnibUPOy+Jo5Lb1kxrzIWavxaygTiwI6e6wMGZFBVDEHdUgpVRy23KU2hZtq/Tng
        8YwRpNPDVwH6UMe9XRFyKvyy2ih+uWYo/qlrh5pEa0zTPNphrh+Iqk2lovSf9T1cso6zIn
        7Eh4iMVRnJ7QbXxHEDFO3VVbtn6Pm85itJFkGX8atoQjWW6y0VwXCyZNGkDVtm5ZhaeZHG
        m9VGbX78KuuRWfmLK67dw6G4ShjsQQub0TZZXxeD+Q4PNrpa57LeS8bkgJ++Uob3lrukQ7
        /Rk9boN2O0+XW17Sti1ssucCjXch7OmwL0Cmn/S6nOdIBsgUb7tGubcTrNc95g==
Date:   Wed, 1 Jun 2022 23:17:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 5.19
Message-ID: <YpfXf/unhrWZkE3j@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the pull request for the i3c subsystem. Only clean ups and no
functional change this cycle.

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.19

for you to fetch changes up to 66ed42caf286a7aaeb6f1db4b2995dd9416226c2:

  MAINTAINERS: rectify entries for some i3c drivers after dt conversion (2022-06-01 22:46:58 +0200)

----------------------------------------------------------------
I3C for 5.19

Subsystem:
 - yaml conversion of the DT bindings

----------------------------------------------------------------
Guo Zhengkui (1):
      i3c: master: svc: fix returnvar.cocci warning

Lukas Bulwahn (1):
      MAINTAINERS: rectify entries for some i3c drivers after dt conversion

Minghao Chi (1):
      i3c/master: simplify the return expression of i3c_hci_remove()

Rob Herring (2):
      dt-bindings: i3c: Convert cdns,i3c-master to DT schema
      dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema

 .../devicetree/bindings/i3c/cdns,i3c-master.txt    | 43 ----------------
 .../devicetree/bindings/i3c/cdns,i3c-master.yaml   | 60 ++++++++++++++++++++++
 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 41 ---------------
 .../bindings/i3c/snps,dw-i3c-master.yaml           | 52 +++++++++++++++++++
 MAINTAINERS                                        |  4 +-
 drivers/i3c/master/mipi-i3c-hci/core.c             |  7 +--
 drivers/i3c/master/svc-i3c-master.c                |  3 +-
 7 files changed, 116 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
 delete mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
