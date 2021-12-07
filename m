Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8746BC90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhLGNdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbhLGNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:31:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D492C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 05:28:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7h2N0WRxz4xgy;
        Wed,  8 Dec 2021 00:28:28 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <f16c30f5c9185a63335322cf1a8b22f189d335ef.1637922595.git.christophe.leroy@csgroup.eu>
References: <f16c30f5c9185a63335322cf1a8b22f189d335ef.1637922595.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/ptdump: Fix display a BAT's size unit
Message-Id: <163888364104.3690807.15744779328710272705.b4-ty@ellerman.id.au>
Date:   Wed, 08 Dec 2021 00:27:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 11:30:03 +0100, Christophe Leroy wrote:
> We have wrong units on BAT's sizes (G instead of M, M instead of ...)
> 
> 	---[ Instruction Block Address Translation ]---
> 	0: 0xc0000000-0xc03fffff 0x00000000         4G Kernel   x     m
> 	1: 0xc0400000-0xc05fffff 0x00400000         2G Kernel   x     m
> 	2: 0xc0600000-0xc06fffff 0x00600000         1G Kernel   x     m
> 	3: 0xc0700000-0xc077ffff 0x00700000       512M Kernel   x     m
> 	4: 0xc0780000-0xc079ffff 0x00780000       128M Kernel   x     m
> 	5: 0xc07a0000-0xc07bffff 0x007a0000       128M Kernel   x     m
> 	6:         -
> 	7:         -
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ptdump: Fix display a BAT's size unit
      https://git.kernel.org/powerpc/c/cdc81aece8041fd5437bdabde6c543cdeb2891a8

cheers
