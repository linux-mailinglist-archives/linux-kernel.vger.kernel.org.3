Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747454FBA47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbiDKLAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiDKLAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:00:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E443ED8;
        Mon, 11 Apr 2022 03:57:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b21so25920557lfb.5;
        Mon, 11 Apr 2022 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQNJOqD3nhB7+SOHNLfHLDhNQpfl6lw7yBEcOA5QX+4=;
        b=RA58j+ZBO8KFGMW2vafqGUfzQgrcCaIe8LzN465UwHNoq6nqRgA0BaPXhTLri+T723
         lMm4XOpU+7qAAVfiXWvubo6g9BtjlJokY6mI8burAFTjc/tXC/7p3s+HIb39bjdtBXlr
         Sw2alDw81QUbi2QdsO6F9gq+mSQFozTo8Lqlf1iZvdP5lSaHfNF8/ClxAebO3zsknGBL
         3BCeQ8HgtZL08pURAbsQaiPNU9C+X5XYoc5j/Ab9ChnZufMwmSSDEggWzPrsTyjDi5R2
         +7GzGaCAISL7s9blrOpNblk9w/oQpbpgWq1TMRaYutb2JuvfSJA4LNE6NQi/fTHYUmME
         WPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQNJOqD3nhB7+SOHNLfHLDhNQpfl6lw7yBEcOA5QX+4=;
        b=UWfmtowvok3U27jRxIG4cZphaTB9NN9oKPBVEI6LT0irn+apSljzVSwZ8YorA2DUQP
         DSBJA2BuN4PL1yfpGUwDPbqUh2ZQ8/Zg4CtOO5jRvLcoSaxvSGH+zBwmSAnBnJ5v0yFT
         UufNK72zM2r3u3TLseMaeieIpqoWlDo6OYrhDrow6Hmd18irjqza6po3LuTG1BWQpibh
         qit9K5Udk2nKOSCAjrK/iE/MNuUp8QXkxETBh9pwmxGChHLuyHE64XReAoVPP1+9Hk+l
         +zFkjJIvBGqLPW19UynYKlQ2tK2V6HCZESeyGWPIROk7K49xbSlwd0qivaMNn8IgSWHN
         fdfg==
X-Gm-Message-State: AOAM530lRd5IHb9CKgeHdmxGseQPyj4bhH2IoHr2oHt2wL6Mv5jSMRGZ
        LJbEiGnZLJdd49RXpG38zy4=
X-Google-Smtp-Source: ABdhPJxcGW4eTSshR/ptrc95tL2+QcZlS55S6naH6PFXxkJ6sRk8oaDD84wCb/XLootqzmY69sVIZA==
X-Received: by 2002:a05:6512:308d:b0:464:f074:68cb with SMTP id z13-20020a056512308d00b00464f07468cbmr14981342lfd.482.1649674677282;
        Mon, 11 Apr 2022 03:57:57 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id a7-20020a19e307000000b0046ba24f205fsm459827lfh.57.2022.04.11.03.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:57:56 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:57:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 09/21] ata: libahci_platform: Introduce reset
 assertion/deassertion methods
Message-ID: <20220411105755.a7pjktet5osocluv@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-10-Sergey.Semin@baikalelectronics.ru>
 <96c85e40-1ebc-81f7-a786-0d5bb01ce0da@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c85e40-1ebc-81f7-a786-0d5bb01ce0da@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:52:27AM +0900, Damien Le Moal wrote:
> On 3/24/22 09:16, Serge Semin wrote:
> > Currently the ACHI-platform library supports only the assert and deassert
> > reset signals and ignores the platforms with self-deasserting reset lines.
> > That prone to having the platforms with self-deasserting reset method
> > misbehaviour when it comes to resuming from sleep state after the clocks
> > have been fully disabled. For such cases the controller needs to be fully
> > reset all over after the reference clocks are enabled and stable,
> > otherwise the controller state machine might be in an undetermined state.
> > 
> > The best solution would be to auto-detect which reset method is supported
> > by the particular platform and use it implicitly in the framework of the
> > ahci_platform_enable_resources()/ahci_platform_disable_resources()
> > methods. Alas it can't be implemented due to the AHCI-platform library
> > already supporting the shared reset control lines. As [1] says in such
> > case we have to use only one of the next methods:
> > + reset_control_assert()/reset_control_deassert();
> > + reset_control_reset()/reset_control_rearm().
> > If the driver had an exclusive control over the reset lines we could have
> > been able to manipulate the lines with no much limitation and just used
> > the combination of the methods above to cover all the possible
> > reset-control cases. Since the shared reset control has already been
> > advertised and couldn't be changed with no risk to breaking the platforms
> > relying on it, we have no choice but to make the platform drivers to
> > determine which reset methods the platform reset system supports.
> > 
> > In order to implement both types of reset control support we suggest to
> > introduce the new AHCI-platform flag: AHCI_PLATFORM_RST_TRIGGER, which
> > when passed to the ahci_platform_get_resources() method together with the
> > AHCI_PLATFORM_GET_RESETS flag will indicate that the reset lines are
> > self-deasserting thus the reset_control_reset()/reset_control_rearm() will
> > be used to control the reset state. Otherwise the
> > reset_control_deassert()/reset_control_assert() methods will be utilized.
> > 
> > [1] Documentation/driver-api/reset.rst
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/ata/ahci.h             |  1 +
> >  drivers/ata/libahci_platform.c | 47 ++++++++++++++++++++++++++++++----
> >  include/linux/ahci_platform.h  |  5 +++-
> >  3 files changed, 47 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > index 1564c691094a..0b1d5c24cb8c 100644
> > --- a/drivers/ata/ahci.h
> > +++ b/drivers/ata/ahci.h
> > @@ -342,6 +342,7 @@ struct ahci_host_priv {
> >  	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
> >  	unsigned int		n_clks;
> >  	struct clk_bulk_data	*clks;		/* Optional */
> > +	unsigned int		f_rsts;
> 

> Why ? using flags directly is not OK ?

First of all I didn't want to mix up the AHCI and platform-specific
flags especially seeing there aren't that many free bits left in the
hpriv->flags field. Secondly a new platform-specific flags set has
already been defined in commit 9d2ab9957397 ("ata: libahci_platform:
add reset control support"). Thus mixing up AHCI_HFLAG* and
AHCI_PLATFORM* flags in a single field wouldn't have been that
maintainable. So to speak at least for v1 I decided to add a new
reset-specific field to preserve the reset-related flags only. It
might have been more reasonable to create a generic storage like
p_flags for all platform-specific flags. But it's up to you to decide
after all. What do you think?

> 
> >  	struct reset_control	*rsts;		/* Optional */
> >  	struct regulator	**target_pwrs;	/* Optional */
> >  	struct regulator	*ahci_regulator;/* Optional */
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 5998e735a813..febad33aa43c 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -150,6 +150,41 @@ void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
> >  }
> >  EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
> >  
> > +/**
> > + * ahci_platform_deassert_rsts - Deassert/trigger platform resets
> > + * @hpriv: host private area to store config values
> > + *
> > + * This function desserts or triggers all the reset lanes found for the AHCI
> 

> s/desserts/deasserts ?
> s/lanes/lines ?

Ok.

> 
> > + * device.
> > + *
> > + * RETURNS:
> > + * 0 on success otherwise a negative error code
> > + */
> > +int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv)
> > +{
> > +	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
> > +		return reset_control_reset(hpriv->rsts);
> > +
> > +	return reset_control_deassert(hpriv->rsts);
> > +}
> > +EXPORT_SYMBOL_GPL(ahci_platform_deassert_rsts);
> > +
> > +/**
> > + * ahci_platform_assert_rsts - Assert/rearm platform resets
> > + * @hpriv: host private area to store config values
> > + *
> > + * This function asserts or rearms (for self-deasserting resets) all the reset
> > + * controls found for the AHCI device.
> > + */
> > +void ahci_platform_assert_rsts(struct ahci_host_priv *hpriv)
> > +{
> > +	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
> > +		return (void)reset_control_rearm(hpriv->rsts);
> 

> return void in a void function ? How does this even compile ?

Well, apparently it does.) I was also surprised not to have any
warning printed from the compiler. Most likely the silent 
behavior was caused by the explicit cast to void. 

Regarding my reasoning. In this case using the return operator that
way spared the two lines of code and let not to use the 'else'
operator. If I didn't use the return operator like that I would have
needed to implement the statements like this:
+	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER) {
+		(void)reset_control_rearm(hpriv->rsts);
+		return;
+	}
+
+	reset_control_assert(hpriv->rsts);
or like this:
+	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
+		(void)reset_control_rearm(hpriv->rsts);
+	else
+		reset_control_assert(hpriv->rsts);

I've decided to try a more simple pattern. If you think it's too
questionable and shouldn't be used I'll drop the return operator.
Do you want me to?

> And what if reset_control_rearm() fails ? What happens ?

Happens the same as before this commit in case of the
reset_control_assert() method invocation failure. The error will be just
ignored. As you can see the ahci_platform_assert_rsts() method is only
utilized in the resources disable procedure or in the revert-on-error
path of the ahci_platform_enable_resources() function. The driver
doesn't check the return values in none of these places.

I still think that we shouldn't convert the code to checking the
status in these parts, but I can add the return status to the
ahci_platform_assert_rsts() method like this:
+int ahci_platform_assert_rsts(struct ahci_host_priv *hpriv)
+{
+	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
+		return reset_control_rearm(hpriv->rsts);
+
+	return reset_control_assert(hpriv->rsts);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_assert_rsts);

How do you feel about this?

-Sergey

> 
> > +
> > +	reset_control_assert(hpriv->rsts);
> > +}
> > +EXPORT_SYMBOL_GPL(ahci_platform_assert_rsts);
> > +
> >  /**
> >   * ahci_platform_enable_regulators - Enable regulators
> >   * @hpriv: host private area to store config values
> > @@ -247,18 +282,18 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
> >  	if (rc)
> >  		goto disable_regulator;
> >  
> > -	rc = reset_control_deassert(hpriv->rsts);
> > +	rc = ahci_platform_deassert_rsts(hpriv);
> >  	if (rc)
> >  		goto disable_clks;
> >  
> >  	rc = ahci_platform_enable_phys(hpriv);
> >  	if (rc)
> > -		goto disable_resets;
> > +		goto disable_rsts;
> >  
> >  	return 0;
> >  
> > -disable_resets:
> > -	reset_control_assert(hpriv->rsts);
> > +disable_rsts:
> > +	ahci_platform_assert_rsts(hpriv);
> >  
> >  disable_clks:
> >  	ahci_platform_disable_clks(hpriv);
> > @@ -285,7 +320,7 @@ void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
> >  {
> >  	ahci_platform_disable_phys(hpriv);
> >  
> > -	reset_control_assert(hpriv->rsts);
> > +	ahci_platform_assert_rsts(hpriv);
> >  
> >  	ahci_platform_disable_clks(hpriv);
> >  
> > @@ -468,6 +503,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  			rc = PTR_ERR(hpriv->rsts);
> >  			goto err_out;
> >  		}
> > +
> > +		hpriv->f_rsts = flags & AHCI_PLATFORM_RST_TRIGGER;
> 

> Why not use hpriv->flags ?

Please see my first comment.

-Sergey

> 
> >  	}
> >  
> >  	/*
> > diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> > index fd964e6a68d6..57d25d30a9fa 100644
> > --- a/include/linux/ahci_platform.h
> > +++ b/include/linux/ahci_platform.h
> > @@ -26,6 +26,8 @@ struct clk *
> >  ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);
> >  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
> >  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
> > +int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv);
> > +void ahci_platform_assert_rsts(struct ahci_host_priv *hpriv);
> >  int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
> >  void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
> >  int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
> > @@ -44,6 +46,7 @@ int ahci_platform_resume_host(struct device *dev);
> >  int ahci_platform_suspend(struct device *dev);
> >  int ahci_platform_resume(struct device *dev);
> >  
> > -#define AHCI_PLATFORM_GET_RESETS	0x01
> > +#define AHCI_PLATFORM_GET_RESETS	BIT(0)
> > +#define AHCI_PLATFORM_RST_TRIGGER	BIT(1)
> >  
> >  #endif /* _AHCI_PLATFORM_H */
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
