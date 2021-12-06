Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52136468F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhLFCkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhLFCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:40:01 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F0C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 18:36:33 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id be32so18783942oib.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 18:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZJF/0KXMnSNVIf5/ZsBXY5+vlIl59+Y1SrGZ6vKlpyk=;
        b=Y6sXzruSfZr9M93iX35pRopd1MgqXToZ0jn27izgNweaAib+JEZm1wAmXvrvyWro9X
         pZc7vJemGHhucn71FZxB1lNKO4mMxNXAxMK+sF6hlAJ0BFJUCnf2SeRJMfhPsAa1e1S8
         HCI9Coq7nJMNDJTnvXIvhtxR6UdIIf08rf/x23OHenLyt7JbbWScxvHTlfdATeQIiPxi
         om7BC3wcXBYNHbQIYUDRkLJPeaI/kQQT5u42I2NZe8sWDDYILnKOFLR0yPdlvKU/27FL
         6FSC/bSgkhQherNypwPJIlI6Kx1gMToO2ZrEgCZLd70kn4A+ssrdw5k8CtS17ub6Nh8j
         ITQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZJF/0KXMnSNVIf5/ZsBXY5+vlIl59+Y1SrGZ6vKlpyk=;
        b=PD2JlThwiHQUdoR0BCQQeLX+jwp/4ZtLPP3lKU7WfVGBdi4sOIOyPCyjxl+F5vBrgp
         4SdmXzTBoFi2UxLdV8E4gqPR9Uv2uWdySe3Bfj8hdF9JeM0USLRAQHWeBirZcx6XKfBV
         EKCbnS/2ITx4ovn+Hddk3Nj2prFEk5G3p+A8THDg2Yu1IaYMrJVI1U6sOQLt7BxMOypz
         kK5pEeOL3NdjyHvM6z1j4jWFQ+w/+rflwY2ctSmEeIwOv4FCoy70FZvQwSY3TOUBx0rc
         ajA5ZRqoeFDc497ImTZTtgRTBMyp49BWoao6pQbZo6UYcp0dZ+qFYK1h1+YrR8nE8MGW
         /XhA==
X-Gm-Message-State: AOAM531Jj6anganVCDbLJbCFOn818ZMYTEjqtyA08reSulasftia7zwU
        B2Xl5csfrTWYa41ZB0niMyQF7+OQctY=
X-Google-Smtp-Source: ABdhPJw/yaBXD9O3vojvBTdVtNiTFoWGb2qqXFDd1+wl36wAb64DwxI6iOupuwe7r7rKk32Snv3gJA==
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr4464782oiu.159.1638758193250;
        Sun, 05 Dec 2021 18:36:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n19sm1984124otq.11.2021.12.05.18.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 18:36:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 5 Dec 2021 18:36:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc4
Message-ID: <20211206023631.GA63932@roeck-us.net>
References: <CAHk-=wguTgfhqftuf6FnW-KZ7zhQGDNktr_POKUkJ6SuMeQuWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wguTgfhqftuf6FnW-KZ7zhQGDNktr_POKUkJ6SuMeQuWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 02:18:58PM -0800, Linus Torvalds wrote:
> Fairly small rc4 this week. Three areas stand out in the diff: some
> kvm fixes (and tests), network driver fixes, and the tegra SoC sound
> fixes.
> 
> The rest is fairly spread out: drm fixes, some filesystem stuff,
> various arch updates, and some smattering of random driver fixes.
> 
> Nothing looks all that scary, although I certainly hope the kvm side
> will calm down.
> 

Build results:
	total: 153 pass: 152 fail: 1
Failed builds:
	mips:allmodconfig
Qemu test results:
	total: 482 pass: 482 fail: 0

A fix for the mips build problem was submitted at
https://lore.kernel.org/all/20211203192454.32624-1-sergio.paracuellos@gmail.com/

Guenter
