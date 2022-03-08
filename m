Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B754D1959
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbiCHNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiCHNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C877D48E78
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646746635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhWKpJMEu/E6K5E8FVFu8klaC4t/DVD3aQhe7Ihi7RE=;
        b=ZUaIlKEloW3slv0bFL5scqw+dxwczmTTIs2JtCxKgWglBD5MvAyYlwThBAHbBa7IPICb4s
        yMj/SMgLtAWgx2z76PIzwYVm0RLbqe15XqFJQJfHG/V7x2b/dwprmiOXILnWSXYnCaJifO
        44STAQyo2pgaShWFGapbJZ+69kZPvSc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-UymztCDiPim5lycHBcthUg-1; Tue, 08 Mar 2022 08:37:14 -0500
X-MC-Unique: UymztCDiPim5lycHBcthUg-1
Received: by mail-pf1-f200.google.com with SMTP id z194-20020a627ecb000000b004f6db380a59so6140456pfc.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 05:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhWKpJMEu/E6K5E8FVFu8klaC4t/DVD3aQhe7Ihi7RE=;
        b=2whWXKe0cqMDoSAG2Zr3hqgPK3rLwLryuKpb7yJrcuLut3mKNsbL1XykRuwTwdE+HX
         bFAEccJZpN8QP506BSsx+FWLDQRsvrWIc89YpdXQipl6dWBA3dxuVQmaqMA2X4/BsQPt
         MK/tiLZAMVUkMu9hjPvgzxt/c2lAtbo5/OuIKeFIpydygaancCB2zqFG8Yqet3fLOYx4
         IA31xQHnZP/ey+Kb3U0Ol9orTw/1GoQ+n/NeZ2p88GuKo8bSid90QbwVsgot7ezhBKFN
         tdBApkAduQkCFX7g5HNrmxO5zONgbp1cg0ayI/HtbZnCSSdas7b6GtjEjhkItmiM1d/j
         PAIw==
X-Gm-Message-State: AOAM532+72Qo2ME0dcOu6S+XS5hOgZMXPk9Y2eCCAxVNdDU+uHXyl6x2
        jGUWvsB1/8FCjdpNqTzxvPwm/S+ixkqQS2X+QEm6R2COB5gwf1ZszuuD7gSJlUEGlHIMlHuDuDC
        OQDCWWtjqCmRDfCCu47wDCrgdpJedaXaRqjTeMFsp
X-Received: by 2002:a17:902:c407:b0:151:f794:ac5e with SMTP id k7-20020a170902c40700b00151f794ac5emr6557651plk.67.1646746632903;
        Tue, 08 Mar 2022 05:37:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxH7lKjecmXh4BgOUsidbsUgZyvzcMgDU6mn0VwVrEex18NF//hg/FePuDpXYtu+/umBrPRyySRl1rvmLXpJR0=
X-Received: by 2002:a17:902:c407:b0:151:f794:ac5e with SMTP id
 k7-20020a170902c40700b00151f794ac5emr6557623plk.67.1646746632670; Tue, 08 Mar
 2022 05:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <CAPhsuW5APYjoZWKDkZ9CBZzaF0NfSQQ-OeZSJgDa=wB-5O+Wng@mail.gmail.com>
 <CAO-hwJJkhxDAhT_cwo=Tkx8_=B-MuS=_enByj1t6GEuXD9Lj5Q@mail.gmail.com> <CAPhsuW54ytOFrpW8+2kTuxNxu+-7JNmybCpbU=uG+un+-Xpw4A@mail.gmail.com>
In-Reply-To: <CAPhsuW54ytOFrpW8+2kTuxNxu+-7JNmybCpbU=uG+un+-Xpw4A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 8 Mar 2022 14:37:01 +0100
Message-ID: <CAO-hwJ+DO0cenO_vqG+85c=U5=W4Ksqfa+nqPEW7cqby=YDwmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/28] Introduce eBPF support for HID devices
To:     Song Liu <song@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 7:12 PM Song Liu <song@kernel.org> wrote:
>
> On Sat, Mar 5, 2022 at 2:23 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > > >
> > >
> > > The set looks good so far. I will review the rest later.
> > >
> > > [...]
> > >
> > > A quick note about how we organize these patches. Maybe we can
> > > merge some of these patches like:
> >
> > Just to be sure we are talking about the same thing: you mean squash
> > the patch together?
>
> Right, squash some patches together.
>
> >
> > >
> > > >   bpf: introduce hid program type
> > > >   bpf/hid: add a new attach type to change the report descriptor
> > > >   bpf/hid: add new BPF type to trigger commands from userspace
> > > I guess the three can merge into one.
> > >
> > > >   HID: hook up with bpf
> > > >   HID: allow to change the report descriptor from an eBPF program
> > > >   HID: bpf: compute only the required buffer size for the device
> > > >   HID: bpf: only call hid_bpf_raw_event() if a ctx is available
> > > I haven't read through all of them, but I guess they can probably merge
> > > as well.
> >
> > There are certainly patches that we could squash together (3 and 4
> > from this list into the previous ones), but I'd like to keep some sort
> > of granularity here to not have a patch bomb that gets harder to come
> > back later.
>
> Totally agreed with the granularity of patches. I am not a big fan of patch
> bombs either. :)
>
> I guess the problem I have with the current version is that I don't have a
> big picture of the design while reading through relatively big patches. A
> overview with the following information in the cover letter would be really
> help here:
>   1. How different types of programs are triggered (IRQ, user input, etc.);
>   2. What are the operations and/or outcomes of these programs;
>   3. How would programs of different types (or attach types) interact
>    with each other (via bpf maps? chaining?)
>   4. What's the new uapi;
>   5. New helpers and other logistics
>
> Sometimes, I find the changes to uapi are the key for me to understand the
> patches, and I would like to see one or two patches with all the UAPI
> changes (i.e. bpf_hid_attach_type). However, that may or may not apply to
> this set due to granularity concerns.
>
> Does this make sense?
>

It definitely does. And as I read that, I realized that if I manage to
get such a clear depiction of what HID-BPF is, it would certainly be a
good idea to paste that in a file into the Documentation directory as
well :)

I think you have a slightly better picture now with the exchanges we
are having on the individual patches, but I'll try to come out with
that description in the cover letter for v3.

Cheers,
Benjamin

