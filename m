Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6E4A9F86
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377772AbiBDSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:52:44 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:36768 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347727AbiBDSwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:52:43 -0500
Received: by mail-yb1-f171.google.com with SMTP id c6so21442951ybk.3;
        Fri, 04 Feb 2022 10:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRqeCJ6tWg/JKX8pl73182q4qGAdegHKS+d/elVIO8Y=;
        b=jzeoaXopSBmHYErsrpJAw2GKwoH1JBaZJItFqNhExJdx5e3WJmw1ucBQuHEvTRH7ut
         ek1QCKVcGWHc08GI/CCTI0M73gKeLxIoCEbwxrOc6AhwjxouP9ETyPfy6VMmKkNBzk1I
         7Wr+ySzjqpu5t8A7K/q/HebD/IkiaUTPx3vX8iNMHSIjvtgAl3sq+IQUGnxMKL3GEOs7
         puFAh/krg7nMFEPO9hmNnBOBV3JHmjqX5+0Q6MFroKLDbSGr6KqII87Z0hSqKqQpR76m
         SmgzF/0JVfYtVUl5ED1AcOz4Ae1M8kDog0HNjV6oyAvddSFEFSE7bzsuBr1vSR54Cmtj
         W+mw==
X-Gm-Message-State: AOAM531WlHFF5kyMvcqG8gaMdLLY4ywmluzMPlHXtDsRA4UeuShzrEqR
        wKmb8JzwGRiOuJ4Eb/+IUCovzE1/9WPO9m27o5s=
X-Google-Smtp-Source: ABdhPJxHKnVROmzucvYb7XsBNZcyFJA032mb2OWKpKTT360cbJZXWSb7dyANtpTIqvhFj6IUf/q62uBqDcZUQiMgppM=
X-Received: by 2002:a0d:d847:: with SMTP id a68mr315671ywe.196.1644000762812;
 Fri, 04 Feb 2022 10:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20220203125613.1166-1-andriy.shevchenko@linux.intel.com>
 <Yfzkm1CVNNRqHzd7@paasikivi.fi.intel.com> <Yfz0v7oqDkgfZyky@paasikivi.fi.intel.com>
 <Yf0s0/JjSKx/R4Ww@smile.fi.intel.com>
In-Reply-To: <Yf0s0/JjSKx/R4Ww@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 19:52:32 +0100
Message-ID: <CAJZ5v0h33afHe2tboa=5OEvEaqJAv730fL9YdXiGppUpdk+41w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Don't split fwnode_get_irq*()
 APIs in the code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 2:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 04, 2022 at 11:41:19AM +0200, Sakari Ailus wrote:
> > On Fri, Feb 04, 2022 at 10:32:27AM +0200, Sakari Ailus wrote:
> > > I'd prefer to prepend this patch to the rest of the set I have and get it
> > > all merged through linux-pm tree, on the dependent patch reaches it.
> >
> > I rebased mine on this patch and I was quite surprised to see it doesn't
> > conflict! So either way works fine for me.
> >
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> Thank you, Sakari!

Patch applied as 5.18 material, thanks!
