Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451064F1855
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378571AbiDDP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378619AbiDDP1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:27:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A911E3EB;
        Mon,  4 Apr 2022 08:25:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 125so281424pgc.11;
        Mon, 04 Apr 2022 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C7kc0WBXzki7SKGLSUPjAVPvpQOiseE27/OA4Hb8PjU=;
        b=CM7bruVNar6ViIQtL5n44QYXZE1Uvm8jsK5oP95zGN41v0xkZ3xDN2Z0O1LhhLWcth
         yeHjhi+BLqb3YtgH9k8FJF8fHFLNgt92VqN9avK5xON8iKnrWLJ68OVH2dWAtuVclOt2
         zdDQ7u6f3kROW8veWKQgnCg7wfnfIck08sVMm4tQX2MUUvJfx350164m5clvR6NwOCii
         klydz0jLwiWkkOOlIB2sXoBsHLmq43RgWgVUej5+ZB7nxVRT2b05w5HhVP7i1DwMXwPX
         UqC5oA5oai9l5YIERIli0KXdpdTrzBI+gbvyVoT6BtUQbBNUT4Bc6MBwv9kN+ejPA5NV
         gkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C7kc0WBXzki7SKGLSUPjAVPvpQOiseE27/OA4Hb8PjU=;
        b=Z6ztcXaCK3iPa8j9FKlaELhmmdWtxKYWbevULB9UGMIMrmLgJIbonwIBOECDY6hvJZ
         1idWoyZlO9kTB/e+sEOBVQXSM6TUN3l0zi1COpRru4tlVl4Ml7pnCZhAEI0t9kS6WJKs
         /9ogNfbAuTp4js368eGc74VVyV6cWiAdXtmW3nD/XczlTagNPAbOV+mAwL3bc3I73iwO
         mbzJNC71G7QchSiVbsgJgkQh+FfE7hRsm+Vg2lK12yYGDBGsJQLG3rpnlFgqoAJ6reV+
         eo1Z/BA9pCHKPsOLNHZ91cuNzUNFQlk0WKUuS4WUQU+i6kGMUl/ZXdaB5+v0LMu7bnzC
         gfjQ==
X-Gm-Message-State: AOAM533Y3JwsO0R9wav1Gkp5hu7Mc7+ZtomZBS9OSFv/vTGy2GYLZWIB
        bo9FSnDeOXkvfsnIuBT4pGE=
X-Google-Smtp-Source: ABdhPJyX1HGc5HkE1B4GZBABO2GZpRStGi3sYjqdjfv7Puk6FAmTQOSVQpHoLIdgEJmPNQaOj7MB3g==
X-Received: by 2002:a65:654f:0:b0:378:b8f6:ebe4 with SMTP id a15-20020a65654f000000b00378b8f6ebe4mr306781pgw.399.1649085944813;
        Mon, 04 Apr 2022 08:25:44 -0700 (PDT)
Received: from VICKYMQLIN-NB1.localdomain ([106.39.148.25])
        by smtp.gmail.com with ESMTPSA id v17-20020a63b951000000b0038644f62aeesm10772528pgo.68.2022.04.04.08.25.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Apr 2022 08:25:44 -0700 (PDT)
Date:   Mon, 4 Apr 2022 23:25:38 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Johan Hovold <johan@kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_aspeed_vuart: Fix potential NULL
 dereference in aspeed_vuart_probe
Message-ID: <20220404152538.GA35@VICKYMQLIN-NB1.localdomain>
References: <20220404143842.16960-1-linmq006@gmail.com>
 <YksEnnyJDoL+fE5d@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YksEnnyJDoL+fE5d@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 04:45:50PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 04, 2022 at 02:38:40PM +0000, Miaoqian Lin wrote:
> > platform_get_resource() may fail and return NULL, so we should
> > better check it's return value to avoid a NULL pointer dereference.
> > 
> > Fixes: 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up register mapping")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > index 93fe10c680fb..9d2a7856784f 100644
> > --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > @@ -429,6 +429,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
> >  	timer_setup(&vuart->unthrottle_timer, aspeed_vuart_unthrottle_exp, 0);
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -EINVAL;
> 
> How did you test this change was correct?

Hi,

   I look into the implementation of platform_get_resource(),
and do cross-check the usages of it in the codebase, especially
the usages in other probe function. 
And I go through some simliar bugfix commits in the revision history——
add check for return value of platform_get_resource() in probe
functions，to learn the way to fix this kind of bugs. 
But sorry I don't have the corresponding device for running test.

