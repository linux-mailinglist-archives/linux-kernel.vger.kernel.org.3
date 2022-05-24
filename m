Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0425324C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiEXICB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiEXIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:01:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAF4205E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:01:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p189so10093226wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ma2nUBxa8PfLpFkWZENKEZQqERw2jeRipPKdsi7/lDQ=;
        b=FuhZjvAq5Zd9Ni6Pq4Pgxn/GlTbgGLsFc909TJp4uCpK7sKQCS8yeIl3lhbx8JJ5kM
         FHroFdX5+k+eNVhb+QQrvZnlYhiR7mg7qTJ3BF7VimNAiZmv9nAHO2ia2wy6TCW/Vcdl
         NmodvR5zrNLs3TOUdc8vgMVUY1zAso9rCRqgnxYZTRXW1aCY59b04rctwlHXy5xhwes/
         o6HFZ2OyDFwybRMgHVX7XP5W8SapTIlXV/9F+BGxUqsg/MNrEkguBnqaFQMv4CRbPO0b
         v8fczUD8RzQXtJ8yYKkrp8d8pYFoOZ6M+EppE+W363PO/0vYRl+QPUAOoanka1Qtov1/
         pe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ma2nUBxa8PfLpFkWZENKEZQqERw2jeRipPKdsi7/lDQ=;
        b=rKDE4dsau2i+wLySAcUP5yyDEyfEj6tOwDZH1j6zL/zQcswIzP5zsa2FELE3NTN6T7
         gZPMCTlO4Sn8FvlSFJWMUk0qofka2+NvXL1N6OguMEbPxXe5zuEafDn0dbLMLa88iaki
         SKC+j7Wq200DWYOYCk1VoTk5HmWeSL2X6K/vBaOhpVkNPNwo37nspsWZmPrD3DyISyDA
         SCYM8ZrIPs3NtWLWIcrkaP7uybozWSAiWiPJuchluxwISBJx4pI6EXIV1oAFIZmaDbRO
         AVUFGd+PF2b5pESYj4TiKkPwMnXlK3oNkNU0Xj/f9L8agGB5KmsChlflAUhW+KUcbPRd
         J5wQ==
X-Gm-Message-State: AOAM531G5pO99r+Z1tkjrZdFPoWyPuSI5AmJ1l6LBr2uSz9j65oiCasb
        wonaXvXAUF9efM0wxbaIazwdjA==
X-Google-Smtp-Source: ABdhPJz4BI9iIoaky8AaHSBmq9k12VExb0i/NW0Wl66IVb6NhzAjgbwg2S1QWnt5gppcbNRDkA9mPA==
X-Received: by 2002:a05:600c:3646:b0:397:326d:eac7 with SMTP id y6-20020a05600c364600b00397326deac7mr2587912wmq.43.1653379296486;
        Tue, 24 May 2022 01:01:36 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c2f9000b003942a244eebsm1213807wmn.48.2022.05.24.01.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 01:01:35 -0700 (PDT)
Date:   Tue, 24 May 2022 09:01:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] mfd: twl6030: Make twl6030_exit_irq() return void
Message-ID: <YoyQ2dXqIbHT/sPi@google.com>
References: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
 <20220113101430.12869-2-u.kleine-koenig@pengutronix.de>
 <Ymq/tVTo2JIEDEQa@google.com>
 <20220523212457.3cd5f5afwla2ahxi@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220523212457.3cd5f5afwla2ahxi@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Thu, Apr 28, 2022 at 05:24:21PM +0100, Lee Jones wrote:
> > On Thu, 13 Jan 2022, Uwe Kleine-König wrote:
> > 
> > > This function returns 0 unconditionally, so there is no benefit in
> > > returning a value at all and make the caller do error checking.
> > > 
> > > Also the caller (twl_remove()) cannot do anything sensible with an error
> > > code. Passing it up the call stack isn't a good option because the i2c core
> > > ignores error codes (apart from emitting an error message).
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/mfd/twl-core.c    | 4 ++--
> > >  drivers/mfd/twl-core.h    | 2 +-
> > >  drivers/mfd/twl6030-irq.c | 3 +--
> > >  3 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > Applied, thanks.
> 
> I would have expected these to appear in next since you wrote to have
> applied this series. But they have not though your claim to have applied
> them is over three weeks old now?! :-\

Don't worry.  They're both applied and will be in v5.19.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
