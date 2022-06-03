Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AF53C67C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiFCHkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFCHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:40:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516BE37038
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:40:28 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVNF1-1oOqAI23Yl-00SNzi for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022
 09:40:25 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2f83983782fso74100997b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 00:40:25 -0700 (PDT)
X-Gm-Message-State: AOAM531h8sHen+Vl/NL7UDjQErgZPNtbZwCifTUPR2NsqDFvpuDm97nA
        RXwEDtjeO7DayTVk78GioMV5cJ0MONiK/i1h6bE=
X-Google-Smtp-Source: ABdhPJyoKcG7HwT0epHhqyR9k2OLyyQ8Z+fyvWxq+MyNtBds3sgzOpMUe6hXdU1GhLplGXey9+/vbRa+obzDhQ1F3gk=
X-Received: by 2002:a81:745:0:b0:30f:b172:9efb with SMTP id
 66-20020a810745000000b0030fb1729efbmr10200079ywh.495.1654242024298; Fri, 03
 Jun 2022 00:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYts-KH-R5EkBpz2u6H_Cx6YTXus1JKJS6yBxGhb0O2qQQ@mail.gmail.com>
In-Reply-To: <CA+G9fYts-KH-R5EkBpz2u6H_Cx6YTXus1JKJS6yBxGhb0O2qQQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Jun 2022 09:40:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3QKWxqGore3+_DJnWo7bJgvDhkZjtkyg5EUg4_D=mE2w@mail.gmail.com>
Message-ID: <CAK8P3a3QKWxqGore3+_DJnWo7bJgvDhkZjtkyg5EUg4_D=mE2w@mail.gmail.com>
Subject: Re: gcc-12: build errors: arch/arm64/kernel/setup.c:225:56: warning:
 array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8AYpfq2+TVDR1ig/fkiZrIyp5SLUEBKHEd4toZ7am6kHyYa9QLc
 mtsNAvoMcqWmbLthQJaVvGsKPK4IGpeR9gbjRJWZVFcap0lVF29dxpRFNvqh0FuncsBUbXN
 p0EiUMvGOeFH3OHQMGm3rRslOnPjOsm2GlZrXtD0nQ62NCsseiTAzlxsZS2FzzAMgDk5B9k
 i8DinwB3MrgL6zeVSUuXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dsq4n3VxSqk=:GHvPR8aZyB67I188P1eXqv
 uHIxMUYEJO2cIxCuWcKRdkYF1kX78HmL03kH7KDzEZgpEVXYqrxol/3P/bxty8IIeizoMvg4D
 ueQwgkvLPIO8jCWE8qf59ek2Z4lxuKD6o9FKikWPhJWxYfrNzHX/DwV8LraLrBKikKw/Rnj66
 HWEKJjNJYCcf8dGaNBETg6s4ZQHAI33qirHD+KX2P7bLXMtA3IJO6MBNfIooFIWT/0BlUuyav
 aCC9s58TTNWnb4r+EECLN4KD+RiFR9QnbZ1T+fsT23sixJDZtLYfi1BAHu+haVvTa5B0kkDaO
 x9q0JYfMczXHxXL0boXrytnaMe4Z8nVeQj420tOU11GHQGwYW6yMSuQ5AcsH6q82mDRSkX2Uk
 pUCX6VxvK38BKrpgt9eP8Y/JgZi+RGDw3VNaWI3Asz0yccN1aFuAq1m0zw1HbBZztpcR7uCYB
 mbjpO/Bc8EZgjqG5Kmo6j4YKkouTomiiaBuP8ICVOaPER7zwoE25/lsrM39SF3/dnG5OliSeT
 dPmwXXxVbe2dTlrE++xCKoKZx5AITyW2rUJF+MMfska0/BU3MHJJjAqIR3TMffEqDtQklbtID
 /GOHaCMW7zawhiCHj0VmVwmhK6nezt6bXyP/BfIxDr1x3JNG3Y6s/KeOIpuXFOUd/E2nDHRS5
 O4nW+JQIIc0UtYb+46EX13woXJt2MSbpBbKurWm78oRly69GFwjzer0eQc/yDRHt0MCTvYir1
 TVsUlVnnQC2KP9f/fHsCRDPZauXTKdJb0bEPIA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 4:03 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>     inlined from 'setup_arch' at arch/arm64/kernel/setup.c:350:2:
> arch/arm64/kernel/setup.c:225:56: warning: array subscript -1 is
> outside array bounds of 'char[]' [-Warray-bounds]
>   225 |         kernel_code.end     = __pa_symbol(__init_begin - 1);
>

Is this the only warning of this type that you get for arm64?

I think the easy fix would be to reword this line to

       kernel_code.end     = __pa_symbol(__init_begin) - 1;


        Arnd
