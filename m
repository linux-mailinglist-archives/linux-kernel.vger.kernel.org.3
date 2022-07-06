Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9C569066
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiGFRN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiGFRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:13:54 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8121928B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:13:53 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10c0d96953fso8596647fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mxdgugHFm61QnWsTGvwXhJEDhQIxbzyKJe6gVnyZ9vs=;
        b=d0myfOqHKv7z4m9YAIJf5wvcr7uG8MYKd3NTDLI12QlwayakyRAxJl1j+8cMZ0sZ56
         201DIPhgtHGPMFW6Zii31tyyvcKDfufKxkB96/wFI9PgUInulMaV5u8y90T3MiVSbtc3
         q6YBu8YTzozuF3c4jq96gI53G0w8Ztr+ln43h4YOki/8ZW/vMOz6M8l3kIzFF4LEGAHC
         FaIfrP36jEjkuNiy6bc0PLqPvhSHqINcnNx5LcmNdEfOsM9MPvyvnHnS15/UPLxdz5/v
         WLEGdgwfJLpypek5LUOCo+KA+/uJD6tgVM4WNG1zrolkVzIMcMWSRSvk6SCBGjSlBc6q
         h1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mxdgugHFm61QnWsTGvwXhJEDhQIxbzyKJe6gVnyZ9vs=;
        b=7ePnWS2xKnhkGvsUBqeXLrhGWms85HFJFRIvq6XhRrgdONYCoL2a8Hhbo6cw+itGkO
         x6DYiuI0j3jRNzBx23L0RE2y2cMWvxV3CiEGYc8ROqDrwwtcNYr2mkcQs/ufiXLxZqSi
         3Gi+UgAApV1dBRJauwwGvA8URIqI+IIWggjtbsH3n/7RrIr7KqyRFyd75rbwowOA0+aZ
         8WiUbcgfMicXE4xxQKBlhD5cUykneD8AphGtaoP7eQRNWlMCgpP0by1Pg2kEjLAxGrX6
         EeRdA83UoEemkwmSxz4of+WUSNIYY3Af0h/Xsu19ClZANsB5MK+w4kuXJwYvC045kvNg
         DNIA==
X-Gm-Message-State: AJIora956Lw0XtZgeNZt1dCnQ8D4Q92GqiGjddIN54rrr1JSE6qOyX4D
        5nnHmyJ5LxL0/0CPkKvIHgUg0aygLtlDlQ/g+5IVJQ==
X-Google-Smtp-Source: AGRyM1tVbfE46GziKEYEaCleqGHTzwNTLP9yfhgC6SKrYqk9Hp5HcehwmoDJy1HL+Q47vh3/JDpQ/VIMf3qPM4wRlQY=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr26484802oab.112.1657127632275; Wed, 06
 Jul 2022 10:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com> <7e05e0befa13af05f1e5f0fd8658bc4e7bdf764f.camel@redhat.com>
 <CALMp9eSkdj=kwh=4WHPsWZ1mKr9+0VSB527D5CMEx+wpgEGjGw@mail.gmail.com> <cab59dcca8490cbedda3c7cf5f93e579b96a362e.camel@redhat.com>
In-Reply-To: <cab59dcca8490cbedda3c7cf5f93e579b96a362e.camel@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 6 Jul 2022 10:13:41 -0700
Message-ID: <CALMp9eT_C3tixwK_aZMd-0jQHBSsdrzhYvWk6ZrYkxcC8Pe=CQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] KVM: x86: Event/exception fixes and cleanups
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 6, 2022 at 4:55 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:

> 1. Since #SMI is higher priority than the #MTF, that means that unless du=
al monitor treatment is used,
>    and the dual monitor handler figures out that #MTF was pending and re-=
injects it when it
>    VMRESUME's the 'host', the MTF gets lost, and there is no way for a no=
rmal hypervisor to
>    do anything about it.
>
>    Or maybe pending MTF is saved to SMRAM somewhere.
>
>    In case you will say that I am inventing this again, I am saying now t=
hat the above is
>    just a guess.

This is covered in the SDM, volume 3, section 31.14.1: "Default
Treatment of SMI Delivery:"

The pseudocode above makes reference to the saving of VMX-critical
state. This state consists of the following:
(1) SS.DPL (the current privilege level); (2) RFLAGS.VM2; (3) the
state of blocking by STI and by MOV SS (see
Table 24-3 in Section 24.4.2); (4) the state of virtual-NMI blocking
(only if the processor is in VMX non-root oper-
ation and the =E2=80=9Cvirtual NMIs=E2=80=9D VM-execution control is 1); an=
d (5) an
indication of whether an MTF VM exit is pending
(see Section 25.5.2). These data may be saved internal to the
processor or in the VMCS region of the current
VMCS. Processors that do not support SMI recognition while there is
blocking by STI or by MOV SS need not save
the state of such blocking.

Saving VMX-critical state to SMRAM is not documented as an option.

> 2. For case 7, what about General Detect? Since to raise it, the CPU need=
s to decode the instruction
>    Its more natural to have it belong to case 9.

I think it actually belongs in case 10. The Intel table says,
"Fault-class Debug Exceptions (#DB due to instruction breakpoint),"
and I probably just blindly added "General Detect," because it is a
fault-class debug exception. You're right; the CPU has to decode the
instruction before it can deliver a #DB for general detect.
