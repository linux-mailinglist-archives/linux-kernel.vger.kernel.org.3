Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D10747347B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbhLMS5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhLMS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:57:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C45C061574;
        Mon, 13 Dec 2021 10:57:09 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA0771EC058C;
        Mon, 13 Dec 2021 19:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639421823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vug8c6LeiYsA8ecHoSXfAGDN69ymkQs1b6qpIjHtAAE=;
        b=jaXPqYRD1U/EpsAljNHIQnZJtaf+hUyUFWtbuqD43Jf/AApyBPA7ymJZoxF8/uHXBJXYLH
        J+hAKMqZn7J728aTOtDyDHG1AlBvR+BYoyc+qbyHjOfXQvC618ovAS0L4k7FrZBCP0FX+L
        oLfQeqzBGjssQRAnKvq9Pg7ZaU0GOek=
Date:   Mon, 13 Dec 2021 19:57:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     john.p.donnelly@oracle.com
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
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
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: Re: [PATCH v17 00/10] support reserving crashkernel above 4G on
 arm64 kdump
Message-ID: <YbeXfkEkqp1Js3TP@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <5ef3ef54-33db-3cb2-4908-8bd1254749e3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ef3ef54-33db-3cb2-4908-8bd1254749e3@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:37:48AM -0600, john.p.donnelly@oracle.com wrote:
> After 2 years, and 17 versions, can we now get this series promoted into a
> build ?

For example:

$ ./scripts/get_maintainer.pl -f Documentation/admin-guide/kdump/kdump.rst
Baoquan He <bhe@redhat.com> (maintainer:KDUMP)
Vivek Goyal <vgoyal@redhat.com> (reviewer:KDUMP)
Dave Young <dyoung@redhat.com> (reviewer:KDUMP)
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
kexec@lists.infradead.org (open list:KDUMP)

I see only two acks from Baoquan.

So yes, this needs to go through the normal review process first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
