Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748614EA87C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiC2H2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiC2H2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:28:00 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1A282467F4;
        Tue, 29 Mar 2022 00:26:17 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id BF6B51E80D7E;
        Tue, 29 Mar 2022 15:25:42 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9r--XoVcY8pM; Tue, 29 Mar 2022 15:25:40 +0800 (CST)
Received: from [18.165.124.108] (unknown [101.228.248.165])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 6921A1E80D70;
        Tue, 29 Mar 2022 15:25:39 +0800 (CST)
Message-ID: <49b93407-dee3-b3bb-6d36-d6f94e9b16bf@nfschina.com>
Date:   Tue, 29 Mar 2022 15:26:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] KVM: arm64: vgic-debug: remove unnecessary type castings
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        kernel-janitors@vger.kernel.org
References: <20220328103836.2829-1-yuzhe@nfschina.com>
 <87h77ifbbd.wl-maz@kernel.org>
 <0f4cf955-ca2b-626f-867e-5a0ecfe68ca1@nfschina.com>
 <87r16li6e7.wl-maz@kernel.org>
From:   yuzhe <yuzhe@nfschina.com>
In-Reply-To: <87r16li6e7.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/29 15:07, Marc Zyngier 写道:

> On Tue, 29 Mar 2022 07:14:16 +0100,
> yuzhe <yuzhe@nfschina.com> wrote:
>>>> @@ -229,7 +229,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
>>>>      static int vgic_debug_show(struct seq_file *s, void *v)
>>>>    {
>>>> -	struct kvm *kvm = (struct kvm *)s->private;
>>>> +	struct kvm *kvm = s->private;
>>>>    	struct vgic_state_iter *iter = (struct vgic_state_iter *)v;
>>> How about you fully get rid of the unnecessary casts then?
>>>
>>> 	M.
>> I don't know what you exactly mean. I follow the
>> kernel-janitors/TODO List to get rid of the unnecessary casts.  And
>> I checked all the code in the arch directory and found these issues.
> Let me quote the lines again:
>
>>>>      static int vgic_debug_show(struct seq_file *s, void *v)
> [...]
>>>>    	struct vgic_state_iter *iter = (struct vgic_state_iter *)v;
> Do you see what I mean?
>
> 	M.

Got it, thanks. I will check again and resubmit.

yuzhe

