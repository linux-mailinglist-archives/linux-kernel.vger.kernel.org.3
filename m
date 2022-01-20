Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7F494BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376323AbiATKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiATKhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:37:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F983C061574;
        Thu, 20 Jan 2022 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IPCG7u59l6g4gQfA7/kz26XOwQYj1kTGYtvG8ISDhgk=; b=Akv/koBNrr3moj2wsPZFQCOwVS
        IU+JXc/VRE1FDa90VZfM8su2uTNUv4TkPxWnaahpiY+xeAv79xFB55Mx7rX9K5nAiYfc+eNfAmiSg
        hTVLfiOdWn/4mdFWVbtEWAgBlWF2oviic1+frRSQKwWu8hXjl0TdStm5f9m6zBXMntdQBrKBaT0BC
        BpTpRP3zE1UmycEz0bYQqioC+7HXSEFHEzQHDGrD6AuZlngTzQYAv8fUnKPNj3fcJkTKJ7pxHrFle
        E0UVt9wm4D4YEydthRAQDU463abbfxg+DkWU2cKVZIiywHEPAYMCKBpNA1Duy1pS1MaJgjPG+W4ye
        PN6MERiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAUoZ-002Gvy-Ho; Thu, 20 Jan 2022 10:37:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 929B03002F1;
        Thu, 20 Jan 2022 11:37:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6803421417389; Thu, 20 Jan 2022 11:37:08 +0100 (CET)
Date:   Thu, 20 Jan 2022 11:37:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <Yek7VNT2GsTfZsCD@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
 <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net>
 <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
 <YefTCk4to5YzO8AB@hirez.programming.kicks-ass.net>
 <CAPNVh5dccb59Dj5Aeo3AybS+EiHix+-U7wgm8AakPqL3zdTQtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5dccb59Dj5Aeo3AybS+EiHix+-U7wgm8AakPqL3zdTQtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:52:30AM -0800, Peter Oskolkov wrote:
> Could you, please, post an updated RFC when you have a chance? Thanks!

I was working on that, I'll try and get it done today.
