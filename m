Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423EA567454
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiGEQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiGEQaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:30:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A387E1837F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:30:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d16so12010161wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mv3mJqTJJTSx3NpvZlyG+2KI9BHYtO9VrU9ve+aY6E=;
        b=SPEMBybHl76PAFAbvb9V0r4ns9juoAy1mwlBzc5BEOCAbWPxSpdfsYR7K5HIfOmuNI
         LZDhRk6tS4hNJXukYfwnm7ZU+DQ0MFYyoNmTF6sLXVnAV2YbEYpaLJQ+5svtvXRQbkK6
         ASSYpyhabNxatLE0bjdF0/Gi9HcWwEoF5+cYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mv3mJqTJJTSx3NpvZlyG+2KI9BHYtO9VrU9ve+aY6E=;
        b=wKvs7TFtY2lM7/0OQx2l9eAVn9Owd7SrUA82VZV+d9neNasrqwjNCkizMIdNTad9e2
         8kJu0Elx6WVLuLHojxhq0CGwTJkrjcmZF+6ukT6xwJ92YwOro2hmQXA6znW1MckcJBym
         VciYOSOfP9Jw0bhjFhOP9Q0X2lNtdT/fA6liMaENQ+l+xGU5pQAHgLSo5dP1xjLO2ArV
         FXgOhAdhsCIbE+gBzEAXKCoNMbC17yCE6xX13LOnpuHLeRjcqFA+/Dlqw/01kclUMEHX
         fB864EcQu0yUYt0222+3iZvcdBZSmvJntl8/mJaOgxiudomcPCXS2yIDYGK2PpO0xd3H
         2ubA==
X-Gm-Message-State: AJIora856saOq6i5ef5sxt36v6LVZiCnx4XHaRCri63eYf27ryfKYdFa
        GstEsgGpy9MNkaQ+4y9VgKUPWQ==
X-Google-Smtp-Source: AGRyM1vvEqIY6YnA7gl5KpdF8rSMkdbHIRId4+/4m6l7DrLUYhvCWvQdBOZ0Bhdh83gAKgYHz3V8MA==
X-Received: by 2002:adf:c64c:0:b0:21a:7a3:54a4 with SMTP id u12-20020adfc64c000000b0021a07a354a4mr33582204wrg.163.1657038599242;
        Tue, 05 Jul 2022 09:29:59 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0021d4aca9d1esm15258179wru.99.2022.07.05.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:29:58 -0700 (PDT)
Date:   Tue, 5 Jul 2022 18:29:56 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: equalizer cfg in max98088 driver
Message-ID: <20220705162956.GA2676656@tom-ThinkPad-T14s-Gen-2i>
References: <20220705075500.GA1987744@tom-ThinkPad-T14s-Gen-2i>
 <YsQd7mub0KJdYUDw@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsQd7mub0KJdYUDw@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jul 05, 2022 at 12:18:06PM +0100, Mark Brown wrote:
> On Tue, Jul 05, 2022 at 09:55:00AM +0200, Tommaso Merciai wrote:
> 
> > Just a question. Can you explain me the proper way to configure eq1 and
> > eq2 of max98089 using sound/soc/codecs/max98088.c driver?
> > Could be a valid solution fetching eq1, eq2 bands params from dts?
> 
> There's plenty of examples of equalisers in the code already.  I don't
> know how this specific device works but generally these are either
> exposed as a series of volume like sliders or as binary controls.  This
> doesn't restrict people to settings from the firmware, making
> development of new configuraitons much easier.

Thanks for your reply.
I meant somethings like this:

	max98089: codec@10 {
		#sound-dai-cells = <0>;
		compatible = "maxim,max98089", "maxim,max98088";
		reg = <0x10>;
		clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
		clock-names = "mclk";

		/* eq1 cfg params */
		eq1-cfg-dt-en;
		eq1-band1 = /bits/ 16 <0x2000 0xC001 0x4000 0x005D 0x0000>;
		eq1-band2 = /bits/ 16 <0x2C30 0xC01F 0x3DAA 0x03EC 0x111E>;
		eq1-band3 = /bits/ 16 <0x0C41 0xC0BE 0x29AA 0x09B5 0x3094>;
		eq1-band4 = /bits/ 16 <0x6671 0xC655 0x3036 0x1BC0 0x2A16>;
		eq1-band5 = /bits/ 16 <0x538D 0xD64E 0x23BD 0x308D 0x3517>;
	};

Regards,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
