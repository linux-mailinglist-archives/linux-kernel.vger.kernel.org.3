Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085A58605E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbiGaS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiGaS2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:28:11 -0400
Received: from aer-iport-1.cisco.com (aer-iport-1.cisco.com [173.38.203.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70DBBE37
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3500; q=dns/txt; s=iport;
  t=1659292087; x=1660501687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Cdb2OQrgAvdR16JMhjiKU3mXiADfXmJC5nN3O18Blw=;
  b=LLFO7RNrB0c0I+UW5QTaFC6UJCfy6VnefuF2nNDU8AH9nwsvv0DbecyU
   FcsXbq5ihjjZkvWQVin9IO7PFcB31D6V7F9FHgchv60fIJP4yxwqK+Kr1
   nLpoOYybxruflDjDOa1mBI9PA3OGgzI6+hFRnLjdR8XMRLwuE2p4utQVv
   I=;
X-IPAS-Result: =?us-ascii?q?A0ACAADAyOZilxbLJq1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF7BgEBAQsBgyRWLBJFjG1fiA0DiyCRWYElA1QLAQEBDzcLBAEBhQYCh?=
 =?us-ascii?q?HUmNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBAQEBAQEBCRsGD?=
 =?us-ascii?q?AUQNYVoDYZDAwMyAUEFECAxITYZgn0BgmUDMgMQpl2CK4EBg08Bg1gNgkyBP?=
 =?us-ascii?q?QGGMoNGhSc9BoFJRIR9giCIXwSHHJBpAwkEBwVKRAMLLA8WBQgJFxIQEAIEE?=
 =?us-ascii?q?RoLBgMWPwkCBA4DQAgNAxEEAw8YCRIIEAQGAzEMJQsDFAwBBgMGBQMBAxsDF?=
 =?us-ascii?q?AMFJAcDHA8jDQ0EHx0DAwUlAwICGwcCAgMCBhUGAgI2GDkIBAgEKyMPBQIHL?=
 =?us-ascii?q?wUELwIeBAUGEQgCFgIGBAQEBBYCEAgCCCcXBxMzGQEFWRAJIRwOGhAFBhMDI?=
 =?us-ascii?q?G8FBz4PKDM1PCsfGwqBEiorFQMEBAMCBhgDAyICEC4xAxUGKRMSLQkqdQkCA?=
 =?us-ascii?q?yJtAwMEKi4DCSEfBwkwHZZEggUHUzsrUVCBKI8Jhk4BqlwsbINbiyKOd4VlG?=
 =?us-ascii?q?jGFRqMhlnyEeog+g1+WPYFhdYEgTSMVgyMJCj4ZD44sDQmIZIVMQjECATgCB?=
 =?us-ascii?q?gsBAQMJjwYBAQ?=
IronPort-Data: A9a23:+Zjfp6wk14CNCZE19Zh6t+ehxirEfRIJ4+MujC+fZmUNrF6WrkUCm
 jQcXGuAb6qJNGqjLdh3b4ix/U9V6sPSndQ1QVRspFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJloCCea/H9BC5C5xZVG/fngqoHUVaiVYUideSc+EH170U04wrZg6mJVqYHR7z2l6
 IuaT/L3YDdJ6xYsWo7Dw/vewP/HlK2aVAIw5jTSV9gS1LPtvyV94KYkGE2EByCQrr+4sQKNb
 72rILmRpgs19vq2Yz+vuu6TnkYiGtY+MeUS45Zbc/DKv/RMmsA9+v1jBvpMeHl3sDLXw+FL7
 vUUkKD3TC58a8UgmMxFO/VZOyhzJ+hN/6XKZCH5us2IxEqAeHzpqxlsJBhpZstDqqAtWToIr
 6ZwxDMlNnhvg8q2zb2nVORgmuwoLdLgO8UUvXQIITTxVq1/HM+dHs0m4/dFwygdlPJ1RsyAT
 JpAUTgxT0THfDBQbwJ/5JUWxbf02SaXnydjgE6Sv7Q+52TI5Ahw1qX9ddTSZ9qGTNlUmUDeo
 XjJl0zwAQkfHNiezyeVt3yrm+nDlD/6X4RUE6e3ntZshl67yWsUBxkbE1C8pJGRjkejQdtWA
 0cT9icnsLI17kXtScPyNzWksWKfuTYZWsYWHuEngCmOx6fP6AGeBUAPTiRGbd07sYkxXzNC/
 luAldnuGSBHqrCZSXuBsLyTqFuaNSETLGIGYC4PRBot7NzqoYV1hRXKJv5sCqO6jd3dHTD23
 iCEqzU4i7wPjMkNkaKh8jjvhzOqu4iMTQMv4AjTdnyq4xk/Z4O/YYGsr1/B4p59wJ2xR1Sb+
 XkcnNKCqeYHEdeGlTeGR6MGG7TBC+u53CP02gZdH8kwyRSW/CD/TLp2wGhbGABsG5NREdP2W
 3P7tQRU7Z5VGXKla65rfo68Y/gXIbjc+cfNDa+LM4IfCnRlXErWo3E0PB/4M3XFyRB0yckC1
 YGnndFA5Ev26JiLLhLrHo/xMpdymEjSIF8/orihlXyaPUK2PiL9dFv8GALmghoFxK2Fuh7J1
 N1UKtGHzR5SOMWnPHSGq9ZOfQxSdCZgbXwTlyCxXrDbSuaBMDxxY8I9PZt6E2CYt/0Pz7yRr
 i3VtrFwkQKg3xUr1jlmmlg6OO+wAv6TXFowPDcnOh6zymM/bIO0hJrzhLNpFYTLANdLlKYuJ
 9FcIp3oKq0WGlzvpmRMBbGg/dcKXEn62mqz09+NPWFXk2hIHFeSpLcJv2LHqUEzM8ZAnZFm/
 eb7hl+CHctrqsYLJJ++Vc9DBmiZ5RA18N+elWORSjWPUC0AKLRXFhE=
IronPort-HdrOrdr: A9a23:hcogSKBCwgw1v+nlHemp55DYdb4zR+YMi2TDGXocdfUzSL39qy
 nAppomPHPP4gr5HUtQ+uxoW5PwJE80i6QV3WB5B97LNzUO+lHYTr2KhrGM/9SPIUDDH5ZmtZ
 uJt8NFebvN5Z8Qt7ec3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,206,1654560000"; 
   d="scan'208";a="3315765"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Jul 2022 18:27:00 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 26VIQpY1008219;
        Sun, 31 Jul 2022 18:26:59 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Daniel Micay <danielmicay@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Laura Abbott <lauraa@codeaurora.org>,
        Nick Kralevich <nnk@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [v4.9 PATCH 5/6] init/main.c: extract early boot entropy from the passed cmdline
Date:   Sun, 31 Jul 2022 20:26:35 +0200
Message-Id: <20220731182635.1910069-6-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220731182635.1910069-1-hegtvedt@cisco.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Micay <danielmicay@gmail.com>

Feed the boot command-line as to the /dev/random entropy pool

Existing Android bootloaders usually pass data which may not be known by
an external attacker on the kernel command-line.  It may also be the
case on other embedded systems.  Sample command-line from a Google Pixel
running CopperheadOS....

    console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0
    androidboot.hardware=sailfish user_debug=31 ehci-hcd.park=3
    lpm_levels.sleep_disabled=1 cma=32M@0-0xffffffff buildvariant=user
    veritykeyid=id:dfcb9db0089e5b3b4090a592415c28e1cb4545ab
    androidboot.bootdevice=624000.ufshc androidboot.verifiedbootstate=yellow
    androidboot.veritymode=enforcing androidboot.keymaster=1
    androidboot.serialno=FA6CE0305299 androidboot.baseband=msm
    mdss_mdp.panel=1:dsi:0:qcom,mdss_dsi_samsung_ea8064tg_1080p_cmd:1:none:cfg:single_dsi
    androidboot.slot_suffix=_b fpsimd.fpsimd_settings=0
    app_setting.use_app_setting=0 kernelflag=0x00000000 debugflag=0x00000000
    androidboot.hardware.revision=PVT radioflag=0x00000000
    radioflagex1=0x00000000 radioflagex2=0x00000000 cpumask=0x00000000
    androidboot.hardware.ddr=4096MB,Hynix,LPDDR4 androidboot.ddrinfo=00000006
    androidboot.ddrsize=4GB androidboot.hardware.color=GRA00
    androidboot.hardware.ufs=32GB,Samsung androidboot.msm.hw_ver_id=268824801
    androidboot.qf.st=2 androidboot.cid=11111111 androidboot.mid=G-2PW4100
    androidboot.bootloader=8996-012001-1704121145
    androidboot.oem_unlock_support=1 androidboot.fp_src=1
    androidboot.htc.hrdump=detected androidboot.ramdump.opt=mem@2g:2g,mem@4g:2g
    androidboot.bootreason=reboot androidboot.ramdump_enable=0 ro
    root=/dev/dm-0 dm="system none ro,0 1 android-verity /dev/sda34"
    rootwait skip_initramfs init=/init androidboot.wificountrycode=US
    androidboot.boottime=1BLL:85,1BLE:669,2BLL:0,2BLE:1777,SW:6,KL:8136

Among other things, it contains a value unique to the device
(androidboot.serialno=FA6CE0305299), unique to the OS builds for the
device variant (veritykeyid=id:dfcb9db0089e5b3b4090a592415c28e1cb4545ab)
and timings from the bootloader stages in milliseconds
(androidboot.boottime=1BLL:85,1BLE:669,2BLL:0,2BLE:1777,SW:6,KL:8136).

[tytso@mit.edu: changelog tweak]
[labbott@redhat.com: line-wrapped command line]
Link: http://lkml.kernel.org/r/20170816231458.2299-3-labbott@redhat.com
Signed-off-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Nick Kralevich <nnk@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 33d72f3822d7ff8a9e45bd7413c811085cb87aa5)
---
 init/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/main.c b/init/main.c
index 67fa94c5967..6bc1a3fa152 100644
--- a/init/main.c
+++ b/init/main.c
@@ -502,8 +502,10 @@ asmlinkage __visible void __init start_kernel(void)
 	setup_arch(&command_line);
 	/*
 	 * Set up the the initial canary and entropy after arch
+	 * and after adding latent and command line entropy.
 	 */
 	add_latent_entropy();
+	add_device_randomness(command_line, strlen(command_line));
 	boot_init_stack_canary();
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
-- 
2.34.1

