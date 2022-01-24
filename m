Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14149894C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbiAXSyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:54:13 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:43606 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbiAXSw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:52:27 -0500
Received: by mail-qk1-f174.google.com with SMTP id h2so21394780qkp.10;
        Mon, 24 Jan 2022 10:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVltL7XfUr78OBdyLqEqOu/YRzCA0cEoywdSG9wAfwo=;
        b=QJ58ryjU0BQnhokNxWiSvx9LVJwvpRNeTjeCa7g5uqbTy6E9pv4SzezeQnGTPQcvYm
         QQgaIWSpdt/RWwmso62q/DYncSFGhGGOJDQcPLiwqvy/X8ucaeyM8sAguAMXYjX5WH8V
         +FP/z9eeimYBcPQUsRAJxiWRYGOOts4wBFoKeuHADnfTwnGpAgY5QdrgKI2zhaLcEkgJ
         fNOm17Fze2vFZPl7Gx+vU6mWOzbhmA0MYXWYNjJXD2Fy0MwytP904gXmZ+GVLAsjn34x
         zYEQVjdBrIVpxAHKO1IXyFtQO9j+3uNqTqwgX2O9CqTiNfygiLvxE5OjvUuga8IXiWz+
         MdFA==
X-Gm-Message-State: AOAM5328EF22RW5au7gQUBSdOKnMVMs4/R7IOtYCmclHB/6PYcievHFn
        h0eIp75pgzzLfbS8pASIQ5NN0Q9JL3KtqqxW23w=
X-Google-Smtp-Source: ABdhPJx7TK2MvPwVSaAnSh01KupVk1iv0Pp7EXSDqNuAkHni9KT1XFQY2XONmQZbwXzKfAEkNwUa4j5bzUrEm8hJr20=
X-Received: by 2002:a05:620a:1a97:: with SMTP id bl23mr12176564qkb.621.1643050346792;
 Mon, 24 Jan 2022 10:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20220111103346.2660639-1-abailon@baylibre.com> <7hilu9xe7n.fsf@baylibre.com>
In-Reply-To: <7hilu9xe7n.fsf@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Jan 2022 19:52:11 +0100
Message-ID: <CAJZ5v0gZFBEKDt6S0H91F5xCjC3qtT6B+cTnv6u1nijMHkc8jA@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND 0/2] Add a generic virtual thermal sensor
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 5:58 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Daniel, Amit,
>
> Alexandre Bailon <abailon@baylibre.com> writes:
>
> > This series add a virtual thermal sensor.
> > It could be used to get a temperature using some thermal sensors.
> > Currently, the supported operations are max, min and avg.
> > The virtual sensor could be easily extended to support others operations.
> >
> > Changes in v2:
> > - Fix some warnings / errors reported by kernel test robot
> > - rename some struct and functions with a more accurate name
> > - update the dt bindings: rename type attribute to aggregation-function
> > - factorize a little bit the aggregation functions
> > Changes in v3:
> > - Aggregate thermal zone instead of thermal sensors
> > - Use try_get_module / put_module to prevent thermal providers to be removed
> > - Update the bindings, to be more accurate
> > Changes in v4:
> > - Fix two warnings reported by kernel test robot
>
> Any more feedback on this series?

Hopefully, I'll get to it this week and I'll let you know.
