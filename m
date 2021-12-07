Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241C146BC83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhLGNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbhLGNb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:31:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15295C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 05:28:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7h2K0Xh4z4xgY;
        Wed,  8 Dec 2021 00:28:25 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Erhard Furtner <erhard_f@mailbox.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <15cbc3439d4ad988b225e2119ec99502a5cc6ad3.1638261744.git.christophe.leroy@csgroup.eu>
References: <15cbc3439d4ad988b225e2119ec99502a5cc6ad3.1638261744.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix shift-out-of-bounds in KASAN init
Message-Id: <163888363476.3690807.11887155536707238032.b4-ty@ellerman.id.au>
Date:   Wed, 08 Dec 2021 00:27:14 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 09:42:37 +0100, Christophe Leroy wrote:
> ================================================================================
> UBSAN: shift-out-of-bounds in arch/powerpc/mm/kasan/book3s_32.c:22:23
> shift exponent -1 is negative
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.5-gentoo-PowerMacG4 #9
> Call Trace:
> [c214be60] [c0ba0048] dump_stack_lvl+0x80/0xb0 (unreliable)
> [c214be80] [c0b99288] ubsan_epilogue+0x10/0x5c
> [c214be90] [c0b98fe0] __ubsan_handle_shift_out_of_bounds+0x94/0x138
> [c214bf00] [c1c0f010] kasan_init_region+0xd8/0x26c
> [c214bf30] [c1c0ed84] kasan_init+0xc0/0x198
> [c214bf70] [c1c08024] setup_arch+0x18/0x54c
> [c214bfc0] [c1c037f0] start_kernel+0x90/0x33c
> [c214bff0] [00003610] 0x3610
> ================================================================================
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Fix shift-out-of-bounds in KASAN init
      https://git.kernel.org/powerpc/c/af11dee4361b3519981fa04d014873f9d9edd6ac

cheers
