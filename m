Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9010E593476
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiHOSEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHOSEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:04:44 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F529812
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:04:41 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id 7u4e2800X4C55Sk01u4eRu; Mon, 15 Aug 2022 20:04:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oNeS6-001DDz-HI
        for linux-kernel@vger.kernel.org; Mon, 15 Aug 2022 20:04:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oNeS6-00C44k-4f
        for linux-kernel@vger.kernel.org; Mon, 15 Aug 2022 20:04:38 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.0-rc1
Date:   Mon, 15 Aug 2022 20:04:38 +0200
Message-Id: <20220815180438.2875559-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
References: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.0-rc1[1] compared to v5.19[2].

Summarized:
  - build errors: +26/-15
  - build warnings: +8/-28

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/568035b01cfb107af8d2e4bd2fb9aea22cf5b868/ (all 135 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3d7cb6b04c3f3115719235cc6866b10326de34cd/ (all 135 configs)


*** ERRORS ***

26 error regressions:
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: .cfi_endproc without corresponding .cfi_startproc:  => 32
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: bad or irreducible absolute expression:  => 16
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: junk at end of line, first unrecognized character is `:':  => 16
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `be 0x100(%sr2,%r0)':  => 29
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `ldi 0,%r20':  => 30
  + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `ldw 0(%sp),%r31':  => 26
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ble 0x100(%sr2,%r0)':  => 51, 46
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 0,%r25':  => 44
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 1,%r25':  => 49
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 173,%r20':  => 50, 45
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.callinfo':  => 40
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.entry':  => 41
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.exit':  => 54
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.proc':  => 39
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.procend':  => 55
  + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.stringz':  => 76
  + /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 239:34
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: error: the frame size of 2096 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 6806:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: error: the frame size of 2160 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 3778:1
  + /kisskb/src/include/linux/bitfield.h: error: call to '__field_overflow' declared with attribute error: value doesn't fit into mask:  => 151:3
  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_603' declared with attribute error: FIELD_GET: mask is not constant:  => 354:38
  + /kisskb/src/include/linux/random.h: error: 'latent_entropy' undeclared (first use in this function):  => 25:39
  + /kisskb/src/include/linux/random.h: error: 'latent_entropy' undeclared (first use in this function); did you mean 'add_latent_entropy'?:  => 25:46
  + {standard input}: Error: displacement to undefined symbol .L377 overflows 12-bit field:  => 2286
  + {standard input}: Error: displacement to undefined symbol .L378 overflows 8-bit field :  => 2302
  + {standard input}: Error: displacement to undefined symbol .L382 overflows 8-bit field :  => 2213

15 error improvements:
  - /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer: 103:18 => 
  - /kisskb/src/crypto/blake2b_generic.c: error: the frame size of 2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]: 109:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]: 1614:1 => 
  - /kisskb/src/drivers/gpu/drm/r128/r128_cce.c: error: case label does not reduce to an integer constant: 417:2, 418:2 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function): 149:37 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor': 149:22 => 
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]: 150:1 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size': 88:22 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]: 89:1 => 
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]: 100:2 => 
  - {standard input}: Error: displacement to undefined symbol .L271 overflows 12-bit field: 1625 => 
  - {standard input}: Error: displacement to undefined symbol .L271 overflows 8-bit field : 1634 => 
  - {standard input}: Error: displacement to undefined symbol .L318 overflows 8-bit field : 1711, 1681, 1665, 1693 => 
  - {standard input}: Error: pcrel too far: 1667, 1609, 1698, 1660, 1629, 1670, 1684, 1702, 1635, 1632, 1705, 1657, 1656, 1644, 1695, 1673, 1676, 1686, 1649, 1655, 1700, 1618, 1685, 1672 => 2249, 2206, 2231, 2261, 2293, 2248, 2215, 2262, 2247, 2232, 2216, 2217, 2209, 2204, 2274, 2221, 2229, 2259
  - {standard input}: Error: unknown opcode: 1713 => 


*** WARNINGS ***

8 warning regressions:
  + /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 407:1
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1092 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 308:1
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1144 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 634:1
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_100000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: vmlinux.o: section mismatch in reference: __trace_event_discard_commit (section: .text.unlikely) -> initcall_level_names (section: .init.data):  => N/A
  + {standard input}: Warning: overflow in branch to .L3; converted into longer instruction sequence:  => 2308

28 warning improvements:
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 407:1 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 303:1 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1148 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 638:1 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for ZPOOL: 61 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for ZPOOL: 37 => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14410): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14428): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14440): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14458): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14470): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14488): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x144a0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x144f0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14508): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14520): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14538): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14550): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14568): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14580): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14598): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47b0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47c8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47e0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47f8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4810): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4828): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4840): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x52bc): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
