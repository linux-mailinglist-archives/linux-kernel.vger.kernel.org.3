Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDEB52BD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiEROHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiEROHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:07:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600860A8B;
        Wed, 18 May 2022 07:07:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l19so2661958ljb.7;
        Wed, 18 May 2022 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUatQ9xZn9LWvvc+mLHXb05n0nL6xTDEP0ScWdFDiM0=;
        b=UTulVSX+Rey9WdkqBwoBNc4OSVPQhahjKH6xbHK6FBW0aHlMQyFMfQkaia/biOkV/p
         3Nz0cP1KZRyl3CCZQMRl9xAXVEVGKADEUhYm9FIQ0g3QE+1RodNHDbPr3ScNVDUtWLfy
         Faa6Rb6QxjWXqRtUAuN2FxM6z4ovRaPJyjFghNQp3OzjyqsNG1zDhbUmpEowCVnON530
         CrmW+BrY1VjZO/WYCnJov6KQQp2922pWYrDnq4HjMglTGh61rIaeoX/h/9pdWUo20BHd
         +uFwSbRhdRMfJpjPEtIWyYONTnh95ipsOB2wNBr0aPcetTmvOqH9a8zVclshK3PPMcQ2
         AfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUatQ9xZn9LWvvc+mLHXb05n0nL6xTDEP0ScWdFDiM0=;
        b=oSRlI3RLD1t/JXnqIFYHLIS47JYBpr5vkmc1OzcDgXPekamlruiHeatL2BbkHM9VUs
         UN9P1veE3Yz6cJ38bnglJ0mO37izVZfnZgSufBTD9bsnG27xQsGy376vlQfd7njjFc/a
         aCNorargKE75qqXyuW4zvy1+Ae2ee7gr9/HbTffLesFOUu544TCcfptbw26fdz+G/qLe
         +WePMi4G9Jw+mXs9Y+6ifznu6dbVMYO/bc4jILeP398biccuW+4Z6A+gPd7HYFx7YYC4
         7gqsT7g4qP8gBCXPiKbUxqQa8UHUbkgCPeIIQBN8iwWQdC7jPS2vP9OOoDCSMgwGU4fI
         21cQ==
X-Gm-Message-State: AOAM531N2VIshAc3+OuFSZMoYse68iAL5Ih+hGV9VPxXsFK5A7N9mQ1Y
        cKnKJ6nNP77Qu7T6291jUTojaFe9A3EUiFXDACshMMvl
X-Google-Smtp-Source: ABdhPJxy6I2TBeYmu+Es4D7wxTOZOFj1XQFiA7wbrOSGjx99NDBoGwPOlsY4xtRSGq50KcTGavY9QpVl34+Q1Vd+xxE=
X-Received: by 2002:a2e:b4b9:0:b0:253:bddf:d144 with SMTP id
 q25-20020a2eb4b9000000b00253bddfd144mr3839962ljm.505.1652882842578; Wed, 18
 May 2022 07:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-13-max.oss.09@gmail.com>
 <CAOMZO5DzVFRW=HF-oO96THqDqmHsJywityDKFF7YNZTtCdjAuw@mail.gmail.com>
In-Reply-To: <CAOMZO5DzVFRW=HF-oO96THqDqmHsJywityDKFF7YNZTtCdjAuw@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 18 May 2022 16:07:11 +0200
Message-ID: <CAEHkU3XR9_iVqes4mHrD-x+5Ae__1fAbv=U5R9Ae0TPPmwfAZw@mail.gmail.com>
Subject: Re: [PATCH v1 12/17] ARM: dts: imx6q-apalis: Add adv7280 video input
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

On Mon, May 16, 2022 at 2:10 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Max,
>
> On Mon, May 16, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> > +       adv_7280: adv7280@21 {
> > +               compatible = "adi,adv7280";
> > +               reg = <0x21>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_ipu1_csi0>;
>
> I suggest passing "adv,force-bt656-4" property as this fixes sync problems.

I will add the property in a V2 of the patchset. Thanks for the suggestion.
With my setup, i.e. PAL camera as the signal source I see no
noticeable change though.

Max
