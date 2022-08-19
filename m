Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9C5999F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347721AbiHSKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348047AbiHSKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:42:34 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28CDF4CA0;
        Fri, 19 Aug 2022 03:42:33 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i7so2955085qka.13;
        Fri, 19 Aug 2022 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f2ymQP7RmyhXPwARC3XVO6qBIZTzz5uQg4wHNvMjs4k=;
        b=mCPV9jMIz0oEOjkgWgvplWqWmlNVEzR7uz2r+pEAWeJebgT5MlOkKaYqLlHrZqOp/j
         DS66dyi7cQXSSGVTIZI+OkYU/TO5792CsscgKhvoNQotG9iQsj74xQZHbxxvIjlsh324
         suGLCjyMSgI7tJGzT2qcyk875xTTh2jUH/cDV/FKtvVES1qzNorrJ2ilrb72mNnyhHCs
         XlCGcB/E2y5Vk1hieATHIc0jW5jyZ+MmmckyahgUPanINAQB7GfwgataySfYaV06gnyW
         swMrPb6rO52QIgVPAVwlU+PzEDw1+uyNmuH3VOFysKrhqsjdEwd1jw+IDWM+Zr86qZ0H
         iRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f2ymQP7RmyhXPwARC3XVO6qBIZTzz5uQg4wHNvMjs4k=;
        b=iFxA+t2UONJUCFQZUxmb6LJZSftkBc/IHijHl++EouU88Ccs61rU9z/hW2zG5q33rA
         6PJekYsxW4TerAlaBOKn0762UMT90td7NkKZ9H8H/mQ8kcOCO3zH2mYpCVon5OeQjcFI
         ns2ra9CWwkdGwG1yi4Ll2/P7RITuiFOiUOwVVn4SC3v3wL2McSoRdYB7e9XWSiZz7kCf
         gUV6ms3KmyysqrBvKDlJBWa+esIWpXjx0FXAri5H6H+UKWuZVVX1usmbm5bITmYtl4rm
         WMq5r1u7Ga5VXpCOrWVba0G720mpJxIM7q4gzxCC7ijiDH4zs6V+DZ0I+fgIWqUWZOSa
         03ZQ==
X-Gm-Message-State: ACgBeo2VCB/LJfVbP/HBfa75Vf4XHEu8dZq/9lSJ9ieIQscTp0yKb9T1
        sm7LJXR1ZvNC+7gPIYVc0rmYm8VyTnofUjtRavM=
X-Google-Smtp-Source: AA6agR4WT/qaoOUdtk1Itp7c3bhT+eoG2hRYXMONj34prB+dXxr5zgJu5oFbq2rNTgmJuezsOmwy4NFU/np3CyxDxJI=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr4710971qko.383.1660905752738; Fri, 19
 Aug 2022 03:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
 <1660649244-146842-2-git-send-email-john.garry@huawei.com>
 <CAHp75Vc4vT==hB=svhDBhSpNFCQXwzZ1RMxy4mQspFhmSjQ03g@mail.gmail.com>
 <366fd6dd-a37b-c7ec-fdf3-48f8a8024834@huawei.com> <CAHp75Vd-6mfK=Or4MjXswUZsovHhMyDDJCv8srBH70f24MGvpA@mail.gmail.com>
 <1a5eb773-d339-512f-7c5d-7ef72edfdc2a@huawei.com>
In-Reply-To: <1a5eb773-d339-512f-7c5d-7ef72edfdc2a@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 13:41:56 +0300
Message-ID: <CAHp75VeGpOh4REjUK+iBKr6AD7szSdd8HZoMZeX3oBtqu50C7w@mail.gmail.com>
Subject: Re: [PATCH PoC 1/3] ACPI / PNP: Don't add enumeration_by_parent devices
To:     John Garry <john.garry@huawei.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
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

On Fri, Aug 19, 2022 at 1:20 PM John Garry <john.garry@huawei.com> wrote:
> On 19/08/2022 10:59, Andy Shevchenko wrote:
> >>>> The hisi_lpc driver also creates a platform device serial device for uart,
> >>>> which is the actual uart which we want to use - see
> >>>> hisi_lpc_acpi_add_child(). That function does not check
> >>>> physical_node_count value, but acpi_create_platform_device() does check it.
> >>>> So if we were to move hisi_lpc_acpi_add_child() across to use
> >>>> acpi_create_platform_device(), then the change in this patch is required to
> >>>> not create the PNP binding (so that physical_node_count is not set from
> >>>> PNP probe).
> >>> Hmm... The flag, as I interpret it, is equal to "the device in
> >>> question is a peripheral device to the non-discoverable bus, such as
> >>> SPI, I2C or UART". I.o.w. I do not see how PNP suits here. So, from my
> >>> point of view it seems like an abuse of the flag. Not sure the current
> >>> state of affairs in ACPI glue layer regarding this, though.
> >> Sorry, but I'm not following you here. Which flag are you talking about?
> > "enumerated by parent".
>
> ok, right. So I thought that PNP0501 was a standard cid to describe
> 16550-compat UART which may be on an LPC bus. And a LPC bus is
> non-discoverable, like SPI or I2C, which also use "enumerated by parent".

While in most cases the above-mentioned UART is sitting behind LPC and
what you described is all true, there is no requirement to have
PNP0501 to be tightened to LPC bus, so it can be any 8250-compatible
UART.

> Indeed, using PNP0501 for hisi lpc UART cid would be without problem,
> apart from the fact that we can't do all the PIO translation (so need
> "enumerated by parent").

Yeah, what can use this flag is the UART peer that connects to the
UART host, but it's a bit grey, because UART is p2p and not
controller-peripheral type of connections.

-- 
With Best Regards,
Andy Shevchenko
