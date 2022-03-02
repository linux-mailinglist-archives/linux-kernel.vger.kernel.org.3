Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC14CAB81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbiCBR0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiCBRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:25:59 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22B2CA31A;
        Wed,  2 Mar 2022 09:25:15 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2dbc48104beso26251917b3.5;
        Wed, 02 Mar 2022 09:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHLK0rZoZwvLk407H3I3AQl9EwHKDQ8Qn/KJVxCEprA=;
        b=Mpa9yuqvsgiPWU7E5zDlY7qrZ7YkH/oJgAwF0bkUoBZTiKb5A4QoOJmxH5ADLmgE0L
         WrHX6Gcsj2UNIAUowILtqQAe5yzF3jnRbxGuuojrdZPkmEnf4tGFqcfyXq1C/nrKLsXN
         daRlwC/rUv+SrgitsXZmEvTrc+73PV6zDsjEDAWT4Iv43QDXuNzvJvR9/K3YVNcxNIqp
         KKXIN6+IXkSawy5mHmKIhiCdpYBfu/gVlaGjwcDarFGZC6JeX7/zQJnzeePylIsc/Ekb
         nVq7ojdJ7f8X9+DsKlF2ongMaze3of8LvrhLF8zp2DkAkpFU/nRKPra2CjjKxXwxint2
         SdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHLK0rZoZwvLk407H3I3AQl9EwHKDQ8Qn/KJVxCEprA=;
        b=BM+bwcIcL4cDLMCpC3J3bargKUpDecQ+cd0ogrp6TK83HVoHWLTnk579OaBV7zJ+Lq
         aaZG74jVFgrfehU0VEgUeAVlK5RO6sFAB4LGsZ9koUu72exBnwSI2pfOl946M4ZvVpXL
         k4lqA15ZqKVPlVUvApDwTQ6lMB/ldXXqsyHn+X6f4fZ2X9O9O65QGYyRX6BxmtmLHsqI
         qeIAbTeOOJ7uKEuDs8n4c+LAvXUGpcxkym0Qe+igb+22V5pTvuCLiZPKpdYbCyAM1JpD
         1NNGao+cAZHIuvxEXHKpvYpCksC4rLvjoY3FGpju6KPRoFCG5EG8GLDQLZpziNJ5iqLW
         NQRg==
X-Gm-Message-State: AOAM530MshHyBczYWFqa7u0d9FNBYCCb1E13NXhsasTcuF2inoaMAAqt
        TAR++joHqLkU6B7vOXT4QLYMFrYWARvFeUi065s=
X-Google-Smtp-Source: ABdhPJwQX66RmntT4aJExWpWltr3suaoJxs4GWL9aqZqibeCHhZOncYjov5VmoDhhvP6zgQnYaeSQWcDLbeK6o/LHao=
X-Received: by 2002:a81:3807:0:b0:2d8:2ed:1d19 with SMTP id
 f7-20020a813807000000b002d802ed1d19mr30671490ywa.519.1646241915023; Wed, 02
 Mar 2022 09:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20220302143427.447748-1-vkoul@kernel.org> <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
 <Yh+l7+7zDvI/9e6n@matsya>
In-Reply-To: <Yh+l7+7zDvI/9e6n@matsya>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 2 Mar 2022 12:25:03 -0500
Message-ID: <CAMdYzYoVz4wk-EhfxQdwu9FqRg8Vj-HGMFG+CFjfsHeM8HcnNQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Revert "dt-bindings: soc: grf: add naneng
 combo phy register compatible"
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Mar 2, 2022 at 12:14 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 02-03-22, 11:04, Rob Herring wrote:
> > On Wed, Mar 2, 2022 at 8:34 AM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > This reverts commit b3df807e1fb0 ("dt-bindings: soc: grf: add naneng
> > > combo phy register compatible") as that was wrongly merged, so better to
> > > drop the wrong patch
> > >
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > > I am applying this to phy-next to fix the issue
> >
> > Reverting will just cause a different warning that it is undocumented.
>
> Right, but a patch for that would fix that
>
> > The fix in the other thread won't apply either if you revert.
>
> It is not applying for me, so that needs to be updated anyways..

It seems phy-next has fallen out of sync with -next.
It's missing this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/soc/rockchip/grf.yaml?h=next-20220302&id=7dbb47d64acf4aac131a2aaade726913aa62abe7

>
> --
> ~Vinod
