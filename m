Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35C573246
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiGMJRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiGMJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:17:18 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A50FE4F0D;
        Wed, 13 Jul 2022 02:17:17 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id p14so4404021qvo.9;
        Wed, 13 Jul 2022 02:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zby97TNc1ghpjXRqZzrsX3Uiwj/4uwx2MsSKfbl6g7E=;
        b=u5CPOFktHPDoBx0+1PEVf4b5eS/AEEDoa5fAZucWF8UAspytg0asKGIDYNU5xX/25A
         ZdndZqfeFshpZCWXjZ0qoDJQ3+vRBTJBd+eacmVGYMYienQya6K84rf5uyWQlrxSyTey
         EkeSCiyScl+bul9yy7VYg9UOpXdld+zUwUCJSqiYeW1FViEs79aLcTX2zqHF+mEod9mY
         5vyYs27sVVavFmOesgoGeJIUeXkJ4cQA/+mu8l1KW9zInoGWsK2j7ptZp6F4o0N4kRUg
         5NEkuUj36U3t/fiXA2e97ZcNEDtP++uTRqRtzgBnfQzNutfl2ZQSn5RfaFJ9YecYwqEm
         PFAw==
X-Gm-Message-State: AJIora9GF/51kq0zZfRgKcnYOU2eKa/VG+UPfWVxf4cbhqcaIf116Ya2
        WMtXqYlv01dY/8Dsz8+mgaAykoal97ddog==
X-Google-Smtp-Source: AGRyM1vExN4xusyHHPvUVXKPu3A04mwXo+bSfaFOyCZGSr+d6fdvfVFoTiI9EG3ZsX+tE1/XVJLjOg==
X-Received: by 2002:a05:6214:29c4:b0:472:fb62:3a03 with SMTP id gh4-20020a05621429c400b00472fb623a03mr1846804qvb.93.1657703836439;
        Wed, 13 Jul 2022 02:17:16 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id d9-20020ac85ac9000000b0031eb3af3ffesm1535185qtd.52.2022.07.13.02.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:17:15 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id p129so18267155yba.7;
        Wed, 13 Jul 2022 02:17:15 -0700 (PDT)
X-Received: by 2002:a25:bc8e:0:b0:66e:fe43:645c with SMTP id
 e14-20020a25bc8e000000b0066efe43645cmr2777562ybk.202.1657703835228; Wed, 13
 Jul 2022 02:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220712164235.40293-1-f.fainelli@gmail.com> <CAK8P3a2QrYbWOqV+CG-W0ZkzW6ORgw8R6Dv-L3o2ZAtJs-B3Kw@mail.gmail.com>
 <0131e1d6-09c0-31a4-5b9d-0e2fc49d61ac@linaro.org>
In-Reply-To: <0131e1d6-09c0-31a4-5b9d-0e2fc49d61ac@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Jul 2022 11:17:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDDY_72y3WYt401hG122xg1s7_VRCG9Vyhhkzco-nBYw@mail.gmail.com>
Message-ID: <CAMuHMdWDDY_72y3WYt401hG122xg1s7_VRCG9Vyhhkzco-nBYw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Kconfig.platforms: Re-organized Broadcom menu
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        william.zhang@broadcom.com, anand.gore@broadcom.com,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jul 13, 2022 at 10:40 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 13/07/2022 10:25, Arnd Bergmann wrote:
> > On Tue, Jul 12, 2022 at 6:42 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >> There are now multiple Broadcom SoCs supported so group them under their
> >> own menu such that the selection is visually more appealing and we can
> >> easily add new platforms there in the future. This allows us to move
> >> ARCH_BRCMSTB back to its siblings.
> >>
> >> No functional changes introduced.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>
> >> Note this is based on "arm64: bcmbca: add arch bcmbca machine entry"
> >
> > Hi Florian,
> >
> > So far, we have tried to keep the Kconfig.platforms file rather coarse-grained,
> > mainly limiting it to company names and high-level families, but avoiding
> > sub-menus or adding too many sub-families.
> >
> > If we add per-vendor submenus, we should probably first decide how we
> > want to structure this across vendors. I've added maintainers and lists to
> > Cc for a couple of the ones that are in a similar situation.
> >
> > I can see a couple of ways we can do this:
> >
> > a) keep the list of platforms as short as possible, combining related
> >   SoC families from a single vendor wherever possible, but no sub-menus
> >   (same as today)
> >
> > b) Always use sub-menus when there is more than one family, but
> >    keep relatively coarse platform selection.
> >
> > c) Use sub-menus and also move to a more fine-grained SoC
> >     selection, similar to what we have on 32-bit arm.
> >
> > I would not really want to go to c), but a) and b) both make sense to
> > me as long as do it consistently across all platforms.
> >
> > Any other ideas or opinions?
>
> Whatever we decide here, the SoC can override in drivers/soc, just like
> Renesas did. I think Renesas chose option c), but made it in
> drivers/soc. I would vote to have consistent policy, so if arch/arm64 is
> a) or b), sub-archs should not redefine it in drivers/soc.

We did so because of the "only a single symbol in
arch/arm64/Kconfig.platforms"-policy.

> Or we could choose d)
> d) keep arch/arm64 list of platforms as short as possible, but sub-archs
> can do whatever they like on drivers/soc.
>
> Personally, I find fine-grained SoC selection a bit ridiculous
> optimization, like compiling kernel, Glibc and userspace with -O3,
> -funroll-loops and many other flags. One gets smaller size but looses
> multi-platform and ability to test one kernel on different boards.
> Therefore I would vote for b) with disallowing drivers/soc defining more
> ARCH_ and more SOC_.

No one prevents you from selecting multiple SoCs, they are not
mutually-exclusive...

With arm64 (or risc-v ;-) instead of arm32 being used for all new
SoCs,  I expect the real small ones (with a few MiB of embedded
SRAM) to enter the arm64 realm soon.  No point in including e.g. all
pinctrl drivers from the vendor if you have barely enough RAM to run
Linux and your app...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
