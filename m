Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43645225DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiEJUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiEJUvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:51:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85891EC44
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:51:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l18so198037ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07qwqsAAhiC9sDvaZsU6xwGVxsO0fmMFnxDhX9hrYBA=;
        b=bqXRLwxylUn4QAcf4WHpGkbZGtJHF87z6qz1NC+vTFWJmCNkkb/VYX0RWoq8sNRCRs
         UhgsBkHviAYQ8jy97pu6wSjLK4fAIXU0Pa+u/ICOV+ZwOADrHfqFBTsAUszKFYQqSSUa
         IkDBuoDAeJuBBk/SUk4xe0ILEpih87FQ4lgDY3YSVBKnVzNRlIaaU3BhtYVVGjkguiOG
         tQsnZurrmX+urpmpiO6v3O1KIIMqAekjkwO0UvvakeUItH8Y3hbLVW2wXdXmYrVYu8Ir
         g1xoOLPgsAYc0iDaUx4jXtV/k3BA/pbzaTTkyn/w5yvgNH/Xwbb4NXEKF7I1xri7z1tA
         fJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07qwqsAAhiC9sDvaZsU6xwGVxsO0fmMFnxDhX9hrYBA=;
        b=MfvKX70Feo9QxKqF9RlJqRjtpajB5xtdierqOmXl9i0WllAA2kRnkVT//xcQHfzicH
         fvqrzRNbpjbCxJ5j0d6M96nKIlbUPa5N9IoH8GRgFZKwZMkDyWpANRWFqEluPDXquzUW
         +govPadH3D2If0SU76viUtIPEvtnyJniyjWdMzPe/31WuNK7D5FTTM3mgQNlTMv8yTBc
         OQfehbM2GH/QvRYy7Lvu+kCbCd9h2T0qIASVgKM+TApbSSWv78EG+Z+kHl3BrlO5ziKO
         Lbx16wcDJ7mrRcdh/A/f5DiwhTgbEtNd2SbRy/vI0HNtTxldlouEZR6jCZVe06Jv7sLJ
         jSaQ==
X-Gm-Message-State: AOAM5336ZogOCwkjtVco88rClfXFkiy8dey+72N80yynYqLxPewRL8c0
        OMldD2ATQBY9SBBfo1/Zy6Cn1NBybv7lnXZve+3/CQ==
X-Google-Smtp-Source: ABdhPJwhL/4CkSXVPA2XHHYCdllLQ6hwa5YKD0kcAt631RefW8hZez9vAB0UXDYjWTwqdd+KwKRFwK9YSASiuofY6Rg=
X-Received: by 2002:a17:906:44b:b0:6f8:d325:bb84 with SMTP id
 e11-20020a170906044b00b006f8d325bb84mr15188978eja.174.1652215866988; Tue, 10
 May 2022 13:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210323182520.2712101-1-bgeffon@google.com>
 <20210323182520.2712101-4-bgeffon@google.com> <9c0b4b2a-3678-186a-072a-280628e5da02@gmail.com>
 <CADyq12wc9=dt5V=YEr+U9JLP1VObG_UOsGaQUDH88WAZH-4Txg@mail.gmail.com>
In-Reply-To: <CADyq12wc9=dt5V=YEr+U9JLP1VObG_UOsGaQUDH88WAZH-4Txg@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 10 May 2022 16:50:31 -0400
Message-ID: <CADyq12yxbFB=XinWpkpJjNmoNPrXQS6mgy+aCYu8bd9hZQLakg@mail.gmail.com>
Subject: Re: [PATCH] mremap.2: MREMAP_DONTUNMAP to reflect to supported mappings
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 2:08 PM Brian Geffon <bgeffon@google.com> wrote:
>
> Hi Alex,
> It has not landed yet, it's currently in Andrew's mm tree. I can reach
> out again when it makes it into Linus' tree.
>
> Brian
>
>
> On Thu, Mar 25, 2021 at 2:34 PM Alejandro Colomar (man-pages)
> <alx.manpages@gmail.com> wrote:
> >
> > Hello Brian,
> >
> > Is this already merged in Linux?  I guess not, as I've seen a patch of
> > yous for the kernel, right?

Hi Alex,
This change has been in since 5.13 as commit
a4609387859f0281951f5e476d9f76d7fb9ab321, I apologize I forgot to
update you about the man page change after it landed.

Brian

> >
> > Thanks,
> >
> > Alex
> >
> > On 3/23/21 7:25 PM, Brian Geffon wrote:
> > > mremap(2) now supports MREMAP_DONTUNMAP with mapping types other
> > > than private anonymous.
> > >
> > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > ---
> > >   man2/mremap.2 | 13 ++-----------
> > >   1 file changed, 2 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/man2/mremap.2 b/man2/mremap.2
> > > index 3ed0c0c0a..72acbc111 100644
> > > --- a/man2/mremap.2
> > > +++ b/man2/mremap.2
> > > @@ -118,16 +118,6 @@ This flag, which must be used in conjunction with
> > >   remaps a mapping to a new address but does not unmap the mapping at
> > >   .IR old_address .
> > >   .IP
> > > -The
> > > -.B MREMAP_DONTUNMAP
> > > -flag can be used only with private anonymous mappings
> > > -(see the description of
> > > -.BR MAP_PRIVATE
> > > -and
> > > -.BR MAP_ANONYMOUS
> > > -in
> > > -.BR mmap (2)).
> > > -.IP
> > >   After completion,
> > >   any access to the range specified by
> > >   .IR old_address
> > > @@ -227,7 +217,8 @@ was specified, but one or more pages in the range specified by
> > >   .IR old_address
> > >   and
> > >   .IR old_size
> > > -were not private anonymous;
> > > +were part of a special mapping or the mapping is one that
> > > +does not support merging or expanding;
> > >   .IP *
> > >   .B MREMAP_DONTUNMAP
> > >   was specified and
> > >
> >
> > --
> > Alejandro Colomar
> > Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
> > http://www.alejandro-colomar.es/
