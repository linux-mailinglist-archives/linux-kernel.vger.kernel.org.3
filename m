Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABE6523591
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbiEKOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbiEKOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:32:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B35AEF9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:32:11 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1qfu-1nmaSP1QVc-002CQH for <linux-kernel@vger.kernel.org>; Wed, 11 May
 2022 16:32:09 +0200
Received: by mail-yb1-f175.google.com with SMTP id i38so4307096ybj.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:32:09 -0700 (PDT)
X-Gm-Message-State: AOAM532P+RNLufug+EOuyGH0/0qb8/6NSaNmqDNdl1++Tw6Y5NFiTcLE
        UaODPs9KbYrlU5YZcnrp3etFSgPqKvDLmVrx0LE=
X-Google-Smtp-Source: ABdhPJxaOxs7Cvyz95djOd/9PFJGLZIvCztyvC00pvhe69fN5VCHZPMM6UvxixpNKUFijbzu95cTBJHGpgaLJNAHgSI=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr23401326ybx.472.1652279528106; Wed, 11
 May 2022 07:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220506192957.24889-1-nick.hawkins@hpe.com> <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com> <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
 <20220510141124.GB28104@willie-the-truck> <PH0PR84MB171830414ADC0DD69BD4116788C89@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1AG5RXW74LbskwMh1yJzXUjrzdL=iqaVz_7W2hExVuGw@mail.gmail.com> <YnvIGOpL06ZtbJgR@shell.armlinux.org.uk>
In-Reply-To: <YnvIGOpL06ZtbJgR@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 May 2022 16:31:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1GX=PgJU8UtH2u1yj0STFMv+9tr+pZBV4vvW+1iEQLDg@mail.gmail.com>
Message-ID: <CAK8P3a1GX=PgJU8UtH2u1yj0STFMv+9tr+pZBV4vvW+1iEQLDg@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Will Deacon <will@kernel.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8Salp2wJZj3Gzv6vVdggpn7TUtptCLsLTTuUDCj7r4icscZN/CS
 0qp90+/cRHHcx9ZSH4qlYdRBFf0slYJBcIfW/+/lP1Zh+gmR95umN1jgK42ETrm4e+QHWdi
 h/zUAvW5C1jLOVUUwbaZAmq5yjn2cSdm/nBfidGaXyHD7edbthX5v/KqStW7kB5vmVU3Dps
 xb7elaAFTwSilHoy989aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9k/ndWWP8ak=:rev2PVL3zuqftvezxHsYiG
 skDjXfF21sXd4EJbJwMuR5GT2LGNa9Gext7Mfw4A3nB5d8i0FCRJqpRQaQKJul8kqIW9vkwke
 mD4Kdk3ZjtUVtFzytKa/1+uge9rw9AZ7e+jp8tpik9bCUCMCdt1o3S9OqX3VfedWvYPSItotv
 JZYRvDdQwOhLcgez/AkITzoI6gsECR9w4bSFfI5tgO6z6eDXtGMYVA8C9/1o17b06yW6MKXmz
 8U5f6irrkkOaaXhborBwkpBa1QnD7hmp8TzSmAnjtImo8TyJWMVXexryl94lKfnRy7x8GWXfp
 bEQWV2BiHyltzkxyugpBviWawOYXtLTZw+9ZYLDsXBGXeH3MXn4aCm6XrHR17J9T0COF86wXM
 H/RzLer6OUXPSU1CysZcihijsJI/sZyR0YYgi1T0u9DGpuPLeC72iCSDWtLBVXfoTEDOGAojC
 XTzQ5fK99ZUDKpalf8pX97TIvw/BSx4twcVLtz9qIhc/eeBmwdxkxHKvYOq4J+ALgadpZXced
 oZKI+oXUawDKIU9/CIu9aq7M3auY49k2/uhIXSMDBw9128AFrdgE5BrtLkZDzedvoqCVcvHs/
 N2qoEo57wKxZ24oOZTVXvxEGbQUa+2yaVN39ggh9ObGeMcDYV2b0rXvXG8Qy0Vu1N+2ElYP6K
 bC5YpUE6H964R7QW/cAlnpBt6RvX5lUH9fPI3HD2WDmawWOP3LjI9eCBCt41NTzIbtmg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 4:28 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, May 11, 2022 at 02:45:27PM +0200, Arnd Bergmann wrote:
> > If it doesn't work, then there is no point trying. You could try
> > changing the exception handling so it searches the ex_table for
> > Undefined Instruction exceptions as well, but that's probably more
> > complicated.
>
> What's the point when we have the undef hook?

It seemed a little easier to follow the code flow if things are in
one place.

        Arnd
