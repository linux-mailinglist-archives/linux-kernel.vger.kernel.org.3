Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7861C520F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiEJIDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiEJIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:03:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C024FDAE
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:59:48 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7iOw-1nsPBo3jUI-014jPj for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022
 09:59:47 +0200
Received: by mail-yb1-f179.google.com with SMTP id j2so29310360ybu.0;
        Tue, 10 May 2022 00:59:46 -0700 (PDT)
X-Gm-Message-State: AOAM531oz8gvUpiawWa8IE5dyd1p8lNIXEHpzxd80MJETiPyQPjB9wLh
        lqG+sLKFfJuNZLaLqPuuzazwQDadR6ZQ0dbVksI=
X-Google-Smtp-Source: ABdhPJxZkma0O6QtReHOkgdZVslQ52BEo6cVnAkEKrGL7gi26GMpuYJF5exwXilUaUijrom5XbzZGHxoHSjm/Bt1+OA=
X-Received: by 2002:a25:c604:0:b0:645:d969:97a7 with SMTP id
 k4-20020a25c604000000b00645d96997a7mr16206286ybf.134.1652169585696; Tue, 10
 May 2022 00:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220510152020.1.I6094f0a935212eabc7d9348d6cb5a2517ccc2514@changeid>
 <CAGXv+5FBJScU_-YC=vhPVM0KEO5vtP=KOH_gRnpFivQaHziU_Q@mail.gmail.com>
In-Reply-To: <CAGXv+5FBJScU_-YC=vhPVM0KEO5vtP=KOH_gRnpFivQaHziU_Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 May 2022 09:59:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a06-fCBUAu3KWu75yBsdN9M4szkr+7Ngu8FcO+jW+PYhA@mail.gmail.com>
Message-ID: <CAK8P3a06-fCBUAu3KWu75yBsdN9M4szkr+7Ngu8FcO+jW+PYhA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: add aliases for mt8173 mmc device nodes
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OQLDfXU58BLNJq2S8aldHsdnBv6ZTaypOZ+dR/qjYCkyTHCTJkE
 jfMQqWqQYB8HQWRwTHgWJKRBRGf5SPJv9b+ZuuhOiBDDm7kv04mY+7AalVHlorg0v2IQO89
 CRz8eFTbwTttHV1p+0yuXTo7XUc10VhVBgMpldVt5Veakycma2Ikn7cg82JrYxjHHsQDSaV
 2lXq7JbNboSKdzUaFrJPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bAu0I0o5AEA=:r6eT8D+1DzxbquKMZiS4Hb
 gWDMfnOo81tH0RdSYls/uDaUM5en1tSsskNap4sOkC1PDd8hpJCHIX7PigD9HZMCJuCcVt7ie
 XFrqWIgsaQPDHqe7oRKysoqzbreMSMKK0KNyHh0/Hm1jDfvhGrlhqDI2noINBZodTv6bGRF4i
 cn4q+OknBieKjbvMWqhoQBfuJiyYgrsI01VTzSXkGVjBdGTtIMI6JUOoq0IeFINTiHBXEU7tx
 TO9KVtfQP22kfd6xKhduS+TmoS9sdLQ8x1gqUMnZ89KL0/Rnka39c/1mS4zKo/C6L8LQ4nw4L
 KYifL6WwFlAjQz3T6EEJvPJd4h5HOocXtC1hYnNy3H7dXpjIqowlH5s5W/Nmf7IeEJr8bEXIP
 TI0xBrdoW4AIlBr9H+CFjsOqq+Drasaa1p3slIXp3h6AHB+Bg69oHCQcDnFnGZGs5FmpcgGVI
 QdBQ9TmmK1uL7RYFOj/3BTs67if9T0HgsBjJSfN3cEPNnh7dbOX+QaI7Juss8th8qNlv9Ta0q
 UjHDAPFOZdD3pc17Qf/eJG5Z3fOaLF3Q/HyMO/AELvmx4yIHlGIBl8a3QjHxMW4VJD7H0VHy/
 6QprEbc7K69XE30oJx/IGppfpEUFzbsOzZMPjWIIVu/aSQLlW3clbZdlLNLTrGIoIXAMqcPAw
 YRGNcZ/EoAQ2aZnOUPEaxKtLNBOEcHmenJy+Ex2yjaDT/76Qs0VH3NMR4bBndjB/H90fiKEqL
 yQuBDz7fJR8R5p+Sm69gea0M1FhPhzwt/qUjrWiu3mJU1hH3WHiGH6QV4FYuP7+GW4Exe55Ir
 MqZQSvqSOXK2NIO4dzoEkr8JKQBr0i1gmaU52qaeDP+geqkmV4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 9:36 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> On Tue, May 10, 2022 at 1:21 PM Eizan Miyamoto <eizan@chromium.org> wrote:
> >
> > Doing this makes them get enumerated in a deterministic order so that
> > the assigned name in /dev that the mmc devices get assigned is
> > consistent across reboots.
>
> Arnd, one of the soc maintainers asked folks not to do this:
>
> https://lore.kernel.org/all/CAK8P3a3_uO23Y0tyfdh26tmCVcyp6XM+ur0WUd4khGUoBb32Hw@mail.gmail.com/
>
> and subsequently all mmc aliases for Rockchip were moved to the board level.

Right, please move the aliases into the per-board dts files, and make sure
to only list the ones that are actually connected on a given machine.

> > See ead9f7d7ea9 ("arm64: dts: qcom: sc7180: Assign numbers to eMMC and
> > SD") for similar work.
>
> I don't know why it didn't happen for Qualcomm though.

It takes a while to get things consistent, need to have another look there.

      Arnd
