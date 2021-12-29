Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122664811E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhL2LLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbhL2LLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:11:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CB4C061574;
        Wed, 29 Dec 2021 03:11:07 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 353C21EC04D1;
        Wed, 29 Dec 2021 12:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640776262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=airGDjUxCcJh80Hcyr6jOEHci9owmSN8F2s+Qye6gdM=;
        b=c2QDGOra6/ICP03WygoMMs45fqwYs76gnmhzZFO1o8a/GIjZFIMKcfFNMOMZ/5i/1fjjbm
        1dn6X3mj4JuMeATbim9WfyPoSa4jEfgb5y+/O+dRajblTM+qB9fAkipmcxfwTloaEwh7Jz
        /P2uHhOyf3iudq2ma2SuFjcnt0MIwyg=
Date:   Wed, 29 Dec 2021 12:11:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
Message-ID: <YcxCTTGu/Ut7bU+W@zn.tnic>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
 <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
 <YcwSCAuEgO10DFDT@dhcp-128-65.nay.redhat.com>
 <Ycw0V1CmBPCPqexn@zn.tnic>
 <Ycw6s6DwZuHjckXL@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ycw6s6DwZuHjckXL@dhcp-128-65.nay.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 06:38:43PM +0800, Dave Young wrote:
> I appreciate you further explanation below to describe the situation.
> I do not see how can I tell this to *all* submitters,

You don't have to - that was hypothetical. :-)

I'm typing this on a public mailing list with the hope that people will
see it.

> but I am and I will try to do this as far as I can.

Much appreciated.

> Maintainers and patch submitters, it would help for both
> parties show sympathy with each other, some soft reminders will help
> people to understand each other, especially for new comers.

Yap, that's why we keep repeating it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
