Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23D51D718
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391540AbiEFL5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiEFL53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:57:29 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC60B644D8;
        Fri,  6 May 2022 04:53:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m128so12400168ybm.5;
        Fri, 06 May 2022 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYDx03vE3jj2oGtCbP5NamIhARgu7n1pdw/vsL9R664=;
        b=hKBAMIJoWWyEdg3efE7Byll1TwG/WXi2Lhlq2hZqVg2yQpxMPMnJWt6c6nBIKeYCds
         Z8csE03z77cxg4ecxxgWAjaNIe124wXGAQ3z9a2mYwAzMZPu00TW0xCLfCKPNSGabwJj
         kS8VYK209oLBKUJTdx/k9jvQH7QpeicvykZzyIBfvXe6Ha5hFIlyvf0SpqXApyFakmsM
         i/ssq8sQBt4Q/IfchBXRKpGdjPL78J4/Z7UtIBfinsRujZUH2HOMrAswtHDjdxoPraBx
         RQxLHlsMi79SBMMf69CjnXp8JLSVC/oG8kTA4KjTnhlpz6C3Kc+kxA+qelD71NoE/7FD
         D9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYDx03vE3jj2oGtCbP5NamIhARgu7n1pdw/vsL9R664=;
        b=oj1U8+HkJbXDJY9UsL4sRuVzGSLuAfKev3RkeBPz3ttMcQvcihRK2YIpzMWcPgnSee
         A0+GZhQC05lJDMTWyCbQb9CqqWaZczSGLmLS6u4d73e6aq6VMb394LG8u38nJlTuJf/p
         YdZDcNpxZRprPaGm0CSUNBwxndwStwZEzQFQe0tvHwyFejLyewZB3VysVYh38J7zVrg8
         9bHyZYV38lOTLsSgHDHitdXk3tYVrQDc0p34OTtZ1qm6NQZYnhbKGAxv9PHaxJcL0AQ4
         xMuXYZZ/+evojnRdfuffFRIPOWiMuKVyv16wX03ju0tcHTFiAGft1QWvUu+2gNts6Rej
         Ob2Q==
X-Gm-Message-State: AOAM530pz3s41hYswKyUIstNK6h3Zfygf9Zasa+Y7e/CklMt986AMg3c
        AF51PEH751NBEcqou5ruuqnDJIvXP9MiMnmuRno=
X-Google-Smtp-Source: ABdhPJwB7OZnhAunTIHb1sJ66k5ItOIlfdkZSCCN0dtbVq/MUbTdSqU5hpGfmcu6xMfHH4B5CT9/8GOAzbqA6LKbNk0=
X-Received: by 2002:a25:83d1:0:b0:648:725c:6a05 with SMTP id
 v17-20020a2583d1000000b00648725c6a05mr1924802ybm.218.1651838025986; Fri, 06
 May 2022 04:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592225B5A5E1BA7D250C466786C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922F57B34C8E515D520630C86C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922F57B34C8E515D520630C86C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 6 May 2022 12:53:19 +0100
Message-ID: <CA+V-a8vPXQ0hVZ9KNx7dMp-93m5TEUAwjboRYBt=CrqWmxGhSw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the
 resets instead of indexing
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
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

On Fri, May 6, 2022 at 7:17 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> > Subject: RE: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack
> > the resets instead of indexing
> >
> > Hi Lad Prabhakar,
> >
> > Thanks for the patch.
> >
> > > Subject: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack
> > > the resets instead of indexing
> > >
> > > Instead of indexing the resets, stack them and instead create an id
> > > member in struct rzg2l_reset to store the index. With this approach
> > > for every id we will have to loop through the resets array to match the
> > id.
> > >
> > > This in preparation to add support for Renesas RZ/Five CPG in
> > > r9a07g043- cpg.c file where the resets array will be split up into
> > > three i.e. common and two SoC specific.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/clk/renesas/rzg2l-cpg.c | 76
> > > ++++++++++++++++++++++++++------- drivers/clk/renesas/rzg2l-cpg.h |  4
> > > +-
> > >  2 files changed, 63 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/clk/renesas/rzg2l-cpg.c
> > > b/drivers/clk/renesas/rzg2l- cpg.c index 1ce35f65682b..94fe307ec4c5
> > > 100644
> > > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > > @@ -681,14 +681,37 @@ rzg2l_cpg_register_mod_clk(const struct
> > > rzg2l_mod_clk *mod,
> > >
> > >  #define rcdev_to_priv(x)   container_of(x, struct rzg2l_cpg_priv,
> > > rcdev)
> > >
> > > +static const struct rzg2l_reset
> > > +*rzg2l_get_reset_ptr(struct rzg2l_cpg_priv *priv,
> > > +                unsigned long id)
> > > +
> > > +{
> > > +   const struct rzg2l_cpg_info *info = priv->info;
> > > +   unsigned int i;
> > > +
> > > +   for (i = 0; i < priv->num_resets; i++) {
> > > +           if (info->resets[i].id == id)
> > > +                   return &info->resets[i];
> > > +   }
> >
> > Is it not possible to use shared reset like RZ/G2L and RZ/V2L?, which has
> > optimal memory and performance wise we can avoid bigger loop.
> >
> > Like adding Last index of RZ/Five as last reset index and Handle RZ/G2UL
> > specific as invalid reset index in xlate??
>
> Or add a invalidate_resets() callback to info structure and in probe, call this
> Callback,if present to invalidate the resets which are not specific to this SoC.
>
Could you please elaborate on this.

Cheers,
Prabhakar

>
> >
> >
> > > +
> > > +   return NULL;
> > > +}
> > > +
> > >  static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
> > >                        unsigned long id)
> > >  {
> > >     struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > > -   const struct rzg2l_cpg_info *info = priv->info;
> > > -   unsigned int reg = info->resets[id].off;
> > > -   u32 dis = BIT(info->resets[id].bit);
> > > -   u32 we = dis << 16;
> > > +   const struct rzg2l_reset *reset;
> > > +   unsigned int reg;
> > > +   u32 dis, we;
> > > +
> > > +   reset = rzg2l_get_reset_ptr(priv, id);
> > > +   if (!reset)
> > > +           return -EINVAL;
> > > +
> > > +   reg = reset->off;
> > > +   dis = BIT(reset->bit);
> > > +   we = dis << 16;
> > >
> > >     dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id,
> > > CLK_RST_R(reg));
> > >
> > > @@ -708,9 +731,16 @@ static int rzg2l_cpg_assert(struct
> > > reset_controller_dev *rcdev,
> > >                         unsigned long id)
> > >  {
> > >     struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > > -   const struct rzg2l_cpg_info *info = priv->info;
> > > -   unsigned int reg = info->resets[id].off;
> > > -   u32 value = BIT(info->resets[id].bit) << 16;
> > > +   const struct rzg2l_reset *reset;
> > > +   unsigned int reg;
> > > +   u32 value;
> > > +
> > > +   reset = rzg2l_get_reset_ptr(priv, id);
> > > +   if (!reset)
> > > +           return -EINVAL;
> > > +
> > > +   reg = reset->off;
> > > +   value = BIT(reset->bit) << 16;
> > >
> > >     dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id,
> > > CLK_RST_R(reg));
> > >
> > > @@ -722,11 +752,17 @@ static int rzg2l_cpg_deassert(struct
> > > reset_controller_dev *rcdev,
> > >                           unsigned long id)
> > >  {
> > >     struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > > -   const struct rzg2l_cpg_info *info = priv->info;
> > > -   unsigned int reg = info->resets[id].off;
> > > -   u32 dis = BIT(info->resets[id].bit);
> > > -   u32 value = (dis << 16) | dis;
> > > +   const struct rzg2l_reset *reset;
> > > +   unsigned int reg;
> > > +   u32 dis, value;
> > > +
> > > +   reset = rzg2l_get_reset_ptr(priv, id);
> > > +   if (!reset)
> > > +           return -EINVAL;
> > >
> > > +   reg = reset->off;
> > > +   dis = BIT(reset->bit);
> > > +   value = (dis << 16) | dis;
> > >     dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
> > >             CLK_RST_R(reg));
> > >
> > > @@ -738,9 +774,16 @@ static int rzg2l_cpg_status(struct
> > > reset_controller_dev *rcdev,
> > >                         unsigned long id)
> > >  {
> > >     struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > > -   const struct rzg2l_cpg_info *info = priv->info;
> > > -   unsigned int reg = info->resets[id].off;
> > > -   u32 bitmask = BIT(info->resets[id].bit);
> > > +   const struct rzg2l_reset *reset;
> > > +   unsigned int reg;
> > > +   u32 bitmask;
> > > +
> > > +   reset = rzg2l_get_reset_ptr(priv, id);
> > > +   if (!reset)
> > > +           return -EINVAL;
> > > +
> > > +   reg = reset->off;
> > > +   bitmask = BIT(reset->bit);
> > >
> > >     return !(readl(priv->base + CLK_MRST_R(reg)) & bitmask);  } @@ -
> > > 756,10 +799,11 @@ static int rzg2l_cpg_reset_xlate(struct
> > > reset_controller_dev *rcdev,
> > >                              const struct of_phandle_args *reset_spec)  {
> > >     struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > > -   const struct rzg2l_cpg_info *info = priv->info;
> > >     unsigned int id = reset_spec->args[0];
> > > +   const struct rzg2l_reset *reset;
> > >
> > > -   if (id >= rcdev->nr_resets || !info->resets[id].off) {
> > > +   reset = rzg2l_get_reset_ptr(priv, id);
> > > +   if (!reset) {
> > >             dev_err(rcdev->dev, "Invalid reset index %u\n", id);
> > >             return -EINVAL;
> > >     }
> > > diff --git a/drivers/clk/renesas/rzg2l-cpg.h
> > > b/drivers/clk/renesas/rzg2l- cpg.h index 92c88f42ca7f..a99f2ba7868f
> > > 100644
> > > --- a/drivers/clk/renesas/rzg2l-cpg.h
> > > +++ b/drivers/clk/renesas/rzg2l-cpg.h
> > > @@ -152,12 +152,14 @@ struct rzg2l_mod_clk {
> > >   * @bit: reset bit
> > >   */
> > >  struct rzg2l_reset {
> > > +   unsigned int id;
> >
> > Now you are adding 4 bytes to each reset entry in the LUT.
> >
> > Cheers,
> > Biju
> >
> > >     u16 off;
> > >     u8 bit;
> > >  };
> >
> > >
> > >  #define DEF_RST(_id, _off, _bit)   \
> > > -   [_id] = { \
> > > +   { \
> > > +           .id = (_id), \
> > >             .off = (_off), \
> > >             .bit = (_bit) \
> > >     }
> > > --
> > > 2.25.1
>
