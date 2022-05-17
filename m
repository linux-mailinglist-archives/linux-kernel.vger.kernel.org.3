Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F73752AB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352296AbiEQSmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiEQSmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:42:44 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5CC28E04;
        Tue, 17 May 2022 11:42:43 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z139so1259224iof.8;
        Tue, 17 May 2022 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kh4EnLD5q25bV5mnKOfEKUkGgPpU5YAK0WJ01JIxNg4=;
        b=aUrMJiwv/pKGCIiR1FDh6ybW4X9ORE3GqTTU46RKMu/5qjgrJedBoy12P6roStHy+d
         UDkoTN0toafzpAhVeCVBaef5V88Nc5mlJNtf+347enG/JDAAcYlQUmX0buXocznHk5Ko
         jasUD1NLA/aFd66v+Hllo1XnExWtr7zC6s7H5i3HGDx8o8qwDH9VEMs1jfdpj4jw/5tf
         c/N1bFsySnbbP76od6uYB40iaMD9qPoNRKPUcfxEN6TAIBj1nX09xS58DzZvQeKS+i55
         rZ0ezrhe+BDDtQVGCvwcKG3PqWIDufzzV0gy5XihuCNMzywqD9n1CQYC5Mnv1Uq1CqHC
         0MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kh4EnLD5q25bV5mnKOfEKUkGgPpU5YAK0WJ01JIxNg4=;
        b=7AOnRciPniPIzk0sA1OKNklkZzXSsh4RDVVMxswWHklbSZ8HA+hCdHDoLxzDHRLrwE
         UxTgBuvPPS+3DHCpBmT3vjjjQpIe6voh/xFhGQIklcHenE3VENVZu2mhP9yvF/4x5C4Z
         QD7LQtiWQOJ4OA0vA/l+36bzOdJEO0UrZlaCe6qWqCFofIK3gOCMUmXFio7y6OLDM09o
         p0E//whQkAJlkqrC7tny3T5JpqxglwpFoHvSfOf0s3UyaTyQ40RSNGgCG/ZggHTl8heC
         erOXhzZD5+d+iXUSFXNaV1ZO0jRZxffbMaIcgYmapL36Bi61TXwpCC8uoXFyvnZ6+YgB
         nfCQ==
X-Gm-Message-State: AOAM531xL/mrHz9TjrovCePUmpnUFmrhSr5uG2mn3uZpa1IGDS4KD2j+
        L5MoQuy9XV6lysOsUfhe9NhKyGyKe83UChKhzro1hTqDJORUcQ==
X-Google-Smtp-Source: ABdhPJx2j+WLRuHx6rpO7Dl95/n6zjxwt0lx2dBVqcmN8p1lNQkuRQtrCf4t+2gbUw7UgAe8w7av6kvka5elU3LTjus=
X-Received: by 2002:a05:6602:490:b0:65d:cfc5:9221 with SMTP id
 y16-20020a056602049000b0065dcfc59221mr10786278iov.0.1652812962454; Tue, 17
 May 2022 11:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-2-linux.amoon@gmail.com>
 <6a6ed76a-50fa-2b05-896e-8936d3c3f597@linaro.org>
In-Reply-To: <6a6ed76a-50fa-2b05-896e-8936d3c3f597@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 May 2022 00:12:27 +0530
Message-ID: <CANAwSgTMwKhn6QDcoOXcSVgUqLGq1W6X4QvcSRHT-JSVfOe0rA@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] thermal: exynos: Enable core tmu hardware clk flag
 on exynos platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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

Hi Krzysztof,

On Sun, 15 May 2022 at 15:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2022 08:41, Anand Moon wrote:
> > Use clk_prepare_enable api to enable tmu internal hardware clock
> > flag on, use clk_disable_unprepare to disable the clock.
> >
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> Here as well you ignored my first comment:
> https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#mbfc57b40a7ed043dd4d4890bedb6bad8240058cd
>
> "This is not valid reason to do a change. What is clk_summary does not
> really matter. Your change has negative impact on power consumption as
> the clock stays enabled all the time. This is not what we want... so
> please explain it more - why you need the clock to be enabled all the
> time? What is broken (clk_summary is not broken in this case)?"
>
Ok, I fall short to understand the clock framework.

> This was not addressed, you just resent same code...
>
Thanks for the review comment.

Here is the Exynos4412 user manual I am referring to get a better
understanding of TMU drivers

[0] https://chasinglulu.github.io/downloads/SEC_Exynos4412_Users%20Manual_Ver.1.00.00.pdf

Exynos Thermal is controlled by CLK_SENSE field is toggled on/off by the TMU
for rising and falling temperatures which control the interrupt.

TMU monitors temperature variation in a chip by measuring on-chip temperature
and generates an interrupt to CPU when the temperature exceeds or goes
below pre-defined
threshold. Instead of using an interrupt generation scheme, CPU can
obtain on-chip
temperature information by reading the related register field, that
is, by using a polling scheme.

tmu clk control the CPU freq with various power management like DVFS and MFC
so this clk needs to be *enabled on*,
If we use clk_prepare_enable API  we enable the clk and the clk counters,

I check the call trace of the *clk_prepare_enable*
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/clk.h?h=v5.18-rc7#n945
it first calls *clk_prepare* and then *clk_enable* functions to
enable the clock and then the hardware flag gets enabled for the clock

I also check the call trace of the *clk_prepare* below
[2} https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk.c?h=v5.18-rc7#n943
it does not enable the clk explicitly but prepares the clock to be used.

"clk_prepare can be used instead of clk_enable to ungate a clk if the
operation may sleep.  One example is a clk which is accessed over I2c.  In
the complex case a clk ungate operation may require a fast and a slow part.
It is this reason that clk_prepare and clk_enable are not mutually
exclusive.  In fact clk_prepare must be called before clk_enable.
Returns 0 on success, -EERROR otherwise."

What it means is we still need to call *clk_enable* to enable clk in the drivers
and *clk_disable* to disable within the driver.

In exynos tmu driver uses many clk_enable and clk_disable
to toggle the clock which we can avoid if we used the switch to used
*clk_prepare_enable* function in the probe function.

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/samsung/exynos_tmu.c?h=v5.18-rc7#n259
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/samsung/exynos_tmu.c?h=v5.18-rc7#n350
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/samsung/exynos_tmu.c?h=v5.18-rc7#n653
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/samsung/exynos_tmu.c?h=v5.18-rc7#n731

Locally I remove these function calls of clk_enable/ clk_disable
function calls in the driver
with these changes, stress-tested did not find any lockup.

Please correct me if I am wrong.

>
> Best regards,
> Krzysztof

Thanks & Regards










-Anand
