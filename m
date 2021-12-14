Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C04474BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhLNTY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhLNTY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:24:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC2C06173E;
        Tue, 14 Dec 2021 11:24:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD7ABCE1A82;
        Tue, 14 Dec 2021 19:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F59C34604;
        Tue, 14 Dec 2021 19:24:17 +0000 (UTC)
Date:   Tue, 14 Dec 2021 19:24:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: Re: [PATCH v17 02/10] x86: kdump: make the lower bound of crash
 kernel reservation consistent
Message-ID: <YbjvXl51hc6GZa71@arm.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-3-thunder.leizhen@huawei.com>
 <YbjrjpehprvoRXbV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbjrjpehprvoRXbV@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 08:07:58PM +0100, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 02:55:25PM +0800, Zhen Lei wrote:
> > From: Chen Zhou <chenzhou10@huawei.com>
> > 
> > The lower bounds of crash kernel reservation and crash kernel low
> > reservation are different, use the consistent value CRASH_ALIGN.
> 
> A big WHY is missing here to explain why the lower bound of the
> allocation range needs to be 16M and why was 0 wrong?

I asked the same here:

https://lore.kernel.org/r/20210224143547.GB28965@arm.com

IIRC Baoquan said that there is a 1MB reserved for x86 anyway in the
lower part, so that's equivalent in practice to starting from
CRASH_ALIGN.

Anyway, I agree the commit log should describe this.

-- 
Catalin
