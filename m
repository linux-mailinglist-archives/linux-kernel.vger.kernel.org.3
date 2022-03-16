Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BCF4DA99D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352382AbiCPFW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbiCPFW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:22:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9965BE6C;
        Tue, 15 Mar 2022 22:21:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qa43so1788239ejc.12;
        Tue, 15 Mar 2022 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FJPuvcpULrXU5rJIxqChK1QcwIzv3ZufSJl5Tvybh4Q=;
        b=Pi0mNJrZGf0xS0gPTi1wEYM9oEa9N9U6+KeW/SphwCtCMLelTdyH2/RGPTt4M00mGc
         lWRV5j7BYg6dJzMqj9DRSExxYZ7WDl/kbnpTDfDvObVyylt52rfcqBVPaNTzSd7lPBx+
         J6mvj01XvMNaYDH6PnF2GdcWlzSvIu5THKK+jBuHYTumIyK/NvLqqjlUEjT2lq4tdDbQ
         qlMdqOR5DbHt5mIw8PFkcPngHD/E/49lXq6PG4gUnXbU/sVwJMCr3VJLPokY3BoDfl+a
         msWHdYHI4A+ApGbYiwieXSu3lWIHXR5DjZpNYrNRU7H4BMuQq7IVWNgpIQ+D2JPEoPVK
         Wt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FJPuvcpULrXU5rJIxqChK1QcwIzv3ZufSJl5Tvybh4Q=;
        b=Gqf2mrWUQe1dFDjSIWHrs7JTamwGUlVNWfKm9MPeHB7k4g3xWeUem7PoLn5I/ocngt
         urxxHtv75WGN6VZ+R5CE5D9txsoi0YIkr7reMYKC8vyktdv/ZT5M3CvzH+60qzNa8Soc
         0SGKDZLZUbKPIQS6dhGWNT7xzrJ70UYblkuTmWV9MIFY8hHFQiixrge3s3Z+wmRnLRSQ
         EoIQk60dPdGfn6jTT4rCdqFuVajxWgFgvLcYO9tBSZmyp+pcElPlemTqSomWmpB6x3pc
         D1KaG3vin7ZdM4tSdu9Ra93EaFEekoiDSatCLW7KQ1Hjz7z5YTABBBdeWo+LRfVQJQBM
         G0+Q==
X-Gm-Message-State: AOAM533zMqcmRR/2DOFwbZYTChvjW2iF4rrFQG4xpl+o2jkfBtaYCqbJ
        65lsPnucbElIdinaI9T5YzXvalzpi8M=
X-Google-Smtp-Source: ABdhPJyivZ/URHlB2xL5PAgwk7CHlC6dMQg2EP1/JL1OLFw8sLjTPvEWbukfEh2PKpSDFH6A/iDoog==
X-Received: by 2002:a17:907:60cf:b0:6db:f0a6:74af with SMTP id hv15-20020a17090760cf00b006dbf0a674afmr5994072ejc.317.1647408103284;
        Tue, 15 Mar 2022 22:21:43 -0700 (PDT)
Received: from felia.fritz.box (200116b826783100351493f9f729970f.dip.versatel-1u1.de. [2001:16b8:2678:3100:3514:93f9:f729:970f])
        by smtp.gmail.com with ESMTPSA id j11-20020a05640211cb00b00418572a3638sm430509edw.38.2022.03.15.22.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 22:21:42 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>, nvdimm@lists.linux.dev
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove section LIBNVDIMM BLK: MMIO-APERTURE DRIVER
Date:   Wed, 16 Mar 2022 06:21:33 +0100
Message-Id: <20220316052133.26212-1-lukas.bulwahn@gmail.com>
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

Commit f8669f1d6a86 ("nvdimm/blk: Delete the block-aperture window driver")
removes the file drivers/nvdimm/blk.c, but misses to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

The section LIBNVDIMM BLK: MMIO-APERTURE DRIVER refers to the driver in
blk.c, and some more generic nvdimm code in region_devs.c.

As the driver is deleted, delete the section LIBNVDIMM BLK: MMIO-APERTURE
DRIVER in MAINTAINERS as well.

The remaining file region_devs.c is still covered by the section LIBNVDIMM:
NON-VOLATILE MEMORY DEVICE SUBSYSTEM, and all patches to region_devs.c will
still reach the same developers as before.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Dan, please pick this minor clean-up patch in your -next tree on top of
the commit above.

 MAINTAINERS | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index faa5e53db1dd..5eacf125e052 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11128,17 +11128,6 @@ F:	drivers/ata/
 F:	include/linux/ata.h
 F:	include/linux/libata.h
 
-LIBNVDIMM BLK: MMIO-APERTURE DRIVER
-M:	Dan Williams <dan.j.williams@intel.com>
-M:	Vishal Verma <vishal.l.verma@intel.com>
-M:	Dave Jiang <dave.jiang@intel.com>
-L:	nvdimm@lists.linux.dev
-S:	Supported
-Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
-P:	Documentation/nvdimm/maintainer-entry-profile.rst
-F:	drivers/nvdimm/blk.c
-F:	drivers/nvdimm/region_devs.c
-
 LIBNVDIMM BTT: BLOCK TRANSLATION TABLE
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
-- 
2.17.1

