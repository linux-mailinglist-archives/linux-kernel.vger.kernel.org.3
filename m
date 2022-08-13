Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1E591B81
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbiHMPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiHMPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:37:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6D22BD1;
        Sat, 13 Aug 2022 08:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14A7EB80688;
        Sat, 13 Aug 2022 15:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928BEC433D6;
        Sat, 13 Aug 2022 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660405045;
        bh=YKS5k8HQOL4Skk22H+cxjJPrMUDWvdWUTz36jDqZAJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cXROFHWGoInf1pK354gp5Gb9NyimQMtBez5XiY9JTc+SxkCr6CWCJe+n2oZqHfzlH
         wfzhWVtq6NHlL5/TjcUp4bmN36+oYBF5bh041xeTET3yfGzrenYrA0fDV7khptS650
         zb5W4MOzma2Xk26UWd8/VQLvRxwsrTO8C2J5P992bopRmg1EIpDz8gOorUsKv3Ii7F
         Qy+gg6gmNcisR4OqIC402ov2Evvymt2UYJXnySgcq0igmFxGrnoADcSwhpGGeuT+wA
         JccQ8kCw2Jy7xQMfLherw5k43kwBXycb4aj4+Rft3sWzV5XyMZrS3FQxr8QZW/NcNO
         qDKiTP1zMFlUw==
Date:   Sat, 13 Aug 2022 16:47:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v7 06/13] dt-bindings: mfd: Add MediaTek MT6370
Message-ID: <20220813164748.0c5564c2@jic23-huawei>
In-Reply-To: <YvJdpq0MWNPQZw5c@google.com>
References: <20220805070610.3516-1-peterwu.pub@gmail.com>
        <20220805070610.3516-7-peterwu.pub@gmail.com>
        <YvJdpq0MWNPQZw5c@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 14:14:14 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Fri, 05 Aug 2022, ChiaEn Wu wrote:
> 
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > Add MediaTek MT6370 binding documentation.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > ---
> >  .../devicetree/bindings/mfd/mediatek,mt6370.yaml   | 280 +++++++++++++++++++++
> >  include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  |  18 ++
> >  2 files changed, 298 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> >  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  
> 
> Applied, thanks.
> 
Hi Lee,

The iio: adc: patch is dependent on this (due to the binding header) -
so either you should pick that up as well, or it'll get delayed until what
you've picked up is available upstream - or I guess some hackery to allow them
to go via different trees and flip to the header only once all the prior steps
are in place.

Note I'd messed up sending an Ack on the ADC patch which I've now fixed.

Thanks,

Jonathan


