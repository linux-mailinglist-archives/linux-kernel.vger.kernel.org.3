Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6F55E8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347890AbiF1PeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbiF1PeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA6A2C656;
        Tue, 28 Jun 2022 08:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE69B6157F;
        Tue, 28 Jun 2022 15:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51223C3411D;
        Tue, 28 Jun 2022 15:34:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M6VMqQUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656430442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y0lZ4KUV8UB2MGHdDpLNiE999LZukoHN15YiJs71eY4=;
        b=M6VMqQUpNH3bgXpNntMSJk0EUmeXeiOCsJAd/6wU05hKKMEZF0ZT28RF0MCbQKGI+IwDHm
        znP2O9feIB5Cj7qguw0NgXnl+HXGYDGve5Lc7eX4S8v9JyRUGUyXKDISN4xK04oIyo7Dba
        Zt1VIpNZ1DxYR2GD1LOZpvv/AINVYhE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 532837ab (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Jun 2022 15:34:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] dt-bindings: chosen: remove
Date:   Tue, 28 Jun 2022 17:33:54 +0200
Message-Id: <20220628153354.870543-1-Jason@zx2c4.com>
In-Reply-To: <YrserfmdD+QH+y/X@zx2c4.com>
References: <YrserfmdD+QH+y/X@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently this is no longer maintained and undesired. Remove it.

Link: https://lore.kernel.org/lkml/c8dddfe6-6385-ed34-e789-9f845c8a32bd@linaro.org/
Link: https://lore.kernel.org/lkml/CAL_Jsq+uSdk9YNbUW35yjN3q8-3FDobrxHmBpy=4RKmCfnB0KQ@mail.gmail.com/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/devicetree/bindings/chosen.txt | 137 -------------------
 1 file changed, 137 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/chosen.txt

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
deleted file mode 100644
index 1cc3aa10dcb1..000000000000
--- a/Documentation/devicetree/bindings/chosen.txt
+++ /dev/null
@@ -1,137 +0,0 @@
-The chosen node
----------------
-
-The chosen node does not represent a real device, but serves as a place
-for passing data between firmware and the operating system, like boot
-arguments. Data in the chosen node does not represent the hardware.
-
-The following properties are recognized:
-
-
-kaslr-seed
------------
-
-This property is used when booting with CONFIG_RANDOMIZE_BASE as the
-entropy used to randomize the kernel image base address location. Since
-it is used directly, this value is intended only for KASLR, and should
-not be used for other purposes (as it may leak information about KASLR
-offsets). It is parsed as a u64 value, e.g.
-
-/ {
-	chosen {
-		kaslr-seed = <0xfeedbeef 0xc0def00d>;
-	};
-};
-
-Note that if this property is set from UEFI (or a bootloader in EFI
-mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
-the Linux EFI stub (which will populate the property itself, using
-EFI_RNG_PROTOCOL).
-
-stdout-path
------------
-
-Device trees may specify the device to be used for boot console output
-with a stdout-path property under /chosen, as described in the Devicetree
-Specification, e.g.
-
-/ {
-	chosen {
-		stdout-path = "/serial@f00:115200";
-	};
-
-	serial@f00 {
-		compatible = "vendor,some-uart";
-		reg = <0xf00 0x10>;
-	};
-};
-
-If the character ":" is present in the value, this terminates the path.
-The meaning of any characters following the ":" is device-specific, and
-must be specified in the relevant binding documentation.
-
-For UART devices, the preferred binding is a string in the form:
-
-	<baud>{<parity>{<bits>{<flow>}}}
-
-where
-
-	baud	- baud rate in decimal
-	parity	- 'n' (none), 'o', (odd) or 'e' (even)
-	bits	- number of data bits
-	flow	- 'r' (rts)
-
-For example: 115200n8r
-
-Implementation note: Linux will look for the property "linux,stdout-path" or
-on PowerPC "stdout" if "stdout-path" is not found.  However, the
-"linux,stdout-path" and "stdout" properties are deprecated. New platforms
-should only use the "stdout-path" property.
-
-linux,booted-from-kexec
------------------------
-
-This property is set (currently only on PowerPC, and only needed on
-book3e) by some versions of kexec-tools to tell the new kernel that it
-is being booted by kexec, as the booting environment may differ (e.g.
-a different secondary CPU release mechanism)
-
-linux,usable-memory-range
--------------------------
-
-This property holds a base address and size, describing a limited region in
-which memory may be considered available for use by the kernel. Memory outside
-of this range is not available for use.
-
-This property describes a limitation: memory within this range is only
-valid when also described through another mechanism that the kernel
-would otherwise use to determine available memory (e.g. memory nodes
-or the EFI memory map). Valid memory may be sparse within the range.
-e.g.
-
-/ {
-	chosen {
-		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
-	};
-};
-
-The main usage is for crash dump kernel to identify its own usable
-memory and exclude, at its boot time, any other memory areas that are
-part of the panicked kernel's memory.
-
-While this property does not represent a real hardware, the address
-and the size are expressed in #address-cells and #size-cells,
-respectively, of the root node.
-
-linux,elfcorehdr
-----------------
-
-This property holds the memory range, the address and the size, of the elf
-core header which mainly describes the panicked kernel's memory layout as
-PT_LOAD segments of elf format.
-e.g.
-
-/ {
-	chosen {
-		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
-	};
-};
-
-While this property does not represent a real hardware, the address
-and the size are expressed in #address-cells and #size-cells,
-respectively, of the root node.
-
-linux,initrd-start and linux,initrd-end
----------------------------------------
-
-These properties hold the physical start and end address of an initrd that's
-loaded by the bootloader. Note that linux,initrd-start is inclusive, but
-linux,initrd-end is exclusive.
-e.g.
-
-/ {
-	chosen {
-		linux,initrd-start = <0x82000000>;
-		linux,initrd-end = <0x82800000>;
-	};
-};
-- 
2.35.1

