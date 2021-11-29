Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5A462694
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhK2WyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhK2Wx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:53:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5FCC09CE49;
        Mon, 29 Nov 2021 12:22:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o13so39331853wrs.12;
        Mon, 29 Nov 2021 12:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bd8os49boluMWjCPlqHxyzhvgDaCkV5iDG3ksc4Oiew=;
        b=JfGF2y22b1w2YpnDbGsNpUaD0qGZ5PtvI69SCPcLUOrJiY1sl8NMyFVmYVCH9WoDwp
         VwVv/AsBWBPipZCXyxs6dP2FeWa+AIZD+d62HU4aR/UigN0beszIVRwejJgSZ2XfBctn
         uk3kXYwUX3NXYU9BAESYsp68b+gotQykh/uzEl1o8OZQ4G+yA4k0GlQohXazTPqedsaw
         UKdJdu6G1gDMsXmiEQxWPImvPL1VXmaekdmnXN/FDIhAPphwXWLgmz6/1L42Kr4I60hY
         rYHs02yWDOAhNaBo2iKsmWELs/D4271YksdgLAM95dsLotCbXCqTrKBR9YTXJWeidqFV
         LaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bd8os49boluMWjCPlqHxyzhvgDaCkV5iDG3ksc4Oiew=;
        b=y7WMWWcUtaMG0UGc/CdzmsxZlV0tTEDOz56X4tXYLYPy5e/wymhzcVSJVthkLcLmAU
         X/3fLATTUa2Rv27JQRxw+jMeZW05nRdxg2WVfy7aWJkS8/g32JnxDB+av+637jzPx7R8
         TM4q9W6vhaCIe5kH7Qu1H9sqPYW5QC9Dg8JI5bEz4/8+0lUvl+b/zF1/59dPFE9z/zrG
         LUJV0WmecERe2qcx3F7n8sjLo8kOU+UczhTtlF/NXkJ2Q3kWpHR7u2LLrsWUiAieMYok
         x4HF/aeCSS+W6YOvXY8czKRpjllhb2tWBZbW+4r/fhNf/lR3dK13oYQgIt7SWcmiBfxA
         G5Lg==
X-Gm-Message-State: AOAM530sOJihpjtC+aL7TSNG2p1BdeoYp7sX/pTRMX5ZbF9HjXLtiEhO
        PPVcEyhPfLQBcoTPTq93m3apbxTKHmDR+Q==
X-Google-Smtp-Source: ABdhPJyHGI56MgmqOPpRT2GOWXCw4Uc+KNVhzS0Mzfto+/7wpT2FwsYAABpFPq7f5ZW3aQ0yApfpEw==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr39029256wrs.291.1638217319837;
        Mon, 29 Nov 2021 12:21:59 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06460b103a790e4c64a8.dip0.t-ipconnect.de. [2003:c7:8f4e:646:b10:3a79:e4c:64a8])
        by smtp.gmail.com with ESMTPSA id n7sm14395121wro.68.2021.11.29.12.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:21:59 -0800 (PST)
Date:   Mon, 29 Nov 2021 21:21:57 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 4/4] Docs: usb: update explanation for device_present to
 disconnected
Message-ID: <c4e0a964d0dbd34c13d3a8ff4df6dbb231de6de4.1638152984.git.philipp.g.hortmann@gmail.com>
References: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update text for `device_present` flag to `disconnected` flag

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../driver-api/usb/writing_usb_driver.rst          | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 74bb72a2f0ac..d398d2155cd3 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -277,15 +277,13 @@ notify the user-space programs that the device is no longer there. The
     }
 
 
-If a program currently has an open handle to the device, we reset the
-flag ``device_present``. For every read, write, release and other
+If the driver probed the device successfully, the flag ``disconnected``
+is initialized and set to false. For every read, write and other
 functions that expect a device to be present, the driver first checks
-this flag to see if the device is still present. If not, it releases
-that the device has disappeared, and a ``-ENODEV`` error is returned to the
-user-space program. When the release function is eventually called, it
-determines if there is no device and if not, it does the cleanup that
-the ``skel_disconnect`` function normally does if there are no open files
-on the device (see Listing 5).
+this flag to see if the device is still present. If not, a ``-ENODEV``
+error is returned to the user-space program. When the device is
+disconnected, `skel_disconnected` function is called. It sets ``disconnected``
+to true and cleans up.
 
 Isochronous Data
 ================
-- 
2.25.1

