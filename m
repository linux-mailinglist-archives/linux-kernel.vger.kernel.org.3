Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C34B62BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiBOFad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:30:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiBOFa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FD112859C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV681Pdrz4xmx;
        Tue, 15 Feb 2022 16:30:08 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cc89d3c11fc9c742d0df3454a657a3a00be24046.1643538554.git.christophe.leroy@csgroup.eu>
References: <cc89d3c11fc9c742d0df3454a657a3a00be24046.1643538554.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Make pte_update() non atomic on 603 core
Message-Id: <164490280591.270256.978317263917716851.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:45 +1100
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

On Sun, 30 Jan 2022 10:29:34 +0000, Christophe Leroy wrote:
> On 603 core, TLB miss handler don't do any change to the
> page tables so pte_update() doesn't need to be atomic.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/32s: Make pte_update() non atomic on 603 core
      https://git.kernel.org/powerpc/c/4291d085b0b07a78403e845c187428b038c901cd

cheers
