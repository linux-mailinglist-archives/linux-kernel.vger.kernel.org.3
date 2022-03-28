Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9AD4E981E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbiC1N3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbiC1N25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:28:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8163E5E762;
        Mon, 28 Mar 2022 06:27:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w25so16894899edi.11;
        Mon, 28 Mar 2022 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PJXGZlpigjTh6H9JMMa18nQ2vBOjy1Eubx2lpLSUCN4=;
        b=P+Xah39W4u3PaDSAqPLufO5/H/K2gU2w/d2wFaGX2dVMn3ptW0NhEHGwzIdwRpRl/0
         z1FSOdPVtx96dA5F7FeFqr/xM+E7aaBMX+Jrr4ATSqkcDJ6ByLiqoci0ikB8zblEPzRr
         AgfVgEhpKJPDuyJpnsbMs0owuaCWieQCxknWTP5AisVim3x2oWgpvZspTe1rCjJ71yEY
         k1XEvY3EOHeoQH9GnIpyLgDu0KacloeGCU6qlaS6y84XNz0XNDoFZ24ZhfgNJ0IJhypy
         Itw+T2ZDe09wzSYH9OizIncV+P60OAXYspmhj2dwWHF5nT/b4EcIUOf1ZGBuS6ErOxv8
         XOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PJXGZlpigjTh6H9JMMa18nQ2vBOjy1Eubx2lpLSUCN4=;
        b=kwByqwyHsmgVDDXPEUBpuYWgXhcrIPFMA7ryqfL9ZyX5jmNIK9p/pLd10BBxV0sH/y
         5+cayCHfcZd4B2GbB8lJamLC7vtXyKdVIUdEOTkEw/6JC/RdgiBL7UfG6Wstp4mhwvFc
         s0cDiwH7/8dbURRbArn4WRHIb2+M6L6o4i8DI5Qo8H2g2CBpNW3OiK+1aSgpdI16dbUS
         clgbY1izjuJ72lqaHVsWcwlZJDYDUEtryKZgYcspg1TfpwJSX7XAQy+w54jz4B7zc2wA
         6MS+dkAQP60/sequTrK+5NC9AfCLx14j4Dv27JQAPybz5uRZEraq4P2x2m4vP7+2sZ16
         AXfg==
X-Gm-Message-State: AOAM531Pif7ptqV/rXgVy1sqKMokLrTxCaZqnrxa2V0Ap2A+H7zpdAhB
        oI+38FkUwNXRJh0cQklj3ss=
X-Google-Smtp-Source: ABdhPJzfZMouNxSUPChSrobO0DmZY1dpjyjoJXynXzykI+ox1dAeHmzyb365QAjutoruA3M7o01bCQ==
X-Received: by 2002:a05:6402:27d0:b0:419:5184:58ae with SMTP id c16-20020a05640227d000b00419518458aemr16315076ede.314.1648474034597;
        Mon, 28 Mar 2022 06:27:14 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id y16-20020aa7d510000000b004197c1cec7dsm6986648edq.6.2022.03.28.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:27:14 -0700 (PDT)
Date:   Mon, 28 Mar 2022 15:27:13 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <YkG3sQ3MDhVoW8l4@Ansuel-xps.localdomain>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <YkG2RPrtPaBNXb7a@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkG2RPrtPaBNXb7a@latitude>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 03:21:08PM +0200, Jonathan Neuschäfer wrote:
> On Mon, Mar 28, 2022 at 02:09:14AM +0200, Ansuel Smith wrote:
> > Hi,
> > as the title say, the intention of this ""series"" is to finally categorize
> > the ARM dts directory in subdirectory for each oem.
> [...]
> > [1] https://gist.github.com/Ansuel/47c49925ee7ef4b1dd035afc74679ab5
> > [2] https://gist.github.com/Ansuel/19f61f1e583c49407ce35c10e770fbe0
> 
> Nice idea, thank you!
> 
> A few notes on categorization below.
> 
> 
> >  create mode 100644 arch/arm/boot/dts/broadcom/Makefile
> >  rename arch/arm/boot/dts/{ => broadcom}/bcm-cygnus-clock.dtsi (100%)
> 
> Or maybe bcm instead of broadcom. Not sure which is preferred by
> Broadcom people.
> 

In arm64 they used broadcom so i assume the full name looks correct.

> >  create mode 100644 arch/arm/boot/dts/dove/Makefile
> >  rename arch/arm/boot/dts/{ => dove}/dove-cm-a510.dtsi (100%)
> 
> Arguably part of Marvell.
> 
> >  create mode 100644 arch/arm/boot/dts/edac/Makefile
> >  rename arch/arm/boot/dts/{ => edac}/ecx-2000.dts (100%)
> >  rename arch/arm/boot/dts/{ => edac}/ecx-common.dtsi (100%)
> >  rename arch/arm/boot/dts/{ => edac}/highbank.dts (100%)
> 
> Why edac?
> The most obvious name I can see here is calxeda.
> 
> >  create mode 100644 arch/arm/boot/dts/freescale/Makefile
> 
> Freescale has been part of NXP for a while, so it might make sense to
> merge the freescale and nxp directories. I can't speak for
> NXP-the-company, so that's just my view as a bystander.
> 
> >  create mode 100644 arch/arm/boot/dts/kirkwood/Makefile
> 
> The Kirkwood family should probably be sorted into Marvell.
> 
> >  create mode 100644 arch/arm/boot/dts/layerscape/Makefile
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a-moxa-uc-8410a.dts (100%)
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a-qds.dts (100%)
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a-tsn.dts (100%)
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a-twr.dts (100%)
> >  rename arch/arm/boot/dts/{ => layerscape}/ls1021a.dtsi (100%)
> 
> The Layerscape family is part of Freescale/NXP.
> 
> >  create mode 120000 arch/arm/boot/dts/nxp/armv7-m.dtsi
> 
> armv7-m.dtsi is a bit confusing, because it contains a few devices at
> fixed addresses, so it looks vendor-specific at a first glance into the
> file. However, if it is actually as vendor-neutral as the name implies,
> I think it should live dts/ directly, rather than in vendor
> subdirectories.
>

Considering it's really just 3 binding IMHO it should be just dropped
and merged in other dtsi... But lets not extend this too much.
This is really just a simplic link and armv7-m.dtsi is placed in dts/
I create links in each oem that includes it to skip any changes to the
dts.

> >  rename arch/arm/boot/dts/{ => nxp}/lpc18xx.dtsi (100%)
> 
> Here we have the NXP LPCxxxx family, which is AFAIK unrelated to the
> i.MX family (and thus the bulk of the Freescale legacy).
> 
> >  create mode 100644 arch/arm/boot/dts/vybrid/Makefile
> 
> Vybrid is another chip family of NXP, with a good deal of Freescale
> legacy in it as evidenced by the "fsl," prefix in the devicetrees.
> 
> 
> 
> Thanks,
> Jonathan

Thx for the hint hope to get more comments about the dubious
categorization about nxp and freescale.

-- 
	Ansuel
