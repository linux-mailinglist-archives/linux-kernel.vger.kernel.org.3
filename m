Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503124E4979
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiCVXGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiCVXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:06:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA96EB18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:05:03 -0700 (PDT)
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MkpvV-1nvzu63kbP-00mITJ for <linux-kernel@vger.kernel.org>; Wed, 23 Mar
 2022 00:05:01 +0100
Received: by mail-wr1-f46.google.com with SMTP id a1so24080667wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:05:01 -0700 (PDT)
X-Gm-Message-State: AOAM530/oeP0Hd4PAjFmd4oOHjT0zw/4U+PDCyVmzYc4TEmnUVdh2bbc
        4IzIil1k7kgVE7NPoB2R8jJUHL79Tr8O/y7Ps2s=
X-Google-Smtp-Source: ABdhPJzBDzTl6p1jDX1JhrS+PrHCT/fUw9VS2COZYGSn2eW/srG409F665qf4EdktUQdOcofFLP/MbHEsACSpCSvZaM=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr12992250wrg.219.1647990301568; Tue, 22
 Mar 2022 16:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220216183704.42084-1-nick.hawkins@hpe.com>
 <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
 <9FE3F625-39FC-4ED7-A2CC-567EF0181886@hpe.com> <CAK8P3a3sR98Ujk5AFA=F7aTWWEx93-Jjan1yXqaqaw-6x85NwQ@mail.gmail.com>
 <483082A1-A464-4D3D-B994-66B09E5D54B5@hpe.com> <CAK8P3a2n=yVfe+QiBvxAXw=5DmVY+Mjaag2s2fq+F=sQngos-Q@mail.gmail.com>
 <4CD3E272-3C69-441E-B4DE-7004701614EB@hpe.com>
In-Reply-To: <4CD3E272-3C69-441E-B4DE-7004701614EB@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Mar 2022 00:04:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3z8uT+0p55N_it3Mg-J08dn31S4rCLoXdK4eheyOR0Eg@mail.gmail.com>
Message-ID: <CAK8P3a3z8uT+0p55N_it3Mg-J08dn31S4rCLoXdK4eheyOR0Eg@mail.gmail.com>
Subject: Re: [PATCH] [v1] arch: arm: configs: gxp_defconfig
To:     "Verdun, Jean-Marie" <verdun@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:plEgxbT0guGaNov+9SiQMzIM7IFq5Xthlc7F8AyUCgedSgHe5x4
 bmnjLmdEf7ct2Zg0IuNrNuiLUxnMVDlmP39J19otetCVa9bRAH4VMwa+HWeELZdfcedGWiA
 HaW6fzkbXtLiIKVA93b08/+KMQQHl6EdQiWfX9vtRvPJnN1CTzL85RHLabzfSwYAqD7Mka9
 7Wa1wyxRrGL6zAlLT6tOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VHfGvt5DdYM=:lOJUpb6tNlQ9neqfPgR1c6
 OU7LmKHmp2+q7e3CS5j5P+NQ9cyS3Xt9wddsgsxyTQdoP2d1xdttJk9MHG9RoYE9nv1UFKc+P
 1C2LjUrPh0Y+YG9fdmjyKLxC8QK4Fn/S3TWwPvlcEue8Kd84po9B9D7LXaYedFsG6tzR8YDdQ
 KMG0x3z3kfJ3hMjpxb2b1tHrXOKZsIA8VVO4L0r6xQFM0w8odsloAhgRy4YNx/p0EKm+4VBWY
 +1fQhPQKbhEdB92oagqLZXreXcmu62IQ3uFxcBIJ7v1ELjkjp6wXM4wHWxo2OYLFztNrl8TQb
 vi4HExo9iCrxhUwzWc7A+q2y8dJgB8p8VFdASooHmdx9SW5PmIE3R8pEJ7EsCdpoiuSiC5M4F
 ajtdlqvLs7dUS6xKXNuc2D1kGcNj6gXokP0GJWdI1JV/KUC7dWFRo0zAJhDrpnQOVVG7OhXBv
 lafWlAlZQOKblJ643HXvt6m3FMY4xKaWdLkhVHOqXi1L9QP/4dwQdgcZRdJF8ArOD6Y8kKuk8
 wbYpbJdPN6EeO5yPyIeBalHeAx7fskVbBgLnqWC7pDtwRexHB+yltjwRLNPjIRlD0w8IuZ9ex
 EAJ7qgK3JC3Em+LliIe9LIeDNKKlWeN1sf7ln1+OIq8fPNf3XGoboHH7txA8ehNqn1Ez9CEPB
 gIDp1hcR9XjAV4fBa/EROig3b09YyHiqUaOxPZt3xjdQ13rBy8U7HSyMqH7ei2JgwrMw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:41 PM Verdun, Jean-Marie <verdun@hpe.com> wrote:

> I spent additional time to analyze the issue

Thank you for putting the work into the analysis!

> Would you accept a patch which is switching PERF_EVENTS=y to
> PERF_EVENTS=m into multi_v7_defconfig ?

Unfortunately that is not possible at the moment, as this is a 'bool'
option rather than
a 'tristate'. I don't know if it might be possible to change that, but
this is probably
done for a good reason.

> Then we could add our GXP definition into it like other chips are. This could also
> help other chip vendors affected by the same bug. I am pretty sure we are not the
> only one. Reducing defconfig file and relying on general purpose one per architecture
> revision make totally sense to me.

I think it should be possible to detect this erratum at runtime, especially now
that we understand what the hardware issue is.

We should probably add a CONFIG_ARM_ERRATA_764319 Kconfig
option that controls whether a workaround is enabled or not. One
way that I think this can be handled is to have a custom inline asm
for the trapping register CP14 accesses, using a __ex_table fixup,
similar to what we do for trapping user space memory access.

Another option would be to detect affected systems by the CPU
revision register or from some DT properties.

       Arnd
