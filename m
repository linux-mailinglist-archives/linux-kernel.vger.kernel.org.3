Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E6D4CA520
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbiCBMr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiCBMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:47:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9C67807D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:46:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v4v6c5wz4xcP;
        Wed,  2 Mar 2022 23:46:39 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <ddcb422102a37eb45f57694c7ef0ec6187964dff.1644742951.git.christophe.leroy@csgroup.eu>
References: <ddcb422102a37eb45f57694c7ef0ec6187964dff.1644742951.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Don't allow the use of EMIT_BUG_ENTRY with BUGFLAG_WARNING
Message-Id: <164622487604.2052779.15267979527677516590.b4-ty@ellerman.id.au>
Date:   Wed, 02 Mar 2022 23:41:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022 10:02:41 +0100, Christophe Leroy wrote:
> Warnings in assembly must use EMIT_WARN_ENTRY in order to generate
> the necessary entry in exception table.
> 
> Check in EMIT_BUG_ENTRY that flags don't include BUGFLAG_WARNING.
> 
> This change avoids problems like the one fixed by
> commit fd1eaaaaa686 ("powerpc/64s: Use EMIT_WARN_ENTRY for SRR debug
> warnings").
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Don't allow the use of EMIT_BUG_ENTRY with BUGFLAG_WARNING
      https://git.kernel.org/powerpc/c/38a1756861b8fc2ea9afb93e231194c642a4e261

cheers
