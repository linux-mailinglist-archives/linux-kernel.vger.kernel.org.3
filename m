Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642D24C53BC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 05:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiBZEye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 23:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBZEyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 23:54:33 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E71AA064
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:54:00 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso9630247ooi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWWlAFz05x0WZQU6INSvc2zGDo6a5FwCDit26I06Y0w=;
        b=hajdGby9NoWKpfwTYiv9VdiiqaQbZAK4shAvaQ4mKq8P6QkIf3aSoxc5RAMpMx8EJ3
         ZnKvJKOYtmKvnkc4rBRMowHY0nXztZfCU74NlU+a0VtQpcC93Mm/rwxOp/FZHrivHOh/
         aTpkeW1tony7sHzFI9k2mG88UHLLVlP2HBcyPC2tX+IUWQ3fxrkofJp4F/Sbz1g59ujL
         PNb4iOvJ2R6Rh34Rbm/vKLMvGUwFYuLsCAMLzjk3ZweA1nzgYgJ4RMIna2KM2Qd4EoQh
         Zcq/kELrIEFqt9jdwD+AgtuJCEZ0d2GfQ+GrnMu3nXdNZ3ICOwPVT1lu4MXnQO2WzERf
         Ehng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWWlAFz05x0WZQU6INSvc2zGDo6a5FwCDit26I06Y0w=;
        b=pCT6RDRBtAERSQU4hLyBkdQT+5RNLXXrj46dArX59BG/Gxbd15/YTZ02m9WUp/0iph
         l49eMuguvmWY53ikKACy0Er1zclWORBanY8FT0IlZlVFX2Jd9a+S21FQI+Z7eI3Y374j
         LZ2jp6CWVdXsAm71LLe2Rf0HAenf5UXltAY91EQNWwcp08zO7IogtgAun9x9u8gobgxs
         o+MC7es2MV/hpRvh9oTub8J9k6D/jGKvcntfBE/mYabwM7gyDNR+xEJ/7LG+xkL8pwU8
         nuBogUhOjZk38Z59+hlRdaXsURX/2ESwwViqz3rYOou90ybG9aZMVZnd2vyt+XPQs3NB
         n3MA==
X-Gm-Message-State: AOAM533GGxTUfZdIz50gN+X0Uz4AH2fPWbQXNlIAS80WVo6WZfrwHPnj
        4My3J3TZnbZX0q5885SIvlPxfowfMjy7E7AZDYSABQ==
X-Google-Smtp-Source: ABdhPJx4B2UpUOycKMsEaKR1oo34cgguixNwY1J0Kw2hQf+OlP3d246J3e01nM0ALz+GGLelTlqinnKpTdgxg1YmUVE=
X-Received: by 2002:a05:6870:2890:b0:d3:f439:2cbb with SMTP id
 gy16-20020a056870289000b000d3f4392cbbmr3008695oab.139.1645851239328; Fri, 25
 Feb 2022 20:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20220223062412.22334-1-chenyi.qiang@intel.com>
 <CALMp9eT50LjXYSwfWENjmfg=XxT4Bx3RzOYubKty8kr_APXCEw@mail.gmail.com>
 <88eb9a9a-fbe3-8e2c-02bd-4bdfc855b67f@intel.com> <6a839b88-392d-886d-836d-ca04cf700dce@intel.com>
 <7859e03f-10fa-dbc2-ed3c-5c09e62f9016@redhat.com> <bcc83b3d-31fe-949a-6bbf-4615bb982f0c@intel.com>
 <CALMp9eT1NRudtVqPuHU8Y8LpFYWZsAB_MnE2BAbg5NY0jR823w@mail.gmail.com>
In-Reply-To: <CALMp9eT1NRudtVqPuHU8Y8LpFYWZsAB_MnE2BAbg5NY0jR823w@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 25 Feb 2022 20:53:48 -0800
Message-ID: <CALMp9eS6cBDuax8O=woSdkNH2e2Y2EodE-7EfUTFfzBvCWCmcg@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: VMX: Enable Notify VM exit
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 8:25 PM Jim Mattson <jmattson@google.com> wrote:
>
> On Fri, Feb 25, 2022 at 8:07 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> >
> > On 2/25/2022 11:13 PM, Paolo Bonzini wrote:
> > > On 2/25/22 16:12, Xiaoyao Li wrote:
> > >>>>>
> > >>>>
> > >>>> I don't like the idea of making things up without notifying userspace
> > >>>> that this is fictional. How is my customer running nested VMs supposed
> > >>>> to know that L2 didn't actually shutdown, but L0 killed it because the
> > >>>> notify window was exceeded? If this information isn't reported to
> > >>>> userspace, I have no way of getting the information to the customer.
> > >>>
> > >>> Then, maybe a dedicated software define VM exit for it instead of
> > >>> reusing triple fault?
> > >>>
> > >>
> > >> Second thought, we can even just return Notify VM exit to L1 to tell
> > >> L2 causes Notify VM exit, even thought Notify VM exit is not exposed
> > >> to L1.
> > >
> > > That might cause NULL pointer dereferences or other nasty occurrences.
> >
> > IMO, a well written VMM (in L1) should handle it correctly.
> >
> > L0 KVM reports no Notify VM Exit support to L1, so L1 runs without
> > setting Notify VM exit. If a L2 causes notify_vm_exit with
> > invalid_vm_context, L0 just reflects it to L1. In L1's view, there is no
> > support of Notify VM Exit from VMX MSR capability. Following L1 handler
> > is possible:
> >
> > a)      if (notify_vm_exit available & notify_vm_exit enabled) {
> >                 handle in b)
> >         } else {
> >                 report unexpected vm exit reason to userspace;
> >         }
> >
> > b)      similar handler like we implement in KVM:
> >         if (!vm_context_invalid)
> >                 re-enter guest;
> >         else
> >                 report to userspace;
> >
> > c)      no Notify VM Exit related code (e.g. old KVM), it's treated as
> > unsupported exit reason
> >
> > As long as it belongs to any case above, I think L1 can handle it
> > correctly. Any nasty occurrence should be caused by incorrect handler in
> > L1 VMM, in my opinion.
>
> Please test some common hypervisors (e.g. ESXi and Hyper-V).

I took a look at KVM in Linux v4.9 (one of our more popular guests),
and it will not handle this case well:

        if (exit_reason < kvm_vmx_max_exit_handlers
            && kvm_vmx_exit_handlers[exit_reason])
                return kvm_vmx_exit_handlers[exit_reason](vcpu);
        else {
                WARN_ONCE(1, "vmx: unexpected exit reason 0x%x\n", exit_reason);
                kvm_queue_exception(vcpu, UD_VECTOR);
                return 1;
        }

At least there's an L1 kernel log message for the first unexpected
NOTIFY VM-exit, but after that, there is silence. Just a completely
inexplicable #UD in L2, assuming that L2 is resumable at this point.
