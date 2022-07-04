Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2ED5653C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiGDLf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiGDLf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:35:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7610547
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:35:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3dy2YgLz4xRC;
        Mon,  4 Jul 2022 21:35:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <e2454434992cc932a5a34b695ae981c0b2f4c28e.1652862729.git.christophe.leroy@csgroup.eu>
References: <e2454434992cc932a5a34b695ae981c0b2f4c28e.1652862729.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/irq: Don't open code irq_soft_mask helpers
Message-Id: <165693439495.9954.8279750224507948132.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:33:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 10:32:27 +0200, Christophe Leroy wrote:
> Use READ_ONCE() and WRITE_ONCE() instead of open coding
> read and write of local PACA irq_soft_mask.
> 
> For the write, add a barrier to keep the memory clobber
> that was there previously.
> 
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/irq: Don't open code irq_soft_mask helpers
      https://git.kernel.org/powerpc/c/ef5b570d3700fbb8628a58da0487486ceeb713cd
[2/2] powerpc/irq: Replace #ifdefs by IS_ENABLED()
      https://git.kernel.org/powerpc/c/78ffe6a7e2a169c4dcbbd08717a0a8d738659d15

cheers
