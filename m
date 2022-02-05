Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8C4AA80F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379495AbiBEKXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:23:25 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:57378 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377656AbiBEKXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:23:24 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 24D932013AF;
        Sat,  5 Feb 2022 10:23:22 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 9F54C811AC; Sat,  5 Feb 2022 11:23:14 +0100 (CET)
Date:   Sat, 5 Feb 2022 11:23:14 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] pcmcia: db1xxx_ss: restrict to MIPS_DB1XXX boards
Message-ID: <Yf5QEpz0FeXjBOcB@owl.dominikbrodowski.net>
References: <20220123174031.3109-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123174031.3109-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Jan 23, 2022 at 09:40:31AM -0800 schrieb Randy Dunlap:
> When the MIPS_ALCHEMY board selection is MIPS_XXS1500 instead of
> MIPS_DB1XXX, the PCMCIA driver 'db1xxx_ss' has build errors due
> to missing DB1XXX symbols. The PCMCIA driver should be restricted
> to MIPS_DB1XXX instead of MIPS_ALCHEMY to fix this build error.
> 
> ERROR: modpost: "bcsr_read" [drivers/pcmcia/db1xxx_ss.ko] undefined!
> ERROR: modpost: "bcsr_mod" [drivers/pcmcia/db1xxx_ss.ko] undefined!
> 
> Fixes: 42a4f17dc356 ("MIPS: Alchemy: remove SOC_AU1X00 in favor of MIPS_ALCHEMY")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org

Applied to -pcmcia, thanks!

	Dominik
