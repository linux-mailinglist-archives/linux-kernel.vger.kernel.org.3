Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383555FAC8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiF2Ii7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiF2Ii5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:38:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFB53BBC8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:38:56 -0700 (PDT)
Received: from zn.tnic (p200300ea97156ae0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:6ae0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 520D11EC026E;
        Wed, 29 Jun 2022 10:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656491931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L9WE3gWi6m03dtemylFUuHBiKHvsHD0gyP8Y9dCvOfA=;
        b=qawEfIkdwRiq4adAOjjqQWpL2o8cLOpZ8kNu/ZxHFEgmdmHGOIeOZh77P9eLKa75gklo4W
        M8kr2p661xWJQVcvlKhVOR5f5R3buAFrghPjkV+pRBx9Lh5tnKuLMJLSV6hFIVHcB26Ux5
        2m3SrbXjGMTMV3/TpJXLT3X1qRzz8YA=
Date:   Wed, 29 Jun 2022 10:38:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan McDowell <noodles@fb.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [tip:x86/kdump 1/1] WARNING: modpost:
 vmlinux.o(.text+0x1e7210c): Section mismatch in reference from the function
 ima_free_kexec_buffer() to the function .meminit.text:memblock_phys_free()
Message-ID: <YrwPjnxBk3Xyuakg@zn.tnic>
References: <202206291039.yGgljGbx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202206291039.yGgljGbx-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 10:52:13AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/kdump
> head:   69243968bd526641e549ed231c750ce92e3eeb35
> commit: 69243968bd526641e549ed231c750ce92e3eeb35 [1/1] x86/kexec: Carry forward IMA measurement log on kexec

I've zapped it from tip for the time being.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
