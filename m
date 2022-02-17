Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2314B94EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiBQAYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:24:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBQAYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:24:32 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD92A97F5;
        Wed, 16 Feb 2022 16:24:17 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id y20so1834595iod.1;
        Wed, 16 Feb 2022 16:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d7Od8dIn85e3Xy9cQ9vIGOTn1xmgXrdHDODzZdDnhiY=;
        b=5pFGdmMhGyp5j3uDeqT+rS97Sel+5+kpN9gQlVu+OAU0fWXKMNpjhmVZuB+9iVJ1p7
         GmM3CGeIXnJZOmeoKPrROhwBtjs1GJWwzETrShAly6367WO18lka/mJl1ZBA9kr5gAI/
         4mHNad5/cA8sgmrWcnvT4my2KpRBLeqsvczPMg8+c7qwSAVxqdOmb7IvrXzjhj3tgjXD
         tuDY+ncdIuJtHbXN3Ez8MPEHz1kFn2SmNZd32DgOP1lOaWK+ZlXJzG/ivdM7UGmh4rba
         jm5iegQp1Kv8FrkF+LdJb5djO4WB6a95GNwl6T2L9lnfflaL6GKA5RpxV+jEaJvDiJrO
         Nrog==
X-Gm-Message-State: AOAM530+W69MSEFlGVuX5ElqT76zje4cAahiibHpAC4+A0zJuQAvsZuG
        ODegZkj+KpfQiBo1Mo7m2A==
X-Google-Smtp-Source: ABdhPJwPiqCKCzxq4T0+jgrCbDyFfMya37xtwu5Rp4CnyYl8GRRZiFWr4uXT1XfqZ14/0Upl4S3EzQ==
X-Received: by 2002:a05:6638:f95:b0:314:58f9:5896 with SMTP id h21-20020a0566380f9500b0031458f95896mr282378jal.228.1645057457077;
        Wed, 16 Feb 2022 16:24:17 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z11sm871280iow.17.2022.02.16.16.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 16:24:16 -0800 (PST)
Received: (nullmailer pid 1964169 invoked by uid 1000);
        Thu, 17 Feb 2022 00:24:14 -0000
Date:   Wed, 16 Feb 2022 18:24:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kane Jiang <jian.jiang@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH 3/3] Add i.MX8MM GPT input capture example.
Message-ID: <Yg2VrswIr5xknsvk@robh.at.kernel.org>
References: <20220210084335.1979778-1-jian.jiang@nxp.com>
 <20220210084335.1979778-4-jian.jiang@nxp.com>
 <1644504472.335356.2624783.nullmailer@robh.at.kernel.org>
 <DB8PR04MB5771F8F410BF86F66F04E97C9A309@DB8PR04MB5771.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8PR04MB5771F8F410BF86F66F04E97C9A309@DB8PR04MB5771.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 08:40:45AM +0000, Kane Jiang wrote:
> Hi Rob,

Please do not top post and wrap your lines. IOW, use a mail client 
compatible with maillists (Outlook is not).

You also need to read submitting-patches.rst. The subjects of your 
patches don't follow kernel conventions.

> 
> Thanks for your check.
> These warnings were not caused by my patches. They were there without 
> my patch, fsl,imxgpt.yaml misses lots of i.MX chips.

Yes, my message pointed that out.

> How about I remove the compatible string change in 0002 patch and 
> remove the 0003 patch? Later I may update the fsl,imxgpt.yaml totally. 

I don't know. I only care about warnings shrinking, not growing. It's up 
to i.MX folks to figure out how to go about doing that. 

Rob

> 
> All the Best
> Kane Jiang
> 
> -----Original Message-----
> From: Rob Herring <robh@kernel.org> 
> Sent: Thursday, February 10, 2022 22:48
> To: Kane Jiang <jian.jiang@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>; Steve Longerbeam <slongerbeam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer <s.hauer@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org; Daniel Lezcano <daniel.lezcano@linaro.org>; Fabio Estevam <festevam@gmail.com>; Thomas Gleixner <tglx@linutronix.de>; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH 3/3] Add i.MX8MM GPT input capture example.
> 
> Caution: EXT Email
> 
> On Thu, 10 Feb 2022 16:43:35 +0800, Kane Jiang wrote:
> > Cause i.MX GPT dts example cannot match i.MX8 chip series.
> > So add NXP i.MX8MM chip GPT input capture function example to yaml 
> > file.
> >
> > Signed-off-by: Kane Jiang <jian.jiang@nxp.com>
> > ---
> >  .../devicetree/bindings/timer/fsl,imxgpt.yaml | 48 
> > +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> 
> Running 'make dtbs_check' with the schema in this patch gives the following warnings. Consider if they are expected or the schema is incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F1590920&amp;data=04%7C01%7Cjian.jiang%40nxp.com%7C393dc52f32cf4ef317f008d9eca4546f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637801012814081451%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nl0FYBbRdqpHTKcz7i9dReTOXjY8NiQDEhsvudfKoug%3D&amp;reserved=0
> 
> 
> timer@2098000: clock-names: ['ipg', 'per', 'osc_per'] is too long
>         arch/arm/boot/dts/imx6dl-alti6p.dt.yaml
>         arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml
>         arch/arm/boot/dts/imx6dl-aristainetos2_4.dt.yaml
>         arch/arm/boot/dts/imx6dl-aristainetos2_7.dt.yaml
>         arch/arm/boot/dts/imx6dl-aristainetos_4.dt.yaml
>         arch/arm/boot/dts/imx6dl-aristainetos_7.dt.yaml
>         arch/arm/boot/dts/imx6dl-b105pv2.dt.yaml
>         arch/arm/boot/dts/imx6dl-b105v2.dt.yaml
>         arch/arm/boot/dts/imx6dl-b125pv2.dt.yaml
>         arch/arm/boot/dts/imx6dl-b125v2.dt.yaml
>         arch/arm/boot/dts/imx6dl-b155v2.dt.yaml
>         arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6dl-cubox-i.dt.yaml
>         arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dt.yaml
>         arch/arm/boot/dts/imx6dl-dhcom-picoitx.dt.yaml
>         arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dt.yaml
>         arch/arm/boot/dts/imx6dl-emcon-avari.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw51xx.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw52xx.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw53xx.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw54xx.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw551x.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw552x.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw553x.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw560x.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5903.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5904.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5907.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5910.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5912.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5913.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard2.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-icore.dt.yaml
>         arch/arm/boot/dts/imx6dl-icore-mipi.dt.yaml
>         arch/arm/boot/dts/imx6dl-icore-rqs.dt.yaml
>         arch/arm/boot/dts/imx6dl-lanmcu.dt.yaml
>         arch/arm/boot/dts/imx6dl-mamoj.dt.yaml
>         arch/arm/boot/dts/imx6dl-mba6a.dt.yaml
>         arch/arm/boot/dts/imx6dl-mba6b.dt.yaml
>         arch/arm/boot/dts/imx6dl-nit6xlite.dt.yaml
>         arch/arm/boot/dts/imx6dl-nitrogen6x.dt.yaml
>         arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6dl-phytec-pbab01.dt.yaml
>         arch/arm/boot/dts/imx6dl-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx6dl-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx6dl-pico-nymph.dt.yaml
>         arch/arm/boot/dts/imx6dl-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx6dl-plybas.dt.yaml
>         arch/arm/boot/dts/imx6dl-plym2m.dt.yaml
>         arch/arm/boot/dts/imx6dl-prtmvt.dt.yaml
>         arch/arm/boot/dts/imx6dl-prtrvt.dt.yaml
>         arch/arm/boot/dts/imx6dl-prtvt7.dt.yaml
>         arch/arm/boot/dts/imx6dl-rex-basic.dt.yaml
>         arch/arm/boot/dts/imx6dl-riotboard.dt.yaml
>         arch/arm/boot/dts/imx6dl-sabreauto.dt.yaml
>         arch/arm/boot/dts/imx6dl-sabrelite.dt.yaml
>         arch/arm/boot/dts/imx6dl-sabresd.dt.yaml
>         arch/arm/boot/dts/imx6dl-savageboard.dt.yaml
>         arch/arm/boot/dts/imx6dl-skov-revc-lt2.dt.yaml
>         arch/arm/boot/dts/imx6dl-skov-revc-lt6.dt.yaml
>         arch/arm/boot/dts/imx6dl-solidsense.dt.yaml
>         arch/arm/boot/dts/imx6dl-ts4900.dt.yaml
>         arch/arm/boot/dts/imx6dl-ts7970.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6dl-comtft.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6s-8034.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6s-8035.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-801x.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-8033.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-811x.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-udoo.dt.yaml
>         arch/arm/boot/dts/imx6dl-victgo.dt.yaml
>         arch/arm/boot/dts/imx6dl-vicut1.dt.yaml
>         arch/arm/boot/dts/imx6dl-wandboard.dt.yaml
>         arch/arm/boot/dts/imx6dl-wandboard-revb1.dt.yaml
>         arch/arm/boot/dts/imx6dl-wandboard-revd1.dt.yaml
>         arch/arm/boot/dts/imx6dl-yapp4-draco.dt.yaml
>         arch/arm/boot/dts/imx6dl-yapp4-hydra.dt.yaml
>         arch/arm/boot/dts/imx6dl-yapp4-orion.dt.yaml
>         arch/arm/boot/dts/imx6dl-yapp4-ursa.dt.yaml
>         arch/arm/boot/dts/imx6q-apalis-eval.dt.yaml
>         arch/arm/boot/dts/imx6q-apalis-ixora.dt.yaml
>         arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dt.yaml
>         arch/arm/boot/dts/imx6q-apf6dev.dt.yaml
>         arch/arm/boot/dts/imx6q-arm2.dt.yaml
>         arch/arm/boot/dts/imx6q-b450v3.dt.yaml
>         arch/arm/boot/dts/imx6q-b650v3.dt.yaml
>         arch/arm/boot/dts/imx6q-b850v3.dt.yaml
>         arch/arm/boot/dts/imx6q-cm-fx6.dt.yaml
>         arch/arm/boot/dts/imx6q-cubox-i.dt.yaml
>         arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-cubox-i-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-dfi-fs700-m60.dt.yaml
>         arch/arm/boot/dts/imx6q-dhcom-pdk2.dt.yaml
>         arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dt.yaml
>         arch/arm/boot/dts/imx6q-dmo-edmqmx6.dt.yaml
>         arch/arm/boot/dts/imx6q-dms-ba16.dt.yaml
>         arch/arm/boot/dts/imx6q-ds.dt.yaml
>         arch/arm/boot/dts/imx6q-emcon-avari.dt.yaml
>         arch/arm/boot/dts/imx6q-evi.dt.yaml
>         arch/arm/boot/dts/imx6q-gk802.dt.yaml
>         arch/arm/boot/dts/imx6q-gw51xx.dt.yaml
>         arch/arm/boot/dts/imx6q-gw52xx.dt.yaml
>         arch/arm/boot/dts/imx6q-gw53xx.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5400-a.dt.yaml
>         arch/arm/boot/dts/imx6q-gw54xx.dt.yaml
>         arch/arm/boot/dts/imx6q-gw551x.dt.yaml
>         arch/arm/boot/dts/imx6q-gw552x.dt.yaml
>         arch/arm/boot/dts/imx6q-gw553x.dt.yaml
>         arch/arm/boot/dts/imx6q-gw560x.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5903.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5904.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5907.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5910.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5912.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5913.dt.yaml
>         arch/arm/boot/dts/imx6q-h100.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard2.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-icore.dt.yaml
>         arch/arm/boot/dts/imx6q-icore-mipi.dt.yaml
>         arch/arm/boot/dts/imx6q-icore-ofcap10.dt.yaml
>         arch/arm/boot/dts/imx6q-icore-ofcap12.dt.yaml
>         arch/arm/boot/dts/imx6q-icore-rqs.dt.yaml
>         arch/arm/boot/dts/imx6q-kp-tpc.dt.yaml
>         arch/arm/boot/dts/imx6q-logicpd.dt.yaml
>         arch/arm/boot/dts/imx6q-marsboard.dt.yaml
>         arch/arm/boot/dts/imx6q-mba6a.dt.yaml
>         arch/arm/boot/dts/imx6q-mba6b.dt.yaml
>         arch/arm/boot/dts/imx6q-mccmon6.dt.yaml
>         arch/arm/boot/dts/imx6q-nitrogen6_max.dt.yaml
>         arch/arm/boot/dts/imx6q-nitrogen6_som2.dt.yaml
>         arch/arm/boot/dts/imx6q-nitrogen6x.dt.yaml
>         arch/arm/boot/dts/imx6q-novena.dt.yaml
>         arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dt.yaml
>         arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6q-phytec-pbab01.dt.yaml
>         arch/arm/boot/dts/imx6q-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx6q-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx6q-pico-nymph.dt.yaml
>         arch/arm/boot/dts/imx6q-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx6q-pistachio.dt.yaml
>         arch/arm/boot/dts/imx6qp-mba6b.dt.yaml
>         arch/arm/boot/dts/imx6qp-nitrogen6_max.dt.yaml
>         arch/arm/boot/dts/imx6qp-nitrogen6_som2.dt.yaml
>         arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6qp-prtwd3.dt.yaml
>         arch/arm/boot/dts/imx6q-prti6q.dt.yaml
>         arch/arm/boot/dts/imx6q-prtwd2.dt.yaml
>         arch/arm/boot/dts/imx6qp-sabreauto.dt.yaml
>         arch/arm/boot/dts/imx6qp-sabresd.dt.yaml
>         arch/arm/boot/dts/imx6qp-tx6qp-8037.dt.yaml
>         arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dt.yaml
>         arch/arm/boot/dts/imx6qp-tx6qp-8137.dt.yaml
>         arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dt.yaml
>         arch/arm/boot/dts/imx6qp-vicutp.dt.yaml
>         arch/arm/boot/dts/imx6qp-wandboard-revd1.dt.yaml
>         arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dt.yaml
>         arch/arm/boot/dts/imx6qp-zii-rdu2.dt.yaml
>         arch/arm/boot/dts/imx6q-rex-pro.dt.yaml
>         arch/arm/boot/dts/imx6q-sabreauto.dt.yaml
>         arch/arm/boot/dts/imx6q-sabrelite.dt.yaml
>         arch/arm/boot/dts/imx6q-sabresd.dt.yaml
>         arch/arm/boot/dts/imx6q-savageboard.dt.yaml
>         arch/arm/boot/dts/imx6q-sbc6x.dt.yaml
>         arch/arm/boot/dts/imx6q-skov-revc-lt2.dt.yaml
>         arch/arm/boot/dts/imx6q-skov-revc-lt6.dt.yaml
>         arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dt.yaml
>         arch/arm/boot/dts/imx6q-solidsense.dt.yaml
>         arch/arm/boot/dts/imx6q-tbs2910.dt.yaml
>         arch/arm/boot/dts/imx6q-ts4900.dt.yaml
>         arch/arm/boot/dts/imx6q-ts7970.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1010.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1020.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1036.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1110.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dt.yaml
>         arch/arm/boot/dts/imx6q-udoo.dt.yaml
>         arch/arm/boot/dts/imx6q-utilite-pro.dt.yaml
>         arch/arm/boot/dts/imx6q-var-dt6customboard.dt.yaml
>         arch/arm/boot/dts/imx6q-vicut1.dt.yaml
>         arch/arm/boot/dts/imx6q-wandboard.dt.yaml
>         arch/arm/boot/dts/imx6q-wandboard-revb1.dt.yaml
>         arch/arm/boot/dts/imx6q-wandboard-revd1.dt.yaml
>         arch/arm/boot/dts/imx6q-yapp4-crux.dt.yaml
>         arch/arm/boot/dts/imx6q-zii-rdu2.dt.yaml
>         arch/arm/boot/dts/imx6s-dhcom-drc02.dt.yaml
> 
> timer@2098000: clocks: [[2, 119], [2, 120], [2, 237]] is too long
>         arch/arm/boot/dts/imx6dl-alti6p.dt.yaml
>         arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml
>         arch/arm/boot/dts/imx6dl-aristainetos2_4.dt.yaml
>         arch/arm/boot/dts/imx6dl-aristainetos2_7.dt.yaml
>         arch/arm/boot/dts/imx6dl-aristainetos_4.dt.yaml
>         arch/arm/boot/dts/imx6dl-aristainetos_7.dt.yaml
>         arch/arm/boot/dts/imx6dl-b105pv2.dt.yaml
>         arch/arm/boot/dts/imx6dl-b105v2.dt.yaml
>         arch/arm/boot/dts/imx6dl-b125pv2.dt.yaml
>         arch/arm/boot/dts/imx6dl-b125v2.dt.yaml
>         arch/arm/boot/dts/imx6dl-b155v2.dt.yaml
>         arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6dl-cubox-i.dt.yaml
>         arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dt.yaml
>         arch/arm/boot/dts/imx6dl-dhcom-picoitx.dt.yaml
>         arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dt.yaml
>         arch/arm/boot/dts/imx6dl-emcon-avari.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw51xx.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw52xx.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw53xx.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw54xx.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw551x.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw552x.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw553x.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw560x.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5903.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5904.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5907.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5910.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5912.dt.yaml
>         arch/arm/boot/dts/imx6dl-gw5913.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard2.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6dl-icore.dt.yaml
>         arch/arm/boot/dts/imx6dl-icore-mipi.dt.yaml
>         arch/arm/boot/dts/imx6dl-icore-rqs.dt.yaml
>         arch/arm/boot/dts/imx6dl-lanmcu.dt.yaml
>         arch/arm/boot/dts/imx6dl-mamoj.dt.yaml
>         arch/arm/boot/dts/imx6dl-mba6a.dt.yaml
>         arch/arm/boot/dts/imx6dl-mba6b.dt.yaml
>         arch/arm/boot/dts/imx6dl-nit6xlite.dt.yaml
>         arch/arm/boot/dts/imx6dl-nitrogen6x.dt.yaml
>         arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6dl-phytec-pbab01.dt.yaml
>         arch/arm/boot/dts/imx6dl-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx6dl-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx6dl-pico-nymph.dt.yaml
>         arch/arm/boot/dts/imx6dl-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx6dl-plybas.dt.yaml
>         arch/arm/boot/dts/imx6dl-plym2m.dt.yaml
>         arch/arm/boot/dts/imx6dl-prtmvt.dt.yaml
>         arch/arm/boot/dts/imx6dl-prtrvt.dt.yaml
>         arch/arm/boot/dts/imx6dl-prtvt7.dt.yaml
>         arch/arm/boot/dts/imx6dl-rex-basic.dt.yaml
>         arch/arm/boot/dts/imx6dl-riotboard.dt.yaml
>         arch/arm/boot/dts/imx6dl-sabreauto.dt.yaml
>         arch/arm/boot/dts/imx6dl-sabrelite.dt.yaml
>         arch/arm/boot/dts/imx6dl-sabresd.dt.yaml
>         arch/arm/boot/dts/imx6dl-savageboard.dt.yaml
>         arch/arm/boot/dts/imx6dl-skov-revc-lt2.dt.yaml
>         arch/arm/boot/dts/imx6dl-skov-revc-lt6.dt.yaml
>         arch/arm/boot/dts/imx6dl-solidsense.dt.yaml
>         arch/arm/boot/dts/imx6dl-ts4900.dt.yaml
>         arch/arm/boot/dts/imx6dl-ts7970.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6dl-comtft.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6s-8034.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6s-8035.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-801x.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-8033.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-811x.dt.yaml
>         arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dt.yaml
>         arch/arm/boot/dts/imx6dl-udoo.dt.yaml
>         arch/arm/boot/dts/imx6dl-victgo.dt.yaml
>         arch/arm/boot/dts/imx6dl-vicut1.dt.yaml
>         arch/arm/boot/dts/imx6dl-wandboard.dt.yaml
>         arch/arm/boot/dts/imx6dl-wandboard-revb1.dt.yaml
>         arch/arm/boot/dts/imx6dl-wandboard-revd1.dt.yaml
>         arch/arm/boot/dts/imx6dl-yapp4-draco.dt.yaml
>         arch/arm/boot/dts/imx6dl-yapp4-hydra.dt.yaml
>         arch/arm/boot/dts/imx6dl-yapp4-orion.dt.yaml
>         arch/arm/boot/dts/imx6dl-yapp4-ursa.dt.yaml
>         arch/arm/boot/dts/imx6q-apalis-eval.dt.yaml
>         arch/arm/boot/dts/imx6q-apalis-ixora.dt.yaml
>         arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dt.yaml
>         arch/arm/boot/dts/imx6q-apf6dev.dt.yaml
>         arch/arm/boot/dts/imx6q-arm2.dt.yaml
>         arch/arm/boot/dts/imx6q-b450v3.dt.yaml
>         arch/arm/boot/dts/imx6q-b650v3.dt.yaml
>         arch/arm/boot/dts/imx6q-b850v3.dt.yaml
>         arch/arm/boot/dts/imx6q-cm-fx6.dt.yaml
>         arch/arm/boot/dts/imx6q-cubox-i.dt.yaml
>         arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-cubox-i-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-dfi-fs700-m60.dt.yaml
>         arch/arm/boot/dts/imx6q-dhcom-pdk2.dt.yaml
>         arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dt.yaml
>         arch/arm/boot/dts/imx6q-dmo-edmqmx6.dt.yaml
>         arch/arm/boot/dts/imx6q-dms-ba16.dt.yaml
>         arch/arm/boot/dts/imx6q-ds.dt.yaml
>         arch/arm/boot/dts/imx6q-emcon-avari.dt.yaml
>         arch/arm/boot/dts/imx6q-evi.dt.yaml
>         arch/arm/boot/dts/imx6q-gk802.dt.yaml
>         arch/arm/boot/dts/imx6q-gw51xx.dt.yaml
>         arch/arm/boot/dts/imx6q-gw52xx.dt.yaml
>         arch/arm/boot/dts/imx6q-gw53xx.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5400-a.dt.yaml
>         arch/arm/boot/dts/imx6q-gw54xx.dt.yaml
>         arch/arm/boot/dts/imx6q-gw551x.dt.yaml
>         arch/arm/boot/dts/imx6q-gw552x.dt.yaml
>         arch/arm/boot/dts/imx6q-gw553x.dt.yaml
>         arch/arm/boot/dts/imx6q-gw560x.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5903.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5904.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5907.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5910.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5912.dt.yaml
>         arch/arm/boot/dts/imx6q-gw5913.dt.yaml
>         arch/arm/boot/dts/imx6q-h100.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard2.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-hummingboard-som-v15.dt.yaml
>         arch/arm/boot/dts/imx6q-icore.dt.yaml
>         arch/arm/boot/dts/imx6q-icore-mipi.dt.yaml
>         arch/arm/boot/dts/imx6q-icore-ofcap10.dt.yaml
>         arch/arm/boot/dts/imx6q-icore-ofcap12.dt.yaml
>         arch/arm/boot/dts/imx6q-icore-rqs.dt.yaml
>         arch/arm/boot/dts/imx6q-kp-tpc.dt.yaml
>         arch/arm/boot/dts/imx6q-logicpd.dt.yaml
>         arch/arm/boot/dts/imx6q-marsboard.dt.yaml
>         arch/arm/boot/dts/imx6q-mba6a.dt.yaml
>         arch/arm/boot/dts/imx6q-mba6b.dt.yaml
>         arch/arm/boot/dts/imx6q-mccmon6.dt.yaml
>         arch/arm/boot/dts/imx6q-nitrogen6_max.dt.yaml
>         arch/arm/boot/dts/imx6q-nitrogen6_som2.dt.yaml
>         arch/arm/boot/dts/imx6q-nitrogen6x.dt.yaml
>         arch/arm/boot/dts/imx6q-novena.dt.yaml
>         arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dt.yaml
>         arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6q-phytec-pbab01.dt.yaml
>         arch/arm/boot/dts/imx6q-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx6q-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx6q-pico-nymph.dt.yaml
>         arch/arm/boot/dts/imx6q-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx6q-pistachio.dt.yaml
>         arch/arm/boot/dts/imx6qp-mba6b.dt.yaml
>         arch/arm/boot/dts/imx6qp-nitrogen6_max.dt.yaml
>         arch/arm/boot/dts/imx6qp-nitrogen6_som2.dt.yaml
>         arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6qp-prtwd3.dt.yaml
>         arch/arm/boot/dts/imx6q-prti6q.dt.yaml
>         arch/arm/boot/dts/imx6q-prtwd2.dt.yaml
>         arch/arm/boot/dts/imx6qp-sabreauto.dt.yaml
>         arch/arm/boot/dts/imx6qp-sabresd.dt.yaml
>         arch/arm/boot/dts/imx6qp-tx6qp-8037.dt.yaml
>         arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dt.yaml
>         arch/arm/boot/dts/imx6qp-tx6qp-8137.dt.yaml
>         arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dt.yaml
>         arch/arm/boot/dts/imx6qp-vicutp.dt.yaml
>         arch/arm/boot/dts/imx6qp-wandboard-revd1.dt.yaml
>         arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dt.yaml
>         arch/arm/boot/dts/imx6qp-zii-rdu2.dt.yaml
>         arch/arm/boot/dts/imx6q-rex-pro.dt.yaml
>         arch/arm/boot/dts/imx6q-sabreauto.dt.yaml
>         arch/arm/boot/dts/imx6q-sabrelite.dt.yaml
>         arch/arm/boot/dts/imx6q-sabresd.dt.yaml
>         arch/arm/boot/dts/imx6q-savageboard.dt.yaml
>         arch/arm/boot/dts/imx6q-sbc6x.dt.yaml
>         arch/arm/boot/dts/imx6q-skov-revc-lt2.dt.yaml
>         arch/arm/boot/dts/imx6q-skov-revc-lt6.dt.yaml
>         arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dt.yaml
>         arch/arm/boot/dts/imx6q-solidsense.dt.yaml
>         arch/arm/boot/dts/imx6q-tbs2910.dt.yaml
>         arch/arm/boot/dts/imx6q-ts4900.dt.yaml
>         arch/arm/boot/dts/imx6q-ts7970.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1010.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1020.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1036.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-1110.dt.yaml
>         arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dt.yaml
>         arch/arm/boot/dts/imx6q-udoo.dt.yaml
>         arch/arm/boot/dts/imx6q-utilite-pro.dt.yaml
>         arch/arm/boot/dts/imx6q-var-dt6customboard.dt.yaml
>         arch/arm/boot/dts/imx6q-vicut1.dt.yaml
>         arch/arm/boot/dts/imx6q-wandboard.dt.yaml
>         arch/arm/boot/dts/imx6q-wandboard-revb1.dt.yaml
>         arch/arm/boot/dts/imx6q-wandboard-revd1.dt.yaml
>         arch/arm/boot/dts/imx6q-yapp4-crux.dt.yaml
>         arch/arm/boot/dts/imx6q-zii-rdu2.dt.yaml
>         arch/arm/boot/dts/imx6s-dhcom-drc02.dt.yaml
> 
> timer@2098000: compatible: 'oneOf' conditional failed, one must be fixed:
>         arch/arm/boot/dts/imx6sl-evk.dt.yaml
>         arch/arm/boot/dts/imx6sll-evk.dt.yaml
>         arch/arm/boot/dts/imx6sll-kobo-clarahd.dt.yaml
>         arch/arm/boot/dts/imx6sll-kobo-librah2o.dt.yaml
>         arch/arm/boot/dts/imx6sl-tolino-shine2hd.dt.yaml
>         arch/arm/boot/dts/imx6sl-tolino-shine3.dt.yaml
>         arch/arm/boot/dts/imx6sl-tolino-vision5.dt.yaml
>         arch/arm/boot/dts/imx6sl-warp.dt.yaml
>         arch/arm/boot/dts/imx6ul-14x14-evk.dt.yaml
>         arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dt.yaml
>         arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dt.yaml
>         arch/arm/boot/dts/imx6ul-geam.dt.yaml
>         arch/arm/boot/dts/imx6ul-isiot-emmc.dt.yaml
>         arch/arm/boot/dts/imx6ul-isiot-nand.dt.yaml
>         arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dt.yaml
>         arch/arm/boot/dts/imx6ul-kontron-n6310-s.dt.yaml
>         arch/arm/boot/dts/imx6ull-14x14-evk.dt.yaml
>         arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6ull-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6ul-liteboard.dt.yaml
>         arch/arm/boot/dts/imx6ull-jozacp.dt.yaml
>         arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dt.yaml
>         arch/arm/boot/dts/imx6ull-opos6uldev.dt.yaml
>         arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dt.yaml
>         arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6ul-opos6uldev.dt.yaml
>         arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dt.yaml
>         arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6ul-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx6ul-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx6ul-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx6ul-prti6g.dt.yaml
>         arch/arm/boot/dts/imx6ul-tx6ul-0010.dt.yaml
>         arch/arm/boot/dts/imx6ul-tx6ul-0011.dt.yaml
>         arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dt.yaml
>         arch/arm/boot/dts/imx6ulz-14x14-evk.dt.yaml
>         arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dt.yaml
> 
> timer@20e8000: compatible: 'oneOf' conditional failed, one must be fixed:
>         arch/arm/boot/dts/imx6ul-14x14-evk.dt.yaml
>         arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dt.yaml
>         arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dt.yaml
>         arch/arm/boot/dts/imx6ul-geam.dt.yaml
>         arch/arm/boot/dts/imx6ul-isiot-emmc.dt.yaml
>         arch/arm/boot/dts/imx6ul-isiot-nand.dt.yaml
>         arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dt.yaml
>         arch/arm/boot/dts/imx6ul-kontron-n6310-s.dt.yaml
>         arch/arm/boot/dts/imx6ull-14x14-evk.dt.yaml
>         arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6ull-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx6ul-liteboard.dt.yaml
>         arch/arm/boot/dts/imx6ull-jozacp.dt.yaml
>         arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dt.yaml
>         arch/arm/boot/dts/imx6ull-opos6uldev.dt.yaml
>         arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dt.yaml
>         arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6ul-opos6uldev.dt.yaml
>         arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dt.yaml
>         arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dt.yaml
>         arch/arm/boot/dts/imx6ul-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx6ul-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx6ul-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx6ul-prti6g.dt.yaml
>         arch/arm/boot/dts/imx6ul-tx6ul-0010.dt.yaml
>         arch/arm/boot/dts/imx6ul-tx6ul-0011.dt.yaml
>         arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dt.yaml
> 
> timer@302d0000: compatible: 'oneOf' conditional failed, one must be fixed:
>         arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
>         arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
>         arch/arm/boot/dts/imx7d-mba7.dt.yaml
>         arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
>         arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
>         arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
>         arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
>         arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
>         arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
>         arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7s-mba7.dt.yaml
>         arch/arm/boot/dts/imx7s-warp.dt.yaml
> 
> timer@302e0000: compatible: 'oneOf' conditional failed, one must be fixed:
>         arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
>         arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
>         arch/arm/boot/dts/imx7d-mba7.dt.yaml
>         arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
>         arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
>         arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
>         arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
>         arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
>         arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
>         arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7s-mba7.dt.yaml
>         arch/arm/boot/dts/imx7s-warp.dt.yaml
> 
> timer@302f0000: compatible: 'oneOf' conditional failed, one must be fixed:
>         arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
>         arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
>         arch/arm/boot/dts/imx7d-mba7.dt.yaml
>         arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
>         arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
>         arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
>         arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
>         arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
>         arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
>         arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7s-mba7.dt.yaml
>         arch/arm/boot/dts/imx7s-warp.dt.yaml
> 
> timer@30300000: compatible: 'oneOf' conditional failed, one must be fixed:
>         arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
>         arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
>         arch/arm/boot/dts/imx7d-mba7.dt.yaml
>         arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
>         arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
>         arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
>         arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
>         arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
>         arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
>         arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
>         arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
>         arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
>         arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
>         arch/arm/boot/dts/imx7s-mba7.dt.yaml
>         arch/arm/boot/dts/imx7s-warp.dt.yaml
> 
> timer@53f90000: compatible: 'oneOf' conditional failed, one must be fixed:
>         arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dt.yaml
>         arch/arm/boot/dts/imx35-pdk.dt.yaml
> 
> 
