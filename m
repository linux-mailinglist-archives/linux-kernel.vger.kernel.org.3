Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970C6539EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350412AbiFAH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347240AbiFAH4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:56:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB093451;
        Wed,  1 Jun 2022 00:56:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so1163751wrg.3;
        Wed, 01 Jun 2022 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Ckm/CNVIe8mJbLbjc1YMyZFHXRScklb7wbzs7EWiK/E=;
        b=Yzat/dwf/AM2htMHXoX8ZrBghDOu9mKHXzc5MFAu5+QDok8BgPTIYAjFXOR2OXZDA4
         6fa7lTHTG7f2t11AkCCBD7C6HFRrIz20d7/BuIDbX/DuWcYL0S0wkh0EGJi5jBc6ktkj
         m0FB/tvuT3D5ZxHrmq26AsXChgNqViQh4a0TkeT/PxgCZ1aj74xvQ4+EhLosRsd7HbhT
         Naw233YPyrpt61pYVfUczchi/g5OBG0Lt7mZ9QOkpvbZJAxXZ2oLiIu8ZbSvyTICQgTf
         F8zBDcFRL4GW7Te3LOqFkserLUHzvltgfeTWq57alR3KAImTN0UwZA1IU+9ma7eQlOT4
         Tb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ckm/CNVIe8mJbLbjc1YMyZFHXRScklb7wbzs7EWiK/E=;
        b=1jwS9UjCNmcpfSwYI9OhUnuU5ZXg6ry9QMlo2b5aWnOA09afrFOgzeTruFudNiwKeK
         6TKSBOqLnpXTrZkV3FTE30rWs7Jmh5My2ef0tSrzveSZPumoQBAfdsN4U9bnVXnhbAw+
         5WbXy0H04558/CFLW9t8a1Rq1oRIm/6k0jCcoZMXLaedQkuh6vNcYpudxXN+3l/MfNmA
         QyKHrza13xDpYBSyACfUiFhjiEcpvXn1rZrCm+c4z7+VMm9V+D8QAIUCb9OkOWcmXrNX
         9D2+8ej74hVRxWizlnzfym8nwcO127S7VfD7ujT1pZZkFyHdymDDfiKtMRe5bCaHMR6B
         m4pg==
X-Gm-Message-State: AOAM533LWjYwdhC53ngqnkdstJaaGrHRrft3kpFeFP+AqIHa3weN6hkC
        RslJk3LfkLykrxFAkH0Jdss=
X-Google-Smtp-Source: ABdhPJw3jqa+s4fKLgdH9oRW96bVnODow/HsEpnjT5TE5pv0Rn52ACPvxIFOieMcuj+vYFblfcImlw==
X-Received: by 2002:a5d:4e86:0:b0:210:1f1d:978e with SMTP id e6-20020a5d4e86000000b002101f1d978emr19751278wru.172.1654070189022;
        Wed, 01 Jun 2022 00:56:29 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0039744bd664esm4686686wmq.13.2022.06.01.00.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:56:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections after refactoring
Date:   Wed,  1 Jun 2022 09:56:13 +0200
Message-Id: <20220601075613.28245-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 78013eaadf69 ("x86: remove the IOMMU table infrastructure")
refactored the generic swiotlb/swiotlb-xen setup into pci-dma.c, but
misses to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Update the SWIOTLB SUBSYSTEM to include arch/x86/kernel/pci-dma.c, which
contains the swiotlb setup now and drop the file pattern that does not
match any files.

Further, update the XEN SWIOTLB SUBSYSTEM to include all swiotlb-xen
headers and replace the pattern in drivers with the specific one file that
matches this pattern.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Christoph, please pick this minor non-urgent clean-up patch for swiotlb.

 MAINTAINERS | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5ea4ef223f8..cc12a3aaad45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19166,7 +19166,7 @@ L:	iommu@lists.linux-foundation.org
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
 T:	git git://git.infradead.org/users/hch/dma-mapping.git
-F:	arch/*/kernel/pci-swiotlb.c
+F:	arch/x86/kernel/pci-dma.c
 F:	include/linux/swiotlb.h
 F:	kernel/dma/swiotlb.c
 
@@ -21831,8 +21831,10 @@ M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 L:	iommu@lists.linux-foundation.org
 S:	Supported
-F:	arch/x86/xen/*swiotlb*
-F:	drivers/xen/*swiotlb*
+F:	arch/*/include/asm/xen/swiotlb-xen.h
+F:	drivers/xen/swiotlb-xen.c
+F:	include/xen/arm/swiotlb-xen.h
+F:	include/xen/swiotlb-xen.h
 
 XFS FILESYSTEM
 C:	irc://irc.oftc.net/xfs
-- 
2.17.1

