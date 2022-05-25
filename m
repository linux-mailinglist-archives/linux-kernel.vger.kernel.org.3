Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE35534004
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbiEYPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245045AbiEYPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:11:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B8B0D17
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x2-20020a17090a1f8200b001e07a64c461so1912517pja.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JyixjUdddf6I90XP9MdFK6+higCWyl5KeV+gVWtp6WU=;
        b=f20Va32dKRJKc/hg0L61Ym/jpgUK0f5vPl1fJoIrhHp4ZYZ651lh4oqGY4DK+jeg4J
         j/5F1rr/CFGPSwCgQSnzLJcizT05k7U/pFvaGcJ5lkhZrGqDWv9IscCatZuGe25yR9q2
         gcabwG6JEe6AnZbUxaBC1uMGDPQd6VHlNYBrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JyixjUdddf6I90XP9MdFK6+higCWyl5KeV+gVWtp6WU=;
        b=VUoAzKOWsXQo60JEUgJSM7kLR9cY+kg+kswGFQOtikalBXdTl4PP3lsu8GtrWylXsF
         WvS4Q1FBaNRG8RfmGdm4JeRaeFZyhfNELfYo+z6fdDqH+4CZkVN8HvVGnFbfTsMEsrov
         ZIvtYiY1hBsNOtXboeRm7ZcIQZt6SYVXqQoAw6Tj0mjxt7/DYajGJ32AFl+EoTbXnnK8
         xnnKT3+AzRjRopzI0cEQvg2v7KC+X1JZYoGQ4LaHv4nfqiN8kc4RewBnXhmXQVjirb1z
         /b+eQPSvBLxooEMA2dkb/szmwXgo3upmx5aYnvoOAociq5Tw3jho6KPyRsb1jVeijZJu
         sdvQ==
X-Gm-Message-State: AOAM530bhWUowF1b5K+SXqrb7xvO4HRZU1sKO5ngui+qqWmv9fFT82qs
        IENHRFdF65gGqSZuPq+ea0eCPA==
X-Google-Smtp-Source: ABdhPJxgS1VuqYEu6r9Y57sGqJnQIEGTKr/QvLaXom2H7c4IuIt24COlf9Rl55IoJgxqziOXj1S5PA==
X-Received: by 2002:a17:90a:6487:b0:1df:7e0f:c93e with SMTP id h7-20020a17090a648700b001df7e0fc93emr10975351pjj.77.1653491502589;
        Wed, 25 May 2022 08:11:42 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4d83:f549:9abd:427])
        by smtp.gmail.com with UTF8SMTPSA id a21-20020a637055000000b003c14af505fesm8581222pgn.22.2022.05.25.08.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:11:42 -0700 (PDT)
Date:   Wed, 25 May 2022 08:11:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 4/5] platform/chrome: cros_kbd_led_backlight: support
 OF match
Message-ID: <Yo5HLJs81/KoXSBT@google.com>
References: <20220523090822.3035189-1-tzungbi@kernel.org>
 <20220523090822.3035189-5-tzungbi@kernel.org>
 <Yo07IDqYuQUzeL+N@google.com>
 <Yo2jhTpsa5Vw4+61@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo2jhTpsa5Vw4+61@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 11:33:25AM +0800, Tzung-Bi Shih wrote:
> On Tue, May 24, 2022 at 01:08:00PM -0700, Matthias Kaehlcke wrote:
> > On Mon, May 23, 2022 at 05:08:21PM +0800, Tzung-Bi Shih wrote:
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id keyboard_led_of_match[] = {
> > > +	{
> > > +		.compatible = "google,cros-kbd-led-backlight",
> > > +	},
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
> > > +#endif
> > > +
> > >  static struct platform_driver keyboard_led_driver = {
> > >  	.driver		= {
> > >  		.name	= "chromeos-keyboard-leds",
> > >  		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
> > > +		.of_match_table = of_match_ptr(keyboard_led_of_match),
> > 
> > You need to put this assignment inside an '#ifdef CONFIG_OF' block,
> > otherwise the compiler won't find 'keyboard_led_of_match' when
> > CONFIG_OF isn't set.
> 
> It doesn't need as of_match_ptr() already guarded it.

I learned something new today :)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
