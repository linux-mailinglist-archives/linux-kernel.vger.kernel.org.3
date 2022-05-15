Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E93D5276FD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiEOKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiEOKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C878BB4AF
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:31:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZQ3Pczz4xZ4;
        Sun, 15 May 2022 20:31:10 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d3a7dc832d905bed14b35d83410cdb69a7ba20e8.1649226186.git.christophe.leroy@csgroup.eu>
References: <d3a7dc832d905bed14b35d83410cdb69a7ba20e8.1649226186.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/5] powerpc/8xx: Move CPM interrupt controller into a dedicated file
Message-Id: <165261054465.1047019.17725531961068292233.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:29:04 +1000
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

On Wed, 6 Apr 2022 08:23:17 +0200, Christophe Leroy wrote:
> CPM interrupt controller is quite standalone. Move it into a
> dedicated file. It will help for next step which will change
> it to a platform driver.
> 
> This is pure code move, checkpatch report is ignored at this point,
> except one parenthesis alignment which would remain at the end of
> the series. All other points fly away with following patches.
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc/8xx: Move CPM interrupt controller into a dedicated file
      https://git.kernel.org/powerpc/c/acf9e575d889eb8806be2c8451e7ad12bf444b50
[2/5] powerpc/8xx: Convert CPM1 error interrupt handler to platform driver
      https://git.kernel.org/powerpc/c/22add2a20e968291251d46d1b833b651b6aba5d7
[3/5] powerpc/8xx: Convert CPM1 interrupt controller to platform_device
      https://git.kernel.org/powerpc/c/14d893fc6846892ae68f8b259594d9cdae99e515
[4/5] powerpc/8xx: Remove mpc8xx_pics_init()
      https://git.kernel.org/powerpc/c/e3ba31b78074bee155662edccd9ca00324087e04
[5/5] powerpc/8xx: Use kmalloced data structure instead of global static
      https://git.kernel.org/powerpc/c/5ad1aa007da5f1907673a7cbfdf6e355835ef428

cheers
