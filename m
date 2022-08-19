Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE49E599A07
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347279AbiHSKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347454AbiHSKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:34:32 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9591A924B;
        Fri, 19 Aug 2022 03:34:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c20so2990796qtw.8;
        Fri, 19 Aug 2022 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=y43Q4Ux8mzcAs/PRKLgB3PhAbbRFuFRwNvqbANaCmZQ=;
        b=WCzWYNhe7Uos+2cSI8d1+g+RmMXisRI0OCPtLc8pLgBH0XA/Q8jgQ/tBCriBS/plKX
         eaTd4DdHfZVz0DOG4feUrCLJrexHYMI1Q2awWoSCdiAZwMgNvUPXo9X49vEgr3qGhb7M
         bvPboaOFVYvi+A3cRBv4+2CBzxZ81DlynNJ7L4JpNxUCQ0hGRuWVJh67WkGymLNzSdZl
         If+S5KdKCITHYr9e6OT3xXAhIDV1hTvjT9q1s3IUtgnxhWRHyLayQbn6NKJcwydyKPn0
         ITdpm64bppQOL504GAXAa/kmBQIn2S4uD/1AprPF7imSPdET3gcOGDGG3X4z52QoHMNz
         sK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=y43Q4Ux8mzcAs/PRKLgB3PhAbbRFuFRwNvqbANaCmZQ=;
        b=y6kBwP10ppmXZwsSelNjKSCEcd1GSOypOTEafVx2BpuO2LdwcH7f9HZiHiTXq10vev
         0IKvhI2m+12dpWCuvG/P7CSTSZWUiIKZaKk9ITna2vBCv+ITSN7hrTHWo7IawCb8cAuF
         /6f/g2y/DCBVADVoX0lLFdEwAYs3jMORJQsCnJGU8ygbUSocOahlzPafyxCZySRPu01U
         fOOQ0RBREk7mLM58iziNTDDrUxT5/0dPEx4tMFbIpq3bwSr2YwiHJzCSjLoslGXXhJkt
         42B99Q9PmqJ/7FksR2se6FxiJXCvInORzEDkjZ9m5NzqXs7xkvbx/1mNKiV66wjLP/KP
         CbPA==
X-Gm-Message-State: ACgBeo06IEZHzM9H/TXhmlM9dZuiWw/NPc7lcTzmmikE5B4B0OUN6UJR
        +e5KliyLO2dY3Iry1kD4GWKUXWvrf60PT9FKQbk=
X-Google-Smtp-Source: AA6agR71z1/2SpT3yPpDi+nG8Mk5PMI4fgXgfA+vgEQzHAkvpZagpe1i71Ye/VpuaokPks7F+VLaUOX9ymA7jlbWiTU=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr5973760qtx.481.1660905270646; Fri, 19
 Aug 2022 03:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <6e908cc827c70b95dae683717592aff0b003e7c9.1660606478.git.ang.iglesiasg@gmail.com>
 <CAHp75VdTZ_JYB2aYVdQTOx9QW1HPKhwYyQH-0tVCtpjHV=VcaQ@mail.gmail.com> <8a1f372f34be71895268e874bb3fbbf105dfabdb.camel@gmail.com>
In-Reply-To: <8a1f372f34be71895268e874bb3fbbf105dfabdb.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 13:33:54 +0300
Message-ID: <CAHp75VeSsVD8rMz-Cj6kFovqdQQPjbH7rUXWS6paRtsBaB-Kww@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: fix datasheet links
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Fri, Aug 19, 2022 at 1:31 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> On Fri, 2022-08-19 at 12:37 +0300, Andy Shevchenko wrote:
> > On Tue, Aug 16, 2022 at 2:39 AM Angel Iglesias <ang.iglesiasg@gmail.com>
> > wrote:
> > >
> > > Updated links for BMP280 and BME280 datasheets on Bosch website.
> >
> > > Datasheet of BMP180 is no longer available on the manufacturer's website,
> > > changed the link to a copy hosted by a third party.
> >
> > Note, that the version is downgraded (from 12.1 to 9).
>
> Apologies, I forgot to add a note about this. Changelog on datasheet 12.1 listed
> these three changes from version 9:
> * Page 26: Changed document referral from ANP015 to BST-MPS-AN004-00
> * Chapter 3.5: New equation for B3 (adds a long cast to AC1)
> * Page 26: Updated RoHS directive to 2011/65/EU effective 8 June 2011

Perhaps you may add this to the comment below into the code.

> Unfortunately, I couldn't find the most updated version in good quality hosted
> in a trustworthy place.

Me neither.

> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
