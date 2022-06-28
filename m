Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1555EF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiF1U3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiF1U3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:29:18 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BD1FCF1;
        Tue, 28 Jun 2022 13:29:00 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-317a66d62dfso129018657b3.7;
        Tue, 28 Jun 2022 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtWDCZqvy4TTvCWnlJoa1yPXQxkPEGRs7O1x1+Wk4xI=;
        b=YlsTfLviybOfR+rjPn7jIq2SbwKZji90z44wO0lKYZeEhuo9RTvFxYChry9BQRHhrf
         9bMSBahzUf7j0ARQZqGYw3BSF4iZaJncz4twzP2XkOzZjLYPyul7yR2Ads2hVaUPhGbx
         wVHaEQ3bnGEnuQ/lnyTnx1aEOse4vZ2wsX1X7kOuT2DMLXurX9ptNd6C4mU104ISWsAG
         +aL/4De0wvwi82+1usS1gz+NrzYXkym3ql/8Kd7NbAdQTeS/0tQRCgKC9xFaFtLpSmy4
         LPlhWAMKjPv5r3BdhF+wEjMBMMRFe06ngiRt8mhYVf1FyrsyNsDo7cYzpSJXdMheXyvK
         zK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtWDCZqvy4TTvCWnlJoa1yPXQxkPEGRs7O1x1+Wk4xI=;
        b=HjjM7jDCf/PMUjwmR1b+yjgDXoan0sUKgIyD/SppbYNtXQQ3bavkhxy5hIARhcjZ5r
         N6bqfJ2J8MemcdQZ8x6M7nzENT7HWnVwHVUDAbXVUjzJLiGS81Ewp166Qlxu8qN21/pR
         7uVnXtQiMQ4f+vTnOuZ+ipGGIDBnvUL6afZjdIlPJYqGD5T2gPQVYS1YjUPQUiShdS02
         7OMXzbIx72NpWzzihMw9vQwg39Z8PL/7lqlxdlOIXpfvZHoiyuDrge+cSGYSlHz/893D
         VIWqIVMjvsYcUe1VLKMXebzQhDJKZsdquvajWdKhOxs0dFVIXN+lUwAAGHv0ntm2cuGm
         3l3Q==
X-Gm-Message-State: AJIora/V7KLfRxNqz/gpX3BaUGRr+UWW6Qq3DJdp9DBsl1pgHMotJQa8
        RNBbVQFW1F4yeQH1C4cuM2uRAkE8R9NkaPwGlUs=
X-Google-Smtp-Source: AGRyM1tuZyBuLff1iMKyDhmPPzrVYxfDfYpgHEfop8Gu1ugJVl2EbfJIbzBsjhmojigBvwwoSSdowcDFQcl+zpuHyO0=
X-Received: by 2002:a81:1889:0:b0:317:987b:8e82 with SMTP id
 131-20020a811889000000b00317987b8e82mr23470162ywy.185.1656448140077; Tue, 28
 Jun 2022 13:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc> <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc> <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
 <2f2d7685e0e43194270a310034004970@walle.cc> <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
 <9e58f421c27121977d11381530757a6e@walle.cc> <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
 <288f56ba9cfad46354203b7698babe91@walle.cc> <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
 <96f40ae6abf76af3b643b1e1c60d1d9f@walle.cc> <f9eb6d94-c451-0c9f-f123-2f1324f68b68@linaro.org>
In-Reply-To: <f9eb6d94-c451-0c9f-f123-2f1324f68b68@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 22:28:23 +0200
Message-ID: <CAHp75VdWdUY-XyGBsQb3i9thCswmBo4UEAEaZCO5MC_HMW+fSQ@mail.gmail.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
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

On Tue, Jun 28, 2022 at 5:17 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 28/06/2022 17:09, Michael Walle wrote:

...

> > Mh. Assume a SoC with an integrated ethernet switch. Some ports
> > are externally connected, some don't. I'd think they should be disabled,
> > no? Until now, all bindings I know, treat them as disabled. But OTOH
> > you still need to do some configurations on them, like disable port
> > forwarding, disable them or whatever. So the hardware is present, but
> > it is not connected to anything.
>
> I see your point and the meaning is okay... except that drivers don't
> touch disabled nodes. If a device (with some address space) is disabled,
> you do not write there "please be power off". Here the case is a bit
> different, because I think ports do not have their own address space.
> Yet it contradicts the logic - something is disabled in DT and you
> expect to perform actual operations on it.

You beat me up to this comment, I also see a contradiction of what
"disabled" means in your, Michael, case and what it should be.

If you need to perform an operation on some piece of HW, it has not to
be disabled.

Or, you may deduce them by knowing how many ports in hardware (this is
usually done not by counting the nodes, but by a property) and do
whatever you want on ones, you have  not listed (by port_num) in the
array of parsed children.

-- 
With Best Regards,
Andy Shevchenko
