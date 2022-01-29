Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933E54A2E13
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiA2LPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiA2LPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:15:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317CC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:15:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JmBZ56XGMz4xcS;
        Sat, 29 Jan 2022 22:15:09 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Maxime Bizon <mbizon@freebox.fr>
In-Reply-To: <b0b752f6f6ecc60653e873f385c6f0dce4e9ab6a.1638789098.git.christophe.leroy@csgroup.eu>
References: <b0b752f6f6ecc60653e873f385c6f0dce4e9ab6a.1638789098.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/fixmap: Fix VM debug warning on unmap
Message-Id: <164345486523.1545234.1636640296413408216.b4-ty@ellerman.id.au>
Date:   Sat, 29 Jan 2022 22:14:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 11:11:51 +0000, Christophe Leroy wrote:
> Unmapping a fixmap entry is done by calling __set_fixmap()
> with FIXMAP_PAGE_CLEAR as flags.
> 
> Today, powerpc __set_fixmap() calls map_kernel_page().
> 
> map_kernel_page() is not happy when called a second time
> for the same page.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/fixmap: Fix VM debug warning on unmap
      https://git.kernel.org/powerpc/c/aec982603aa8cc0a21143681feb5f60ecc69d718

cheers
