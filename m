Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6E501732
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343701AbiDNPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242410AbiDNN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B412018A;
        Thu, 14 Apr 2022 06:55:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c64so6433544edf.11;
        Thu, 14 Apr 2022 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5aWYxkMrcBFiZitnUw0BTQJF0hESlZ4bWlKsoVZ2qk=;
        b=JY+wyiniWXODIB9ip+nO+wz7WCk7mIMRSrne8Efqpq6QArFTFLkSy1HHHAcMyfO5Lh
         7c1+uBsd4DXxMgKgAzuhJTQ0T9kSCP/aKmZ/hIqrpZTi8d3M3czgJv7aRJNpJ66uwW63
         BDRAZJPH/yW0iqGp3y8Hz29qbByy24RMCqzS22Jv3/MJqFu5JTzVRgfIJ5fQLRGVOKGe
         Xr5vqtVVMEhDZeplv7OUiuwOGeVEm7ycntN+Frp3W/awvwq20P3gmiVwW14Qpmv4N7aj
         Zwyk166RqpMzhj/c31zjd7lwvBFPdn/RyZVLjjZ/ofxopRqmY5+oBYmQyLX5EBnMvwah
         ZvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5aWYxkMrcBFiZitnUw0BTQJF0hESlZ4bWlKsoVZ2qk=;
        b=VzsQjve0imrdIA5pTjN/xdTpcH8ZCY9eRvqNTrZwHFFG8SkSE5Z3bw4DNjt20CSlWi
         0UPINHOxSs3DctGS5K6Bzy22gF/UA2tBrFt/P/Ajp7vreKD260LWRl/HwGFWyVwGiGTC
         OeqbJg31v4ZpRtsV+QyDt13jqkIyVwwhD3HTjg/thMHFBqLZYzpw3F4mIUEr+giiCieO
         D6BwqkNiHIg2lYE0J2LTka2s6MlW9XJpqgpBdUPmUwQgYAsuLFHglgQT2o9k6TyHmyxv
         TCCWUYsztgtUYCYDhDPX/hHFNBkBOWHVobQzRwUrQ+GiKnMp5gsviaqSYkZFjXGrmvCZ
         caTg==
X-Gm-Message-State: AOAM531eb0WkOPEpBG0GzPdUeNOFSa5XO2Fholrwn9BhvIxILPoSXPoq
        J3VkVnnlnKjaK6yU2/MSxHrBGebf2bqJDwQHbaY=
X-Google-Smtp-Source: ABdhPJwyww3e7aXwVAs5W5XjFg3dukyYoKr1v4cFU96Oyg0QAXFlpH1HVg2jgzcNDXhZb66cB0aqELroxq5jSc7mxQ4=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr3188574edm.122.1649944543309; Thu, 14
 Apr 2022 06:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk>
 <alpine.DEB.2.21.2204132103190.9383@angie.orcam.me.uk> <CAHp75VdOf3+j8yQh=-f6iCN_gRhisgoQjov2kK1fhgv7xaBJRg@mail.gmail.com>
 <alpine.DEB.2.21.2204141421190.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204141421190.9383@angie.orcam.me.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Apr 2022 16:55:07 +0300
Message-ID: <CAHp75Vcb0JBQoNrb=ABCsPeM1U2zmHLw0P7Haa-Z=6D__VuqWA@mail.gmail.com>
Subject: Re: [PING][PATCH v3 0/2] serial: 8250: Fixes for Oxford Semiconductor
 950 UARTs
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
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

On Thu, Apr 14, 2022 at 4:47 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> On Thu, 14 Apr 2022, Andy Shevchenko wrote:

>  I fail to understand really why a piece of code to correct and improve
> broken UART baud rate calculation has to be stuck in limbo for almost a
> year.  There is nothing wrong with this code and it has a proper change
> description and my observation has been that actually broken code often
> with half a sentence serving as justification gets accepted with no fuss
> all the time. :(

If you remove those 3 or so lines of the code (that are pushing old
SPD_CUST hack) I would be happy to Ack your patches immediately.
Otherwise it's up to maintainers, if they are fine on that. I think
it's a step back advertising something that should have not existed
from day 1.

-- 
With Best Regards,
Andy Shevchenko
