Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C4518BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiECSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiECSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:05:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002893E5FB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:01:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q23so24431980wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6I56eRd5y2rFRWielfkZ72wjiNM/15nuDK8Xp9LuUiA=;
        b=LeUrUBx3+db/PS5S8Zl9a/7ysiWTMWnx2IFEV8j1tYja232PRSz2YRlblgMUrGvB/W
         0FEWQG7JQEqqf/ukzbvoKaNlsNhncgc1BtQVUD+1EVyP7P5SieqGYzMQn04cDVxyGw3g
         NTIQmL4vdlbY7bOF8v88M79mO1iCIa2jQ+SNb04C7a5wJfuXZzZKLx12Sniyd1T9Hals
         Lu8e6Hh8NW0GTd+x6o8zjhxACENigwkDFGChAto5x4L98s3SfaMjOp8fskfcx8fN05QM
         HX+XQ73d20GyNcZ2qI08juIxFkkSmi3cVpfiqLfDoRGiq6CFuKdbNNODLmAlvFFtk3+p
         pUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6I56eRd5y2rFRWielfkZ72wjiNM/15nuDK8Xp9LuUiA=;
        b=uQhNbs3swBQzzDGdgRslYFufZtUKXDPA0M2KUzD/4Oi0CD92Kb9WNyQMzBHwSJw6BP
         lncEQxyjBRmaRF8BMTmL49QuaLmU72dgN93eC9ox7lrFxdke9ZdMvIbYxiaGTaLQNhSS
         gonGL6OZgxewtAJscvUd0oz2kjBJMVJ2qeyBy7x2Qum2cxQ+MBopsVZejVdR2x0GOCJE
         kz9yb6gmeO5uTht4bNruni7wdhkWEgJUMy6w1qdJ8pO1Z8hCcl0EX+DbOEQzvhTn2+Cl
         hKaSpVH4YzCAhOZLt4s1Vp88R0lptuW3BmD3PKrZv67LNeFe5S+rpWk9OgQHVEOB8xAw
         t2jQ==
X-Gm-Message-State: AOAM530X9+UsOmYAcGO7h01MLhjld+p3T6yueTUgiqswz5R7e2GFuoBK
        zfxIWchHx3D902Ae3oOqRRtH67P+/nUcvdrQ00Rk
X-Google-Smtp-Source: ABdhPJzOYaIKJriOfQ51PZIzy/4t+eFQw20nyazLGGtO0jsTxUXlAPL2qurCkEYSbki5xSMZuC2hUQuj5/QaNLkYRq4=
X-Received: by 2002:a5d:4e05:0:b0:20a:d4a6:32b1 with SMTP id
 p5-20020a5d4e05000000b0020ad4a632b1mr13335404wrt.174.1651600908421; Tue, 03
 May 2022 11:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220502134850.28372-1-cgzones@googlemail.com>
In-Reply-To: <20220502134850.28372-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:01:37 -0400
Message-ID: <CAHC9VhRkDsCR2gyVamYktvx_8LoPKox__YOv+-F4cYZjitCbdw@mail.gmail.com>
Subject: Re: [PATCH] selinux: resolve checkpatch errors
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 9:49 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Reported by checkpatch:
>
>     security/selinux/nlmsgtab.c
>     ---------------------------
>     ERROR: that open brace { should be on the previous line
>     #29: FILE: security/selinux/nlmsgtab.c:29:
>     +static const struct nlmsg_perm nlmsg_route_perms[] =3D
>     +{
>
>     ERROR: that open brace { should be on the previous line
>     #97: FILE: security/selinux/nlmsgtab.c:97:
>     +static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =3D
>     +{
>
>     ERROR: that open brace { should be on the previous line
>     #105: FILE: security/selinux/nlmsgtab.c:105:
>     +static const struct nlmsg_perm nlmsg_xfrm_perms[] =3D
>     +{
>
>     ERROR: that open brace { should be on the previous line
>     #134: FILE: security/selinux/nlmsgtab.c:134:
>     +static const struct nlmsg_perm nlmsg_audit_perms[] =3D
>     +{
>
>     security/selinux/ss/policydb.c
>     ------------------------------
>     ERROR: that open brace { should be on the previous line
>     #318: FILE: security/selinux/ss/policydb.c:318:
>     +static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *data=
p) =3D
>     +{
>
>     ERROR: that open brace { should be on the previous line
>     #674: FILE: security/selinux/ss/policydb.c:674:
>     +static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap)=
 =3D
>     +{
>
>     ERROR: that open brace { should be on the previous line
>     #1643: FILE: security/selinux/ss/policydb.c:1643:
>     +static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s,=
 void *fp) =3D
>     +{
>
>     ERROR: that open brace { should be on the previous line
>     #3246: FILE: security/selinux/ss/policydb.c:3246:
>     +                               void *datap) =3D
>     +{
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/initial_sid_to_string.h |  3 +--
>  security/selinux/nlmsgtab.c                      | 12 ++++--------
>  security/selinux/ss/policydb.c                   | 12 ++++--------
>  3 files changed, 9 insertions(+), 18 deletions(-)

I generally dislike checkpatch-only patches, but you've been fixing a
lot of other things so I'll go ahead and merge this into selinux/next.

--=20
paul-moore.com
