Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ADC47EE54
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 11:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352476AbhLXKn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 05:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbhLXKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 05:43:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88AC061401;
        Fri, 24 Dec 2021 02:43:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t26so16780190wrb.4;
        Fri, 24 Dec 2021 02:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYowiWvO/gbLV76oGiytYGNx7I5pruViggqU/wNr2S0=;
        b=f1D+y6mEvMN8p/Tbw86vSVh0C8fX8qS2ns/R4s8EtzG+npVnDoCtQ0ruzaKO3S6NuF
         rZOh1tZXD8aVJZ2dUKJMLMB8lbXN8ZM11TVZIfVH7c8g4yWket7eHo+JKoIaJHlQCouw
         yC+Ws7TLFZgNlIeq2AHFySwkaEPnz/dLT2NupaM1gvw3/PfIOqkoOnQMAYRwuuXnCJG1
         avQNJDU9coXcWQmcdHP0DPiHzIl8RiSl3nnTnM8YJHxTGPSI1ryMVcCF5sKcrfNfeziz
         1x7rYi7u9kbAolp38OF5bNlmbbVCL0YkofsLQxRdpjSqbAbezFmaJeEh6dRcg3Lc6aIo
         c/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYowiWvO/gbLV76oGiytYGNx7I5pruViggqU/wNr2S0=;
        b=v1bhpYeEA/z5TVJuMPvY8UCvYuXPElYQqk5opgV/CmI/W+zy51nRsbm+Wx8ej60Yfb
         5wu0r50qX/2+gF0WuWTESaN6UOLWBawRIXEJtT6P2ZpqSF22hPussRqJraUdExFjxw5F
         SWRkaL2b5+K0MQX0RH3g/WPvIQdOa7Yitnr2sbWASCOvmWcWNOH4MKucmlw9JRbQDoGL
         nEc8ZudhHWyyGzchbzbRy+RL19/SaF1nqvo3u2uMTlOsAdOPvHfJgnvwSPvr+LXq4LFg
         9z1h0v7miUl65ziVfGtr78tDlDy3jiE/h8nVNvbQfQ/cI9fjjtAs/HfPRtCQPNBESCmE
         TWCQ==
X-Gm-Message-State: AOAM533Wo58L8ARbh8SvphfFZF5Ygc5S53s+KjldYJcEJYoEo287HIlB
        zDJ4VK15h0yx+f4rTrywteo=
X-Google-Smtp-Source: ABdhPJwHMEnOlEEKQIS2WBM5zLk6VIpwNdZypIDwWhx4qHnaGlYDccnMSyCietL8L303VVVanaPrmg==
X-Received: by 2002:adf:ef81:: with SMTP id d1mr4324396wro.132.1640342633198;
        Fri, 24 Dec 2021 02:43:53 -0800 (PST)
Received: from fedora.domain.name ([95.70.245.16])
        by smtp.googlemail.com with ESMTPSA id l2sm7640352wrs.43.2021.12.24.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 02:43:52 -0800 (PST)
From:   Onur Ozkan <onurozkan.dev@gmail.com>
X-Google-Original-From: Onur Ozkan <work@onurozkan.dev>
To:     trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Onur Ozkan <work@onurozkan.dev>
Subject: [PATCH v3] tools/power/cpupower/{ToDo => TODO}: Rename the todo file
Date:   Fri, 24 Dec 2021 13:43:43 +0300
Message-Id: <20211224104343.33331-1-work@onurozkan.dev>
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
 tools/power/cpupower/{ToDo => TODO} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/power/cpupower/{ToDo => TODO} (100%)

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/TODO
similarity index 100%
rename from tools/power/cpupower/ToDo
rename to tools/power/cpupower/TODO
-- 
2.33.1

