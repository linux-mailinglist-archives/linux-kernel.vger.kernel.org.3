Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F3648884D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 08:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiAIHZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 02:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiAIHZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 02:25:56 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FBFC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 23:25:56 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p14so9552006plf.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 23:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=diyJJCapjwWwuZdOgRzv/HASqU3BBDHkCO/M0zGXsZo=;
        b=dqxJd99aGbdZTlbjS5+wJ7NXTiVh57PMP4sq1EvM4szMryE176yChyN0AdI7sKCEFD
         S4s9GPayeZg/dcZC2mWClIWZFOB+8pCG0IeZvWwIXRqzFaznUZn+h0zQ1y+/Rv4KfJka
         Vc/0eWOiDK7m0Y5ssvIWgc842L6NOCEyV3vV1GYFuEmbHYbgcauCx8ByZK4FmjGK6vTY
         yZdAj4sRQW/kekcT+jklft1HBiyEF/EeXPPSG1yuyRtYu7JYGBkKuV4W8zMx5+9KgWA7
         5wZV22EBv1eM4qiVbmcj7WM3jq1KiI90o/xIuxJxgJQcs2BP/PoR85IfO1jqErHHxBLl
         o3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=diyJJCapjwWwuZdOgRzv/HASqU3BBDHkCO/M0zGXsZo=;
        b=5uHGnUSO5Egws9d5OgeKD8shsdj64p4STDk8tbNeAiYJj6pzDEaA8MP6XHPdBSpK8y
         rvu66QBDkJiQe/ZUL1D0orZTu4emL+eUlH3hYy3k8DO0+d94kGF0eI2jf8cnLpvmawPo
         DGUSwumpbuld5R51KiWR1SSTPs7k+h3/E2iIM6W9RxjTBt3Yc/LDqga866OOigcINstt
         bkzrauJEJaHJrFzMqC5Lq7aQCcUmDRx7vzYqINikOOlC2x1rGLJfoR/wcB0sJRM7bNht
         TygVXmvPb9wwvxJ9tvCloMZr3QsV86zFxse5/o2h9QTSq1BemvmCw2B2qBrfkOd1RnJ7
         AXaA==
X-Gm-Message-State: AOAM532+QfsiKjWjEO2gCTK0hBq+sPwq1xqXUKhstzA6g+9y828191tM
        5ueqIrSuVZamXg6l77FsubhKvUH9K3mETQ==
X-Google-Smtp-Source: ABdhPJzMHwfUmgDL0s0ubRGDt8UKWVjl2HQp9XAwNqAdC8n8WiJrNqSi5Ij4gfIUZfOpaE1TVxL00A==
X-Received: by 2002:a17:90a:ac0f:: with SMTP id o15mr18906445pjq.145.1641713155540;
        Sat, 08 Jan 2022 23:25:55 -0800 (PST)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id ke3sm4964658pjb.46.2022.01.08.23.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 23:25:54 -0800 (PST)
Date:   Sat, 8 Jan 2022 23:25:40 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, soc@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] SoC: One more fix for 5.16
Message-ID: <YdqN9GxRTQYVA/f4@lx2k>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,


The following changes since commit 8922bb6526ac4b20bd8de7f47d6e77808670f6c4:

  Merge tag 'socfpga_fix_for_v5.16_part_3' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into arm/fixes (2022-01-05 16:18:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-5.16-5

for you to fetch changes up to c8013355ead68dce152cf426686f8a5f80d88b40:

  ARM: dts: gpio-ranges property is now required (2022-01-08 13:28:28 -0800)

----------------------------------------------------------------
SoC: One more fix for 5.16

I had missed one patch when I sent up what I thought was the last batch
of fixes for this release. This one fixes issues on the Raspberry Pi
platforms due to gpio init changes this release, so hopefully we can get
it merged before final release is cut.

----------------------------------------------------------------
Phil Elwell (1):
      ARM: dts: gpio-ranges property is now required

 arch/arm/boot/dts/bcm2711.dtsi | 2 ++
 arch/arm/boot/dts/bcm283x.dtsi | 2 ++
 2 files changed, 4 insertions(+)
