Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1E5233B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiEKNIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiEKNId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:08:33 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD8694BF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:08:25 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4KywFg4Vvfz1s767;
        Wed, 11 May 2022 15:08:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4KywFg3pqTz1qqkC;
        Wed, 11 May 2022 15:08:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id kYXiVRSumpor; Wed, 11 May 2022 15:08:22 +0200 (CEST)
X-Auth-Info: YEBr5TXT5M0JFjoy9bg7asKyhj92V+KtsCcBJL9EYLO6BmBfGrQV3CaUgj1M9MBe
Received: from igel.home (ppp-46-244-167-40.dynamic.mnet-online.de [46.244.167.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 11 May 2022 15:08:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 5485A2C39F6; Wed, 11 May 2022 15:08:22 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] m68k: math-emu: Fix dependencies of math emulation support
References: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
        <875ymcwek5.fsf@igel.home>
        <CAMuHMdXrd07goR2WffENJnLMAWZxtxoQzaL_7+SG-ZSvaYK1HQ@mail.gmail.com>
X-Yow:  Yow!  Now we can become alcoholics!
Date:   Wed, 11 May 2022 15:08:22 +0200
In-Reply-To: <CAMuHMdXrd07goR2WffENJnLMAWZxtxoQzaL_7+SG-ZSvaYK1HQ@mail.gmail.com>
        (Geert Uytterhoeven's message of "Wed, 11 May 2022 14:02:01 +0200")
Message-ID: <87lev8ushl.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 11 2022, Geert Uytterhoeven wrote:

> The FPU emu code also relies on the CPU trapping on the proper
> instructions, which I believe you need a 68020+ for, too?

While pre-020 doesn't have the coprocessor interface (which is not
fpu-specific, though), they still use the same exception vector.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
