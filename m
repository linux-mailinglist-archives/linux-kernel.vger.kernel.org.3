Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5752BE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiERO2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiERO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:28:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D4AE272;
        Wed, 18 May 2022 07:28:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p22so3926937lfo.10;
        Wed, 18 May 2022 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2asfCeFU8cxuqhZ8P9yqC7YEl+u0MhBiTAzL9Svh7A=;
        b=GmR8tJF+da69/ciqhoEMUlRXNwY1NUWXLCdla2Iu0ylQrvgqJoaWgHVOQj0I/BO/Yt
         nP4pPV2Kh56+9lbMh47i6yH9vGRnw2GTipLOgIx+vR+o1Z19nkbhutn80ixKS4ga71jK
         A+ydg7x70pVAreJc50GlbW+OwN4b1u438Z94tANm2MAVc58md+nH8YLzs76lB2twLY0D
         0bjCE4/cf9hyv05pUsTplflbdMB6BwJCjDvEXdlQ5+2eCdzPFvSK51qLn+aQF9t0mpAp
         H2KU6PUOJmea42Z4FOKIZhF2ehzOT0AGgCkSpXpTU+CqqcJKgs/va/ovxPFOCXf81M73
         bWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2asfCeFU8cxuqhZ8P9yqC7YEl+u0MhBiTAzL9Svh7A=;
        b=36Ii1TxGVGh/ouMaNsYieULjVjiwS7xN7gErghLFGIgGfxNL+Ejrfwfbt9Ldv3E51x
         aVkEDT+uUmJoGk8PTfmtfH62E6HSRDmHVOaLHEqPEWQ9H6dOPu+DpM1NwEEIOT+YK+YP
         TqRjyoCl/Y6iDKEl9YgwuD5GpE2cu9wbIk8PpxyJBaouxPZncwUowezEH5qvPTWgY8RP
         XAD5XJ2pj1MJwtQF5zoITWQMXqwpqRRPRNjkOtND5L4IsE3eXX/Gnlnlka1adSF9z8k/
         KAz1Ib3oWHUzDbXDNyxfnq4qZv+GvCQxnAJoGV1Xo16VCz2kd1TipMpdKAzb8pCkhXzX
         olrw==
X-Gm-Message-State: AOAM532Dv1qZhEvYIH53LG0MiG2JfR2iIj2A8vpePoTTKkBl0RpmP2JO
        i4A2KpFKE97hHK0rgKrPhkgtGFc+Cj3YneSIkTg=
X-Google-Smtp-Source: ABdhPJzhrFJxl5/2J/veCGoYkn9Nu3bLLfWmyPSxzWdQt4Lt0dmM4NhnyYCHFhjGCnAmfT4rPU9IGMBqwfLndhZJouw=
X-Received: by 2002:a19:8c1a:0:b0:472:315:48db with SMTP id
 o26-20020a198c1a000000b00472031548dbmr20359645lfd.235.1652884122909; Wed, 18
 May 2022 07:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-12-max.oss.09@gmail.com>
 <CAOMZO5BtQtX2873RQJ6hB0rAZThJ82mf4gTm9JboAkMrwq+f6g@mail.gmail.com>
In-Reply-To: <CAOMZO5BtQtX2873RQJ6hB0rAZThJ82mf4gTm9JboAkMrwq+f6g@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 18 May 2022 16:28:31 +0200
Message-ID: <CAEHkU3VKf9xNMMEcW39imkysH31e8SLtdOj-c+_EYkxMW2qN=w@mail.gmail.com>
Subject: Re: [PATCH v1 11/17] ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio

On Tue, May 17, 2022 at 8:28 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Max,
>
> On Mon, May 16, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> > +       ov5640_csi_cam: ov5640_mipi@3c {
> > +               compatible = "ovti,ov5640";
>
> Does it make sense to describe the ov5640 camera in the Apalis SoM dtsi?
>
> The camera is not populated in the SoM. What if the customer baseboard
> uses a different camera?
>
> The same applies to the adv720 description.

We moved to a pattern where we do describe the 'Toradex' peripherals
in the SoM dtsi but
keep their status disabled. Then if the peripheral is on the carrier
board we only have to
enable it in the carrier board dts, for peripherals attached to the
carrier boards (e.g. like the
cameras) we enable it in device tree overlays.
This did reduce code duplication a lot.
A customer who attaches a different camera would add its camera node
in its device tree
or overlay and keep the ov5640 or adv7280 nodes disabled.

So I would rather not change anything here.

Max
