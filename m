Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E95474F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbhLOA07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbhLOA0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:26:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E63C061401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:26:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGJj61hvz4xhm;
        Wed, 15 Dec 2021 11:26:45 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Erhard Furtner <erhard_f@mailbox.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <2c7e421874e21b2fb87813d768cf662f630c2ad4.1638984999.git.christophe.leroy@csgroup.eu>
References: <2c7e421874e21b2fb87813d768cf662f630c2ad4.1638984999.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/powermac: Add additional missing lockdep_register_key()
Message-Id: <163952788299.919625.3266210464453181174.b4-ty@ellerman.id.au>
Date:   Wed, 15 Dec 2021 11:24:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 17:36:52 +0000, Christophe Leroy wrote:
> Commit df1f679d19ed ("powerpc/powermac: Add missing
> lockdep_register_key()") fixed a problem that was causing a WARNING.
> 
> There are two other places in the same file with the same problem
> originating from commit 9e607f72748d ("i2c_powermac: shut up lockdep
> warning").
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powermac: Add additional missing lockdep_register_key()
      https://git.kernel.org/powerpc/c/b149d5d45ac9171ed699a256f026c8ebef901112

cheers
