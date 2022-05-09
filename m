Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E882C51FAAA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiEILB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiEILBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:01:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A41F8C46
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:58:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652093879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YWc+mEXYNAVwE78o/T5W2jG9k71MoTWKPtoi2RzWyvQ=;
        b=nwVR44IDpt1cN2ysgoxfRYaTcAE9ZL4EDAtq2GpRv8P90qNbguGL4jAwrLHHlUYJDUsHwB
        Sd0ODdcA9TW/X/y8P5VKfzM/Xfz9y5KszSI0ppg2knwPHTPii6Mv1PFr8cpVPKfJBPpNB9
        F88ZM7qcAosmf620ca8trHcP462hjPG3/PDg5rFB2rCaWVK6C/y7Izb+szeCzL4dRh6UL1
        wlTbZ9CiA9l7fD1vxwv0eT+u/PcZ3SRWBKjKEPweDab4gyrOunxqe/POPc9X3ly2TmQkV7
        VHzvusbnGORRkuouApyCY66xClUBL+nRwpIwTjDAssZcewuZNa+PH41maQnapQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652093879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YWc+mEXYNAVwE78o/T5W2jG9k71MoTWKPtoi2RzWyvQ=;
        b=JuqxO4qZb3g4nVuiux/YpfpmoPtIOs8CDco0XzVIWsQG906KMY3kG4UwrcETzC510Q7Uyj
        O75gyiCLteuFAOCQ==
To:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
In-Reply-To: <87ee13rn52.ffs@tglx>
References: <20220509041305.15056-1-kernelfans@gmail.com>
 <20220509041305.15056-2-kernelfans@gmail.com> <87ee13rn52.ffs@tglx>
Date:   Mon, 09 May 2022 12:57:59 +0200
Message-ID: <87bkw7rn0o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09 2022 at 12:55, Thomas Gleixner wrote:
> On Mon, May 09 2022 at 12:13, Pingfan Liu wrote:
>> -		cpu_hotplug_enable();
>
> This is tinkering at best. Can we please sit down and rethink this whole
> machinery instead of applying random duct tape to it?

That said, I still have not figured out which real world problem you are
actually trying to solve.

Thanks,

        tglx
