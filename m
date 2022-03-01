Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F94C9168
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiCARWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiCARWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:22:54 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFF2DABD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:22:13 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 139so14910986pge.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmI3sf8/z6VNUU3GK/NGwjBSNbHziWiyj48Jpew7XtE=;
        b=C700QmEoBAgxezGfjxaTykOtQq9AzNdkKWgr6GfKkxBZjNHSkQx/Mizw9hkK8BEprw
         2eqMUBw9IOSfWY7ReSAarzzv99FflP1gmSxiiMPvvSO78RtzZrl1Urlfyv2b1BcYuazX
         HToJYqV/m/iPLvCPzfztlEG81/e7Jwl1jiw0XwjA6n9hAdjK6tYO+9hbqEvbTWfJxj28
         4L4xvaLLyKJmQcSzoM9NWe7AWVEKH+30FVJPlF4IbEF0SE0zbqS1eFSYgdUXhsunTQWI
         nG2w0993cECeAKZuwovO0PEMlYgbzcUz0N+ntOzD52NZimEQjjigU0rsEe69yk1GyI9s
         vtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmI3sf8/z6VNUU3GK/NGwjBSNbHziWiyj48Jpew7XtE=;
        b=dKPiQD0ItE7I/nkUsS+0/NCyXrzruqn9iTGAsaqE94NewwSEJ+D8/Opxrr26shojcF
         LT2QNTcBAGtcK31Fd7Xjch/Z/fQCZ9hPal4LmOELozDIouw8ZyjHfFBbGeJt4FxGf4XS
         3S+ebpwey62FPZH+Km92uhYh6HZalZwlvgsRkiIWhNntN311CvnxBLyCohWOMNa/Xasx
         UIVwlaoSnArzk30eK9K1YqXRwWAZmUncuAfCEPyNUdE8J7tx+BSUudzKsUJfSMjdAlUf
         oiNYBjEt+QLj+3HNmPmHLVF3mTy+5xkpAD/2lJU4z3Q7ZQKo5AMfFsRC87mJJtQBV9x9
         Ntag==
X-Gm-Message-State: AOAM533UPiuXkFhB0R05WOofTIeaqC26CuhX88W8uFu3T+orJsxLE2bl
        M11erPMMlspgrM4HeX/bAM6ro9+iLrwufVJmNu5Kbg==
X-Google-Smtp-Source: ABdhPJybeDiL39InkiZ7SRlRZFj7cyMX1L8QoV/jWQ3P2+kJGQ6zY14rMiTLgeiB9iu0H8NmbZm1Gh+gGvwDoEAuwZU=
X-Received: by 2002:a63:5148:0:b0:373:c8d7:f23f with SMTP id
 r8-20020a635148000000b00373c8d7f23fmr22407754pgl.509.1646155333223; Tue, 01
 Mar 2022 09:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20220224060148.4092228-1-shakeelb@google.com> <Yh5RiUMegXf92ivM@cmpxchg.org>
In-Reply-To: <Yh5RiUMegXf92ivM@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Mar 2022 09:22:02 -0800
Message-ID: <CALvZod4ZSrhGTNhEXc8JfT0r=v1tNBXsQc6Be-cOLi1UFzzoQQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer as well
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 9:02 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Feb 23, 2022 at 10:01:48PM -0800, Shakeel Butt wrote:
> > I have been contributing and reviewing to the memcg codebase for last
> > couple of years. So, making it official.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
>
> It's already been sent to Linux, but for the record
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks all.
