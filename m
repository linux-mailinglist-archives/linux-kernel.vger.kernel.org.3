Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB45328B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbiEXLQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbiEXLQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:16:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A743277
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:16:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7y2dSXz4yTG;
        Tue, 24 May 2022 21:15:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220410161035.592-1-rdunlap@infradead.org>
References: <20220410161035.592-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] macintosh: via-pmu and via-cuda need RTC_LIB
Message-Id: <165339058207.1718562.17348886954707647471.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:42 +1000
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

On Sun, 10 Apr 2022 09:10:35 -0700, Randy Dunlap wrote:
> Fix build when RTC_LIB is not set/enabled.
> Eliminates these build errors:
> 
> m68k-linux-ld: drivers/macintosh/via-pmu.o: in function `pmu_set_rtc_time':
> drivers/macintosh/via-pmu.c:1769: undefined reference to `rtc_tm_to_time64'
> m68k-linux-ld: drivers/macintosh/via-cuda.o: in function `cuda_set_rtc_time':
> drivers/macintosh/via-cuda.c:797: undefined reference to `rtc_tm_to_time64'
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh: via-pmu and via-cuda need RTC_LIB
      https://git.kernel.org/powerpc/c/9a9c5ff5fff87eb1a43db0d899473554e408fd7b

cheers
