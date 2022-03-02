Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7216F4CA4AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241748AbiCBMUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbiCBMTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:19:55 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A11D4BFD6;
        Wed,  2 Mar 2022 04:19:11 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d07c4a0d06so14729607b3.13;
        Wed, 02 Mar 2022 04:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vb72GLr6Ee3U6cMdODTkV43DodSF/shfmMcds/5VIw=;
        b=kFIn83UQPNp2YQXGZ6vUBxp7pFT0bb/xiZD2h4HzwgeUvSva8rIMT4RES8AoEseVZS
         z11uYAJWsZCNwLtvizkaW8BNUgAl9lc/YI77qMY71vcixUzHbqZKrRTt1srRqMEQe18D
         DwokZ2XEpylFiXxtb7qiRP2Spd6gTq/sXCe8NuBOdZKOrJMBxi5Pdv9Ck7ufOUb6ak2m
         4cxA+QQRVEFEXzHDftRH5CCTkFqcFgQrdRSpRCmvLDG0BlY+a9A3OX7BTqMRg7X4GN1P
         eKtm5xsZkmagztN4HKnSeq41DoOzeVah6F1q/ZtXBkJcgFcyg+ucOXKj+S7BKJ8Ya2MC
         lVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vb72GLr6Ee3U6cMdODTkV43DodSF/shfmMcds/5VIw=;
        b=v9l+qFUhvcNtwy+vCiJWM6myywCCZiRNR5zYnKVC62FpVwRdeyOYUqGIiowr3l3t9H
         //O+rPnJbknoEEeInnWo4b8/GyxDGx4+lbqH6xfvNGBXbsO3oBVIeIrLvZZ8sbdG4g9o
         8v0DRnYb+2R3/yi2KD47JkuBkiFKlCjRl31dU46brYaNQsKjETUUzXeMi8HsYpnReoU8
         SCcy/ts7QkqUFvcgdcVqUPk/69HLBPfULH80sk2rTZbAnpuElwJOps3U9wzkOY0ZT7I0
         cQrxzYbBN8m5ZTz78ne4zMaG/pp7PYUwDpQnWRjzyleBICf+ISNKfMZipv3cf5PrWP2d
         EkGQ==
X-Gm-Message-State: AOAM532CB8WMdnSgZwEuRXBPqS28M8jpwSZVQpDPy2Bs64oz9a/JD4ZB
        cOw2COpFvr2F+g4Efs7QIQ+ezKMQylV4nU+kuhw=
X-Google-Smtp-Source: ABdhPJyL+HJILY3xOuTeZtNsYtJCOluQWPYN2HDUEDAElMZ5+oMd9++QKvgOqwUj6bvXHy1XbsXeSiDguuBkqf4S4rM=
X-Received: by 2002:a81:1c47:0:b0:2d7:5822:1739 with SMTP id
 c68-20020a811c47000000b002d758221739mr30015911ywc.502.1646223551058; Wed, 02
 Mar 2022 04:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20220228135700.1089526-1-pgwipeout@gmail.com> <20220228135700.1089526-2-pgwipeout@gmail.com>
 <CAMdYzYqs=iRY6uNzVSkHrrhPYFixXdbZjtwSpPOjf-6f8TXutw@mail.gmail.com> <Yh8n7XiJbaT4pZGD@matsya>
In-Reply-To: <Yh8n7XiJbaT4pZGD@matsya>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 2 Mar 2022 07:18:59 -0500
Message-ID: <CAMdYzYrkDbr5mHYmAbqBoJJEKH8A5xXfRNuTiTn8q40vRJeCgA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: soc: grf: fix rk3568 usb definitions
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
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

On Wed, Mar 2, 2022 at 3:16 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 01-03-22, 09:52, Peter Geis wrote:
> > Good Morning,
> >
> > Would it be possible to pull this patch individually, to fix the
> > current error reported by Rob?
>
> This does not apply for me on phy-next. What was this based on..?

This is based on linux-next, which the applicable patch was accepted on 24 Feb.
The original patch was correct, but it seems a merge error happened
and these two lines were moved into an incorrect location.
This patch corrects that, but I see on the original patch chain you
are discussing reverting and reapplying to fix it.

>
> >
> > Thanks,
> > Peter
> >
> > On Mon, Feb 28, 2022 at 8:57 AM Peter Geis <pgwipeout@gmail.com> wrote:
> > >
> > > The rockchip,rk3568-pipe-grf and rockchip,rk3568-pipe-phy-grf
> > > compatibles were incorrectly assigned to the syscon, simple-mfd
> > > enumeration, vice only the syscon enumeration.
> > > This leads a dtbs_check failure.
> > >
> > > Move these to the syscon enumeration.
> > >
> > > Fixes: b3df807e1fb0 ("dt-bindings: soc: grf: add naneng combo phy register compatible")
> > >
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > > index 072318fcd57b..5079e9d24af6 100644
> > > --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > > +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > > @@ -15,6 +15,8 @@ properties:
> > >        - items:
> > >            - enum:
> > >                - rockchip,rk3288-sgrf
> > > +              - rockchip,rk3568-pipe-grf
> > > +              - rockchip,rk3568-pipe-phy-grf
> > >                - rockchip,rk3568-usb2phy-grf
> > >                - rockchip,rv1108-usbgrf
> > >            - const: syscon
> > > @@ -39,8 +41,6 @@ properties:
> > >                - rockchip,rk3399-grf
> > >                - rockchip,rk3399-pmugrf
> > >                - rockchip,rk3568-grf
> > > -              - rockchip,rk3568-pipe-grf
> > > -              - rockchip,rk3568-pipe-phy-grf
> > >                - rockchip,rk3568-pmugrf
> > >                - rockchip,rv1108-grf
> > >                - rockchip,rv1108-pmugrf
> > > --
> > > 2.25.1
> > >
>
> --
> ~Vinod
