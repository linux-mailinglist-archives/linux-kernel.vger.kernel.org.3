Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4844788D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhLQK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:29:08 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhLQK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:29:02 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3DBd-1mv9H70c1t-003cnj; Fri, 17 Dec 2021 11:29:00 +0100
Received: by mail-wm1-f50.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so1275980wmc.2;
        Fri, 17 Dec 2021 02:28:59 -0800 (PST)
X-Gm-Message-State: AOAM530TIWsOjX56L5p48423QNaanac0qxcA9nMJBgwtpgl1S2w4O6L5
        dMonB9WfKEi4m4IpWug4Q3eDoYD3Zjvmh6/+d1c=
X-Google-Smtp-Source: ABdhPJzt5zYuPDN2kyerQhSiMM2qDbHR33/fmfF5ts41gKt3J8mLkHRysVIEdlJk2pNUlh3mDSd/3MBFVv8V8UNy0j0=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr2096113wmn.98.1639736939561;
 Fri, 17 Dec 2021 02:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
 <CAK8P3a29tzgd_4WncippZBEJra9n0bQTysBkPBp_WA0sb28gTg@mail.gmail.com>
 <1360c4fe-4a09-a8a1-3224-7f1d4af59f6f@benettiengineering.com>
 <CAK8P3a1oZK1qMRBE3D8otCTY6Lg4jMXxVpAZHQzLTA8woA3_UQ@mail.gmail.com> <634e9304-2eba-4ea9-65ac-5d4f5d011b70@benettiengineering.com>
In-Reply-To: <634e9304-2eba-4ea9-65ac-5d4f5d011b70@benettiengineering.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Dec 2021 11:28:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3kpzi6ozLkTH9GtWqvs=JHkm6mp=dLs2vOHjrW=FoYdw@mail.gmail.com>
Message-ID: <CAK8P3a3kpzi6ozLkTH9GtWqvs=JHkm6mp=dLs2vOHjrW=FoYdw@mail.gmail.com>
Subject: Re: [RESEND in plain-test] Re: [PATCH v5 0/9] Add initial support for
 the i.MXRTxxxx SoC family starting from i.IMXRT1050 SoC.
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jesse Taube <mr.bossman075@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WK5VepgWAxnURy8YRejIh8hTkw5BVDQTSGj/3hPn3SfcZcCrTNG
 lyrjT7Khp69AhFY2gmWBqy8B7mI0u376qu/e8G+ii1vIN8sgfc/1+L3rjj94EI3UnaG0z57
 RO+Pq9Xqvyn/wjbT7TA9Te2G/+YJro8CWVtmzVrYJxaS1Z5N6psweEF9CjLox9uW8fNy32M
 GbCTb7+MTwkGrVS+vq8ww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lLY2FP303Ug=:MZPZYIsXwYO/ZM4ROB9bVL
 ek+5PS1T7DfV9tiQ87KICIi9k6x4nuPH98rqb0m7oJUEJWrPLc2ez8ADmiMGAyYwyC8pv1AAy
 xya0TCnN5uypyLGXuGqcxBeQcKTGk1FHhTaiW5o7ohDxUPljwJ/lnLJk1XlfmaFbJ+ffXmz3X
 n8KrmA2dUCShP1GgdHOZVG/09ZNaTw7t3VcQws87+YsdmR6tMyfOS0B4iMv2h0HqqdKg6EpNr
 4C4VpPGy5Z1sc1fTDgaFrb+tfiFu88DMyb3gv0EU/6MpzBfBSa9RUQupHb4llGvYJL6sqQsIw
 M5bODNoegAojZzX9YZxk4DqT19BmGrsGEsvvp9EgOU4rd3+mq5etrOVaPre9w6YkJEuG9oSRP
 U9F+WsDgBJNkfoolfjYhu5Jz3Jim8au0jpykcloY6yE7iLL+CQ2H7Z27p1OyJidBRmZB1Yunn
 wDlOCeCCDsKpMisu6DMCIfzT+vwyA5+fyJ9RGWXOH0oSy4ar0+IawfV80JEMp7mjOvQu+eNir
 oO3OiwkaTYaDkPZ7muehPSYq0Po6AcHR4fA3H69wKOaIbq058nkE6Fi49b0d/cLymY/q6cfVV
 4mzsltuA093tdpFohN4LP9Rk3Jb1Bq2lN1LdApMefoWcniNQDghB3pZ5J8XIXWUqRs2N7PX5o
 CWJ1F1IGni4qppXt7S1SD0jXlbNKuJ62jmwzE+R7VqLFp1zm3ruQ5/uncYdUf9Lcwkq8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:54 AM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
> On 16/12/21 22:13, Arnd Bergmann wrote:
>
> > Vladimir has put some work into making Cortex-R work in the kernel, and
> > he may have some other thoughts on this question.
>
> I'm curious if he has something specific to Cortex-R to tell.
>
> I've found that Cortex-R82 has a MMU:
> https://www.arm.com/products/silicon-ip-cpu/cortex-r/cortex-r82
> but I can't find any SoC that uses it. Also, I don't know how many
> people could use it honestly.

R82 is fairly new, but I expect that we will see support in Linux in the
future. Aside from having an MMU, it also 64-bit-only, so we'd treat
it like a normal ARMv8-A core in arch/arm64.

        Arnd
