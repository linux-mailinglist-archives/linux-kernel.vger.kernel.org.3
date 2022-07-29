Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1E5852AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbiG2Pcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiG2Pcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:32:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C696FA0C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:32:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fy29so9101451ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jmBIRMRQS/VgtMcMzm0Oe80Xtab0xlTKGKq4qVMd4kY=;
        b=ZlQLOFKuTG5vgUQiyuXFtBbf6p1VnWLpTKhhUn8bD9oI97N5UwWofWf/jVXh+6FEI3
         PsrYm8DSkIGvjUy6Fu+MYXsgMbiqP9ECFlJ1NYDkty/Tt9xK6EtUkaWcc/lIPnnnBJrT
         SSwomT5XTaslGcRyymoPuanPAzQDSWB+Xonos7q4IqLOs7TX3pG/ewNHud2BZwCUFcXB
         PvYO8+1rd3Ivlb1cCgo3FkA03JRCQ1XJVBS1uAU0EuUMh7/kFWcjMwulMFcpri8FXQzv
         Sm+i3mWxDcq0FNDUiUq2Zkuixu5Jrsl3/+fyCQgTYHOdRPH/EEEDGgDNiXaGhCMpdfNx
         gJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jmBIRMRQS/VgtMcMzm0Oe80Xtab0xlTKGKq4qVMd4kY=;
        b=209EBJxwq/nban5H1w2kUkJX/k6g6/ifuYTCDAo+x67uK3/WNc821FIkaarF25nONj
         Rb62+8gETHKnOCIW5iBTrf9KbbyhW5jvVr4TfGHOqcAICYBRw8oys5QUgc5NVi0m5J0K
         pYDm17gwHDv1M+ngET1Hm+ZqPeH0B6v75vAkVGwV7zSnGM3qrLCSGdaAHVU2JZoDm19a
         7Oi4xj+nNRFkoVhbnn+h31c7nQmIhrcHzVK/Bh0YrM4hMnI16SvYX6pddWaQr2dyyuGu
         uO3obyHUjIO8O7qnLLwTFeAWB01EV0tklfHbsPGXYz5NrYtggHmkNbxcMFwTz64hIlOO
         2rDg==
X-Gm-Message-State: AJIora9hARR6b3sLcytGXQKYtQmyJLBYq6oXzchxSE/5NvodQvE3xMs8
        9H9YxUSJiY03fmoz474iuYNkwmvlO/r3KmguZQ0=
X-Google-Smtp-Source: AGRyM1vNISp+OeLGZrYIy7SfAY+GquNrF6kbAQH50eNQJ5t6bF8PfYsV9OfaunP6KrxX7eG9G6dp9UZnVijPuCqsW6I=
X-Received: by 2002:a17:907:9706:b0:72b:4b0d:86a2 with SMTP id
 jg6-20020a170907970600b0072b4b0d86a2mr3227461ejc.242.1659108759194; Fri, 29
 Jul 2022 08:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com> <Yt605xj898VSAsA3@casper.infradead.org>
 <YuPwLq+D8k53GZa3@smile.fi.intel.com> <YuP6Evijb2oZqD3D@localhost.localdomain>
In-Reply-To: <YuP6Evijb2oZqD3D@localhost.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 17:32:01 +0200
Message-ID: <CAHp75VcgRxFLY6ckgRxPxQtShTssgu__FyCER5yg5nASwmzmZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to kstrtobool()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 5:21 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Fri, Jul 29, 2022 at 05:35:26PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 25, 2022 at 04:21:11PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 25, 2022 at 03:55:27PM +0100, Mark Rutland wrote:

...

> > > Well, that's going to break people who've started using the new option.
> > > As a quick fix, how about only allowing either "f\0" or "fa"?
> >
> > I think we need to be more strict in kstrtobool(), i.e. 'f\0' ('t\0') and 'fal'
> > ('tru') perhaps?
>
> lol what?
>
> the only way to be strict is to accept "0" and "1" with optional
> newline and delete all the rubbish entirely.

You have an anti-user mindset. Be more constructive, please.

-- 
With Best Regards,
Andy Shevchenko
