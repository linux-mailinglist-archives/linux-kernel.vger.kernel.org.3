Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815F75653BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiGDLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiGDLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F7E11142
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:35:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3f54rVHz4xYn;
        Mon,  4 Jul 2022 21:35:57 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1b416f8a8fe1bc3f4e01175680ce310b7eb3a1e4.1655974565.git.christophe.leroy@csgroup.eu>
References: <1b416f8a8fe1bc3f4e01175680ce310b7eb3a1e4.1655974565.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/64e: Rewrite p4d_populate() as a static inline function
Message-Id: <165693441307.9954.9463227776617482295.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:33:33 +1000
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

On Thu, 23 Jun 2022 10:56:57 +0200, Christophe Leroy wrote:
> Rewrite p4d_populate() as a static inline function instead of
> a macro.
> 
> This change allows typechecking and would have helped detecting
> a recently found bug in map_kernel_page().
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64e: Rewrite p4d_populate() as a static inline function
      https://git.kernel.org/powerpc/c/2db2008e636327a3caa648ef1e34a9d501d20e2e

cheers
