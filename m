Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FF48AA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349261AbiAKJYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiAKJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:24:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7BAC06173F;
        Tue, 11 Jan 2022 01:24:12 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so11219600edn.0;
        Tue, 11 Jan 2022 01:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQi7Ep1KiyxJ3mVBc/kJlrYc61FZbFHiGPtZ65wHCRg=;
        b=kSjmkxADbqD68jbTxflsuPZG+aF1bHD2SB1jwsYrn+W7Yw3++LkqaSnccAwwLUUpy5
         9sTXKlbfan9oTLbgy5HWPkptDltNky2EP626hfazHEocbVmlxTZWSRa90RcPD9Gmzsbt
         yZQFqgMb0FAzbxbiMEiDn3XyUiwwbMsk7QVOkJUvRVJ6bidKtYTg/6QMO/x5fzAF1OFU
         6pSSc6lQkg8fUoq7ip2WljV9hp9Jd48RxUEME+sdixJqf5tRTjWBKojU6BZxHG8JTWv0
         NZ96ySx4Yb9k/f3aq1nYfi0OLH6WGsFiCUX3KKRK5U1aGTSCrFKGUQD1qF0WqOGPcEax
         Gx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQi7Ep1KiyxJ3mVBc/kJlrYc61FZbFHiGPtZ65wHCRg=;
        b=Gm+yGlqWfwv+nLDTM8R6PXgOgnX8fBiOtPdXSnwMHbMZqfRZuTpvRd+BWa7vZ5Zg3i
         tmQqR8ZZsczFGsurZcur9lK+M7SSP4+RhH5djTyrK9d40+WNGnEKMslkH4Zh7YU1pkXr
         VHZPkuJryhQUp/pZjIYv8xFqlCeSs9xWIXr06dKwZ4qCR0acEPwyXRLojDydRqbu9kCv
         pyl03TOhZ9zvNeK6exZgttthoh7dMwA7kRT09z6sDvGl5kHLzNa4g05unBQst1N5d5+N
         U6d5TQ3VLhh3NkD+7Uj1wLohRLRWxUbFPeeNek1jGMFl54bvy5aHDrrLjDnyyAAuQ44y
         ZBaA==
X-Gm-Message-State: AOAM530sTuUBKBEVa61v15u5xJo/aE+fdJeF9MJOMBbnhl7b0M6gkKmc
        rwl9M3CqGzrjIseIF8ej5UlUJlcTUPNoyzZIxLw=
X-Google-Smtp-Source: ABdhPJyQc8tbOUnYe/GojCvUfeQf3A0KXlZK8tE3xXzky8gsO3WBJSuSMN8dvPY4B1kecD3OVwePwa4odspxYieqS+w=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr2750714ejc.497.1641893050880;
 Tue, 11 Jan 2022 01:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20220111074703.3677392-1-cosmin.tanislav@analog.com> <20220111074703.3677392-3-cosmin.tanislav@analog.com>
In-Reply-To: <20220111074703.3677392-3-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jan 2022 11:22:23 +0200
Message-ID: <CAHp75VeVRwbMhQp-oBYM7yVzL_ma0jRu3ESEjz19zLQDFWyzkA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: addac: ad74413r: for_each_set_bit_from -> for_each_set_bit
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:47 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> The starting bit is always zero, it doesn't make much sense to
> use for_each_set_bit_from. Replace it with for_each_set_bit
> which doesn't start from a particular bit.

We refer to the function() like this.
But no need to resend, I hope Jonathan may amend this when applying.

-- 
With Best Regards,
Andy Shevchenko
