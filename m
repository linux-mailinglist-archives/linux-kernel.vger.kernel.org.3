Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0CD5953F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiHPHfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiHPHee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:34:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF73D8E1C;
        Mon, 15 Aug 2022 21:16:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 17so8166685pli.0;
        Mon, 15 Aug 2022 21:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=iMjp1pmx9d1MiBxAyaWKVDH1qY8XRo0KqTWn0WPr7nQ=;
        b=A2NhZqXR3XwQPM2cJAjrzE7BnoX+OgI8gmYq9/Q5PnbhL/Csih7fYg/Ylu92o5vNIw
         1A62Dfsks3IixLufu3TX2VQe1AakmnhQGpDoJMLnOeSke7y7GBilHXRLYgjHWzPH9RNZ
         I60JX68g6qwSGW32BaApM/Dlw6sHRFdSRlGrK7JZ1lba6YGOUHitgBkzcVAc2/ez2L1V
         8tEfdXJDeXzKMarZteEREJgG9QiTHk/5IIf/SRTGULnrLcD3D5uEg7tPtM0PwzOCISUn
         xm4FmRWZmT77xTTehidqXkS+qHW0qzSrgwfO7HubSI41m0DugXCbtU39e4rrVaisHPw0
         ykaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=iMjp1pmx9d1MiBxAyaWKVDH1qY8XRo0KqTWn0WPr7nQ=;
        b=y4HDii8qfBIm6zCPSu4D/6+RM8v8ui4nIMslbyqWCKtkXkIKp8bGpp/hxcX1daeV1o
         Y+UoSusE2iF8Z7+QHmYGGLzLUo58UyMb4tEOawcQz78YfAaSdSxfysQIFkUFm4PrYnmJ
         dNi13PndYs5yGKSAYYd/YDi+/FEgbgzfRQjryAthefjaaSkNvRvmiRML2jcytbi3YSiv
         EmxuhrA5gKVHjK7ykyfuQQz0RzSSQJZL2eYYZ6kmy36/ptztmqUFbQkIO6zdGs8mFdoL
         y/pQB5i6xP9J/dx6Ot7HRcy5cgYjVuebCIEBXPlXGHq0C9zSsfaBOSHooV/Ygli3Y2sv
         LBPg==
X-Gm-Message-State: ACgBeo39U2RNwrq9yufC5aMKzJBTuY0nGRgwcqf301pPHcj09ojYmrHx
        xXPVNU0pBv63W6jX6d2fNcU=
X-Google-Smtp-Source: AA6agR5RhCQnvTQ2itDaCabXEeCUp+sazLXG8afjfgNlCq8mZOHZQLmSLSNwX0u4n7DVfhrid5KOOg==
X-Received: by 2002:a17:903:22c1:b0:16f:3d1:f5c with SMTP id y1-20020a17090322c100b0016f03d10f5cmr20184549plg.155.1660623374584;
        Mon, 15 Aug 2022 21:16:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:98d5:dcc4:68c2:c537])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090a488e00b001fa8ee8649esm645136pjh.7.2022.08.15.21.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 21:16:12 -0700 (PDT)
Date:   Mon, 15 Aug 2022 21:16:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        linux-input@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: Tree for Aug 15 (input/misc/ibm-panel.c)
Message-ID: <YvsaCjnkucMeyj60@google.com>
References: <20220815122926.7fd3ac58@canb.auug.org.au>
 <0d836243-6a02-e031-961e-1e334dfd167d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d836243-6a02-e031-961e-1e334dfd167d@infradead.org>
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:26:43PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/14/22 19:29, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20220812:
> > 
> 
> on x86_64:
> 
> when CONFIG_I2C=m and CONFIG_I2C_SLAVE=y:
> 
> ld: drivers/input/misc/ibm-panel.o: in function `ibm_panel_remove':
> ibm-panel.c:(.text+0x16): undefined reference to `i2c_slave_unregister'
> ld: drivers/input/misc/ibm-panel.o: in function `ibm_panel_probe':
> ibm-panel.c:(.text+0x3e3): undefined reference to `i2c_slave_register'
> ld: drivers/input/misc/ibm-panel.o: in function `ibm_panel_driver_init':
> ibm-panel.c:(.init.text+0x18): undefined reference to `i2c_register_driver'
> ld: drivers/input/misc/ibm-panel.o: in function `ibm_panel_driver_exit':
> ibm-panel.c:(.exit.text+0x11): undefined reference to `i2c_del_driver'

It sounds like I need to adjust the depend statement to be:

	depends on I2C && I2C_SLAVE

Thanks.

-- 
Dmitry
