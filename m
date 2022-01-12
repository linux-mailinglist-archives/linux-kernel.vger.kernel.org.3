Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270E648BE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350940AbiALFtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350927AbiALFtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:49:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348AC06173F;
        Tue, 11 Jan 2022 21:49:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2AD6B81DFE;
        Wed, 12 Jan 2022 05:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4504AC36AEA;
        Wed, 12 Jan 2022 05:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641966553;
        bh=uEJemrohi9OZgKT8giEq5i49SQYJ5x2Oe5rbsLhaKfo=;
        h=Date:From:To:Cc:Subject:From;
        b=qZre6pX3PtZzEKaVahfUMAOtV2rxHJxS4xzCXNZeKoLdF2n48qAT9XVJhej0BfTZa
         my2p4SFrtW4Aur7Dng06oXmC0LX2uRgIoBU6Eb7gR9FuBt8pCXvR4MJnGeszws80AV
         bohwh3ZYAJ4KsjtV5pXjpYzBUxZM+kRvMPZmzmy9g/7hW07Y0kEz38SNro+dUHft6J
         oVdMfXfzQmPGQpo2nUYq8GgnXYLe0lptTfTomD++VOf1bioFPMlGS2agFCgP6CCLOs
         TA9d1wJtGUWHCroiKGY06Wu1h8Pbfh0+C/yVhtrjmdTuqS9FTehDOleagecDNr15tE
         PEbry204kfK6w==
Date:   Wed, 12 Jan 2022 06:49:09 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.17-rc1] media fixes
Message-ID: <20220112064909.1ec47504@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.17-2

For:
  - some fixes at si2157 tuning logic;
  - a warning fix on atomisp when used with clang.

Thanks,
Mauro

The following changes since commit 68b9bcc8a534cd11fe55f8bc82f948aae7d81b3c:

  media: ipu3-cio2: Add support for instantiating i2c-clients for VCMs (2021-12-16 20:58:56 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.17-2

for you to fetch changes up to 8d4ff8187bb2b0c9025269f0da42ed16c878cb18:

  media: si2157: add support for DVB-C Annex C (2022-01-10 15:56:50 +0100)

----------------------------------------------------------------
media updates for v5.17-rc1

----------------------------------------------------------------
Nathan Chancellor (1):
      media: atomisp: Do not define input_system_cfg2400_t twice

Robert Schlabbach (3):
      media: si2157: fix 6MHz & 6.1MHz bandwidth setting
      media: si2157: fix bandwidth stored in dev
      media: si2157: add support for DVB-C Annex C

 drivers/media/tuners/si2157.c                      | 34 +++++++++++++---------
 .../media/atomisp/pci/isp2400_input_system_local.h |  2 --
 2 files changed, 20 insertions(+), 16 deletions(-)

