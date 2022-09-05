Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579B45AD5AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiIEPCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbiIEPCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:02:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F95157253;
        Mon,  5 Sep 2022 08:02:35 -0700 (PDT)
Received: from mail-ed1-f49.google.com ([209.85.208.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mgefy-1p1G3J21uO-00h5rL; Mon, 05 Sep 2022 17:02:33 +0200
Received: by mail-ed1-f49.google.com with SMTP id t5so11662723edc.11;
        Mon, 05 Sep 2022 08:02:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo1gEHJF8Cdr3N3kLjVbMtYYKFhIcIrDGcfsXCrn1Dxv2vqDVdbc
        0GnXxPuGjo5P2FO6P7KoLafvof7+SrDOYZX9UoM=
X-Google-Smtp-Source: AA6agR5Zpi8UpqH6e5skhgCwJSliabxHpg8kRwFUc3FUwRTjr0UFTrHJ0lZGEC7TB6VldfwUXSKuLqsvHQTI+S/PlwA=
X-Received: by 2002:a05:6402:35cf:b0:448:84a9:12cf with SMTP id
 z15-20020a05640235cf00b0044884a912cfmr30360818edc.51.1662390152956; Mon, 05
 Sep 2022 08:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220826125400.2199429-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220826125400.2199429-1-arnaud.pouliquen@foss.st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Sep 2022 17:02:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1_hSEODQ69LWgJCuFD=JDj4BxAiy3fsMFmMMKTwma1hg@mail.gmail.com>
Message-ID: <CAK8P3a1_hSEODQ69LWgJCuFD=JDj4BxAiy3fsMFmMMKTwma1hg@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4X4k7Dtow7g3eaJ0qxw5r2qgroSA+ahNxCcYezjypQgRphIRRPr
 hPZb/5+fPtOmxjVk9twkt/59wing3yvq1RE9wfKsfRLTXXX4knWx1ckl4F3ATR0EURGnpda
 ReVYqCl3sO5N3riBJhwfBn1O+/OFSWgKJXCiKIgyuBv2jXOfdK6qGWYzcm4XlddtHqUxgTY
 Dc+LfCG1TyfpHsPb02Q6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hPBQXxBeH7U=:W1s8yxF+dylamoAYmXjlAF
 gl7bRo1AkaEKsVB9J7Jl90GZ/gloOrBdty13pWw6aPlE0S6QHIO4CAuUzs94VQMrBk1RhBEBa
 2qKfZnheRlbB53yp0VHNAVQ9dl8LebE0050BBdHB3Go8r7xqgq6zCeVt0BNa8vTBPN9rN1IaO
 e2DoFP+OcagASZWzFIguV9yL+Kls0l+Z0F0sSMIQ64BHp3d/s97eM4buzpCnOJePyfe74X6E4
 ATsFYdMdiQMHXP0Fwlm102OenyMHW9SZ+ODGkpJYwhvYI2EQdWe6U6BWCmLV1Gw9AxEBcyALO
 0Km8en13fq9NL++vKMJxnz9Vp3JMToEQjowefjr1k96quGxfEusVlUdf898fwcmCS83/T2wxi
 2y/rAbJEzfc88b4HLav0hV6C9lauX2kWy4bgnhmpEgACkHDg/TW9siT1bHrJ0gQlBIOePcArZ
 SwzIQj3+V1vDiQvdOaI6saNYs8yJzGiAyP8r71lrwbxCaDFiGU6lpXYa7IA0mB0VGna1M7tgx
 +ZF3vwAMWCJVKAyZjrN37svOc6uvEm1c9vqm2CgBjVuf8XFOypTafQHlLaulLlw5578e9cfHt
 +7NBilG5mbKk9IJ+AWX0i+EjTmKrir9Cg/fe+yvqp5aQKZNoR+YoK9u5s/QarRI9yoenW1ubn
 TIB/hG6CJOKKi2q6RpPHa95mcWfN9Mgz4fQi+k7RN3idns9f4oP7f91i/wEE28r8X6ScZHClZ
 ufKcKd4Qnx5t2ZKJw6HNe6tWiAuHe0Bl0V0Yjo4ZzOWj8PP1QZobymjEWoP9SVvNSI3QgCZ6J
 qPjrPce
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 2:54 PM Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> This patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
>
> update from v3 [2]
> - resent after rebase on Linux kernel v6.0-rc2.
>
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> [2]https://lore.kernel.org/linux-arm-kernel/YpdutV3%2FjOsfPb5c@arm.com/t/
> ---


Applied to arm/defconfig, thanks!

      Arnd
