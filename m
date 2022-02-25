Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452464C502B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiBYUzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiBYUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:55:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9471D793D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:54:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a23so13117143eju.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uRsrBukF/OaHklKeUPxgxH16ty4e2SknPEAhNIbuzI=;
        b=Oj2UeHh27U1O4N7l5DBWuAtV67Ay3IpEleEp+o54d3CxEXDSMdqy6DaeA+FVZB28VP
         wIIn8hgELwuOTwz6hOaeVZtlebfiuq3gyTf4EaQ6Ptcgp36l3GNy4BKzj98oUPVXqbOH
         gElIpqL5novCm4oHdfP/9MAthJ3028EkXQoYQhUxfrXY0LYmRD4bIlikE4dSBajq45EX
         dVAVsJS2CRwsKGD6LJW4W2dl/l5Jh4mRy2v+obEo3Dwi1agtVRiunAVTbAg1P6EPHGZZ
         O+Bq6Nnjd3C4m0q/YAKHsgvk6yajs4u7OTkygvn5yYQB0CV3QVVbUQ5prDm2Lyoc50HM
         HAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uRsrBukF/OaHklKeUPxgxH16ty4e2SknPEAhNIbuzI=;
        b=Zcn3gVb4YFXvpnPugm6L8ZPPbjuxc+fMnnjSZA54YqMfbnEVk141E7nCoR9FHR4tOz
         vOqA8Jmk7fiBWeAoH87jom3dHZNiYU8QhZ6o1TyXew3El3eLMME27lV91cgcQQd7GD33
         hi/M5Oq5QdYHoP0naHYHxdF8XAjOfViznkM1ZwvebRhrCDfgrVn8ReYy2la1ieTs3cPD
         dMTqke/GinWnpjGGVuIDYmlbodIrY4KwAB0O1BdVi2CbtIvDSB+dvPz6n8t3NB6WkYAU
         yOuGV6V38gD8dkZj+/CX5H6ejChwXCjwg8X0iX08l8kN7bh6yRMLCkak3QCjOAyxsaVy
         rA4g==
X-Gm-Message-State: AOAM530OWNd92HefPCvJJnhrODkeJA2xhqCdtxcY8t9wQMWKwB8hk/c5
        Ov6OfsSA1brjPs/I83IY007l0RSl4jS68HAzWlGN
X-Google-Smtp-Source: ABdhPJy6ikiiG5Pgs8lsfgZefLhFTNca6qzZhUMHty1h0zpae8r/I4ovX2ynJs0741nV5ruzT5/eOwQ1CLGrCli+a3s=
X-Received: by 2002:a17:907:2a54:b0:6d5:879d:aca4 with SMTP id
 fe20-20020a1709072a5400b006d5879daca4mr7473197ejc.29.1645822497528; Fri, 25
 Feb 2022 12:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20220224102417.42268-1-richard_c_haines@btinternet.com>
 <CAHC9VhT4V=d8LtNT2mbiB6m1eUypi5WxPdRux_YNJ9iCV=WjWg@mail.gmail.com> <CAFqZXNtLw_c1V7MvQ=uVO9da1LH0dP64Vy3eEvL8Por_o6NQ5A@mail.gmail.com>
In-Reply-To: <CAFqZXNtLw_c1V7MvQ=uVO9da1LH0dP64Vy3eEvL8Por_o6NQ5A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Feb 2022 15:54:46 -0500
Message-ID: <CAHC9VhTW+zZQb6a2QE2iRYfyyUxjMphRYfSWt6bgp2JvodrTgQ@mail.gmail.com>
Subject: Re: [PATCH V3] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 5:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> (IMHO the POLICYDB_CAPABILITY_ prefix is ridiculously long for no
> reason and we should simply shorten it (just POLCAP_ would be
> perfectly fine, IMHO) instead of trying to abbreviate the rest. Of
> course, this doesn't have to be done now - I'm taking a note to myself
> to splice in such rename next time I add a new capability, if not
> earlier.)

Yeah, that prefix is probably longer than it needs to be.  Since we're
at -rc5 right now, with -rc6 just a few days away, I'll go ahead and
toss out a patch to shorten the names next week.  While I have very
mixed feelings on style/formatting-only patches, things like this
should go into selinux/next at the end of the -rcX cycle so as not to
cause unnecessary conflicts for people making "real" changes :)

-- 
paul-moore.com
