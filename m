Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF28E552DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiFUI5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348632AbiFUI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:57:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E45A27177;
        Tue, 21 Jun 2022 01:56:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v1so25954698ejg.13;
        Tue, 21 Jun 2022 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0cx/amxb3Wd/PcYv0eYLLeJxSM7TQT62UUtprSbhbwY=;
        b=l6LNhCtWPcYK5lVOJB4knQOEE4oFs6J2Jg6Rt0e7BaNut9e46lb5KdVYDnj6ilkGm2
         mQ7VTnH80+cXckqjznh1du5dtOdVPhs652Du5TxDiQ+58oHjtxhVtjko9YTZsFibM+4t
         dteat9bhz8IHA88U249+vCWBP8CMzaA8asRdTLzsuGL9ee0hN04GeQteE0Fi4kylaNKj
         0TFF8lnde6SvXHYI9XMpMF1ignz5BbL2lHAoTlF4Oug9V6Zxoushwt5/wntbiBkIu6+l
         VjoJciC5kvKSDrAabkgWHTdSnlVHc0xwfw64uWPO7VuWtTj36CeQPvqwS05CcagrCAjw
         1RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cx/amxb3Wd/PcYv0eYLLeJxSM7TQT62UUtprSbhbwY=;
        b=m8yDpWL7xnjkW6wcHoxsuYxU6LlsCcTBEV72s689WvD+38v5JEDXr78vVMoMPGgyan
         jRHUv6HlIiS4AnO6TI0RBl701pqSD0TXEg2dUotfR5Pd3e0ur/NXQUIc03sx4iptAnuW
         OiGRCGiyi2Xx9NxL7+pddkPMn34YLt/G9MEOhCFpK7CurT2+BMa8oYCgTnfp5O+KMDgr
         DV4HoKqYMQd/TyevHAbQNKsolLJDP00yT1S7ehDDMrph97pZtYq8hXbEgLAvIkzmzgkJ
         rNcZAWFIYybJCzGFkqFVV9xjjdUKbq3dXpPalinCgC3dG16Hd33zZVdQNMyUI45M9EGh
         b83g==
X-Gm-Message-State: AJIora+x8yZDC9bqMjjaFgJ5yMhGdWFHxYUH6xYK99Gh3P+ESpI023rc
        8FXYd7Y0HWif71+feEYOhwnhh/6Qhvam6gML1X0=
X-Google-Smtp-Source: AGRyM1sw3R8Crk409rPsvgBxACxYsWIMkIS18fGIYjIZmrNrU7BKdbSLOiW7pxIAdyNT+keBTGz9ZcOQjom49l348P4=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr24696900ejc.579.1655801815068; Tue, 21
 Jun 2022 01:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220621064321.25635-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220621064321.25635-1-jiangjian@cdjrlc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 10:56:18 +0200
Message-ID: <CAHp75VeXCaoKQ94x+ehXWMi5zeysJdjrzS1WE2oZCUAeLbCzvQ@mail.gmail.com>
Subject: Re: [PATCH] iio: aligned '*' each line
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 8:57 AM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> Consider '*' alignment in comments

Subject should start with "iio: dac: ad5380: ..."

The commit message should follow English grammar (missed period in
your case) and explain a little bit more, e.g. "Consider '*' alignment
in the comments of struct ad5380_chip_info declaration".

...

>   * @channel_template:  channel specification template
>   * @num_channels:      number of channels
>   * @int_vref:          internal vref in uV
> -*/
> + */
>

While at it, drop the unneeded blank line here.

>  struct ad5380_chip_info {


-- 
With Best Regards,
Andy Shevchenko
