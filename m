Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A0754B832
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiFNR7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiFNR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:59:38 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D029CAF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:59:36 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31332df12a6so37974137b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26g0MRBcct9YNTtppVTH2VrL+ERGht+b/7zwiSemUyA=;
        b=J/nOyu12o+bRB6Fge5isqT7wonLs+xdaSOYk2ZzUXUfdYO+tT/NdTBYHgwhpGYQ2OZ
         RPmye6epdqPtaw2Nbws6asqaYf+6aVxIqXDMZqxjNbzCQ3zwB1L5G/BhpEzxNla/VIO8
         cDStVQFFwJb6UTJpX5S+LIugBTOAwh6cGWRiIgHiZi3tWxT7rMU+TWdd2QMU7ovh8PNx
         gwaIT5F7fFUR2oLX1CsaFR9TrEfJFASZUCVW8i9DhsF3f8y+wbxkjn4QyC9i8LNrGM93
         gQQlBK9AywuTU1ofkcSnNRSmzJuv/FDzyMjYLJrFjuFY9oaCAxFePfAUwZONNTzqOrtA
         C31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26g0MRBcct9YNTtppVTH2VrL+ERGht+b/7zwiSemUyA=;
        b=O6j3fbG6jZOTsRaliUVpzua3588HKXp5Zgxtx0vK+zcc1bgvji6xEWr6ywsG8k00M6
         yGEXCjl/E6zJiOrIV1SsolHtxSl7dQdn9N6eG4EHURJQvdePWVZH2hJqiyasXvC3hJ0O
         8/mGmQyPH301HR+rBS1GifArp4MR01mBawL9QshOkogcauJ/hz8i9xThGo58xsSr2ygE
         moLGtmKH+D8mtCB1OvmDJCHB9mgU1pbgOuwMo//VBBzOPRv5J1A1gJ9B7PRgEJCcKR1C
         z5crS1GEpNqq3Myh4SYZOqZ4UMqeMVwEWiHaMKs/J68ip7fQ0lsUm3bhEoMxt4/L7oCX
         14cA==
X-Gm-Message-State: AJIora8mWJ+1GlVE1rMOSOsDptKH71Ykhu+zqZnz/75PhIB7nhY5nsM7
        0/nVtxJeNtSn0jCik3TTNFCQ72/iWkEzAVyTBbaDfA==
X-Google-Smtp-Source: AGRyM1uYZTCyS6ekVxMN4LE950ueaI6pIZQPKcwQF0t97ENb1ZzjK0WrhozZcmpCzb6Uo04yXOpLPQ3F6GVqXwU6Q74=
X-Received: by 2002:a81:2f84:0:b0:314:2bfd:bf1f with SMTP id
 v126-20020a812f84000000b003142bfdbf1fmr7094481ywv.320.1655229576055; Tue, 14
 Jun 2022 10:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220525081416.3306043-10-sudeep.holla@arm.com>
 <20220525081416.3306043-11-sudeep.holla@arm.com> <20220525081416.3306043-12-sudeep.holla@arm.com>
 <20220525081416.3306043-13-sudeep.holla@arm.com> <20220525081416.3306043-14-sudeep.holla@arm.com>
 <20220525081416.3306043-15-sudeep.holla@arm.com> <20220525081416.3306043-16-sudeep.holla@arm.com>
 <947470ba-35fc-3c72-d01b-c0a7337216a2@arm.com> <20220606102159.dduxmvq4m2fm6gks@bogus>
 <CAKfTPtB8iPzEXipsJqNtd9-aJMKx-FAaiGMzOg58HgRQuo39iA@mail.gmail.com> <20220610102753.virkx47uyfsojol6@bogus>
In-Reply-To: <20220610102753.virkx47uyfsojol6@bogus>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Jun 2022 19:59:23 +0200
Message-ID: <CAKfTPtD==UMjbSGHvKxT_z=LyvsJt=UCHsqkbgVnagbn5Aqpcw@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 at 12:27, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Jun 10, 2022 at 12:08:44PM +0200, Vincent Guittot wrote:
> > On Mon, 6 Jun 2022 at 12:22, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
>
> [...]
>
> > > Why ? Are you suggesting that we shouldn't present the hardware cluster
> > > to the topology because of the above reason ? If so, sorry that is not a
> > > valid reason. We could add login to return NULL or appropriate value
> > > needed in cpu_clustergroup_mask id it matches MC level mask if we can't
> > > deal that in generic scheduler code. But the topology code can't be
> > > compromised for that reason as it is user visible.
> >
> > I tend to agree with Dietmar. The legacy use of cluster node in DT
> > refers to the dynamiQ or legacy b.L cluster which is also aligned to
> > the LLC and the MC scheduling level. The new cluster level that has
> > been introduced recently does not target this level but some
> > intermediate levels either inside like for the kupeng920 or the v9
> > complex or outside like for the ampere altra. So I would say that
> > there is one cluster node level in DT that refers to the same MC/LLC
> > level and only an additional child/parent cluster node should be used
> > to fill the clustergroup_mask.
> >
>
> Again I completely disagree. Let us look at the problems separately.
> The hardware topology that some of the tools like lscpu and lstopo expects
> what the hardware looks like and not the scheduler's view of the hardware.
> So the topology masks that gets exposed to the user-space needs fixing
> even today. I have reports from various tooling people about the same.
> E.g. Juno getting exposed as dual socket system is utter non-sense.
>
> Yes scheduler uses most of the topology masks as is but that is not a must.
> There are these *group_mask functions that can implement what scheduler
> needs to be fed.
>
> I am not sure why the 2 issues are getting mixed up and that is the main
> reason why I jumped into this to make sure the topology masks are
> not tampered based on the way it needs to be used for scheduler.
>
> Both ACPI and DT on a platform must present exact same hardware topology
> to the user-space, there is no space for argument there.

But that's exactly my point there:
ACPI doesn't show the dynamiQ level anywhere but only the llc which
are the same and your patch makes the dynamiQ level visible for DT in
addition to llc

>
> > IIUC, we don't describe the dynamiQ level in ACPI which  uses cache
> > topology instead to define cpu_coregroup_mask whereas DT described the
> > dynamiQ instead of using cache topology. If you use cache topology
> > now, then you should skip the dynamiQ
> >
>
> Yes, unless someone can work out a binding to represent that and convince
> DT maintainers ;).
>
> > Finally, even if CLS and MC have the same scheduling behavior for now,
> > they might ends up with different scheduling properties which would
> > mean that replacing MC level by CLS one for current SoC would become
> > wrong
> >
>
> Again as I mentioned to Dietmar, that is something we can and must deal with
> in those *group_mask and not expect topology mask to be altered to meet
> CLS/MC or whatever sched domains needs. Sorry, that is my strong opinion
> as the topology is already user-space visible and (tooling) people are
> complaining that DT systems are broken and doesn't match ACPI systems.

again, your proposal doesn't help here because the DT will show a
level that doesn't appears in ACPI

>
> So unless someone gives me non-scheduler and topology specific reasons
> to change that, sorry but my opinion on this matter is not going to change ;).
>
> You will get this view of topology, find a way to manage with all those
> *group_mask functions. By the way it is already handled for ACPI systems,

AFAICT, no it's not, the cluster described in ACPI is not the dynamiQ
level that you make now visible to DT

> so if you are not happy with that, then that needs fixing as this change
> set just aligns the behaviour on similar ACPI system. So the Juno example
> is incorrect for the reason that the behaviour of scheduler there is different
> with DT and ACPI.
>
> --
> Regards,
> Sudeep
