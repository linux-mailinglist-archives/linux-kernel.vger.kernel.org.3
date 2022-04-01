Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083874EE722
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244828AbiDAEZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiDAEZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:25:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4156721A5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:23:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so4236329pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qjcJFY+K3TS1eivpm/IZvtXBuodt+btawh7qCwUG148=;
        b=aLfcYTperTFQ/2tIbR+mHV20JN2Ns3yu+0srEpm/ziN5iNA3nwDh/0a63A7jV0YZD2
         RSIczCBgkTPHHw+nmH4qZCanrtegxWXh3L2ZbAUo9+Pwxn4VJ+0xGrtwE/98y8QArRz3
         MnHReWthknARksAttkLna0sBombylCuqXwVSP106ZPGjfuk36DtCNYSZxxaxrLIU/vvF
         qR86VCq6VIqAIDQ0eN5sqsr9+4Hiv5rZKnZwdECrNMv3hFrFfNRIGNvY8p+7BXN1ipAe
         bBZF6rm/yPLifumYjyvulSPNmIpHmGHg6+JSZluoG9sqOhrITKSJpicWb2GOtXLhukIA
         z/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qjcJFY+K3TS1eivpm/IZvtXBuodt+btawh7qCwUG148=;
        b=Q9oQv3CcIiwn+qadTX7UJ1Y6kBa6c4fkuVmSDukaT35SHq8HadJg5t1RXBtxI6YEs8
         Ubhnj+PEpYEnR0b3ZOLkRtOt6mnRl6UtwDdqjDjc6UG3MVRyaLHxpsZaOfc54aaZ5U0l
         waBRXr+hpT9T7CCCv1SNhy78fffS6cCpuOV0o4WQgizfTcbGQmmY7kOyzxwjPV/ZQfbP
         JSUat9moyCRMqa9cYdMNPlPue/CKzM1w6X6DZmCMOKIx6V9UruCoFHmh7omoUdxaLlqI
         XriHdFpPdOYGH+EhrLeyNnyr2l9JYY1F44t+y7du9sx7254Jo5Q0gHQM1zGc9nA9KY9F
         UQqw==
X-Gm-Message-State: AOAM533ZSZMGE2B5ObYrhmKuqbH4atsz/DB0XyMErqgfKoSIZHYcZJ3n
        xckKkkv8aABJdlMw8uyO5jaRR8evCEopYhZSbHF5VQ==
X-Google-Smtp-Source: ABdhPJw1KFriTS/qN+Hd7TLUXOZHnDPbK5zTZ/kCqb67xUFH865508OfPOxPU4nm0ucirJJvqXORmSyHyE+F91G1pWU=
X-Received: by 2002:a17:903:2cb:b0:14f:4fb6:2fb0 with SMTP id
 s11-20020a17090302cb00b0014f4fb62fb0mr43980317plk.172.1648787017568; Thu, 31
 Mar 2022 21:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org>
 <89B53D3A-FCC5-4107-8D49-81D5B9AE5172@linux.dev> <20220331063956.5uqnab64cqnmcwyr@google.com>
 <YkVcbElWjomA7ofF@dhcp22.suse.cz> <20220331181126.815cfe2b05b4281d32b7bf49@linux-foundation.org>
In-Reply-To: <20220331181126.815cfe2b05b4281d32b7bf49@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 31 Mar 2022 21:23:26 -0700
Message-ID: <CALvZod54A5mkqK3uLhy-ibQ0ioYhrARmJiFdh=2DWqcMuUt5cA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in memcg_reparent_list_lru_node()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Waiman Long <longman@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 6:11 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Thu, 31 Mar 2022 09:46:52 +0200 Michal Hocko <mhocko@suse.com> wrote:
>
> > On Thu 31-03-22 06:39:56, Shakeel Butt wrote:
> > > On Wed, Mar 30, 2022 at 07:48:45PM -0700, Roman Gushchin wrote:
> > > >
> > > >
> > > [...]
> > > >
> > > >
> > > > But honestly, I=E2=80=99d drop the original optimization together w=
ith
> > > > the fix, if only there is no _real world_ data on the problem and
> > > > the improvement. It seems like it has started as a nice simple
> > > > improvement, but the race makes it complex and probably not worth
> > > > the added complexity and fragility.
> > >
> > > I agree with dropping the original optimization as it is not really
> > > fixing an observed issue which may justify adding some complexity.
> >
> > Completely agreed. The patch as it is proposed is not really acceptable
> > IMHO and I have to say I am worried that this is not the first time we
> > are in a situation when a follow up fixes or unrelated patches are
> > growing in complexity to fit on top of a performance optimizations whic=
h
> > do not refer to any actual numbers.
>
> Yup.  I did this:
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm/list_lru.c: revert "mm/list_lru: optimize memcg_reparent_list=
_lru_node()"
>
> 405cc51fc1049c73 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
> has subtle races which are proving ugly to fix.  Revert the original
> optimization.  If quantitative testing indicates that we have a
> significant problem here then other implementations can be looked at.
>
> Fixes: 405cc51fc1049c73 ("mm/list_lru: optimize memcg_reparent_list_lru_n=
ode()")
> Cc: Waiman Long <longman@redhat.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
