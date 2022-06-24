Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7519C5598CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiFXLpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiFXLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:44:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484337B36C;
        Fri, 24 Jun 2022 04:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1671FB82863;
        Fri, 24 Jun 2022 11:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47759C34114;
        Fri, 24 Jun 2022 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071093;
        bh=SXL5zN2nwEilLgVy+817nWe3mGqIkwJPf3KT5KtK610=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqleerCUtjShMpTKt40R3Xw5bJcBgWctuyJJpVXDDC8yUC+px+coDFuFGOhsDclBm
         dg838WtwC4BaQ3bpEalZRbi71buK3vIaBJx8ZVhWnGCY1l7wOcJedOmOBaxgTuvbE9
         l08jW1kWCHcm0hwgtV4GmlCbpSkA1mpGB+nGFXvo=
Date:   Fri, 24 Jun 2022 13:33:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com, jic23@kernel.org,
        lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com, deller@gmx.de,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v3 08/14] usb: typec: tcpci_mt6370: Add Mediatek MT6370
 tcpci driver
Message-ID: <YrWhIMGjUeRkpHkB@kroah.com>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
 <20220623115631.22209-9-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623115631.22209-9-peterwu.pub@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 07:56:25PM +0800, ChiaEn Wu wrote:
> --- /dev/null
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6370.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0+

Are you sure you mean "+" here?

I have to ask, sorry.

And no copyright line?  Your company is ok with that, nice!  :)

thanks,

greg k-h
