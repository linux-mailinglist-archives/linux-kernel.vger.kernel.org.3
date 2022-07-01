Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA884562B58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiGAGOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiGAGOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:14:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0406413;
        Thu, 30 Jun 2022 23:14:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso1761750pjj.0;
        Thu, 30 Jun 2022 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e+0mflHPcrFAKxG3pxd13ih0kMeyuSNLhT8kGhtdkAQ=;
        b=OyrXlxvPGarnKkbxvB9W3+kggkECqbGynzY69Z1l3Uy5kSB5SSJs/8gtTLoVgI5VsF
         vx+lq5IN2i2AmyUqbL0x3sOVFZDZ7IipTn2dlLPIKZodD/9HKTZv73fY0AdGjJ4iTfBl
         yunZ0xWu89CqZzSx16r48C7G5riMXsW63H3ubPmooGxZ3ol2lITU1ies4fNolL1080F6
         CL+jXiZ4PrChrdLrZus9pV4tE2v32NeCCeAPLXePscuu4Zmk56S9zNmouSPi8XYG9NHB
         33vKgm11OGkH/dM6sFfrek2pYx//L0i6E04/OZOydmLfXuH6QlCxJSe1q/j7hGTqsNJQ
         IXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e+0mflHPcrFAKxG3pxd13ih0kMeyuSNLhT8kGhtdkAQ=;
        b=enyq3h3878o/aTt9QnoOg/m5ZgwZVb5ZphwdWkhehGFGCL1RG8BF2OcG/6bGFVCxT3
         RJdF+3P9tsbFugxZmbit/YHrxeNdF0yzOVOcGbv9nF+Rz2gaaKZ4G5uoYPCB1SIMBTx7
         1SOe5PoTV7MqofZQ0Vn79sTNrFYvZo/GQSOzgCeJY8i6rhMT0S1+gZ5BOeVZI4wxNrlc
         9e5xsP00UeiuUqfbZkuvA8nkVVFejDyjsQo93mVgZwZVpb+NMJ7MKZ1uoxk+4uOvLN4x
         TUwLNhYgupKCBWqmTWPKVOfGHESjM4dytGfi6tYnCyGqhCP+Baww8uAvQxafoapZHtjZ
         n6zg==
X-Gm-Message-State: AJIora8KUdLQ174ZYlc0WHsP8o4q7I9a2nioDMg6UP+Lij2Q/7SIcRTJ
        jtaZZjwV21fUN269HGDNFUZhUYboW+XzSetBbRw=
X-Google-Smtp-Source: AGRyM1uJC3Thb+92uHuFcOpevCDGUVxdAYZwtVrCKOqLR08jRMQO5iqllPk7S/vQ06NOWaB4OQe+AA4p0/DqCo0UTls=
X-Received: by 2002:a17:902:da82:b0:16a:7ca5:36c0 with SMTP id
 j2-20020a170902da8200b0016a7ca536c0mr18290985plx.27.1656656091145; Thu, 30
 Jun 2022 23:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220620124146.5330-1-mtwget@gmail.com> <YrmMdcz9mJS1sXyS@atomide.com>
 <CAHRgzyOsxaC2HM=xAMxFUadTEdTBk-yiMjC=-Y=UynoiULSXDw@mail.gmail.com>
In-Reply-To: <CAHRgzyOsxaC2HM=xAMxFUadTEdTBk-yiMjC=-Y=UynoiULSXDw@mail.gmail.com>
From:   Yu-Tung Chang <mtwget@gmail.com>
Date:   Fri, 1 Jul 2022 14:14:41 +0800
Message-ID: <CAHRgzyOgmxTVV6sqSk_ZWYytergDj5haW=EdFCKCyTg+r6Zd-A@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Fix MMCHS0 dma properties
To:     Tony Lindgren <tony@atomide.com>
Cc:     Benoit Cousson <bcousson@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
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

Yu-Tung Chang <mtwget@gmail.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=881=E6=97=A5=
=E5=91=A8=E4=BA=94 14:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Tony Lindgren <tony@atomide.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=80 18:54=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > Hi,
> >
> > * YuTong Chang <mtwget@gmail.com> [220620 15:36]:
> > > According to technical manual(table 11-24), the DMA of MMCHS0 should =
be
> > > direct mapped.
> >
> > Could this be a bug in the manual assuming mmchs0 is working? Or does t=
his
> > fix something for you?
> >
> It modified in commit b5e5090660742c838ddc0b5d1a001e6fe3d5bfd5,
> the dma of mmc1 was changed to edma_xbar and did not explain why it shoul=
d
> not match the document.
> > Regards,
> >
> > Tony
No evidence of any official documentation error, before submitting
b5e5090660742c838ddc0b5d1a001e6fe3d5bfd5, the mmc1 dma properties
matches the official documentation.
