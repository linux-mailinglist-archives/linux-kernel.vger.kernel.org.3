Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534CC5577B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiFWKSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiFWKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:18:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E08F6425;
        Thu, 23 Jun 2022 03:18:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z11so21650618edp.9;
        Thu, 23 Jun 2022 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9ea/dcrsF9M+CJZqSv3b2zBRCLTq5sbj7L8gKts0jQ=;
        b=TFTkb1ZVGMYu/zxZXjN6uNtzgfXwdi5FhXkpJzXoeNdndwLMun/iKmle1hFkXuCQeG
         LpoODm0Lna7VSP+5PxRcrJDWzKHaBM9E/ncY2ewlWX9jNjHDhxl+5OHrhLpfjEp0Zf97
         gBAB2R2knxHO910erbKRa7ejBc32apiS1PAqj0IiNgkOddWvcy9HQA2K40aLJKWpBU90
         qtSgIufbyfRRNTGI6vCGwKkR0plB7q9wySpHOxAe0JylCtquBq66ADfxiiNdjCoIVruI
         teSome/MdQO8c5Dvb+cWUyFDE3XY86OYC1bQ/hfLOMelogpYs7KAhdDZ3coGEh7nyrqw
         a83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9ea/dcrsF9M+CJZqSv3b2zBRCLTq5sbj7L8gKts0jQ=;
        b=3mlthcogdvnIukMiBnH8sGPhSw8Jmt1g5CX4modGW5gO4n5SYLlWj6mxFt6z1/ZQYC
         fSDSuY/Ed0L9Ykkk1WcVVU7hiuN6WTWnC2fg/7wa1gMde2kk/n95qSMm8I3KUynfIpxa
         /lmDBJEMB115tAG0lxSWRhlZPAE0i0j23JI1LLeVSAsKhaPfAt7lb2r/ivIAzRkZYQKT
         JdLenwqeUWcpis0hrbE3oJ6tfGKU3gVzPD25hkyJVei83kZJEc5QDosKVS3DG9ooByAd
         EywNImuED4pXPkVroqs0fBN38wOCYJ2TEGWPtAIUwAU45//siCgxFFz3cvKgX9keQMr1
         xwew==
X-Gm-Message-State: AJIora+BrGYCN+Hpg13UOYKJFwjlKqJHWGRbf+SaceXKNCKfuZfweAt2
        femAhSluS3Y1pQBvFcTrLEgTEQzEW7bdR7p5bbE=
X-Google-Smtp-Source: AGRyM1tj9InnAI9P8P0ZW+y2x54HIErM5Ii+utwX0T1UDOfArPynP5xeyj+97Kd2EGKyVPBYIxmDT0Wht2Omb3rWlLQ=
X-Received: by 2002:aa7:d29a:0:b0:435:705f:1319 with SMTP id
 w26-20020aa7d29a000000b00435705f1319mr9609494edq.54.1655979516662; Thu, 23
 Jun 2022 03:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-7-ilpo.jarvinen@linux.intel.com> <03467516-3962-4ff2-23d2-2b3a1d647c5a@kernel.org>
 <CAHp75VeKhY6dN7j_yXQXUMhOqRwqQ2yN_qF95U9wU6K4uKPdaQ@mail.gmail.com>
 <c7115ff1-2a97-f5a0-a0c2-c7c1064af291@kernel.org> <CAHp75Vfsy5yY3saSCvCu87E-arifwEZXUNtFMrMn38gJY2LU0g@mail.gmail.com>
In-Reply-To: <CAHp75Vfsy5yY3saSCvCu87E-arifwEZXUNtFMrMn38gJY2LU0g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 12:17:58 +0200
Message-ID: <CAHp75VdSadbtkH1JeiPuJ_CSBDq82GaRWLvJFd8Egg7poY8Lxw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] serial: Consolidate BOTH_EMPTY use
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "speakup@linux-speakup.org" <speakup@linux-speakup.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 12:15 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jun 23, 2022 at 10:24 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > On 23. 06. 22, 10:11, Andy Shevchenko wrote:
> > >     * prom_putchar_wait() should be implemented using
> > >        read_poll_timeout_atomic(), incl. failure/timeout handling.
> > >
> > > Not sure since it is an early stage and scheduler might not work as
> > > expected. Conversions to iopoll.h macros bitten us a few times already.
> >
> > Except _atomic does not use scheduler :).
>
> Sorry for a bit misleading comment, but I chased it down, so this what
> I had in mind when commenting:
> be24c6a71ecf ("soc: qcom: rpmh-rsc: Don't use ktime for timeout in
> write_tcs_reg_sync()")

...and this one (specifically for early stages)

c4d936efa46d ("Revert "usb: early: convert to readl_poll_timeout_atomic()"")

> (Yes, it's about _atomic variant)
>
> Means we need to use those macros with care.

-- 
With Best Regards,
Andy Shevchenko
