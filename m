Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEB5094CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383700AbiDUBus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 21:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbiDUBuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:50:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6CF1005;
        Wed, 20 Apr 2022 18:47:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so6453184pjb.2;
        Wed, 20 Apr 2022 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bawkkxUueWZhTJBAyzDirN0JxadLzFnsY+fabm9PJ/k=;
        b=WwiiiwizFYpMvxRzBfGQwVwY9/SLYA8/H5FOancrwj0xpRTkH6ys0a+U44ySnaHZ/v
         nifx4zlzE3K+3buH+nVfp3EEgG7RKQiKi6hmit8qBunb0YqtnJnOVe4UzQfWrJJu/KgA
         FmkJMRtFS24vHsEPjZdO6c3MkqqHReLT0wTvXsYUN3bp4bBFXJDuhyc5DrzA3vwomlms
         qvA5wJJj7uxTB2og8MRdLlxKdT3Gf5MUb2s5I0FMCcbsMAZTE08K6wlYfSdcctyt8zon
         UTqK1oK8OqeOcF05JQ2G/qpRM25L9BtSkh8MW68KdktqE9pKBq/BR/eEnwk2N3fXQQyg
         h7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bawkkxUueWZhTJBAyzDirN0JxadLzFnsY+fabm9PJ/k=;
        b=Tw1usIpmIt2Xk72t+ZY/qCJzEg+FsmhFn2T5KLZvtsbENyLvvD3xXhBMd23w07uzP+
         D3zxrBony496GSqQq46zSQ66WciKg0gAbnTs3Lu1mtrkCQvBmiPsy5IUU8cnXZhtEau4
         /6mlPY1RCE1pn79dSJSDhvdaajbX6hAzuh4AUqFFTvoOSJ1uQ1NwXgVzV55SeG7t3NVQ
         YkXAPA8reTBBKmVYwQQe73ghUx25X7LeHNruchGbTsMYLjPedbmrNmQrWnMdKLeyjioz
         pgE/xkMC6Z88vNbpQ7b6tfc2+SgTqGSv5kf7bvtBkxJ4TXYDHxRKrI4++ZvHcbB4WgcH
         Q2nw==
X-Gm-Message-State: AOAM531oemZBVMmDvRjYzDVTLYeNz0pcqwgl1gWualsEVzLZDL07Ad0y
        xDCPjmq8LJ9/bcPvszUP4eA=
X-Google-Smtp-Source: ABdhPJwTcSpVaiP2sKa+yRk09oSKLvTHkG7lGpeLttjvFrLKzBdw/AowFmslkLKzc7VVe4Uq42jEaQ==
X-Received: by 2002:a17:902:c451:b0:158:7729:f240 with SMTP id m17-20020a170902c45100b001587729f240mr23541055plm.17.1650505677561;
        Wed, 20 Apr 2022 18:47:57 -0700 (PDT)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:477:11a5:c0c0:d920:4378:bdeb])
        by smtp.gmail.com with ESMTPSA id p13-20020a056a000b4d00b004faecee6e89sm21755964pfo.208.2022.04.20.18.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2022 18:47:56 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:47:28 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Ren Zhijie <renzhijie2@huawei.com>, gregkh@linuxfoundation.org,
        cy_huang@richtek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, u0084500@gmail.com
Subject: Re: [PATCH -next] usb: typec: rt1719: Fix build error without
 CONFIG_POWER_SUPPLY
Message-ID: <20220421014727.GB29256@cyhuang-hp-elitebook-840-g3.rt>
References: <20220418082425.41566-1-renzhijie2@huawei.com>
 <Yl/NHAaXFh1UzFdI@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl/NHAaXFh1UzFdI@kuha.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:06:36PM +0300, Heikki Krogerus wrote:
> Mon, Apr 18, 2022 at 04:24:25PM +0800, Ren Zhijie kirjoitti:
> > Building without CONFIG_POWER_SUPPLY will fail:
> > 
> > drivers/usb/typec/rt1719.o: In function `rt1719_psy_set_property':
> > rt1719.c:(.text+0x10a): undefined reference to `power_supply_get_drvdata'
> > drivers/usb/typec/rt1719.o: In function `rt1719_psy_get_property':
> > rt1719.c:(.text+0x2c8): undefined reference to `power_supply_get_drvdata'
> > drivers/usb/typec/rt1719.o: In function `devm_rt1719_psy_register':
> > rt1719.c:(.text+0x3e9): undefined reference to `devm_power_supply_register'
> > drivers/usb/typec/rt1719.o: In function `rt1719_irq_handler':
> > rt1719.c:(.text+0xf9f): undefined reference to `power_supply_changed'
> > drivers/usb/typec/rt1719.o: In function `rt1719_update_pwr_opmode.part.9':
> > rt1719.c:(.text+0x657): undefined reference to `power_supply_changed'
> > drivers/usb/typec/rt1719.o: In function `rt1719_attach':
> > rt1719.c:(.text+0x83e): undefined reference to `power_supply_changed'
> > 
> > Add POWER_SUPPLY dependency to Kconfig.
> > 
Thanks.
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 25d29b980912 ("usb: typec: rt1719: Add support for Richtek RT1719")
> > Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  drivers/usb/typec/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> > index 8f921213b17d..ba24847fb245 100644
> > --- a/drivers/usb/typec/Kconfig
> > +++ b/drivers/usb/typec/Kconfig
> > @@ -56,6 +56,7 @@ config TYPEC_RT1719
> >  	tristate "Richtek RT1719 Sink Only Type-C controller driver"
> >  	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
> >  	depends on I2C
> > +	depends on POWER_SUPPLY
> >  	select REGMAP_I2C
> >  	help
> >  	  Say Y or M here if your system has Richtek RT1719 sink only
> > -- 
> > 2.17.1
> 
> -- 
> heikki
