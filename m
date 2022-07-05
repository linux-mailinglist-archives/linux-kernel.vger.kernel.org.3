Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5DD56649B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiGEHod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:44:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9161412D06
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:44:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d2so20209000ejy.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p4WrMxeyT1HLi3JYPDHBaEUMJazd4JiPotMxjccrcOI=;
        b=CK+VMuXOPY60wZIVnAZQ7xwsWPl4STCGWQlj/Y18ImlheH0kMnUdhDdWi2v4ywwXmq
         yjHK+NcgnPIhVXFoSX6iSCXcS3A4e/QPb9T0sZ7zoiyIL3pgL9bYaDlU6lN/1OqtNlOv
         0dWLVaELMs9oq5gi5ydvR8KrBxRkcYTQKbOlwCtoWK/9EJ5LutESLfPxwzAUbEDK4/g1
         khxj4shhIg+dAlVTSI3bANq6Q1I9HD/oLluGmKLyk18HiHYla4CkrwemkOOTUjD5qfIE
         jq97luvgK97KDecXPKhtpjCDAt5X+keNa39ncJyV5CgHNh5c40L3XIs6VxGBo7gfEHeA
         eWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p4WrMxeyT1HLi3JYPDHBaEUMJazd4JiPotMxjccrcOI=;
        b=6+eSd92b/MJOFluNnJE71ge9J3VXs721A32PR0Oa4jFsagAqst/RT6qvD90hkuXdCM
         hj9CNR1Z5TLWqt2rw9/pI2nZEfPdW8WFbVx/SnemonG2s8+o8K7KWk51UWtNWvey/n9u
         CyD3yw//cfEbKJ1BEz1U36u4QgWwhb8QoCqWJfVoYCvM1kEZxG2FZnzS3ioWL+3W3j5g
         kOeS6frqBY5GRdwfOyJDEB2rmWuvLdnnNe5B0gkn+3JhRVgljBA6bb8tHkk/nTQ4a97R
         ufL1M3Rf8FNKQDK/wT8f0LrQYkNyN645Bf+hfodIDdLeaDeqk6jJhb31WrQ2oMFH3BXH
         LYXw==
X-Gm-Message-State: AJIora/LM94pMJOtxQB2DWS+TjFbCZtbTXrM/Y5u2Gw294ZKpcnsNuFu
        Bq8CSlUXBgsctHdz2y0G5s0=
X-Google-Smtp-Source: AGRyM1ucemoQZ09Gw0/I3mQiuc+mMrI6EyC3S8EzKzn1mq2Vr1UVjIxLl4dhAvYlXIFb38KeVU+UgA==
X-Received: by 2002:a17:907:9710:b0:726:bdf6:edee with SMTP id jg16-20020a170907971000b00726bdf6edeemr32212369ejc.48.1657007068117;
        Tue, 05 Jul 2022 00:44:28 -0700 (PDT)
Received: from [192.168.89.248] (93-33-54-161.ip43.fastwebnet.it. [93.33.54.161])
        by smtp.googlemail.com with ESMTPSA id d1-20020a056402516100b0043a09f6fc24sm6149293ede.47.2022.07.05.00.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 00:44:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <f719c5fb-3e41-38ac-1b16-fcb603e4911f@redhat.com>
Date:   Tue, 5 Jul 2022 09:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/22] Support SDEI Virtualization
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, Gavin Shan <gshan@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, shijie@amperemail.onmicrosoft.com,
        kvmarm@lists.cs.columbia.edu,
        Sean Christopherson <seanjc@google.com>,
        Peter Feiner <pfeiner@google.com>
References: <20220527080253.1562538-1-gshan@redhat.com>
 <6bdb9280-3530-dc1f-d33e-5bc1c5ac927b@redhat.com>
 <87iloq2oke.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87iloq2oke.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 15:12, Marc Zyngier wrote:
> - as far as I know, the core Linux/arm64 maintainers have no plan to
>    support APF. Without it, this is a pointless exercise. And even with
>    it, this introduces a Linux specific behaviour in an otherwise
>    architectural hypervisor (something I'm quite keen on avoiding)

Regarding non-architectural behavior, isn't that the same already for 
PTP?  I understand that the PTP hypercall is a much smaller 
implementation than SDEI+APF, but it goes to show that KVM is already 
not "architectural".

There are other cases where paravirtualized solutions can be useful. 
PTP is one but there are more where KVM/ARM does not have a solution 
yet, for example lock holder preemption.  Unless ARM (the company) has a 
way to receive input from developers and standardize the interface, 
similar to the RISC-V SIGs, vendor-specific hypercalls are a sad fact of 
life.  It just happened that until now KVM/ARM hasn't seen much use in 
some cases (such as desktop virtualization) where overcommitted hosts 
are more common.

Async page faults per se are not KVM specific, in fact Linux supported 
them for the IBM s390 hypervisor long before KVM added support.  They 
didn't exist on x86 and ARM, so the developers came up with a new 
hypercall API and for x86 honestly it wasn't great.  For ARM we learnt 
from the mistakes and it seems to me that SDEI is a good match for the 
feature.  If ARM wants to produce a standard interface for APF, whether 
based on SDEI or something else, we're all ears.

Regarding plans of core arm64 maintainers to support async page fault, 
can you provide a pointer to the discussion?  I agree that if there's a 
hard NACK for APF for whatever reason, the whole host-side code is 
pointless (including SDEI virtualization); but I would like to read more 
about it.

> - It gives an incentive to other hypervisor vendors to add random crap
>    to the Linux mm subsystem, which is even worse. At this stage, we
>    might as well go back to the Xen PV days altogether.

	return -EGREGIOUS;

Since you mention hypervisor vendors and there's only one hypervisor in 
Linux, I guess you're not talking about the host mm/ subsystem 
(otherwise yeah, FOLL_NOWAIT is only used by KVM async page faults).

So I suppose you're talking about the guest, and then yeah, it sucks to 
have multiple hypervisors providing the same functionality in different 
ways (or multiple hypervisors providing different subsets of PV 
functionality).  It happens on x86 with Hyper-V and KVM, and to a lesser 
extent Xen and VMware.

But again, KVM/ARM has already crossed that bridge with PTP support, and 
the guest needs exactly zero code in the Linux mm subsystem (both 
generic and arch-specific) to support asynchronous page faults.  There 
are 20 lines of code in do_notify_resume(), and the rest is just SDEI 
gunk.  Again, I would be happy to get a pointer to concrete objections 
from the Linux ARM64 maintainers.  Maybe a different implementation is 
possible, I don't know.

In any case it's absolutely not comparable to Xen PV, and you know it.

> - I haven't seen any of the KVM/arm64 users actually asking for the
>    APF horror, and the cloud vendors I directly asked had no plan to
>    use it, and not using it on their x86 systems either

Please define "horror" in more technical terms.  And since this is the 
second time I'm calling you out on this, I'm also asking you to avoid 
hyperboles and similar rhetorical gimmicks in the future.

That said: Peter, Sean, Google uses or used postcopy extensively on GCE 
(https://dl.acm.org/doi/pdf/10.1145/3296975.3186415).  If it doesn't use 
it on x86, do you have any insights on why?

> - no performance data nor workloads that could help making an informed
>    decision have been disclosed, and the only argument in its favour
>    seems to be "but x86 has it" (hardly a compelling one)

Again this is just false, numbers have been posted 
(https://lwn.net/ml/linux-kernel/20210209050403.103143-1-gshan@redhat.com/ 
was the first result that came up from a quick mailing list search).  If 
they are not enough, please be more specific.

Thanks,

Paolo
