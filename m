Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18B573112
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiGMI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiGMI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:26:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED51B4A6;
        Wed, 13 Jul 2022 01:26:05 -0700 (PDT)
Received: from mail-yb1-f172.google.com ([209.85.219.172]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MiJIk-1neypJ3S10-00fSLI; Wed, 13 Jul 2022 10:26:04 +0200
Received: by mail-yb1-f172.google.com with SMTP id e69so18098168ybh.2;
        Wed, 13 Jul 2022 01:26:03 -0700 (PDT)
X-Gm-Message-State: AJIora+pN1pO7uIsnDEvVXEo+Gv3tBS8I58kXoCVCabu5m+z9dP3BxR6
        sPFKUK4u9rMqqNudKzjazfqUW4yMdZFffFCAISg=
X-Google-Smtp-Source: AGRyM1s5ctXDWESPghTwunvKDjAPfvsYu2kacgrA/MPXviowltYXdPpskedj7zs4LJm1sUX08EXGIUpvgkI0AhSfMmA=
X-Received: by 2002:a5b:b47:0:b0:66e:3617:d262 with SMTP id
 b7-20020a5b0b47000000b0066e3617d262mr2405858ybr.106.1657700762384; Wed, 13
 Jul 2022 01:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220712164235.40293-1-f.fainelli@gmail.com>
In-Reply-To: <20220712164235.40293-1-f.fainelli@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Jul 2022 10:25:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2QrYbWOqV+CG-W0ZkzW6ORgw8R6Dv-L3o2ZAtJs-B3Kw@mail.gmail.com>
Message-ID: <CAK8P3a2QrYbWOqV+CG-W0ZkzW6ORgw8R6Dv-L3o2ZAtJs-B3Kw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Kconfig.platforms: Re-organized Broadcom menu
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        william.zhang@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        anand.gore@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HeyXD8e/HaOaOGqEfNvCOVkZGJNjOMpMO6jAn5G7kFAUNXa3fdV
 hhmnoWd7mVgdNSxv2wv1tjqzk53qm19wVY8I0ImRpGD1HlDEAkdgY/V/bkg44wLPCpSQdnJ
 1yUTDg4lH+HGhlAqWm/TO4QJKlA0c0rfGbIXcVHLXIcaDPiI3Q4FJ5oymRWzIl9F3OltS0r
 lJiMhqV3mjuiI5uWu2XwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jmpPnYOmdD4=:IHFlISKYwMj9oc4o14PJOl
 JBe3oope5jInhkHXNjXQ+b6NNdchAapeA8Bh17yT2DzThtZYLweoX1ILblUzppI7eWHaLV/+C
 4C3d4WpxluvEMNc8asGzUbtx5yarCUmPUhf7skTxSP14Uftuh7yWwygFJFH2WLthgm/+b7CTL
 EDjzl50QbLMx+ODk5TXraMZ6swz1iY7LO3N1fzL1RqbdYpShUww/vHMTSLdO2OQQmiSq9h3rI
 Qaa4rcX/sqNzdprzB4FZ0Mxd3kNBP9ym53rvgZK0NFVLNYFKjJSDslUgdW/qAUsPiZIs398Qu
 0CuN5NNC0dYgMDBGE4dcsEdm7BGlKwjXHHFWkeyzVeH5KTJjUJYCuyNMq4q481BgMinhqA1bL
 qx9rWMtoQHF6wZPuRozvdsvK9bO2/NlLV5rppuDp3+2R660nMAulrNLNHJMct7TeARilNLbYC
 SYg89ZGdNJisrd0ash+z/Ybnjoco4E1UKB0e7r8ZD2dvQdFykxwx6VEPdC7B5PP68Mcgi0DjQ
 wVSC9GV5ylatR5GIOk56Yk1CzfqVSnYIcaC4K8+d/jmOpNGP4CySTdGmrnfueMmH48j71g2he
 AeFCOKZN5Qbry788kkRzAXIsomp8pAU0eX/aCsN8Faw5NUdlcIKhkuIGHApsMuWZT2ED+srDl
 mrbm4UKqBAGxeTh5CKj+giYVR0FXfYifqlT7rqho7Zn/0T6m4yn5HH1iZhFjlA4/JWAmdioqC
 xS1Bd40hj4k5+Mq21XF32LXvtZlBQBwp6BiKIw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 6:42 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> There are now multiple Broadcom SoCs supported so group them under their
> own menu such that the selection is visually more appealing and we can
> easily add new platforms there in the future. This allows us to move
> ARCH_BRCMSTB back to its siblings.
>
> No functional changes introduced.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>
> Note this is based on "arm64: bcmbca: add arch bcmbca machine entry"

Hi Florian,

So far, we have tried to keep the Kconfig.platforms file rather coarse-grained,
mainly limiting it to company names and high-level families, but avoiding
sub-menus or adding too many sub-families.

If we add per-vendor submenus, we should probably first decide how we
want to structure this across vendors. I've added maintainers and lists to
Cc for a couple of the ones that are in a similar situation.

I can see a couple of ways we can do this:

a) keep the list of platforms as short as possible, combining related
  SoC families from a single vendor wherever possible, but no sub-menus
  (same as today)

b) Always use sub-menus when there is more than one family, but
   keep relatively coarse platform selection.

c) Use sub-menus and also move to a more fine-grained SoC
    selection, similar to what we have on 32-bit arm.

I would not really want to go to c), but a) and b) both make sense to
me as long as do it consistently across all platforms.

Any other ideas or opinions?

        Arnd
