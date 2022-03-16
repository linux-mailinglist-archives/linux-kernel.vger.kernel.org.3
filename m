Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621114DB9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbiCPVI1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Mar 2022 17:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiCPVIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:08:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02125C4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:07:09 -0700 (PDT)
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M5jA2-1nRpxu1Qa2-007G7m for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022
 22:07:08 +0100
Received: by mail-wm1-f44.google.com with SMTP id h16so1500325wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:07:08 -0700 (PDT)
X-Gm-Message-State: AOAM533SSNMB2eGOqBzUvcwM8ajQ/+dYhUV9xjYel1d6uzK+dJ3wme4L
        tvitHMNyRxgR4dfY8yH2eXldqA2FuE8KhMvI40o=
X-Google-Smtp-Source: ABdhPJxVI0R9mGwWDi/y/5CEDvx0ePz2YtMrogMw/xC4RWcFdljmaEtN6zrV4tE/LFMrAHBl9c+q8jvjGis2JVg7Zjo=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr1276860wmj.20.1647464827976; Wed, 16
 Mar 2022 14:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220216183704.42084-1-nick.hawkins@hpe.com>
 <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
 <9FE3F625-39FC-4ED7-A2CC-567EF0181886@hpe.com> <CAK8P3a3sR98Ujk5AFA=F7aTWWEx93-Jjan1yXqaqaw-6x85NwQ@mail.gmail.com>
 <483082A1-A464-4D3D-B994-66B09E5D54B5@hpe.com>
In-Reply-To: <483082A1-A464-4D3D-B994-66B09E5D54B5@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Mar 2022 22:06:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2n=yVfe+QiBvxAXw=5DmVY+Mjaag2s2fq+F=sQngos-Q@mail.gmail.com>
Message-ID: <CAK8P3a2n=yVfe+QiBvxAXw=5DmVY+Mjaag2s2fq+F=sQngos-Q@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ZUHLZJpZPi3ISj1EYJWg/qNDuzG9gEyj7xeASSFOwIMSZK7Ddes
 M0s6tP/BOnKbxs4PBZUdsFE3XCMd1KOV8/81EDQ/vQoKI1bDvu9CwyiJe4DZMpzBmFec2g1
 upUd9Kmpd+aLtjxaeqs8IBevghsYEvf2N5DWsVEyFqbmaUDrKZCQPe9B0ulGSeAHjc1L78N
 IsnFChKtMcKfPNeUmfrGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GDTPPSjIQ8U=:2KavIP7K1POSLqSW/gPJgp
 ZNtf2G/bpGu6LFHbFdw0as95ga2CyOSF2Kuw7Z4bVIdPZ9yYN/yEVaEfjXhQqiZ0NRZ2zksY6
 myVYR+jzfZ0u+V4rAqM3Pij50sRyiQ1vVU/ycsexScBl2t/DewW9AQJIc6v1vbuHC9qxy97Jo
 ynDmoIOJlFPUb7fsADNsJHXXggJxNNqnCw8oRHsMVk9fOf7jtaWFG1qq325ZH+c62jXRd4Uzn
 zNufy1FdfZcm5UliMtC1PbRtDO5X7OhLfkqy77WTUI1LQGOKR7LdZaIXCw44xTcsgtvde2p9Z
 aHTiDs+ETyVGHZ15FLPAqH8L+2K8ZB9tL+jmfppZeoYsRBDpowM39VkcUmEaFkkLJ6VP4ghOZ
 F7dblD5V2pfFSrNqySZHYe9yff8+IHBNTDjv5WL5jtEXdtB50kYZHKmWSLsb55nCPu52o14QM
 cKjDRxIEodL9aWnrGMOcwRkMOJMYMoriYe5T1Mf7zQqU4F660lCw7L3S/QQs/YHIFGTegZLSI
 LmKwOwKiHw7VgYYtKU9+7YunlEe6VL2FoY4k8FlUu+VRi4UE2c2TywgFWYRNIfErEkWP8zA6r
 md5ZaeHb6OpwGh2HzJP15UkQHOB+wIa1CHn9nZF0iqVseB0u35EgMwOB/cIwz1GvG3IFdcLOT
 nfi+guMfGPBSxhoSVt1F7wKRry3r5f5Ns73wyqKgpECRoIMqiW04bU5nRcIahy9FHUzb7Iusg
 T33bCkftTBJVfXV+CjQz/s2m7852ICv+b9+gjiK+8jReUg+44JOhViLMNhMUJA5ygnp3PuRN1
 aZ8kgvuV5ESYzH4Fcpcnf7Ec7WPQs34SqQosBIiXZ+7YmWYTrQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 7:54 PM Verdun, Jean-Marie <verdun@hpe.com> wrote:
> >    If you get unknown instruction exceptions, that is clearly a bug that has to be
> >    fixed somewhere. Turning the options off should not be necessary, but we have
> >    to figure out why these crash, and make sure we have correct runtime detection
> >    in place that ensures that any driver code runs only on platforms that have the
> >    corresponding hardware.
>
> >    Do you have any more information about how and why these crash? My first
> >    guess would be that there is something in your DT that describes hardware
> >    that is not actually there. With a correct DTB file, the two options should
> >    not cause any code to run that wouldn't otherwise.
>
> I think I found part of the issue regarding the PERF_EVENTS. In ./arch/arm/kernel/hw_breakpoint.c, the function core_has_os_save_restore is calling the mrc p14 instruction to determine ARM_OSLSR_OSLM0 value. Unfortunately per the ARM Cortex A9 documentation that call is not implemented on such core
> ( https://developer.arm.com/documentation/ddi0388/i/debug/debug-register-summary )
>
> which is leading to an unknown instruction on our ASIC.
>
> Need to figuring out how to workaround that. I will check what ARM_DEBUG_ARCH_V7_ECP14 is supposed to support. We might have either a bug into the way we report the ASIC id or something is weird into the kernel which is assuming that Cortex A9 support this PMU access.

I'm not familiar with the hw_breakpoint.c code, but I can see that the
get_debug_arch()
and core_has_os_save_restore() functions are at least eight years old,
and Cortex-A9
is one of the most common CPU cores, so it would be unlikely that this
is a problem
with the CPU core in general. My best guess would be that your boot
loader code is
missing a bit of initialization that is required to put this into the
correct state.

      Arnd
