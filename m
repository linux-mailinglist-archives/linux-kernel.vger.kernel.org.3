Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC748114C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhL2Jea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhL2Je3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:34:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327FAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:34:29 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E334A1EC036C;
        Wed, 29 Dec 2021 10:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640770463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ur7/bnxqhmb92vX2Or3sKdC/NzZKUeg8fxrscRISr0k=;
        b=nsSCduZH4EKRhiLJqOYZTGBkygv4UM+ChbPWkPpEorGN2o5oQy2mF8LIYgb2V4O0EOguBo
        iLSVVFGsD6kCJ+r+fy/wUUjxdHEF3s1jlsDiGilA7EBAXJqvmWmntcIEuHw5EjnQn8BpMH
        Kr2oF30WDBTLHyOeSgHmjyyjofMEMVs=
Date:   Wed, 29 Dec 2021 10:34:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:ras/core] BUILD SUCCESS
 de768416b203ac84e02a757b782a32efb388476f
Message-ID: <YcwrofZrHadGAMlD@zn.tnic>
References: <61cba815.Her0ebRPVzS617KT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61cba815.Her0ebRPVzS617KT%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 08:13:09AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
> branch HEAD: de768416b203ac84e02a757b782a32efb388476f  x86/mce/inject: Avoid out-of-bounds write when setting flags
> 
> possible Warning in current branch (please contact us if interested):
> 
> vmlinux.o: warning: objtool: do_machine_check()+0x59a: call to test_bit() leaves .noinstr.text section
> 
> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- x86_64-buildonly-randconfig-r006-20211228
>     `-- vmlinux.o:warning:objtool:do_machine_check():call-to-test_bit()-leaves-.noinstr.text-section

Yes, I'm interested. Please send me reproduction instructions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
