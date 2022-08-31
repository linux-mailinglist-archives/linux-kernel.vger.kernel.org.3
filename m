Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E182F5A75B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiHaFbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaFbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:31:53 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4738CB8F2D;
        Tue, 30 Aug 2022 22:31:52 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id s3so145739ilv.0;
        Tue, 30 Aug 2022 22:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=fh0vOuRtsk5EMk5hSJ7o3ypJ/QfcxJywMLcP1lA6j2E=;
        b=eMN4Bk/NFV6UIkU8Vp7ulrQFxDm0NyzDKKEStiPXLPlYvMOe1MZkTBlfS4JHtIgesh
         b58cDxfEflTTGVOvUSm6eKSAdWlGTGYHMiXiaGbXbWqIPF456qqi/iiqO944sk+jlrHW
         La5/anZQdtDe20tCZ4G4pfSHYlk4D32qq8X+bRc3X888YFvFX8ipTH48Paot6+BzfDJX
         bYVX6NlT5X1CoB7CO9rg5u7vO/uEQWQ0f6MuEl+rlGguau083VmKl3ziIAqVfqyd/7sg
         GscrQcqhTCrJOZqFy3fBpThwLrq3BCTOPtQaTiLjuOWFiFv8JwR3xYhN/OnderBk9pRk
         Rlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=fh0vOuRtsk5EMk5hSJ7o3ypJ/QfcxJywMLcP1lA6j2E=;
        b=ePXvg718+eSXiett6Y6UljaMsz1ZNcBEb28tOMfgyk3fW735n59z/cW4py3EIeUhcR
         CBN9JF20AsugVN6DAu8ndLdouVY2meQP6BDYSs+lLxb6nnUV58ANMoUF0loeyxbhO2Fu
         1EjdZtvVFgY6fnCq31JvWKgpLOq5Nc2NhE4gimEPY0rBuHSZ1sc9CWj3lT63mTG0V7TM
         hq21V21czirQH3HB5Xvpn6M5wb3tbqR1Csk+4nHbFQFwu1bpzwv2zDqCg1XByys/kQT6
         1JCQ7YdX83HNxnmB4aas0VQtxMJB6w1e4ttnrLb3jR+HMAa+O/PfLS5VZpuQTIbUF1/X
         KFMA==
X-Gm-Message-State: ACgBeo35AD0WakHasXm0vVoIOonLTuo76BZ26xK8bEEDp5tcuSFYyYYT
        3GNuXjypJbMvndAEJP4fd6+/W3X8Nqs2Mc6kdKo=
X-Google-Smtp-Source: AA6agR6R1oxHvjEIIPpIv3iBzP+g44uQhnpPL5EhVCjLcdaAjBGQFKT3UqMsZSA5Bw9WI56ED7K4Pnz/cjpTtWKulbk=
X-Received: by 2002:a05:6e02:1886:b0:2eb:438a:c64c with SMTP id
 o6-20020a056e02188600b002eb438ac64cmr4214347ilu.282.1661923911611; Tue, 30
 Aug 2022 22:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220829062202.3287-1-zong.li@sifive.com> <20220829062202.3287-3-zong.li@sifive.com>
 <1a0da77e-8b26-a6aa-4af2-bf852470230a@microchip.com> <CANXhq0rHnsRP=Djin53Nc5n3aYY-=ALu7=F-1Y+-U3_L_ehG6g@mail.gmail.com>
 <e155125d-6a8a-aa28-b331-9c36d21305a5@microchip.com>
In-Reply-To: <e155125d-6a8a-aa28-b331-9c36d21305a5@microchip.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Wed, 31 Aug 2022 13:31:39 +0800
Message-ID: <CA+ZOyahru+kws29VAxt8NFaRRYJzFPegaEdDEFhYxLtwSEds3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: sifive: l2 cache: Rename SiFive L2 cache to
 composible cache.
To:     Conor.Dooley@microchip.com
Cc:     zong.li@sifive.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        greentime.hu@sifive.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Conor.Dooley@microchip.com> =E6=96=BC 2022=E5=B9=B48=E6=9C=8830=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 29/08/2022 09:40, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > On Mon, Aug 29, 2022 at 3:05 PM <Conor.Dooley@microchip.com> wrote:
> >>
> >> Hey Zong,
> >>
> >> On 29/08/2022 07:22, Zong Li wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> From: Greentime Hu <greentime.hu@sifive.com>
> >>>
> >>> Since composible cache may be L3 cache if pL2 cache exists, we should=
 use
> >>> its original name composible cache to prevent confusion.
> >>>
> >>> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> >>> Signed-off-by: Zong Li <zong.li@sifive.com>
>
> >>>
> >>> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> >>> index 58cf8c40d08d..3d65d2771f9a 100644
> >>> --- a/drivers/soc/sifive/Kconfig
> >>> +++ b/drivers/soc/sifive/Kconfig
> >>> @@ -2,9 +2,10 @@
> >>>
> >>>    if SOC_SIFIVE
> >>>
> >>> -config SIFIVE_L2
> >>> -       bool "Sifive L2 Cache controller"
> >>> +config SIFIVE_CCACHE
> >>> +       bool "Sifive composable Cache controller"
> >>> +       default y
> >>
> >> Changing this to default on is not a rename of the file..
> >> This should be in a different patch.
> >
> > Okay, let me separate it to another patch, but I guess we could remove
> > it, and enable it by user. What is your perspective on it?
>
> Personally I would like to leave the default y out & leave it up
> to the user - the driver is more informational than anything else
> so I don't think making it default to on makes sense.
>

Agree, let me remove it in the next version. Thanks

>
>
> >>> +
> >>> +#define SIFIVE_CCACHE_DIRECCFIX_LOW 0x100
> >>> +#define SIFIVE_CCACHE_DIRECCFIX_HIGH 0x104
> >>> +#define SIFIVE_CCACHE_DIRECCFIX_COUNT 0x108
> >>> +
> >>> +#define SIFIVE_CCACHE_DATECCFIX_LOW 0x140
> >>> +#define SIFIVE_CCACHE_DATECCFIX_HIGH 0x144
> >>> +#define SIFIVE_CCACHE_DATECCFIX_COUNT 0x148
> >>> +
> >>> +#define SIFIVE_CCACHE_DATECCFAIL_LOW 0x160
> >>> +#define SIFIVE_CCACHE_DATECCFAIL_HIGH 0x164
> >>> +#define SIFIVE_CCACHE_DATECCFAIL_COUNT 0x168
> >>> +
> >>> +#define SIFIVE_CCACHE_CONFIG 0x00
> >>> +#define SIFIVE_CCACHE_WAYENABLE 0x08
> >>> +#define SIFIVE_CCACHE_ECCINJECTERR 0x40
> >>
> >>   From what I can see, you've also changed these around too?
> >> Please generate the patch's diff so that the rename is detected & the
> >> diff shows only what changed in the file. The -M option is what you
> >> are looking for.
> >>
> >> I have a couple other comments to make about what's changed here other=
,
> >> thatn the rename but I will do so against a v2 where the diff is usabl=
e.
> >>
> >
> > Let me sent the v2 patch, and separate the rename and diff part
>
> Great, thanks. I'll take another look at it then.
>
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
