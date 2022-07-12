Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34E057288D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiGLVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiGLVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:25:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D103C48EF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:25:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ez10so16557352ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tja2EFPyR9iUy4sMrbNy5to4k8GjJT+Iqt2a+ErBpQA=;
        b=BxrxkrKdMBUMSKUeyevDN58rv7qeompAzFXxzgYnlfv2npFCIRJ1tsa2/cutMBemWt
         jNjBLkCJfk0go77/cqLggAA0vhNHUFxqBnLfbjj3nIBybVNQ7hfhRpuet7BNt+eL8gry
         Zf+/qCGY8Erlb077Bhbo24flDlyDR0VzDrp7OJTTC/nAPY2Tb8Yn3F30RyiIkWpbQ6Py
         Qh+HHNJd2gicSC3bJE5wNTvW8LQ32zPTvW2KTc4VuCgMiGSKAidWd6FqGAxTWOAkIi0T
         uEBd9/NV53Y2EB4AXf0oau7KFtmcdrZJ8cuQ+rbvy05Kzt91QeOxxEAPUoq3wSJSy/Fp
         ThZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Tja2EFPyR9iUy4sMrbNy5to4k8GjJT+Iqt2a+ErBpQA=;
        b=oHNJLjbMpmTrEp2NUi3AWEfqqmHqv5Lkz+P7kC4rCqdReTr42NvhRPlsXWRkfHTICi
         av3/4SCj3cMRHrPCcPkZ1aELEzG3e4XjISJ7oFEGMD1ZX6sDeSTSKHybwPUipkzX75CK
         qPbZzFFxG9A9w5C8Lsm5OIP9Sx+eORhpuNBGyuYdqvtxkXT1Nbgul6tA10EFz7HvAsD6
         QwArspwZw7ky+5qfRdzseMpnKC2W3lB0wdMlCtM0fS9AHVhif3MtVGVcLKxZ4UWCxaMW
         b1coyiz5gvVyeR0KjBQMTBw9QSRHg6OuQqXvds10kBlOhVyC1iq/Rf6qOpFcvBtmhENb
         SoQQ==
X-Gm-Message-State: AJIora/NScj/PdP8jBb4zJU7gHDVvGTSPacGB8stm9qWh+VX843rvZCN
        FLTxTKb8xd3GZ1o4/Zr+HEQ=
X-Google-Smtp-Source: AGRyM1vpnj25rEW8EDa4jHWriCtHckJceCmFDF0gafpmNiSyMosLKRzXXVjZ36kMc8xInrfCX8CgWw==
X-Received: by 2002:a17:907:2c5b:b0:72b:54bd:40f8 with SMTP id hf27-20020a1709072c5b00b0072b54bd40f8mr95978ejc.137.1657661102805;
        Tue, 12 Jul 2022 14:25:02 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id l11-20020a1709066b8b00b0072b3182368fsm4160372ejr.77.2022.07.12.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:25:02 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] Documentation: ABI: Mention retbleed vulnerability info file for sysfs
Date:   Tue, 12 Jul 2022 23:24:59 +0200
Message-Id: <20220712212459.469554-1-carnil@debian.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reporting for the AMD retbleed vulnerability was added in
6b80b59b3555 ("x86/bugs: Report AMD retbleed vulnerability") the new
sysfs file was not mentioned so far in the ABI documentation for
sysfs-devices-system-cpu.

Fixes: 6b80b59b3555 ("x86/bugs: Report AMD retbleed vulnerability")
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index bcc974d276dc..3cda940108f6 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -527,6 +527,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
 		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/retbleed
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
-- 
2.36.1

