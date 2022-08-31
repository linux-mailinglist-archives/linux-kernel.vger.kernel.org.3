Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F95A7E73
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiHaNPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiHaNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:15:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A0C80F41
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:15:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHl6F1V9Yz4xGH;
        Wed, 31 Aug 2022 23:15:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cba76f5a5b01fcc49415e632d92c11c1c5998cab.1660843877.git.christophe.leroy@csgroup.eu>
References: <cba76f5a5b01fcc49415e632d92c11c1c5998cab.1660843877.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/vdso: Don't map VDSO at a fixed address on PPC32
Message-Id: <166195162996.45984.6268667436058610815.b4-ty@ellerman.id.au>
Date:   Wed, 31 Aug 2022 23:13:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 19:31:25 +0200, Christophe Leroy wrote:
> PPC64 removed default mapping address from VDSO in
> commit 30d0b3682887 ("powerpc: Move 64bit VDSO to improve context
> switch performance").
> 
> Do like PPC64 and let get_unmapped_area() place the VDSO mapping
> at the address it wants, don't force a default address.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/vdso: Don't map VDSO at a fixed address on PPC32
      https://git.kernel.org/powerpc/c/8a8f7866663588b162031a5348c24e42161461cd

cheers
