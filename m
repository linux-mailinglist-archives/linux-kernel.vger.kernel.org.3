Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9744C28CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiBXKEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiBXKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:04:02 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B0B285AB3;
        Thu, 24 Feb 2022 02:03:33 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d68d519a33so18761117b3.7;
        Thu, 24 Feb 2022 02:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGy3rhJaGOOLENr6AOqwxPuX4vsG4p2aTfrjvFG71Ic=;
        b=VRudSdaelPfQZrHhfpEXS6f84dddWM42vI4uvg/LiTWKyCtuzzOMwN51DlRRI1Baym
         aPaiCOtQ4y8BwqF0TCTmevgo5If+zdR5riIugpkfd2YoO7a/PmTVRAIjr4gBrIsPaMR3
         czab589hM1zKDpSiv5/BivJICzXbV9C9NtiP0i7we5er/pt9xCF2IuH5YRmovvGfYbeV
         TcfbOrSdM04DzZMKUbYdkUpTill6P39i0rQNC7WnodgCqXSp1fHLQ7zlGaaaPu1EO/QM
         6uv2gDJ8vSCU9FucRqomhS9O+6apXV4ulofElepaULGYY8yZLBO7lyRVGL5EPNWrp04q
         cLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGy3rhJaGOOLENr6AOqwxPuX4vsG4p2aTfrjvFG71Ic=;
        b=KkVBABAN3n6bpyTPPoPI9x+Aqj2oI4lsfNIvhBZmH1gOtRp3g2c2ky4ojZfK/4n0DH
         zujHP8KPwCKIBdyZkd6ejpsRHv+lFNOfx5Q03vCop5EIDi+qQ5ukLa5UpBsWsL5AQviU
         S0BeR2AYPYs4cYi8juu37yo4g5oX8052BrSfkilOhEXXqz+kCe1E66YTX9KCUznsZU7t
         RubkE9xIYei5ySSOyQb1JjyghxrRzn0+v7v5kfnOpFtd9n47Hf/54pxwjExgzQOqyfy6
         Fi3N9pJmPPJrdQ3G48xLpcls2tnYraAfcAmUjfYo+m1YTdLYfVCdC6Be5Fo7yHhaQdWa
         A49g==
X-Gm-Message-State: AOAM532ljtJm7S+vAbd8RarduvO56AAbzR+FBOr544i1GCMNN8yX5rsU
        1idoIikqKefFMej6C1F4LZhDca+PCi/LBPf8EYE=
X-Google-Smtp-Source: ABdhPJxIaceg0/qdO5qj8CoPe2p4PvnP0wLB9bIgQveWILrcIpPLXL+jNIzHSTemqFxiGWfXRDV8EsxienAH0FZf3xY=
X-Received: by 2002:a0d:d483:0:b0:2d6:8422:5417 with SMTP id
 w125-20020a0dd483000000b002d684225417mr1653571ywd.119.1645697012419; Thu, 24
 Feb 2022 02:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20220224092114.25737-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWebGqoLeDcTYM9vKkdVpC0wCfcUSpV6gr+4wphzkacCg@mail.gmail.com>
In-Reply-To: <CAMuHMdWebGqoLeDcTYM9vKkdVpC0wCfcUSpV6gr+4wphzkacCg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 24 Feb 2022 10:03:06 +0000
Message-ID: <CA+V-a8uDodqt6e50b33OA5xcFG5P+8QYURgv6RBSwkPzWr9GtQ@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: Introduce ARCH_RZG2L config option
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Geert,

Thank you for the review.

On Thu, Feb 24, 2022 at 9:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Feb 24, 2022 at 10:21 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Renesas RZ/G2L, RZ/G2LC, RZ/G2UL and RZ/V2L SoC's have identical IP blocks
> > for which drivers are common. To avoid updating the Kconfig files for
> > drivers in common to each SoC, introduce the ARCH_RZG2L config option.
> > ARCH_RZG2L config option will be selected by the above mentioned SoC's and
> > ARCH_RZG2L config option will be used as a dependency for the drivers in
> > common.
> >
> > While at it, move PM and PM_GENERIC_DOMAINS under the ARCH_RZG2L
> > config option instead of adding it to individual SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.18, so you can start updating
> dependencies after v5.18-rc1.
>
In that case I'll withhold the Kconfig changes for v2l and post it
after v5.18-rc1 and for now will just send the DTSI changes to enable
them.

Cheers,
Prabhakar
