Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5C472B04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhLMLQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhLMLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:16:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDAC061574;
        Mon, 13 Dec 2021 03:16:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so26403479wrn.6;
        Mon, 13 Dec 2021 03:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLmVAWC8B0yYUausCOePrDM44GA5MP6Kvv4qJruxvnU=;
        b=BXj163/XKWwvwL6C1hhdlhJ2xB1RyU/xbaaHKrnW9JbBWaIyf723j+0zq7c6Ur3BJj
         KMktStbJtvtgQFnA/rwfy4nvpNSfUPbBlwESCs2DpjQNHirOmMyL6Mwgl0NB0WdaO8qB
         m08xj52zRoDpVO+ON01fLThKMiCku58WW0pvw0uEnmmvkfA07VVqA4Nkaf/Jy1AMTVoB
         Jmut8Z4pTC7I+1PjUZOD9OBxdQW/BP71EI9t2owsrETlEXiXoEzpblEjyfgATSmWOiza
         IOr5xRJKH7Sq3Q30G0uJacUMvSjQbB0RVO1jJQfoDPgFSAiHV+s/WSiJlsSvtaJ6PQfH
         fFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLmVAWC8B0yYUausCOePrDM44GA5MP6Kvv4qJruxvnU=;
        b=E63qMlH4wbYGyx9msS1JoVrkCKFWypX+BpJNcoKQtPAZ25bhDCxSLHtIN/UlaKY9Gq
         /drFXyF7HdHfr9RwfRQzJw3houQNIN6WLFSeKMGFHfEQOqgnUCLXXO+NWSmiUVK443tA
         3IrdP95mVUBSztdJGKMpEjPJDhlpQzArb2L6brRY3Zo8nGggg8kUGBeIZ6RkznRSLWJc
         nMH7/aQury9kRsgePsxKoqF6P3vpA3dgg7B9klc1uoGdhp99/aHtKFiiWN0NeSIhtIFZ
         m/Jb1uycaXSjcuZgzdWJ082gUXnrVTGAtScgvw7frJAYW3xcM/VxreSkb4aewhtukKcl
         2Ygg==
X-Gm-Message-State: AOAM530SCpe4MrLySfKXFN5VQix6Z+ckoL1jb2A80nMfspi0pvH087vo
        bMNworFqzYp9PmSV/VgKSQ+qfQC7/JE=
X-Google-Smtp-Source: ABdhPJzZB5cz6PYz5a1BzSkUyaqpEAzznSKgVaUAqckpomwP7Ruvrex8lKAw7Rast17bZi0hVYIzBA==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr29825011wra.557.1639394211695;
        Mon, 13 Dec 2021 03:16:51 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:16:51 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/9] Kconfig symbol clean-up on ./arch/mips/
Date:   Mon, 13 Dec 2021 12:16:33 +0100
Message-Id: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas,

The script ./scripts/checkkconfigsymbols.py warns on invalid references to
Kconfig symbols (often, minor typos, name confusions or outdated references).
This is a patch series addressing the issues reported by
./scripts/checkkconfigsymbols.py in the ./arch/mips/ directory, quickly
filtered down with:

  ./scripts/checkkconfigsymbols.py | grep "arch/mips" -B 1

without considering kernel configs, i.e., after removing ./arch/mips/configs
in the working tree. It addresses all issues I considered to be "true
positives"; so, issues that should be addressed and cleaned up. 

The patches on updating the comments might arguably be considered of lower
value by itself, but as the other patches show, checkkconfigsymbols does detect
some relevant issues in the kernel tree otherwise being unnoticed.
So, it might be worth to clean up the kernel tree to have checkkconfigsymbols
produce a rather short list of issues and then continuously follow and check
what checkkconfigsymbols reports.

These are the remaining reports from checkkconfigsymbols in ./arch/mips, which
are not addressed in this series:

  SGI_IP35
  Referencing files: arch/mips/include/asm/sn/addrs.h, arch/mips/include/asm/sn/agent.h, arch/mips/include/asm/sn/klconfig.h

  Rationale: Ralf Baechle rejected a patch to remove the "upstream-dead"
  SGI_IP35 code in 2014, because there was still some out-of-tree users.
  We might want to recheck if these out-of-tree users still exist or if this
  code can be dropped now.
  See email discussion: https://lore.kernel.org/lkml/1400584909.4912.35.camel@x220/T/#mf1d73d4f531bab670beb30aa0adfce34cbcad528

  SHELL
  Referencing files: arch/mips/Makefile, arch/mips/kernel/syscalls/Makefile

  Rationale: Ignore CONFIG_SHELL. Default variable in Kbuild build system.


Each patch in this series can be discussed and applied individually. They are
sent in one patch series, as they all orginate from the investigation guided
by the same tool and hence share similar topics and resolutions.

Please pick this series of minor clean-up patches on ./arch/mips/. It applies
cleanly on next-20211210. The patches with Fixes: tags might be considerable
for stable.


Best regards,

Lukas


Lukas Bulwahn (9):
  mips: drop selecting the non-existing config SYS_HAS_EARLY_PRINTK_8250
  mips: add SYS_HAS_CPU_MIPS64_R5 config for MIPS Release 5 support
  mips: drop selecting non-existing config NR_CPUS_DEFAULT_2
  mips: dec: provide the correctly capitalized config CPU_R4X00 in init
    error message
  mips: kgdb: adjust the comment to the actual ifdef condition
  mips: remove obsolete selection of CPU_HAS_LOAD_STORE_LR
  mips: alchemy: remove historic comment on gpio build constraints
  mips: txx9: remove left-over for removed TXX9_ACLC configs
  mips: fix Kconfig reference to PHYS_ADDR_T_64BIT

 arch/mips/Kconfig                  |  9 +++++----
 arch/mips/alchemy/common/gpiolib.c |  2 --
 arch/mips/dec/prom/init.c          |  2 +-
 arch/mips/include/asm/kgdb.h       |  2 +-
 arch/mips/txx9/Kconfig             |  3 ---
 arch/mips/txx9/generic/setup.c     | 28 ----------------------------
 6 files changed, 7 insertions(+), 39 deletions(-)

-- 
2.26.2

