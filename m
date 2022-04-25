Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16ED50EB22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245707AbiDYVPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245721AbiDYVPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:15:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401FD84EE1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:12:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650921148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3vmPSy8eTc3pVdzDWzoIH0IwaO2axTc98mYw5raeiM=;
        b=DlqnWf9wvbMipPi5yeiByMvF/HezeRGAcnBrj/gJBol9uR5uAKB1IDweHNUFIKdMjD3Ks3
        mFvXw/Iq98ib8TMiuJxQK3nk0Xakebi0Su+VAwjgucUW7H9hwC0nzUZpHSmX0pIvQfsLOO
        dFdnn09HQV/KhiF0x5i+vFNZZy8kEZ+ANmNkjKETRGwaCOVG5AP+d0fnxTyzCuLEZAyoUz
        f0TcsOcULoVQO3uz9pwCKr9jAtgpG5oxIht2otn/qelRaG3EkvHqew8pPVhkC9mDnRr9qn
        pcrDWG9K4l+TR1CMaWgf+7Z8PyoII/AlBMIKN+htt1iA34pK6FCYevuHBjdALA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650921148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3vmPSy8eTc3pVdzDWzoIH0IwaO2axTc98mYw5raeiM=;
        b=Edx1Vu/5Iz+Owg/QIqsGj0KgVcbROUW90o+RlZ/dSFKSrcyJ1JT16O0mAnp4GLBFRC6eJJ
        SllKICwuGitnmpDw==
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 00/13] extensible prctl task isolation interface and
 vmstat sync
In-Reply-To: <YmbMUAkOxsStAP36@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <20220317150804.GB459366@lothringen> <YmbMUAkOxsStAP36@fuller.cnet>
Date:   Mon, 25 Apr 2022 23:12:27 +0200
Message-ID: <871qxk27gk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022 at 13:29, Marcelo Tosatti wrote:
> On Thu, Mar 17, 2022 at 04:08:04PM +0100, Frederic Weisbecker wrote:
>> 
>> I still see a few details to sort out but overall the whole thing looks good:

From a cursery inspection there is more than a few details to sort out.

>>   Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
>> 
>> Perhaps it's time to apply this patchset on some branch and iterate from there.
>> 
>> Thomas, Peter, what do you think?
>> 
>> Thanks!
>
> Ping ?

This does not apply against 5.18-rc1, which was released on April
3rd. Oh, well. You are really new to kernel development, right?

Don't bother to resend before I finished reviewing the pile.

Thanks,

        tglx
