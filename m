Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0448979B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbiAJLh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbiAJLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:36:22 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3865C061757;
        Mon, 10 Jan 2022 03:36:21 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id c36so22682706uae.13;
        Mon, 10 Jan 2022 03:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOYKOMNdn7daGbU6jgLJi3oEFCH812Tr1mFTkATHWbM=;
        b=dv9b9/vqTHZPdaEMYargHBS4A5dlQeWoYXCDzcpobdFebh23GRb+8bw4rxhay5OVzV
         q4iOrsoS4Ma220UPt9kVVfLFDY7aaMwyQbvGvuzdP8gtm/9xP0RNgpBFRtTqDeEogJJ/
         SVGrNAGMBWnBrNA2/t4+GtG3Lpkwf9SXTf2+SMKckYYuqb8CX33CH4cBnyLfcJw3sFmV
         ym9FiSbQdE6tjguw7B08w1VNejUWXNg9jPz/uZi7EBD9ghjMczdSwJGfOKLUhLGP3Fp8
         B4GS5WrvQJFi8XZx/YkevkMwgUxo0y6IwkTr49n2IyuGlqCwIYZrYItAsYFDjZXlKWBm
         Ct4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOYKOMNdn7daGbU6jgLJi3oEFCH812Tr1mFTkATHWbM=;
        b=gUEU2c+DRiwzOFEh3YeXrW71xtmKsU9I7zzKXDKlkznUecCfXvNwdyEy/ls6V3SxiJ
         0grTL0oSfDjhse9bW6v3FOMfsSugaLbD4KXge3CnLz0WARekm0bL6b9/oObox9cGtmr1
         lQs0NtUYQknWfWfAQ0ttH+qvPi9R4Kjx9swXoIlJ6wowycppjxzENReJlri3afBSKqr9
         42zy7wuK8bPV3BQnFFWj5XlszsLk0xbrasTQWdVfZfdhu7tipcn+7tHWUFUGz6e07UGn
         v5rizan/1SxBzh+NZYdfrYnKxrWpiAsuaahFrxemoT1heiTSnpBlNk81JqpuJHkG0P2z
         pF4Q==
X-Gm-Message-State: AOAM532DnsmzqCKc0sCq+lkytqqqKH3gt9/NiJ4x34vzs9kjEzp/dhf5
        vK5wbrCxh/JL72hXa5rQIRQZIHm7xwgzmuaTe5M=
X-Google-Smtp-Source: ABdhPJzEk8+MsRvQw2gNjyoxD8tAuUiiVmNCo//Sj2gLzgGnTvbK9GC8gICCOiEg70gNF+dajIqVuSVB1vNGZ/vlMG4=
X-Received: by 2002:a05:6102:dc9:: with SMTP id e9mr24344482vst.17.1641814580785;
 Mon, 10 Jan 2022 03:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
 <20220110111036.1380288-5-sergio.paracuellos@gmail.com> <4b32313d0642a4043709ef98339497662dafb211.camel@pengutronix.de>
In-Reply-To: <4b32313d0642a4043709ef98339497662dafb211.camel@pengutronix.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 10 Jan 2022 12:36:09 +0100
Message-ID: <CAMhs-H9QC1MdiA7ShntQ7hOasRrZRbBok-zTqFMUPQjtdnwezQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] staging: mt7621-dts: align resets with binding documentation
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Mon, Jan 10, 2022 at 12:28 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Mon, 2022-01-10 at 12:10 +0100, Sergio Paracuellos wrote:
> > Binding documentation for compatible 'mediatek,mt7621-sysc' has been updated
> > to be used as a reset provider. Align reset related bits and system controller
> > node with binding documentation along the dtsi file.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
>
> Is this patch is missing the gdma and hsdma resets?
> I only looked at v5.16, there those reference &rstctrl as well

Associated drivers are already removed in staging tree since are not
used al all and no effort for mainline them has appeared in a while..
See:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=53a2f33caaeacb820f554899f0780387b1b4381b
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=87dd67f496f71c3693431a236b2b542793d786ff
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=5bfc10690c6c590a972be014ed8595e77e1e2dea

Best regards,
    Sergio Paracuellos


>
> regards
> Philipp
