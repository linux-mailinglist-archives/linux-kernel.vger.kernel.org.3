Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648514E9600
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiC1L7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiC1L5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:57:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F521251;
        Mon, 28 Mar 2022 04:55:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x34so16577589ede.8;
        Mon, 28 Mar 2022 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VBA2TVvDQq46dU+vDSFsKIjMbNiJuAyL+n01cA7mLg0=;
        b=OBOwZMzgqbA4Bri1W+TQyb45lBR8NViCvJYDlk5rJZKcVaCgWCV40Bf7Mv/7s4LQTo
         o61uoNoV320FDfTmAXy0OyXXsM6xbZnily3YKTr/Pe7gWFLFh2fymA9CCUGhWiDEZlLZ
         nNwep3nx1H6RuXTTVxqC1Ux9vx68yHHOYmvP8HexVe79FWRO9Iu3fNpeAYkfW2JkM+Vt
         qrh2k9qqmA2fYydHCfMeMdCIwVVoaxO4gxjQE8JAPqhrWkQW+6YiB4qavu4HrF1R3jtl
         KNxBJkSRciGcZ0Vf/9M87/6ctraLnA19Hi8Jr/TqhQEfd0ot10wekX5HmOo9zLRLpGu/
         NhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VBA2TVvDQq46dU+vDSFsKIjMbNiJuAyL+n01cA7mLg0=;
        b=5xbmGMr3p41Ab7JlLVIjiYRQiis+0OaAHxLWMY6GKtRhkmMaIHLhFkV3m2dufdTgU9
         SbVFfK/Aq+b3bQF9UBVowr3VFji2nEy356ww+RS95mskt2NURTVAuGQ6ar306XJzBWMf
         WblPf0tsSImMs7BukScdKyf7ePkXHHvA03ZdJpQNvuv6duApyiO7u4/m+uS1nYfk4QdL
         ytj+5u7znJ/ty7OpjexT6pK6PLOosjSDIhQBUWsAgHIwoEO9c5GhD7HnxK/lykUQ4uYX
         6sl6dAiuXayPgSNXYh61NTPQvL8azLRzaaOiywFCrDRvDdrDje1z+EHp/60CM/FOONEZ
         FXyQ==
X-Gm-Message-State: AOAM533pGEKxd88Vi26Wdf5F1/j5VByK3wY6gLINMztG7JI5yrmN/CDG
        BCS1IHwN7AoijsMJrsZ54Co=
X-Google-Smtp-Source: ABdhPJxl9m+FiC/OJjd+DqfT2L64nZ1Oy+3md9ABQHlV5EJnd26lo+025HjOApFZeOymI3r2eMPv3w==
X-Received: by 2002:a05:6402:1718:b0:419:564:6b62 with SMTP id y24-20020a056402171800b0041905646b62mr15482099edu.361.1648468502610;
        Mon, 28 Mar 2022 04:55:02 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id nb6-20020a1709071c8600b006e02910f818sm5859904ejc.157.2022.03.28.04.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:55:02 -0700 (PDT)
Date:   Mon, 28 Mar 2022 13:55:01 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-unisoc@lists.infradead.org" <linux-unisoc@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: Re: [RFC PATCH 1/1] ARM/arm64: categorize dts in arm dir and fix
 dependency in arm64
Message-ID: <YkGiFa9DSKpsSZou@Ansuel-xps.localdomain>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <20220328000915.15041-2-ansuelsmth@gmail.com>
 <20220328082858.GJ7371@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328082858.GJ7371@axis.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:28:58AM +0200, Jesper Nilsson wrote:
> Hi Ansuel,
> 
> On Mon, Mar 28, 2022 at 02:09:15AM +0200, Ansuel Smith wrote:
> > - Categorize every dts in arm directory in subdirectory
> > - Fix Makefile to address for the arm subdirectory
> > - Fix any arm64 dependency
> > [...]
> >  arch/arm/boot/dts/axix/Makefile               |    3 +
> >  .../boot/dts/{ => axix}/artpec6-devboard.dts  |    0
> >  arch/arm/boot/dts/{ => axix}/artpec6.dtsi     |    0
> 
> All ARTPEC platforms should be in a directory called "axis".
> Otherwise LGTM.
> 
> Thanks!
> 
> /^JN - Jesper Nilsson
> -- 
>                Jesper Nilsson -- jesper.nilsson@axis.com

Will do the change! Noted.

-- 
	Ansuel
