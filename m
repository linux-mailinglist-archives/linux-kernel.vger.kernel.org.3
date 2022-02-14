Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0105B4B50F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353852AbiBNNEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:04:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345980AbiBNNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:04:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6BA4D633
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:04:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 296F06145B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9194DC340F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644843839;
        bh=pPFYt0qEx7qdyQDiNyUwkwv8M2Ajh46wv9e1uerk2z0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U0J3hyKnUnz8jydCeRJWz8xjXZn3IUnnUIZNwvZhk0omfNOAGhxcsNrGYTxgsYCJh
         ab0zUzMp5J0TQp9JcOmrU5h9N6JmUb+Ut2caOEUh/XGTJvRS3tMgJXID7ymsOfo/3P
         i+ifM4vPOlXT7ycSZsgXFgBpkQAJ4HxEUuKjz63Fx/KzqZMVwI+RnA26yAut/TdPGI
         0P4G24p2nCV7C+sFKvBgqXjpv++NRDRjpbCsMLvX4e6CsNQX5kXpUJ8pSIaEr1vMBJ
         N3y5Cuf63KCZsf8HX8IDDe0NtjHJUlwr0R1zvG4GGXAEZxOnuOBZvTgsurd0+INOnL
         vLe3dkOPL4czw==
Received: by mail-yb1-f178.google.com with SMTP id j2so46010094ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:03:59 -0800 (PST)
X-Gm-Message-State: AOAM532hSGhF6UF+Xvx4+uagyBkcpcKyYDRsOaNA1sT02d3DV6PRm+lk
        RDfRPQV9KGRPF98oCFWfykter93a23OH6GWIvIc=
X-Google-Smtp-Source: ABdhPJy5OKBYHFGHmCbTsHFAY4E9BaO8xe92q5OllSXOHYhAk44zUaPPikn1VL0aPoCxTqf/yhgUs/tnxhdQRduYIG4=
X-Received: by 2002:a25:c483:: with SMTP id u125mr12242317ybf.302.1644843838711;
 Mon, 14 Feb 2022 05:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20220214081210.3999831-1-ogabbay@kernel.org> <20220214081210.3999831-2-ogabbay@kernel.org>
 <20220214103829.1319-1-hdanton@sina.com> <CAFCwf11CZ_DrhUdxO1PpX_v=2i8GS_Vzd4DrERdbtZm-_V+FrA@mail.gmail.com>
In-Reply-To: <CAFCwf11CZ_DrhUdxO1PpX_v=2i8GS_Vzd4DrERdbtZm-_V+FrA@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 14 Feb 2022 15:03:32 +0200
X-Gmail-Original-Message-ID: <CAFCwf10VGQV1TMHBSwH0gOQ_mzdTmtYqUbM7y8MgTN6Y1znUFA@mail.gmail.com>
Message-ID: <CAFCwf10VGQV1TMHBSwH0gOQ_mzdTmtYqUbM7y8MgTN6Y1znUFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] habanalabs: allow user to set allocation page size
To:     Hillf Danton <hdanton@sina.com>
Cc:     Ohad Sharabi <osharabi@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 3:02 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Mon, Feb 14, 2022 at 12:48 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Mon, 14 Feb 2022 10:12:10 +0200 Ohad Sharabi wrote:
> > >
> > >  struct hl_mem_in {
> > >       union {
> > > -             /* HL_MEM_OP_ALLOC- allocate device memory */
> > > +             /**
> > > +              * structure for device memory allocation (used with the HL_MEM_OP_ALLOC op)
> > > +              * @mem_size: memory size to allocate
> > > +              * @page_size: page size to use on allocation. when the value is 0 the default page
> > > +              *             size will be taken.
> > > +              */
> >
> > Nit, the 80-column-char format is prfered.
> Maybe it is preferred, but afaik it is now allowed to use 100-chars,
> and checkpatch no longer shouts about
> it, so I don't see the harm.
> >
> > Wonder how to get the available page sizes in userspace?
> We will add an opcode to our INFO ioctl to return the available page sizes.
> The user will need to query this at the beginning of the application run.
This will be in a separate patch.
Oded

>
>
> >
> > >               struct {
> > > -                     /* Size to alloc */
> > >                       __u64 mem_size;
> > > +                     __u64 page_size;
> > >               } alloc;
> > >
> > > -             /* HL_MEM_OP_FREE - free device memory */
> > > +             /**
> > > +              * structure for free-ing device memory (used with the HL_MEM_OP_FREE op)
> > > +              * @handle: handle returned from HL_MEM_OP_ALLOC
> >
> > Nit, add a seperate cleanup patch for changes with no link to page size.
> Yes, correct, I will split this up.
>
> Thanks,
> Oded
> >
> > > +              */
> > >               struct {
> > > -                     /* Handle returned from HL_MEM_OP_ALLOC */
> > >                       __u64 handle;
> > >               } free;
> > >
> > > -             /* HL_MEM_OP_MAP - map device memory */
> > > +             /**
> > > +              * structure for mapping device memory (used with the HL_MEM_OP_MAP op)
> > > +              * @hint_addr: requested virtual address of mapped memory.
> > > +              *             the driver will try to map the requested region to this hint
> > > +              *             address, as long as the address is valid and not already mapped.
> > > +              *             the user should check the returned address of the IOCTL to make
> > > +              *             sure he got the hint address.
> > > +              *             passing 0 here means that the driver will choose the address itself.
> > > +              * @handle: handle returned from HL_MEM_OP_ALLOC.
> > > +              */
> > >               struct {
> > > -                     /*
> > > -                      * Requested virtual address of mapped memory.
> > > -                      * The driver will try to map the requested region to
> > > -                      * this hint address, as long as the address is valid
> > > -                      * and not already mapped. The user should check the
> > > -                      * returned address of the IOCTL to make sure he got
> > > -                      * the hint address. Passing 0 here means that the
> > > -                      * driver will choose the address itself.
> > > -                      */
> > >                       __u64 hint_addr;
> > > -                     /* Handle returned from HL_MEM_OP_ALLOC */
> > >                       __u64 handle;
> > >               } map_device;
