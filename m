Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9098B53141D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiEWQS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiEWQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:18:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E775001F;
        Mon, 23 May 2022 09:17:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so13563514plh.2;
        Mon, 23 May 2022 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XscYd2XthDWYUhAkxOPgE7MyEYQIXOYcrsFO2Eyz8Ag=;
        b=Ki7jD0kLG6A9jqBBRwOmAbgHs0YQEKbXmx6QN+gwUBEyb1ZJYbe0yDwlxp69FhjUtX
         qsk6JRwaHKF/LdvjW02F1oQkQ3EO8a8sybq4xvqzTFZustbTvuMALd3Tp3zYkYSe9QiB
         CYdSSNUMnTaQQWR7sXpox7RUL/FhsZ9xYoUAAsthkKLyRmkaOrNM8YInpISw61yB8jes
         iPVNQMygQbILNZoj4k5QKM2PTdrG3i/l6+Hv24SlCqYc4+6lNm4QWn8U/YiJfYegJDL8
         yOW7DGQXrfNNIbRLSIXEGXh3pgyWIfooUG6qyZGFshjMWk3DGk6sJyFzp6xgRBkxE6ql
         ORKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XscYd2XthDWYUhAkxOPgE7MyEYQIXOYcrsFO2Eyz8Ag=;
        b=OjS6z/lf51rj8hlBi01WydhOo3zAcY9dX95p/J+PP2iIcQbYMF8aPFX+Oel8G+DT4m
         t4isjcUzvGhmn2ox29luW9dxe8QFxvfTSq0Hng6o2lPC6xKdB/YujSczApB8A7sndnfI
         sIGvUMgYr0ybVU/spJ8B+PQxSRSyD4aq0zwkQfukOxtwXqgJL7BK/YoANiy25z6eXUJv
         vcT9BmAmUNE8hEylAvhEmWbc6zZoQyZjL6ntj9wmGAkZDtephmszu+75ec9xy63EZZJs
         /9QDQZmt3vXSvmWC6B/w0dE/E9gNtz9chVChTa+ScrVep8niC9jlVRWZEsqo1ZYXYWjV
         DYOw==
X-Gm-Message-State: AOAM533zKKNJ2NzSEYj+sTGOXrHhRv87kiSOSz1y2cRZUEQL6UwM4R4e
        27ZRzt2la9YuKajdMglwokc=
X-Google-Smtp-Source: ABdhPJx1UvRPNtRDvXoFm4s4GFCfRU43KQsGhriUzOMYUgwZZJJ8O6kkqdWzCkCAWMgpP43D1W2s0g==
X-Received: by 2002:a17:903:11c7:b0:154:b936:d1d4 with SMTP id q7-20020a17090311c700b00154b936d1d4mr23608030plh.78.1653322678114;
        Mon, 23 May 2022 09:17:58 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d84e:5dcd:9d68:ebbf])
        by smtp.gmail.com with ESMTPSA id w4-20020a654104000000b003fa95b940bdsm595341pgp.88.2022.05.23.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:17:57 -0700 (PDT)
Date:   Mon, 23 May 2022 09:17:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: mtk-pmic-keys - Add kerneldoc to driver
 structures
Message-ID: <YouzshxT6bjxiRqr@google.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-2-angelogioacchino.delregno@collabora.com>
 <YosOsgPwMGuLk9dv@google.com>
 <56598535-5aa4-020e-25fd-295416f4d979@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56598535-5aa4-020e-25fd-295416f4d979@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:54:03AM +0200, AngeloGioacchino Del Regno wrote:
> Il 23/05/22 06:33, Dmitry Torokhov ha scritto:
> > Hi AngeloGioacchino,
> > 
> > On Fri, May 20, 2022 at 02:51:28PM +0200, AngeloGioacchino Del Regno wrote:
> > > To enhance human readability, add kerneldoc to all driver structs.
> > 
> > I am doubtful that this is useful. The reason is that I believe
> > kerneldoc format is only useful for documenting cross-subsystem APIs.
> > Kerneldoc for driver-private data and functions simply pollutes API
> > docs.
> > 
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/input/keyboard/mtk-pmic-keys.c | 30 +++++++++++++++++++++++++-
> > >   1 file changed, 29 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> > > index c31ab4368388..8e4fa7cd16e6 100644
> > > --- a/drivers/input/keyboard/mtk-pmic-keys.c
> > > +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> > > @@ -34,6 +34,13 @@
> > >   #define MTK_PMIC_HOMEKEY_INDEX	1
> > >   #define MTK_PMIC_MAX_KEY_COUNT	2
> > > +/**
> > > + * struct mtk_pmic_keys_regs - PMIC keys per-key registers
> > > + * @deb_reg:             Debounced key status register
> > > + * @deb_mask:            Bitmask of this key in status register
> > > + * @intsel_reg:          Interrupt selector register
> > > + * @intsel_mask:         Bitmask of this key in interrupt selector
> > > + */
> > >   struct mtk_pmic_keys_regs {
> > >   	u32 deb_reg;
> > >   	u32 deb_mask;
> > > @@ -50,6 +57,11 @@ struct mtk_pmic_keys_regs {
> > >   	.intsel_mask		= _intsel_mask,		\
> > >   }
> > > +/**
> > > + * struct mtk_pmic_regs - PMIC Keys registers
> > > + * @keys_regs:           Specific key registers
> > 
> > This new description of the structure and of the keys_regs does not add
> > any information for me.
> > 
> > > + * @pmic_rst_reg:        PMIC Keys reset register
> > > + */
> > >   struct mtk_pmic_regs {
> > >   	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
> > >   	u32 pmic_rst_reg;
> > > @@ -85,15 +97,31 @@ static const struct mtk_pmic_regs mt6358_regs = {
> > >   	.pmic_rst_reg = MT6358_TOP_RST_MISC,
> > >   };
> > > +/**
> > > + * struct mtk_pmic_keys_info - PMIC Keys per-key params
> > > + * @keys:                Pointer to main driver structure
> > 
> > That is obvious from the field definition.
> > 
> > > + * @regs:                Register offsets/masks for this key
> > 
> > Ditto.
> > 
> > > + * @keycode:             Key code for this key
> > 
> > Yep.
> > 
> > > + * @irq:                 Keypress or press/release interrupt
> > > + * @irq_r:               Key release interrupt (optional)
> > > + * @wakeup:              Indicates whether to use this key as a wakeup source
> > > + */
> > >   struct mtk_pmic_keys_info {
> > >   	struct mtk_pmic_keys *keys;
> > >   	const struct mtk_pmic_keys_regs *regs;
> > >   	unsigned int keycode;
> > >   	int irq;
> > > -	int irq_r; /* optional: release irq if different */
> > > +	int irq_r;
> > >   	bool wakeup:1;
> > >   };
> > > +/**
> > > + * struct mtk_pmic_keys - Main driver structure
> > > + * @input_dev:           Input device pointer
> > 
> > I do not find this helpful.
> > 
> > > + * @dev:                 Device pointer
> > 
> > And neither this.
> > 
> > > + * @regmap:              Regmap handle
> > 
> > Nor this.
> > 
> > > + * @keys:                Per-key parameters
> > > + */
> > >   struct mtk_pmic_keys {
> > >   	struct input_dev *input_dev;
> > >   	struct device *dev;
> > > -- 
> > > 2.35.1
> > > 
> > 
> > In the end we ended up with something that now has a chance of
> > introducing warning when someone changes code, for very little benefit,
> > if any at all.
> > 
> > For driver-private data and functions we should rely on expressive
> > variable and function names and only use comments for something that
> > might be unclear or requires additional qualification.
> > 
> 
> Hello Dmitry,
> 
> it's been very helpful for me to see kerneldoc documentation in the various
> drivers across the kernel - helped me understanding what was going on in an
> easier, more immediate way, especially when looking at drivers having some
> kind of "complicated" flow.
> About introducing warnings when someone changes code, I believe that this
> may also be helpful (for a developer) in some *corner* cases, but I agree
> that this is unnecessarily tedious in some others... in the end, it's all
> about personal opinions...
> 
> Of course, some of the documentation being obvious is unavoidable when it
> comes to kerneldoc as you either document 'em all, or nothing.
> 
> In any case, if you really dislike having this kind of documentation, I can
> drop these commits and eventually add in-line comments to some variables to
> make them perfectly understandable, or I can avoid documenting at all (even
> though I am strongly for documenting things clearly).

I might be mistaken, but I think what you appreciated is not presence of
comments particularly in kerneldoc format (you did not generate htmldocs
or something to study the drivers internal API disconnected from the
code, did you?) but rather the fact that some drivers have been
well-commented.

To be clear, I am all for adding meaningful comments to the drivers
structures and code, but kerneldoc is too rigid and adds too much noise.
As I mentioned "this is a pointer to an input device" description might
be OK when looking at HTML docs on the web or elsewhere, but really does
not add anything when you see "struct input_dev *input_dev;" a few lines
below.  So my preference would be to add free-form comments to places
where intent is not clear. For example the original comment to "irq_r"
was pretty good IMO - it called out some irregularity and explained what
it is. We could definitely add comment to "irq" as well to tell that we
expect it to fire on both press and release.

Thanks.

-- 
Dmitry
