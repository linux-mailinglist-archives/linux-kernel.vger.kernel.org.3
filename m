Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFD47EE50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 11:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352470AbhLXKjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 05:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352463AbhLXKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 05:39:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102FC061401;
        Fri, 24 Dec 2021 02:39:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q16so16781974wrg.7;
        Fri, 24 Dec 2021 02:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VTxUkTc3HIQTt7B5afXBlxj2AMRCOqLliY7kCfqs+g=;
        b=TY8fPk9FgTNlJHDIcebaugpRo5I0q9FMiENQTQWqB17aWt79q7UC0cM1ZjTYbhKSPF
         LpE/SUo7idU0uph7hmplrTa1q6IjbyVE8DNUmP7mPXjPK5/i8/ZVYmJFRAFd/NPDq4pi
         lOguRr+cIp5aVpzo1+Iq2LU663Il2A0qeJ+k0Iq2r7AIbwjugWbxrWej5YbkVvmhRaZr
         jBKdCVFsyTvWD/PBWCDphaMWXAsoFf/cgehiAo1gFXNgYaZSNk1aJttQFvCLPQAu7yno
         sp4bH/zOHo6lYEDnjVhs5ZEd1eSw7Wllw1/+0Kk1h2OBh1xC0JNLIt+ikjgCVnKVEgvO
         XAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VTxUkTc3HIQTt7B5afXBlxj2AMRCOqLliY7kCfqs+g=;
        b=7DDWsrIOnwR/Evfks3BLLHofJmlBVU29QCLrGk/hUJESImjqVwU93SUHqOuu2NW7K4
         /lbvD2WT7kzbXAiI3kkQPVcLVtu+eNnUlh2QIuX2+Em5sOTKhMq/hQC6AvehDZW7gjRX
         N/E+XMfydDM1cOS/lYCbdRO2oNZPwVp967vzALp2TRYNBWkv6we8PFgx3PH0V6EhWqdB
         /dlIIPFZZrQzrM07gyvCgQO42b8HzEHkD8idkk20+qWcVeVYHdi4BmHTXfMemPUw+Uvc
         mBdTzyEr6irL8rqBomPdxKSnZ4XTxF8YKYfhoHeZm5Ox9t6nPg+k3hSvSSoLPwSeKgjS
         Ihgg==
X-Gm-Message-State: AOAM532KdLPdIw+ZPb7iPe4O9qmjjhrHbpty7Cxspq+x8OJETCOAvNrk
        2FO/KOjq/iHO7PGMJfpMwl0VjXvjAHY=
X-Google-Smtp-Source: ABdhPJz3RFPIcD9zZR5XM7WTKZdOQf0O5QBhZYYNZSuf436szRc8z8XGyzMI++WawKKKE/fx7Sov4w==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr4350655wrq.106.1640342389019;
        Fri, 24 Dec 2021 02:39:49 -0800 (PST)
Received: from fedora.domain.name ([95.70.245.16])
        by smtp.googlemail.com with ESMTPSA id f6sm11785353wmq.6.2021.12.24.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 02:39:48 -0800 (PST)
From:   Onur Ozkan <onurozkan.dev@gmail.com>
X-Google-Original-From: Onur Ozkan <work@onurozkan.dev>
To:     trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Onur Ozkan <work@onurozkan.dev>
Subject: [PATCH v2] tools/power/cpupower/{ToDo => TODO}: Rename the todo file
Date:   Fri, 24 Dec 2021 13:39:28 +0300
Message-Id: <20211224103928.29480-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed the to-do file to 'TODO' instead of 'ToDo' to
comply with the naming standard.

Here are the all other todo file references in kernel source code:
    drivers/accessibility/speakup/TODO
    drivers/bcma/TODO
    drivers/comedi/TODO
    drivers/dma/TODO
    drivers/gpio/TODO
    drivers/gpu/drm/amd/display/TODO
    drivers/gpu/drm/i915/TODO.txt
    drivers/gpu/drm/omapdrm/TODO
    drivers/gpu/drm/panfrost/TODO
    drivers/iio/TODO
    drivers/leds/TODO
    drivers/parport/TODO-parport
    drivers/pci/hotplug/TODO
    drivers/staging/android/TODO
    drivers/staging/board/TODO
    drivers/staging/clocking-wizard/TODO
    drivers/staging/emxx_udc/TODO
    drivers/staging/fbtft/TODO
    drivers/staging/fieldbus/TODO
    drivers/staging/fwserial/TODO
    drivers/staging/gdm724x/TODO
    drivers/staging/greybus/TODO
    drivers/staging/gs_fpgaboot/TODO
    drivers/staging/iio/TODO
    drivers/staging/ks7010/TODO
    drivers/staging/media/atomisp/TODO
    drivers/staging/media/av7110/TODO
    drivers/staging/media/hantro/TODO
    drivers/staging/media/imx/TODO
    drivers/staging/media/ipu3/TODO
    drivers/staging/media/meson/vdec/TODO
    drivers/staging/media/omap4iss/TODO
    drivers/staging/media/rkvdec/TODO
    drivers/staging/media/sunxi/cedrus/TODO
    drivers/staging/media/tegra-vde/TODO
    drivers/staging/media/tegra-video/TODO
    drivers/staging/media/zoran/TODO
    drivers/staging/most/TODO
    drivers/staging/mt7621-dma/TODO
    drivers/staging/mt7621-dts/TODO
    drivers/staging/nvec/TODO
    drivers/staging/octeon-usb/TODO
    drivers/staging/octeon/TODO
    drivers/staging/olpc_dcon/TODO
    drivers/staging/pi433/TODO
    drivers/staging/qlge/TODO
    drivers/staging/r8188eu/TODO
    drivers/staging/rtl8192e/TODO
    drivers/staging/rtl8712/TODO
    drivers/staging/rtl8723bs/TODO
    drivers/staging/rts5208/TODO
    drivers/staging/sm750fb/TODO
    drivers/staging/unisys/TODO
    drivers/staging/vc04_services/bcm2835-audio/TODO
    drivers/staging/vc04_services/bcm2835-camera/TODO
    drivers/staging/vc04_services/interface/TODO
    drivers/staging/vt6655/TODO
    drivers/staging/vt6656/TODO
    drivers/staging/wfx/TODO
    drivers/thermal/ti-soc-thermal/TODO
    tools/testing/selftests/arm64/fp/TODO
    tools/testing/selftests/arm64/signal/testcases/TODO
    tools/testing/selftests/tc-testing/TODO.txt

Signed-off-by: Onur Ozkan <work@onurozkan.dev>
---
 tools/power/cpupower/ToDo | 24 ------------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 tools/power/cpupower/ToDo

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/ToDo
deleted file mode 100644
index b196a139a3e4..000000000000
--- a/tools/power/cpupower/ToDo
+++ /dev/null
@@ -1,24 +0,0 @@
-ToDos sorted by priority:
-
-- Use bitmask functions to parse CPU topology more robust
-  (current implementation has issues on AMD)
-- Try to read out boost states and frequencies on Intel
-- Somewhere saw the ability to read power consumption of
-  RAM from HW on Intel SandyBridge -> another monitor?
-- Add another c1e debug idle monitor
-  -> Is by design racy with BIOS, but could be added
-     with a --force option and some "be careful" messages
-- Add cpu_start()/cpu_stop() callbacks for monitor
-  -> This is to move the per_cpu logic from inside the
-     monitor to outside it. This can be given higher
-     priority in fork_it.
-- Fork as many processes as there are CPUs in case the
-  per_cpu_schedule flag is set.
-  -> Bind forked process to each cpu.
-  -> Execute start measures via the forked processes on
-     each cpu.
-  -> Run test executable in a forked process.
-  -> Execute stop measures via the forked processes on
-     each cpu.
-  This would be ideal as it will not introduce noise in the
-  tested executable.
-- 
2.33.1

