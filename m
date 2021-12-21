Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195FC47C527
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbhLURnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhLURnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:43:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79909C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:43:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so2244154wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qBE12b8vdnqtstGHFEJZcs6qFoeauTfFcVbXgvgPULA=;
        b=hdnPfbv2sNQLuRXnuw3LxzsfrfuuQFSEWMWM2+xryiMjdQgWpY+182PYMMRSHmx1Er
         nAwTgZUrFPRo6u3h7IlgkxLPRxFQ3WeJmpeDmQZThimeADQEc5nnyD+7nAblN+8x1+iQ
         IHzaz0tFFOdBP2SSJnKGV4VulYnyJ4WYyuXZWUwAbSuV9CKba/SOQnS7I4+uYbSaIWP+
         +z1cnJK9c2U/GmMc2hy5ax2p2DlTf95ykYwNhFWMHby/8O4RpHI++ftH0zVwgak9G321
         lTctF/xGdd4wLFGTOqzh4MkRm8/ycK2+4ZFtwlYSXMx4AD4gMmhrre6mrE/faUTOl5gn
         d89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qBE12b8vdnqtstGHFEJZcs6qFoeauTfFcVbXgvgPULA=;
        b=pGtkMBTDsOB2Ii9Bm8+bB5heWmVvDBrcD841o1MkQXnf9/YXhUrBR7NBDCSnwBLOpu
         1b3/jcGhy8826iVvYoyr5NSWT7ZdMphT4oltxlTe2EFLsln3cWUf4iRoiljxMUwSr0ai
         +vWOVVfr5XsDK+lotGniQ0ipqeIKRGUh+RVYJp9toZHuFmhsty/kIq9uvEODxv5M5PHy
         phE4ngFKorDMqVjUy0o9O3VzVitPRTMEIxEKifwBNaCjI/99ecYV5MEBqR1qUkWxmE7U
         nMYYjwEp1lI9rGpbgQko5hl7joldho7YjAepTqACtJq8av+YAroJASczL/U7UGKLcDh4
         THOw==
X-Gm-Message-State: AOAM530uO+i4kUwjda7/gaW6amSVmjiu1N3RDryked9J8GbfxHEqUrvq
        fD81gWGi6k/OyU6cTAjXTgTPgw==
X-Google-Smtp-Source: ABdhPJxr9epBEjiveABhSyTbxZrFLQQ1wVGQ2VrDZrrOrzDb25Cwi8Vbsjqw1O7zBByQHEU7Y8b2VA==
X-Received: by 2002:a1c:e909:: with SMTP id q9mr3597321wmc.184.1640108610904;
        Tue, 21 Dec 2021 09:43:30 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:4a23:42ad:dc71:62e9])
        by smtp.gmail.com with ESMTPSA id a1sm19123717wru.113.2021.12.21.09.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 09:43:30 -0800 (PST)
Date:   Tue, 21 Dec 2021 17:43:26 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: Add Open Profile for DICE
Message-ID: <YcISPrm/R8QIqkMb@google.com>
References: <20211213195833.772892-1-dbrazdil@google.com>
 <20211213195833.772892-2-dbrazdil@google.com>
 <YbpPYG4rzPmJmwA6@robh.at.kernel.org>
 <YbpZTSpmnieCNZ9a@google.com>
 <CAL_JsqJRpNr7McM9OJcPs095ZfAqGJfN7FhGhy7i6pN+tx1MGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJRpNr7McM9OJcPs095ZfAqGJfN7FhGhy7i6pN+tx1MGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 09:21:00AM -0600, Rob Herring wrote:
> On Wed, Dec 15, 2021 at 3:08 PM David Brazdil <dbrazdil@google.com> wrote:
> >
> > Hi Rob,
> >
> > > > +        dice_reserved: dice@12340000 {
> > > > +            reg = <0x00 0x12340000 0x2000>;
> > > > +            no-map;
> > > > +        };
> > > > +    };
> > > > +
> > > > +    dice {
> > > > +        compatible = "google,open-dice";
> > > > +        memory-region = <&dice_reserved>;
> > >
> > > There's no need for this indirection. Just add the compatible to the
> > > dice@12340000 node. You can bind drivers to /reserved-memory nodes.
> >
> > I have not found a way to make that work for kernel modules. Built-in
> > drivers can bind with RESERVEDMEM_OF_DECLARE, which puts an entry in
> > __reservedmem_of_table and __reserved_mem_init_node() iterates find it
> > there. A good case study might be CONFIG_TEGRA210_EMC, where the driver
> > itself can be a module but the rmem parsing is always built-in under
> > CONFIG_TEGRA210_EMC_TABLE. I don't think that's worth the trouble with
> > this driver.
> 
> I forgot you have to add the compatible to reserved_mem_matches in
> drivers/of/platform.c.

Oh nice! Exactly what I was looking for, thanks. I'll respin shortly.

David
