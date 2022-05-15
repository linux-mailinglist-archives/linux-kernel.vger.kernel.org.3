Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45B5276FE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiEOKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiEOKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA04EAE6B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:31:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZP3RnJz4xbN;
        Sun, 15 May 2022 20:31:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <afb92085f930651d8b1063e4d4bf0396c80ebc7d.1647002274.git.christophe.leroy@csgroup.eu>
References: <afb92085f930651d8b1063e4d4bf0396c80ebc7d.1647002274.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc: Use static call for get_irq()
Message-Id: <165261052949.1047019.3804884242995162781.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:28:49 +1000
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

On Fri, 11 Mar 2022 13:38:04 +0100, Christophe Leroy wrote:
> __do_irq() inconditionnaly calls ppc_md.get_irq()
> 
> That's definitely a hot path.
> 
> At the time being ppc_md.get_irq address is read every time
> from ppc_md structure.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Use static call for get_irq()
      https://git.kernel.org/powerpc/c/e59596a2d6a75ea3deb60698b95942aaf03681f5

cheers
