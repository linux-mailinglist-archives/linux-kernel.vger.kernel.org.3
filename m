Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C5F4785D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhLQICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:02:40 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhLQICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:02:39 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MSLlu-1n4hnR3TGi-00Sf1C; Fri, 17 Dec 2021 09:02:37 +0100
Received: by mail-wr1-f51.google.com with SMTP id q16so2438034wrg.7;
        Fri, 17 Dec 2021 00:02:37 -0800 (PST)
X-Gm-Message-State: AOAM532GNI3eMLc5igCo7uLR4reDcAEsBUTezFMXnsOzI8oxrv1BP5ol
        sOMy77166X7HwC8ZCn0bv4eEwbdJgrsste1HwG8=
X-Google-Smtp-Source: ABdhPJzJeZFelU3godOJegozbjx0Hr/mKwWf6NtOOet6yAUN3rA9EeAB8H/WKKVCvEXO51VDSBIZnrbM6ODS+aiK/Ic=
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr1465626wry.407.1639728157042;
 Fri, 17 Dec 2021 00:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20211217172931.01c24d4b@canb.auug.org.au>
In-Reply-To: <20211217172931.01c24d4b@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Dec 2021 09:02:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2c508kcaSj2-fKdTkN+ojTtZa9+reHLM4QEadX_EBUQQ@mail.gmail.com>
Message-ID: <CAK8P3a2c508kcaSj2-fKdTkN+ojTtZa9+reHLM4QEadX_EBUQQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Huan Feng <huan.feng@starfivetech.com>,
        Kiran Kumar S <kiran.kumar1.s@intel.com>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4oUBFFqlwiSIa1ypbolba4zFKzclW88FiKDg2eLl5NRvMDDGSlb
 nbJkyG17yY6UDdldCaKCnM4zdJ2xYvBv7oNhaSrbSCz9DBkEygA3KhmFuXKy7ZzLISMjjEV
 lg2Rd78UyiqMzYiI4TlIVDZdJ2aLNkXKjrM95LXvmUUYl6nkBNkgZK61F1iSAiQQLIjMvNi
 ZQJC4DgQ2Cat53Nk/1lDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Q9jytcTBbI=:V9WLnEGijd5AFXRjIl1keG
 LS7fjWG9wsPhe0wI/fgzjgOHCFzfBodwhzAMDJM7E4xjan04GZjT77nRFHG+fj303dgwcShRz
 Y2k5vEdxIhCeqCYt+HtfLiEJjYFGsC4JyaNBqakVhPP1Yjh+s/a05WPUWKeTaQnxxx9REaK/+
 eTSTNpuxxvLmHKeRUL+S6Iuly18d6bw/NxfgueUS1y66la1RB5FAMj/Goh4Rcm0ukVPnTuJI7
 vyW1U+Z80pcJ/0IZZypw54p0BQEeh2e1PyVVUicbRrOs4jJPxaxrCbxlaLbIMnlT8lwhqNjnX
 valVUsW20Q0XlyMC8id60gD508I3ZCUODV0Ppx4GdSBemdKwN+2El90NAA6LaMTD0X0qAY7Lz
 snVDsh76AwO2XJm86HlG6i6T/lh3e8RKJ70x/atzB5CD4dEJ3H7posIKu2rXoeACTeh1k52U/
 AqvOAMbgWiH6ZUiE78agCL0K85YGV0kAKCxA1Tjjq4KHoFD44MYEPVBo0qCpGpkyH8YMgSBLm
 QjmmAqne+jw+tode5M8XHSP+dkL/QQL3X58rKStTWTjMKBPomW4mWmmBIfrorZ1VQPr4X3+kt
 gSe8TxCeDjTQ/d/donj8RhzBVlKPxQ6/Cc/qp9aCUUmXxATlf/XSjXRap+7vAtbnWanJYVf0k
 LwMmrFkKntD241/niPrZnKyOjX0zY6jAD+P8V0SWdSqZfnE89GVl6QSko0jWZV92dko24eyhh
 4NheJIF5AbZataeYRF/jBEyqxGlWQ4AsDKWusgE1KEqoOyt5PSX6/q9Q7vc1NXkGMyX7aYIio
 rtmxGVfaf260Rm4ealCe9PwUBSqIIWoBxLebJ+VKOJEg/eFGn8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 7:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the pinctrl tree got conflicts in:
>
>   drivers/pinctrl/Kconfig
>   drivers/pinctrl/Makefile
>
> between commit:
>
>   ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive SoCs")
>
> from the arm-soc tree and commits:
>
>   12422af8194d ("pinctrl: Add Intel Thunder Bay pinctrl driver")
>   b124c8bd50c7 ("pinctrl: Sort Kconfig and Makefile entries alphabetically")
>
> from the pinctrl tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, looks good. There are potentially three or four new SoC families
in the arm/newsoc branch (this is the first one I merged), so I expect to see
a few additional conflicts like this against pinctrl/clk/irqchip, but
they should
all be trivial.

        Arnd
