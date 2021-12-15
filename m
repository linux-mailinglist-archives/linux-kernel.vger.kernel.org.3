Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC174758FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhLOMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:41:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C63C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:41:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so75148460edu.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pa5P7TJTPoCcI6iCLMQS9O9zVLDm47/fvRV9xdvs9Gk=;
        b=kZwDtXK8NdFCbdiSQ62IKZJiYJUsIKUYlCJlBbmgkykwXRjfGnZU86rUx7f/8n4tyY
         N1Y6VQgyd5N70AHYTFH0CuKbITY0nHwJ1V4DXx30+HnXy7JgddzSWrksWaxzbAcAt5ss
         MyzVwCBnyv6gLHbo6WPFSnyZ8aBYQwBN+s80XJ2c2PkFFdgx23bTgSt4281ms4toLqrp
         2udw7QoXKg/lyon1/bHBSLDa/rESK62RSClfJkHeWGHl32mbhfM4ibHPP2qPP2vi2duP
         ytnAXCG9fypdJbH88CUXiSQ6I3CJyBtNEi2eGN4rKkuk+u7BHQ5Ktwv7RY1VpzxvBpZu
         IO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pa5P7TJTPoCcI6iCLMQS9O9zVLDm47/fvRV9xdvs9Gk=;
        b=iMnSuXOMJpXF/OPASKAYFHb7xdvLp8cJJbyjhLELoiWoJT29cAI+1JRUAgUzMamH7a
         L3dj6Iy+UNcUWNdFCvjIBNidfuRs83MymU7y19l3MZIlJWtfCDtX3BZYhbewrQSky0qc
         EIHrEufCqoiWBkIiswakdR7whCHZVyeBhM/YllB6vqQy5QmyWvqTbVErOx8XHTP4jlle
         x2NX3oWagM68v591wb0FkC+VJRwIlBUsovwRUDhQKlIz3Ick4Po0kBWLcq7m7WsSYP0e
         rZ3tp++tdilBUDXhV4KhVC419UnI0CGRQjGlsoWej/+xjkxh0hTChX4oUPWGUtS8wuUM
         4+Dg==
X-Gm-Message-State: AOAM530V3wYklwlcmihMtSxwvAyG609TUnrL0c82jg3p+eqi//+gzBar
        oijYJP79JY+YwAmrLYErm/vT8fzPaze5tAx0yV/xeHO6Lz52j+XH
X-Google-Smtp-Source: ABdhPJyqx50oqjtiQUFh6Za0gonG95YEHb7EWF3cYk2Vcnzwxdbz3gtLfbbRkCZaiY/HO3n7MW1Im7CTK5HmtEwCmpE=
X-Received: by 2002:a05:6402:14f:: with SMTP id s15mr14355960edu.118.1639572066575;
 Wed, 15 Dec 2021 04:41:06 -0800 (PST)
MIME-Version: 1.0
References: <1638619795-71451-1-git-send-email-wang.yong12@zte.com.cn>
 <Yax01zjuzmNyyJK/@balbir-desktop> <CAOH5QeDhjyjAkS1bUju2cv67KFukUr0ov8uG+z3bM6Oa=iFrMA@mail.gmail.com>
 <Ya7uQingLC3fMJlt@balbir-desktop> <CAOH5QeC+0xDrgO+t3zwN4o48F9Q2CiTnzQDO78kuJLfyNJwoLA@mail.gmail.com>
 <CAOH5QeCO_EZzkU=B3L1=1OPiZa7XxnWZK87GbwXNOQXxZqYcoQ@mail.gmail.com> <YbgwWir/Ymt/2gxE@balbir-desktop>
In-Reply-To: <YbgwWir/Ymt/2gxE@balbir-desktop>
From:   yong w <yongw.pur@gmail.com>
Date:   Wed, 15 Dec 2021 20:40:48 +0800
Message-ID: <CAOH5QeDqsiMgX4BB=yWOC02CMv2zHu472O45_8FUXvA3TBYfSw@mail.gmail.com>
Subject: Re: [PATCH v2 linux-next] delayacct: track delays from memory compact
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <bsingharora@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C 13:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 13, 2021 at 09:56:08PM +0800, yong w wrote:
> > Hello,  is this patch OK?
> >
> > Thanks.
> >
> > yong w <yongw.pur@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=B8=89 00:50=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Balbir Singh <bsingharora@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=BA=8C 13:16=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Sun, Dec 05, 2021 at 07:08:02PM +0800, yong w wrote:
> > > > > Balbir Singh <bsingharora@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=
=9C=885=E6=97=A5=E5=91=A8=E6=97=A5 16:17=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Sat, Dec 04, 2021 at 04:09:55AM -0800, yongw.pur@gmail.com w=
rote:
> > > > > > > From: wangyong <wang.yong12@zte.com.cn>
> > > > > > >
> > > > > > > Delay accounting does not track the delay of memory compact.
> > > > > > > When there is not enough free memory, tasks can spend
> > > > > > > a amount of their time waiting for compact.
> > > > > > >
> > > > > > > To get the impact of tasks in direct memory compact, measure
> > > > > > > the delay when allocating memory through memory compact.
> > > > > > >
> > > > > >
> > > > > > Should we call this DIRECT_COMPACT and through documentation
> > > > > > or name change imply that this won't work for kcompactd the
> > > > > > kernel thread - based on my reading of the patches.
> > > > > >
> > > > > Using DIRECT_COMPACT is a little redundant=EF=BC=8Cbecause the
> > > > > delayacct stats of delay accounting is specific to tasks, it has
> > > > > nothing to do with kcompactd, which is similar to the RECLAIM fie=
ld.
> > > > >
> > > >
> > > > What would we expect when we call delayacct -p <pidof kcompactd>
> > > > to be output?
> > > If the slow path of memory allocation is invoked in the kcompacd proc=
ess,
> > > there may be delays being recorded.
> > >
> > > > Don't feel to strongly, but it can be confusing that kcompactd
> > > > has spent no time in compact'ing? Not that delayacct is used for
> > > > kernel threads, but I am not sure if that use case exists today.
> > > Yes, delayacct does not restrict the process of obtaining information=
=EF=BC=8C
> > > but kcompactd is used for  compaction,  the compact delay of
> > > kcompatd is not actually a delay.Maybe it can be added to the
> > > document later to make it clearer.
> > >
> > > Thanks for your reply!
>
> Please avoid top posting, when you say added later, I presume more
> patches for documentation are coming. I am OK with the patch in that
> case.
>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>
> Balbir Singh

OK=EF=BC=8CThank you!
