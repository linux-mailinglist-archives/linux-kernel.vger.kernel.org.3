Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144CC4E4331
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbiCVPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbiCVPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:42:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A638C7C2;
        Tue, 22 Mar 2022 08:40:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id jx9so2100360pjb.5;
        Tue, 22 Mar 2022 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UeqnEbJtsjk38FgKKJvvntXTXF5S5w1SgNTftwLe55I=;
        b=LqMPZ32/mNBrsEGWAuuBqOcOWjEwRjwdv6OukQumYHYqDTGJWfL44Ze/DJzeaQGGDU
         ZmwzF2QAN/8aD9BUepQdhQALlIoW5IOZGXOgCbJfrBmWdg4vmTLF/fB+cc4CR/GHGHpN
         MPkX8YVNx93pPBbTmryACB2U7UeyR2LwtuFwjNZDrlEcvD+sVpbEoectmN2bMOO0aQjY
         jGPj6SDRFcyu11CIFh5BU018KTKDDPcZ4Ynsf/EDAlOB1+gErnLQi/UuxUu8wEgrYOGO
         v9cOtGFj62dvDpxgWLuLOBx4DmDQ1HbL7B+UGzvpwM2LOPo52YXdvb7cNc3bQVWZVkdk
         zHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UeqnEbJtsjk38FgKKJvvntXTXF5S5w1SgNTftwLe55I=;
        b=LwnTECXiupqavnREtqzeZqfAvLczxJrK8CMUctHOcNmlsWod8sPpqWfn9umhshgyK9
         nofYcRy9cS9GeR7i3n6+WNGZH/P/TAZQGwyBlQK8oF1qwARLUIOKcYFKxchNpS6xcbIM
         ZP0+7stcAoWdw4/S2bUg9DdHB3Yt+T2gfXew38mnXxGnAh1N/6E7TYtEno7g2lp/OvTz
         4+gMaVlC0TdQ77sY6Ud8vMmnnSmlD4Rx8zzmrr0U4hrV7L7Acn/X4Ghb137sZ7JeZoDV
         4ni68cSZU2WftqdxXCJrXvBDpOAlyPvoJokvynTh7wi+uZGNO43DmoQUYXvSvT4AFIF4
         QH3w==
X-Gm-Message-State: AOAM533xWXbF9rFtg7de81JiJpr8BNYHji50LTUppH/oPcg8tE9MscP1
        pxXmhBIjudPox2REwDiqTytnkF0C2mUsyK57
X-Google-Smtp-Source: ABdhPJxnVeDiW9j5igEfONbmgwW2E/cXPuxXfw1GcXeDZO5bdExIeNTPWy5GGIHL0/Jy7Cq5o0XNGw==
X-Received: by 2002:a17:90b:4785:b0:1c6:ad62:dda3 with SMTP id hz5-20020a17090b478500b001c6ad62dda3mr5756285pjb.232.1647963654718;
        Tue, 22 Mar 2022 08:40:54 -0700 (PDT)
Received: from jagath-PC ([115.99.184.169])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090a521700b001bbfc181c93sm3174317pjh.19.2022.03.22.08.40.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Mar 2022 08:40:54 -0700 (PDT)
Date:   Tue, 22 Mar 2022 21:10:49 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220322154047.GA3677@jagath-PC>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
 <20220319181023.8090-4-jagathjog1996@gmail.com>
 <CAHp75VdB5q+Y2R46OO-kCKCkPY58YzyLNjN3PjJiQhTOgV4n2w@mail.gmail.com>
 <20220321222117.GD10058@jagath-PC>
 <CAHp75Vdp12bm+CHWun36b36Sui73zh0_wtY5YhEqVdNy4rUxVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vdp12bm+CHWun36b36Sui73zh0_wtY5YhEqVdNy4rUxVA@mail.gmail.com>
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

Hello Andy,

On Tue, Mar 22, 2022 at 10:54:53AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 22, 2022 at 12:21 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > On Mon, Mar 21, 2022 at 10:39:22AM +0200, Andy Shevchenko wrote:
> > > On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> First of all, you left many uncommented comments. I assume you agree
> with my comments and are going to address them. If it's not the case,
> please elaborate.

Yes Andy, I agree with your comments and I will address them in the next v2 series.

> 
> ...
> 
> > > > +out:
> >
> > Just to skip the below "if()" if error occurs in previous regmap read,
> > I used this label.
> >        if (status & BMA400_INT_DRDY_MSK)
> >              iio_trigger_poll_chained(data->trig);
> >
> > I will remove the label in next patch
> 
> Just return directly.
> 
> ...
> 
> > > A useless label. Moreover this raises a question: why is it okay to
> > > always mark IRQ as handled?
> > >
> > > > +       return IRQ_HANDLED;
> >
> > Since I was not using top-half of the interrupt so I marked IRQ as handled
> > even for error case in the handler.
> 
> Yes, but why? Isn't it an erroneous state? Does it mean spurious
> interrupt? Does it mean interrupt is unserviced?

Sorry, even for erroneous state I was returning IRQ_HANDLED.
As shown below, now for erroneous state and spurious interrupt I will return
IRQ_NONE and for valid interrupt IRQ_HANDLED will be returned.

Is below method is correct?

static irqreturn_t bma400_interrupt(int irq, void *private)
{
       struct iio_dev *indio_dev = private;
       struct bma400_data *data = iio_priv(indio_dev);
       int ret;
       __le16 status;

       mutex_lock(&data->mutex);
       ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
                              sizeof(status));
       mutex_unlock(&data->mutex);
       if (ret)
               return IRQ_NONE;

       if (le16_to_cpu(status) & BMA400_INT_DRDY_MSK) {
               iio_trigger_poll_chained(data->trig);
	       return IRQ_HANDLED;
	}

        return IRQ_NONE;
}

> 
> -- 
> With Best Regards,
> Andy Shevchenko
