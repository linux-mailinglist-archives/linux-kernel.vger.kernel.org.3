Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725684F6A52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiDFTtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiDFTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:49:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BA02E0A5;
        Wed,  6 Apr 2022 10:59:51 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BD721EC058B;
        Wed,  6 Apr 2022 19:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649267986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YX86Bq1CunXRltFfq1Z3H5gzQ1SRlqU01eVuZwQdMXc=;
        b=WVxBypOwpwKvq+pR7jm4wlRIgMWZQnwObfcYnm98A9gi1Aa8VpZNrL6xHVa3bhkpk0HKWV
        ELHqHpXpd2DmCneiLxU5Jbib/LZ6jAxzjKf0tSCjMlByYXzyyAbjmsmedW58Yv+9zXj5fr
        WvpPpx0Xte3P5m5tuaPkBQejSrM/sy8=
Date:   Wed, 6 Apr 2022 19:59:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/build] x86/configs: Add x86 debugging Kconfig fragment
 plus docs
Message-ID: <Yk3VEM9LoHozLt2g@zn.tnic>
References: <20220331175728.299103A0@davehans-spike.ostc.intel.com>
 <164918891525.389.9920170532036101413.tip-bot2@tip-bot2>
 <Yk3GCnyA8rhy1Syj@thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yk3GCnyA8rhy1Syj@thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:55:38AM -0700, Nathan Chancellor wrote:
> I am replying to this message versus the original patch because this
> appears to be done during committing.
> 
> This "CONFIG_DEBUG_INFO=y" will not do anything, as the debug info
> Kconfig was turned into a choice in commit f9b3cd245784 ("Kconfig.debug:
> make DEBUG_INFO selectable from a choice").
> 
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> 
> will do what "CONFIG_DEBUG_INFO=y" used to do.

Thanks Nathan, fixed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
