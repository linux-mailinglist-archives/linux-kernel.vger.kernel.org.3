Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525784774AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhLPOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhLPOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:30:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3EC061574;
        Thu, 16 Dec 2021 06:30:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b7so28377295edd.6;
        Thu, 16 Dec 2021 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zyz6+SeIOSQpRQFeqW/jl3kpfCV7scubV1qfNlvUGW8=;
        b=T2h/q+j0Fhb4j4mST1mvsmpvduhyEyyO62tQ/qn75YiGGaJXvpH+eBKoxvzGMM+3jm
         +STU02p47WKVCS4oqjOpjPQ2lqbYp37OuY1K5IqM7KPyWksU1mjIUMSkNvQviHstaC1W
         U+KeNesene1w5vO4URMf815cFZa48IA+8U0opVjos0UTDTLSlNrh8W6/DsR30sTRAXRE
         YZaj17EKg8bjfcqvZyvQ2xSsPq8V/AV6l5bTtOvOFc/4yWMYgMsDqsAl3luO8dOEY+RX
         lZIgaLVEFsrKPtQ4/Ei0g/O7CzceM6VsYfDMjfZeH2/FSUNP7RE/9OQcg10RMjokEwK9
         6iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zyz6+SeIOSQpRQFeqW/jl3kpfCV7scubV1qfNlvUGW8=;
        b=c09W74xeEi0cdgEIYdP35wyH5e0WQ3YVnZd7ueGPQTazJMI1+6uOfFwvzKcJewB4E1
         ozheHKt4LEjcs+nFookCBASWV1QC42QHbwduK6PbXbyFqFphpefqxWe8MY6s0o6Ljwzw
         3ny3vH79hm0EbuQ2bwtw/PO5+G8Jd9z9c+pFgle+/KeJ9eaGy5QcseO+QrbO7//SG/Oa
         lMfBsDdq3J/IaN3qGo4sTivRyIpfcp1uDrl28SmUoFWPdvbtenxCyVeQT7R1ncgoYQwW
         bDLqpJC0Nwvj5n8tTTt/n7s8GiNIy97zKbS0STqgq8WprmNx6PowHO+EL8CleZX01wL7
         oLAg==
X-Gm-Message-State: AOAM531ZQ6XfY5cCzNlAQ1reCxxsZ24ytPLoFvT3yBHImziU1WLVsUfz
        mIDDNZZUNqoJCXY7ppBDW75R6VOCqfErleNRJSs=
X-Google-Smtp-Source: ABdhPJww9DNdDNu0vk0vZXFbGdrhr+pzPK2m2gNSPePV7PzOmPXKijxWGR49cZnA6Vt3yHTKvtePsTC16lV3svMsZsE=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr8028998ejj.636.1639665024183;
 Thu, 16 Dec 2021 06:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20211214142739.60071-1-andriy.shevchenko@linux.intel.com>
 <20211214142739.60071-2-andriy.shevchenko@linux.intel.com> <20211215202736.GC28336@duo.ucw.cz>
In-Reply-To: <20211215202736.GC28336@duo.ucw.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Dec 2021 16:28:55 +0200
Message-ID: <CAHp75Vf05OW3bLLP+vCAvrh=YUOF_1BDLBt2LwAtGLxOABhhRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] leds: lgm-sso: Get rid of duplicate of_node assignment
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>,
        Yihao Han <hanyihao@vivo.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 12:29 AM Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2021-12-14 16:27:39, Andy Shevchenko wrote:
> > GPIO library does copy the of_node from the parent device of
> > the GPIO chip, there is no need to repeat this in the individual
> > drivers. Remove assignment here.
> >
> > For the details one may look into the of_gpio_dev_init()
> implementation.
>
> Thank you, applied the series.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
