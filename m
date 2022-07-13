Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB538573F10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiGMVgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiGMVgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:36:51 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0102A266
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:36:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31c89111f23so126770157b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWB63dsRjVMLiI6k8qFmu5fPSbSPX3yFx1MpCLPsplc=;
        b=EDEl2+JJ8ZJz2gfKTa41oqiDbCoX/M7v9hXiGo3TCOOvsltDHVulVEezz5iZd/A9Bw
         /NaGm/I1nQ8ZJplBN4uln1tLXdrR4t8qPNqE84Ot35exgKkWFduhO5P0Xk27Yq4ovqAv
         NR+3DSKaAz7i5/3ypkQXy5VxMO7As4RiwqvUpV8uUNeDm4hC/dzb9IGPKOjHBf0o2tZ9
         Ml8M3PsccDBSLWBwhcOdRjNt11K/50bar3VEepDSvqGp6V61s13tNKxGeWdEzQ8iQxDP
         7tC18xP0QwxYPZkQa9Tk4PEclTb2OxUzf7uvdi4WuW54MLtX44HVjVysGsd71HhziK//
         Haeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWB63dsRjVMLiI6k8qFmu5fPSbSPX3yFx1MpCLPsplc=;
        b=zCpygt1b8AQ8D27f50s80sKhC+AmgOujrqSDO7VAfnMGYEGDm7zSJnnH95BCmEyPAk
         peE5Y2LgrdHSZkHxsyMC0Z7PnoI1tsumtNWrsVds82ThORIfAqRYOSozVYveg70VX7qg
         pADADnsxFoSDZFZlptbmWC2PeRfGWJ2lVD9plv4RUa0Ujy7WL5qRsYU1Np4Xh6c3o9ny
         ceEzHUO6Yzf/1Np/vN775jWxYWjlXb+OZSshBGqGeG8ZGxRQ6XoOMOh30wJSjj/JpSdc
         BzsLpTx9QPtbQlBjhWmzI5EjzsuiPD34E4fxbsCzO51DaBXnx7nDZYSEtbQ7lBHYJYW3
         ltUg==
X-Gm-Message-State: AJIora+/qTLaaJyR73C2czVErtpm06bQ7HebxOK66wAM7L+kK/g0vLQm
        URA0SxKh400jO0VHc3cH4GKJ+U5BVBXpZwLfzRs=
X-Google-Smtp-Source: AGRyM1sgQ9PXyOubPn9V8k34Wsc2PRu6NEBc1R5DcWdoaa9DCTE4fhIgYxZSbwv45hqcdg+gdjjp10PN5hXe0VPo4FM=
X-Received: by 2002:a0d:db50:0:b0:31d:83a4:cbba with SMTP id
 d77-20020a0ddb50000000b0031d83a4cbbamr6650997ywe.478.1657748209838; Wed, 13
 Jul 2022 14:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk> <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
In-Reply-To: <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 13 Jul 2022 22:36:13 +0100
Message-ID: <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 9:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 13, 2022 at 12:49 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > There may be a patch that solves that, but it's never been submitted to
> > my patch system:
> >
> > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
>
> That patch looks sane to me, but I guess Guenter would need to check

I still see the failure in my builds with this patch. But surprisingly
I dont see the build failure (with or without this patch) with gcc-12,
only with gcc-11.


-- 
Regards
Sudip
