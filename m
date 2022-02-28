Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679EA4C71E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiB1Qpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiB1Qpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:45:43 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38070694AD;
        Mon, 28 Feb 2022 08:45:04 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id g24so10790559qkl.3;
        Mon, 28 Feb 2022 08:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gZ/lBVmz5qkZmaDTKla0rq1d1JmWVouxOfT4UJPJ/zI=;
        b=EUbYpCYm4Rqd9t5BnR6HhwA8Cv5yKyKomML6aJbDTJ1dmfmXbwe/dhAH9kYOFyQLwi
         nD7qryaBes99/P/BXjFSxzpnwzzkckAuI2SuK4P/dQBI4VdFtbpV+EMhPe50lKeKfu4e
         H8CbLTZf2rzwHhKnJYY84EUfcWccLAHWZ5jo1P1FD5BhkGeltKhGghV4Yd1AWwuzUHaa
         fyj7um5P6NaemeD82c+U3dDnWQQNdf50kSfSjgITnw44qT7cRaYircVluNBi43XXqsCa
         fB4/skecH1TslU0CBWl2DNU60au1qDswMX6IkdHa5ynEmvwiidkz8lZDE4nDKQ13Je1a
         EVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gZ/lBVmz5qkZmaDTKla0rq1d1JmWVouxOfT4UJPJ/zI=;
        b=DPL9I0MWUJULRsAZ16I5Y6Vw6FRarhkBkliH32/ZQUW9soYDIvu12eIL73AS0+vmfT
         8uUj8J5/MFx2xOkT/z6U7uyD/KHt13652ubukJSQ7N6JyQaSyubLvx9LYnS0WdEVXqUf
         /HVgSGnA+Mr3zBKjkyeugruy7HNjAast+cU60dh7/Vm6Otnu8rTBoD0XKuulIcN3sqZQ
         598dkFpbVaX4qkY1750Cg5/qGoEci9xC1lmwdadmHaYaiSaPf+h3P/jFMmo3ux8aRCEj
         q/YmIJcaxmUhHz8sfKMlzFI6BRzdXCcEOXF+2/FNiDB32AnIBR0tQEs2JAwaP/jYEgcy
         P7Ag==
X-Gm-Message-State: AOAM531LnvSoApD8HIUX5OQWhR5PKJmsj4gL7AN+OIBP94MqqtjZ7pJY
        m8FQ48TdHa4DHSaHQp6TVUD51Nt7QEg=
X-Google-Smtp-Source: ABdhPJwV79w/xcqL5pMshUMmenCj1DphiDLzuupE/DTTMMGNGZUk/iCMjf3a4MHPPAkfhmIldXgqDQ==
X-Received: by 2002:a37:f719:0:b0:648:cd93:3198 with SMTP id q25-20020a37f719000000b00648cd933198mr11687653qkj.179.1646066703316;
        Mon, 28 Feb 2022 08:45:03 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a034500b00476e85c85b9sm5203572qkm.110.2022.02.28.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:45:02 -0800 (PST)
Date:   Mon, 28 Feb 2022 11:45:00 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     peda@axentia.se, andy.shevchenko@gmail.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v15 00/10] iio: afe: add temperature rescaling support
Message-ID: <Yhz8DBfkJQSpBagW@shaak>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
 <20220227125559.72d5d79a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227125559.72d5d79a@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Feb 27, 2022 at 12:55:59PM +0000, Jonathan Cameron wrote:
> On Sat, 12 Feb 2022 21:57:29 -0500
> Liam Beguin <liambeguin@gmail.com> wrote:
> 
> > Jonathan, Peter, Andy,
> > 
> > This series focuses on adding temperature rescaling support to the IIO
> > Analog Front End (AFE) driver.
> > 
> > The main changes to the AFE driver include an initial Kunit test suite,
> > support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> > and temperature transducer sensors.
> > 
> > Thanks for your time,
> > Liam
> 
> Hi Liam,
> 
> I was waiting for Andy to reply to this. Took a quick look back at
> what was outstanding and realised he had given a
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> for v13.
> 
> I'm assuming there wasn't a strong reason to drop that in the meantime
> and it's a simple omission / crossed emails issue.
> 
> As such, 
> 
> Series applied to the togreg branch of iio.git and pushed out
> as testing to get some build coverage from 0-day.

Great news! Thanks again for your patience, and review on this work.

I noticed you fixed the CI error. Thanks for doing that, and my
apologies for missing it.

Cheers,
Liam

> Thanks,
> 
> Jonathan
> 
