Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941604C6FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiB1Omr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiB1Omn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:42:43 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A507EDAC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:42:03 -0800 (PST)
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxVbb-1o8w5504iX-00xwMN for <linux-kernel@vger.kernel.org>; Mon, 28 Feb
 2022 15:42:02 +0100
Received: by mail-wm1-f47.google.com with SMTP id i188so146255wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:42:01 -0800 (PST)
X-Gm-Message-State: AOAM530v3mwmFi/aSb6QxCY/nOCOAD+Aitah42X0ljfUF9x2rQC/GeH1
        pvS4NIqAIu8nyjreoVAnQMub8z1Y/fRvEgxivWM=
X-Google-Smtp-Source: ABdhPJwk5L+QJI8Ubt5qFj7ABYks38P424wjdir/FSthOlrgADQbn1sfQhvydVSPUW/DGwF6B2NNpmzTkRAyHlnnUZ4=
X-Received: by 2002:a05:600c:154b:b0:381:8148:64d with SMTP id
 f11-20020a05600c154b00b003818148064dmr362035wmg.98.1646059321645; Mon, 28 Feb
 2022 06:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20220228120704.346bn5c56e53qylb@finless>
In-Reply-To: <20220228120704.346bn5c56e53qylb@finless>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Feb 2022 15:41:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1PW8afbjvsUNe2UHXBcQHxGXXPodYiK9AgfW-3tTQR0w@mail.gmail.com>
Message-ID: <CAK8P3a1PW8afbjvsUNe2UHXBcQHxGXXPodYiK9AgfW-3tTQR0w@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] TI K3 defconfig updates for v5.18
To:     Nishanth Menon <nm@ti.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TrLUOGzNhBzBKFvqumwl+h6IlkyXEVJqYwhZwWUEbNxjqp9TSyp
 ND756lm6oSWI2HJKs3AtwKuJi/0iZaedZDLknLbqrRm2QEsRqHVTC4rVJK1vEgV3ZT23+pC
 X+6wpvPnQgmY+/sOz+KtbP0mMp+rV+XPBjugB+QvCn74UJo4R+VHwWBRenW+zQNCA2IzKAw
 lH9mV+ZocdoVxHoGJ046A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y2ALICaAX3U=:AL9ML3wk/0bbQnXU3t445e
 Q/ICx4l+343B51Bv6ZZNsLFhrVmWVc/MHzQFoOFeM/0kafOxO+CQkaQOMYSbKX+iMfGRRlY8a
 AqNqGphdNw4hAXzgvFMEQGFU8rX56EVZsAm6kKMAFq51AdkZAgi0VLJ/PaSFA1OkS2vXgAJhu
 51f7xSUrOEExyvOOzETDkQRzGxFlX1kJDYGYQvsayw0BdWSa4QkwJTqeNME8RGOaDsZ/gqjo9
 FzwqxgVIxlgYvgQ0RHIHV8Z+TyUoZV4XjYQpeIaRZeQfrP2sViu4p4Ztnt/GUzoQXmadiy9mV
 zP5ej8CAlGFPAP9FnVLg7ubWIAW5Nsma3HjBxPpUxPEdybBsKfY6Tt9qBbOFHw9AdMG6LQ2u7
 tK/d42ssa+Jq6pIlN8Viqa7RY4fS7cPZh1dqzVcs6RDpE5g+IqjRqJ3KQWEujcrK/w8CoKdTU
 DRqeHXyw23pJx3E1KyMq/Nd0oesd0M2uJzWNVWmWDepuoEgt+keeJOrzeFSaMnG9wZv7vTB7v
 OZGiwt4mpA5f0Jl661n5Q72ZQYXEUapheDAIsMURxr/Te6UC77wSFDL7vh8YUlxiH9G642Otc
 cr82vQWnCPeaRgK0UoBT4DfsrY0vcW6i7gJix5E2o626iPnqqA49W7KYs/eyvktOBUjCqt2fd
 DdgbCOkzxhA+ghAz24Wwx4RZtqnDZ5PEI89aXqJ0ENYnhQth4SeYlzyOQb6XwIddTi5c=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 1:07 PM Nishanth Menon <nm@ti.com> wrote:
>
> Hi ARM SoC maintainers,
>
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
>
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-config-for-v5.18
>
> for you to fetch changes up to 3bc04fba357a269f4b7ff824b146d82ad1ebf9de:
>
>   arm64: defconfig: Enable USB controller drivers for TI K3 SoC (2022-01-24 13:40:42 -0600)
>
> ----------------------------------------------------------------
> TI K3 defconfig updates for v5.18
>
> * Enable USB modules

It looks like I had this one applied already from the 5.17 submissions. My plan
was to drop it all, but it looks like I made a minor mistake here. As
the contents
are identical, I'll just keep the old version.

        Arnd
