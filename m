Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF72583A49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiG1IXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiG1IXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:23:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5953D62487
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:23:21 -0700 (PDT)
Received: from mail-ed1-f41.google.com ([209.85.208.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M7sM0-1oKqPd2tDW-0050zu for <linux-kernel@vger.kernel.org>; Thu, 28 Jul
 2022 10:23:19 +0200
Received: by mail-ed1-f41.google.com with SMTP id w5so1195313edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:23:19 -0700 (PDT)
X-Gm-Message-State: AJIora+tDIWWZy3m4dtN7tp8z5Ewx1i5MINyoMxjBN6NyykigIIhBUf5
        kubXUD4eCu95V0XL0pFJb/b0Wnf5JGKVOfMsHbU=
X-Google-Smtp-Source: AGRyM1sJuwUbmaCJfA40knbmqWZ6z0D1fCr71/zKh90EOApXVyeo6usVYaUQDdPyOAwkYssRbDuQTKlmtjb0qISTAEE=
X-Received: by 2002:a05:6402:26c2:b0:43b:e542:9f68 with SMTP id
 x2-20020a05640226c200b0043be5429f68mr23098858edd.227.1658996599300; Thu, 28
 Jul 2022 01:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com> <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
 <b39bf8c4-c702-8f49-12aa-d3ac05889b80@huawei.com>
In-Reply-To: <b39bf8c4-c702-8f49-12aa-d3ac05889b80@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Jul 2022 10:23:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0w+_MLOjJAKMENe6MYvBcXWXSir47Hz34WbtdEeAmaBw@mail.gmail.com>
Message-ID: <CAK8P3a0w+_MLOjJAKMENe6MYvBcXWXSir47Hz34WbtdEeAmaBw@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MFKyWuKq357W8a36FQwdz6/JBqPc86mUOWYp+SYvRHZNbxhjXcK
 O6gzMG+M5BWzm67CcP1B8dnYDl8UwdfZeiu1Ni8eWP2b+eUqH1iORHy92NK8+YOlGEoMhsi
 986Zc3We31VARBhisSaWZhzBrelaAHSaxg93wudUhEKMk8nVWuo6a6VzSmxFNKhsi4eSub6
 MvWj+F/5IgVZBf3Ff8kHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mh8BoqOWCOs=:BPnL2Uf0yb6K+IUPcc/kCd
 x3rZPCiJ31xxARV37GCTPeJ1C9/xOGuaMUViWQcGVh1aVuW7fLpn8Sx+hWfXOv09v+z2tEq+p
 8JFAmomI0hD8GVHyMgA7tx9BgtyGbBgdngT1TZXCFWuUG5vUiGx02ej7umEU385S/zrreQnYG
 e67VQkkaxeMaGW5Rxa67v/bCvXTCrVEx8O4KbQJQ73mFz31C6lpwXhcPyvCpv+DS9nFy9jVJB
 lJU/684ZsA+CcM2VrsaA3qhpRKz8G2H71lp3Xh3mgmdYhv7uWhMAA5yoSUvDHjHp9zzhdVDri
 g1qEkktG5MYmsjbAXKA9PlBn3ylQmnrLp1mD9Zm8QvmTvYeVmwxV37p9IzxaR/CV6EGbBTunK
 o6HL7Bgx1DVBkp7mkmK58ZTf4GC8cUWfHKNusPyInrY8qp0+GxdfNFqUqfrE9ompXR5FEj32b
 46sgOrER9RvMCPhQNQL7AI4xj+yp5n3MJ72ASqe91wZ9mDljJOB5CQ1EL2T20gVp1O5L/6B9Q
 W54B+/zWLe3xU58Qm4QntXWkjOmDZ2CDiziZ5UT4J7SBw2LvIT7RGi6Lri7dU9KI3dow5ScvK
 aqdqOc1FFLlN5kgQxWhDfQZV5F6YmegWfdZwHb/lBZYqtl6Qg488jr9RPpWqQmU5AlJ8Kxv70
 FJDkfFExI3zN2fJngtLDkHZnAk5cPpTuSx15uwWuvd6Payi0GGnb3pd3Kyl0mjq0UobZwOxid
 wiYveaHc8ZKiX9i4IfLW3LCZXoiRLE1kcJcX1kfS1ANimEeFdneCAPZqlH1z7RuJIsaC9zahT
 YLoYjdvbtue/aE5tKSfHya8X5ySFbr19xEy8+GpygY9W39hwKXcngVKlEZLvhtDGVp+gIPZDd
 fkSkFK23s9tSXNbJZNcQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 10:06 AM John Garry <john.garry@huawei.com> wrote:
>
> trim list

Adding a few other people for slimbus.

> On 25/07/2022 13:51, Arnd Bergmann wrote:
> >>> CONFIG_SLIMBUS=m
> >> Config 5bd773242f75 added a kconfig "imply" on config SLIMBUS from
> >> config SOUNDWIRE_QCOM, and this happens to mean that we don't explicitly
> >> require config SLIMBUS enabled in the defconfig.
> > That 'imply' looks like it was added to solve a problem using the old 'imply'
> > semantics that are not what this keyword does today. I suspect it's still
> > broken when CONFIG=SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m,
> > and the correct fix is to use a dependency like
> >
> >        depends on SLIMBUS || !SLIMBUS
> >
> > so the defconfig symbol should stay.
> >
>
> JFYI, building for CONFIG_SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m is ok.
> The driver has a runtime check for CONFIG_SLIMBUS in qcom_swrm_probe().
>
> That implementation seems consistent with guidance in
> kconfig-language.rst - so do you think that there is still a problem?

I see Vinod added the IS_REACHABLE() check, which makes it build, but
I think both the 'imply' and the IS_REACHABLE() are mistakes here, as they
are almost everywhere else.

From what I understand, the driver can actually use two different
back-ends, with slimbus being one of them. In the configuration
with CONFIG_SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m,
I think you can end up with a slimbus device being detected at
runtime, which gets passed to the built-in qcom driver, but that driver
then misdetects the bus because it is not linked against the
slimbus module. It then uses the incorrect code path, causing
unintended behavior.

The 'depends on SLIMBUS || !SLIMBUS' dependency would completely
avoid this issue and make the driver work correctly in each configuration.

        Arnd
