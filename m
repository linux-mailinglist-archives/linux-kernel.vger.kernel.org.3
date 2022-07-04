Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF75653CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiGDLhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiGDLgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBDD11A2D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:36:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3fS0gLKz4xn1;
        Mon,  4 Jul 2022 21:36:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        benh@kernel.crashing.org, mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220526065737.86370-1-juerg.haefliger@canonical.com>
References: <20220526065737.86370-1-juerg.haefliger@canonical.com>
Subject: Re: [PATCH 0/2] powerpc: Kconfig cleanups
Message-Id: <165693444574.9954.3298717136812564151.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:34:05 +1000
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

On Thu, 26 May 2022 08:57:35 +0200, Juerg Haefliger wrote:
> Replace some stray tabs with whitespaces and remove an extra empty
> line.
> 
> Juerg Haefliger (2):
>   powerpc: Kconfig: Replace tabs with whitespaces
>   powerpc: Kconfig.debug: Remove extra empty line
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: Kconfig: Replace tabs with whitespaces
      https://git.kernel.org/powerpc/c/cea9d62b64c981b2a72e7166b21ba413fea16c83
[2/2] powerpc: Kconfig.debug: Remove extra empty line
      https://git.kernel.org/powerpc/c/d60cb5010cafc7889384ce49292a320f5bcd56ff

cheers
