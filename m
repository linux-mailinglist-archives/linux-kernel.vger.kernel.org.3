Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F044EB5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiC2W30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiC2W3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:29:24 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B969C1BB7B0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:27:38 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C7E9620002;
        Tue, 29 Mar 2022 22:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648592857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ojg5F1DXCe3Y/aV3OPsS7r+oEs3m50ZmfW/vq63NdB8=;
        b=CGXO0obM94xvnCMJeNES8DMcbrm4pADGk/QsroloKCfHamZL9Vp3E6OMEqLq6LMdqljZ8t
        MtXEVp046HV2pssKiEwR8BAT+j3oOvDhdWkuBj7WZ1SbMj/vSvfzDiz92w1LnZXVrIdlSp
        0AyJYYcY7LSpWaQZeYD+pqDb2jsUL+6YUI5MJWxtGVInsDLOZDy4u66mutXAeEqdnZxFJj
        RHZwBMiLiYiMltatn1dhusseK9ik8VHFQKZgv6ARF08Dqns3E+QztvY3AlyVSoZ+r5YY9h
        6BN4p3CkCy1jseonPus6FV+4Zo24gx5hc+8shwsiGxjEEw3JwSoRpDv4XIG1OA==
Date:   Wed, 30 Mar 2022 00:27:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 5.18
Message-ID: <YkOH2Jd9soaAFoog@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux,

Here is the pull request for the i3c subsystem, adding support to
dynamically add i2c devices on a bus.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.18

for you to fetch changes up to 6cbf8b38dfe3aabe330f2c356949bc4d6a1f034f:

  i3c: fix uninitialized variable use in i2c setup (2022-03-08 22:33:52 +0100)

----------------------------------------------------------------
I3C for 5.18

Subsystem:
 - support dynamic addition of i2c devices

----------------------------------------------------------------
Jamie Iles (3):
      i3c: remove i2c board info from i2c_dev_desc
      i3c: support dynamically added i2c devices
      i3c: fix uninitialized variable use in i2c setup

 drivers/i3c/master.c       | 151 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/i3c/master.h |   1 -
 2 files changed, 142 insertions(+), 10 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
