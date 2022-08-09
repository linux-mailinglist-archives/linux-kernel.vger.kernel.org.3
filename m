Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC23258DCE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbiHIRLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244785AbiHIRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:11:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930524BEC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:11:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a8so12289527pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=LELeyjU2wcn4KWUM76Z5WghrJtriMPw8sOKX4EVWXeY=;
        b=Fh8bYYKpmmyzk0a71fpY04drz4M4AH1XN3cylscD4S+6uptKG2LRP8Dakm1jD9DETs
         MWwbirzue7gZOpW+fn8GO1qDTJhe4tx6AB5VsiXjXvGusNSlAAbqvOj3JZg/f/BYox/e
         0f1b81cePz5c0315ChPsbUnQZ7MQKskz5goF6x/xQOsMoAW8TIlqwTeGFBfyQEDlUP+6
         dQpzvfpjoudMFK3lxFgykZ5kJLjP/BKjfepCwqjCeoZVMn3L5wBVojQ4TZHAxU8co1WN
         Bb2XDu47UmUX0pijqXXjV8CMEt/QwQ2od9lg7rgHA5jWBqoZM8uLxzLMMWqGyylFllLC
         b/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=LELeyjU2wcn4KWUM76Z5WghrJtriMPw8sOKX4EVWXeY=;
        b=IZP0NDyhYBmpy8oTNpHiWxCJb2yQKn+2wCKgpHDgVhLRMFTJwpwg7kPI1BZPpbhmpR
         DdeUFxqcsvDtOI4SEVa9hMLf7dzJ5rQR6RqyLZ2h6z7cQmoowCnpRC6WLclcZNxp5Jqr
         mdAJMHg2Z3qQhlzmBXWeW2aM1b/VCJuXQYRMVf1Pkb60NFNxo0O8gmCkeUOs4yw8/bkO
         hc3SmrLgXsiYM3vpKOVCdXtl7QJFlji+UJyHWBVxYU7rpQXE+I/+43Aum/neY34dUtxf
         E7l/XuJP0fCXLA6qbIFZBSLol2KwgN8jmTHBmbzztqZuLdAIA+J1Q7ZpMAHEfyZIpz7c
         rE4w==
X-Gm-Message-State: ACgBeo3SH/MlEU3y1s+RZLovBG6jK2pKhUHvGer29YYhYM0OlTpIE9JX
        NFreDvK/DOj72gaPH6+Y6rLTofryEb5qC/jf7eo=
X-Google-Smtp-Source: AA6agR6V2aX2w1kWVO63b7s0FIwJoICLEpxmvG2FuyWXdznHPgHZ/2G+gpUVdP8m/prf/unM0ZrVPxk72j5hdcB4J2A=
X-Received: by 2002:a17:903:32c9:b0:171:2846:eef8 with SMTP id
 i9-20020a17090332c900b001712846eef8mr2880769plr.117.1660065104221; Tue, 09
 Aug 2022 10:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com>
In-Reply-To: <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 9 Aug 2022 10:11:31 -0700
Message-ID: <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     Rik van Riel <riel@fb.com>
Cc:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 11:35 AM Rik van Riel <riel@fb.com> wrote:
>
> On Mon, 2022-08-08 at 10:55 -0700, Yang Shi wrote:
> >
> > On Fri, Aug 5, 2022 at 12:52 PM Alex Zhu (Kernel) <alexlzhu@fb.com>
> > wrote:
> > >
> > > Sounds good, I=E2=80=99ll move this to debugfs then. Will follow up w=
ith
> > > the shrinker code
> > > in another patch. The shrinker relies on this scanning thread to
> > > figure out which
> > > THPs to reclaim.
> >
> > I'm wondering whether you could reuse the THP deferred split shrinker
> > or not. It is already memcg aware.
> >
> I'm not convinced that will buy much, since there is
> very little code duplication between the two.
>
> Merging the two might also bring about another bit of
> extra complexity, due to the deferred split shrinker
> wanting to shrink every single THP on its "to split"
> list, while for Alex's shrinker we probably want to
> split just one (or a few) THPs at a time, depending on
> memory pressure.

OK, it is hard to tell what it looks like now. But the THPs on the
deferred split list may be on the "low utilization split" list too?
IIUC the major difference is to replace zero-filled subpage to special
zero page, so you implemented another THP split function to handle it?

Anyway the code should answer the most questions.

>
