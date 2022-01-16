Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DEE48FEB6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiAPTrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 14:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiAPTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 14:47:40 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96236C061574;
        Sun, 16 Jan 2022 11:47:39 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x15so13031439ilc.5;
        Sun, 16 Jan 2022 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wd47ovaNxnYbYIBH4f2jz5+DbNq5PmujzzZD9MvpQ5Y=;
        b=Sb0fIh6/SASSnNEn0N7Pym9SMa9tyFnh2Jn6Bbg+2D7ayQbS8dn/Z4Uw4Ru9vTRpL8
         oayCcK6rTyrbtWbTLGmiRpt6xfJ/Xue/IzzGehxcqXaVNSzt9W3O+AGF7M5sqGvRRcoZ
         yfdfJA53RA4Fb7BfLKoD2o0t4XpsCRsT5zb93HXJd3L/XFYDOP9v2ZJ0KEBxAP83v9KZ
         XBT/MLysMg7XYhN5qhik1cNRTl6n+4Wa58HXQuGlupIAanDE3q8JV9CxLYdsUHV1ElWB
         NVXTA8jqjdCdR3zT6vZnse1p+e8MwSAQd/Hr25zIA6k//3qK1sSwaGJjauzQMcsORJOY
         GxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wd47ovaNxnYbYIBH4f2jz5+DbNq5PmujzzZD9MvpQ5Y=;
        b=ygsc4lgl83eGhjKBcyTYbXe+t4+Z3wP7N2keQNPIciyAG9HsRywmqulKOWnT4GbQZv
         lc8qFD3NTSsc37y7PjQpuwOq8mnfOfiIrPO9oAgu/3XCwBQMdg1EaNHXR9CK34aAs4l1
         jVNrG63s1Q4Wk9ByolpFL9EqyOH0yRVgsRyb/0k32WM/PTFksDIlhHZrlpVkO7VO1CGo
         i8oEGdVl5JEqFZJr6JA9cYkJhYiZLMe15OWe9R39PGIuHjvtFpHc3EiHwjWgnwfkjLg0
         ZNo57WbjVj1JguX8zjdGZG5c+TqDM3dTjU3IEr2Tg2G/w6b96K97g6fpdTP3KZ+eUpql
         vurg==
X-Gm-Message-State: AOAM5319G4Sh4mznFZVY+z9fPwcEsVoMk5zSFYRL5G/cruXgmEmTGAy+
        tup4q7BeoPX4J4uzJnq6uz9GDXDk6EgpxTiP8DM=
X-Google-Smtp-Source: ABdhPJxRhhRfSJWGblRId3osNsD7AxKGBrujFwJH5x1QvZBHtHEZWzSlP5u7FI3d60jZermnDuoCLiNiUHOXZ2L+J6k=
X-Received: by 2002:a05:6e02:1183:: with SMTP id y3mr8763342ili.289.1642362458951;
 Sun, 16 Jan 2022 11:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20220111180347.1245774-1-eugene.shalygin@gmail.com> <2613330.mvXUDI8C0e@natalenko.name>
In-Reply-To: <2613330.mvXUDI8C0e@natalenko.name>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sun, 16 Jan 2022 20:47:27 +0100
Message-ID: <CAB95QATABx11K-woSNsSX_99r_Q__VNuqGP71_=H8rABwpWR3Q@mail.gmail.com>
Subject: Re: PATCH v4 ASUS EC Sensors
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 16 Jan 2022 at 20:29, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> BTW, is this OK:
>
> ```
> [   11.104396] asus-ec-sensors PNP0C09:00: board has 6 EC sensors that span 7 registers
> [   11.104400] asus-ec-sensors PNP0C09:00: hwmon: 'asus-ec-sensors' is not a valid name attribute, please fix

Thank you for reminding me to fix the name! I have to replace dashes
with underscores, apparently, as hwmon itself uses dashes as
separators. I'll send out an update with all three corrections
accumulated so far.

Regards,
Eugene
