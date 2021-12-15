Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CAB474F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhLOA0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:26:53 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:53265 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLOA0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:26:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGJh6VlKz4xbd;
        Wed, 15 Dec 2021 11:26:44 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <ab58b296832b0ec650e2203200e060adbcb2677d.1637930421.git.christophe.leroy@csgroup.eu>
References: <ab58b296832b0ec650e2203200e060adbcb2677d.1637930421.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Allocate one 256k IBAT instead of two consecutives 128k IBATs
Message-Id: <163952787518.919625.8591134996141675509.b4-ty@ellerman.id.au>
Date:   Wed, 15 Dec 2021 11:24:35 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 13:40:35 +0100, Christophe Leroy wrote:
> Today we have the following IBATs allocated:
> 
> 	---[ Instruction Block Address Translation ]---
> 	0: 0xc0000000-0xc03fffff 0x00000000         4M Kernel   x     m
> 	1: 0xc0400000-0xc05fffff 0x00400000         2M Kernel   x     m
> 	2: 0xc0600000-0xc06fffff 0x00600000         1M Kernel   x     m
> 	3: 0xc0700000-0xc077ffff 0x00700000       512K Kernel   x     m
> 	4: 0xc0780000-0xc079ffff 0x00780000       128K Kernel   x     m
> 	5: 0xc07a0000-0xc07bffff 0x007a0000       128K Kernel   x     m
> 	6:         -
> 	7:         -
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Allocate one 256k IBAT instead of two consecutives 128k IBATs
      https://git.kernel.org/powerpc/c/37eb7ca91b692e8e49e7dd50158349a6c8fb5b09

cheers
