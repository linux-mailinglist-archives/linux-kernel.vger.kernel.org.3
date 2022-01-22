Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DCD4969F8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiAVEEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:04:25 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:34672 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbiAVEEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1642824264;
        bh=allgSv4dVDKKDmsUoxhgZ8dIDJH5nfNbWiHKZ+coBTo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=EM5U8MjjBnfydyjrw3phHD0Kx6mfrdtFAN6CarvT7eXn/yiXLkZQX/l1ruYHS0wg8
         6FfazUw7xNSevLY/CoKhzdk7DqKvG/kxvPilRfrXswhnDRogor6QIQNoQWm0ok9aVG
         QuDFHEQZos51lzNXNxPqFSRMOesF0BlWagCZYb/k=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 67DE11281405;
        Fri, 21 Jan 2022 23:04:24 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HsOQPr0IRe0N; Fri, 21 Jan 2022 23:04:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1642824264;
        bh=allgSv4dVDKKDmsUoxhgZ8dIDJH5nfNbWiHKZ+coBTo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=EM5U8MjjBnfydyjrw3phHD0Kx6mfrdtFAN6CarvT7eXn/yiXLkZQX/l1ruYHS0wg8
         6FfazUw7xNSevLY/CoKhzdk7DqKvG/kxvPilRfrXswhnDRogor6QIQNoQWm0ok9aVG
         QuDFHEQZos51lzNXNxPqFSRMOesF0BlWagCZYb/k=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D33D41281403;
        Fri, 21 Jan 2022 23:04:23 -0500 (EST)
Message-ID: <21f7e329c2ff2f5ce6a41ff08bda968e7dc10633.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 5.16+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Jan 2022 23:04:22 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is all the stragglers that didn't quite make the first
merge window pull.  It's mostly minor updates and bug fixes of merge
window code.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Ajish Koshy (1):
      scsi: pm80xx: Port reset timeout error handling correction

Christophe JAILLET (7):
      scsi: efct: Remove useless DMA-32 fallback configuration
      scsi: message: fusion: mptctl: Use dma_alloc_coherent()
      scsi: message: fusion: mptsas: Use dma_alloc_coherent()
      scsi: message: fusion: Use dma_alloc_coherent() in mptsas_exp_repmanufacture_info()
      scsi: message: fusion: mptbase: Use dma_alloc_coherent()
      scsi: message: fusion: Use dma_alloc_coherent() in mpt_alloc_fw_memory()
      scsi: message: fusion: Remove usage of the deprecated "pci-dma-compat.h" API

Colin Ian King (1):
      scsi: mpi3mr: Fix some spelling mistakes

Damien Le Moal (1):
      scsi: core: Fix scsi_mode_select() interface

Jiasheng Jiang (2):
      scsi: nsp_cs: Check of ioremap return value
      scsi: qedf: Fix potential dereference of NULL pointer

Kees Cook (1):
      scsi: megaraid: Avoid mismatched storage type sizes

Miaoqian Lin (1):
      scsi: ufs: ufs-mediatek: Fix error checking in ufs_mtk_init_va09_pwr_ctrl()

Minghao Chi (1):
      scsi: aic79xx: Remove redundant error variable

Randy Dunlap (1):
      scsi: aacraid: Fix spelling of "its"

SEO HOYOUNG (1):
      scsi: ufs: Modify Tactive time setting conditions

Suganath Prabu S (1):
      scsi: mpt3sas: Update persistent trigger pages from sysfs interface

Xiang Chen (1):
      scsi: hisi_sas: Remove unused variable and check in hisi_sas_send_ata_reset_each_phy()

Yang Li (1):
      scsi: mpi3mr: Fix formatting problems in some kernel-doc comments

And the diffstat:

 drivers/message/fusion/mptbase.c      | 149 +++++++++++++++++++---------------
 drivers/message/fusion/mptctl.c       |  82 +++++++++++--------
 drivers/message/fusion/mptlan.c       |  90 ++++++++++----------
 drivers/message/fusion/mptsas.c       |  94 ++++++++++-----------
 drivers/scsi/aacraid/aachba.c         |   2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c    |   6 +-
 drivers/scsi/elx/efct/efct_driver.c   |  11 +--
 drivers/scsi/hisi_sas/hisi_sas_main.c |   5 --
 drivers/scsi/megaraid.c               |  84 ++++++++-----------
 drivers/scsi/mpi3mr/mpi3mr_fw.c       |  11 ++-
 drivers/scsi/mpt3sas/mpt3sas_base.h   |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c    |  87 +++++++++++++++++++-
 drivers/scsi/pcmcia/nsp_cs.c          |   3 +
 drivers/scsi/pm8001/pm8001_sas.c      |   7 +-
 drivers/scsi/pm8001/pm8001_sas.h      |   3 +
 drivers/scsi/pm8001/pm80xx_hwi.c      |   7 +-
 drivers/scsi/qedf/qedf_main.c         |   2 +
 drivers/scsi/scsi_lib.c               |   8 +-
 drivers/scsi/sd.c                     |   2 +-
 drivers/scsi/ufs/ufs-mediatek.c       |   2 +-
 drivers/scsi/ufs/ufshcd.c             |   2 +-
 include/scsi/scsi_device.h            |   5 +-
 22 files changed, 386 insertions(+), 280 deletions(-)

James



