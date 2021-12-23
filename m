Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B1447E43D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348702AbhLWNwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348462AbhLWNv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:51:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE753C061401;
        Thu, 23 Dec 2021 05:51:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z29so21689987edl.7;
        Thu, 23 Dec 2021 05:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xnf5tg9xjHOiwQT7N7ZwvL+tTqg5m1BRJMGrP/gost0=;
        b=W1gHvUFoH7AC/jJSsUR+59BWEHjad338aw2rsUTO4hTo39kVOtEN5XRgqkmu5iHBTl
         xciVJzHMEsEyFwkI0Tp3YZjg4ec7aIYjlvnrOKR5hU1JXFUaFzsxeou6BPoUiYEZap+J
         Wwbf8mT41tWLCjbO/PdHIpqM+gaHLunukPSCKHcZsRU5hpZoqPXhmK1MltlwKFKNpSkW
         NDXQEdaGCeYIsl3ZrnOmL1ZuzLJxIj+P9YjrVDjWNNRFbeTb48shaffamYJARuWH3eVN
         lyAghmhiBSmX8wsNtpdvqGStGkQoPUKofYsT6jmSBMXGHpqNQh3+6oZZa4Qp5TyWuzv7
         HO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xnf5tg9xjHOiwQT7N7ZwvL+tTqg5m1BRJMGrP/gost0=;
        b=19Bq8w1HHXe8aG+NYZ0f5x0VrX0ibc0R/0+cQCUGCTwSBDzvwtTc8eb2dohe46guU7
         W0JPAE/jk8O/KgzCo8RU34mLMdVJPXeGgL3fiyd7EAjMStkSVCgyYOTLXObiyWIzAzt2
         YWhMN4zkYVrPBcsEi2/yl/V4YzetB1ZFE+HPqh3xzj9nk23UIDiQps72beyhCT65To90
         itfCDtjz1VYkcwDiqVEfa+Quvt2yeQSB96Xc5mDjU9SJrxYgJnZkz5TUGVEuNDhS0KoD
         vuw/NLu3SYxbDfoREQR21LRPz9QgvENheGrVGfRRiusnVT2JCiltZlkEDUIpEqA3BO51
         cemw==
X-Gm-Message-State: AOAM531MpSVVvDuK3zv+sM8YRTYufyTtTzuX2XZqQYsVjpVHXGZPgQjy
        HXKSxhM+Ydi5X37jr2wbGTeDYcdzXAGS+sttBG0=
X-Google-Smtp-Source: ABdhPJz+eA0P9hj70NkKVI2oJ5ZhiYaKQWne8/nJALPRVJKwOWxjRe+E1NYX8khEBzMr1jOLJieed7m/+AqpVzKp28E=
X-Received: by 2002:a17:906:ced9:: with SMTP id si25mr2160700ejb.77.1640267517196;
 Thu, 23 Dec 2021 05:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20211202122021.43124-1-alistair@alistair23.me> <20211202122021.43124-2-alistair@alistair23.me>
In-Reply-To: <20211202122021.43124-2-alistair@alistair23.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Dec 2021 15:49:59 +0200
Message-ID: <CAHp75VfGmn8+3=qx1-jqO+yO4zFgS854LcVm1tDSwhz5BnJF0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] Input: Add driver for Cypress Generation 5 touchscreen
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Alistair Francis <alistair23@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 9:05 AM Alistair Francis <alistair@alistair23.me> wr=
ote:
>
> From: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
>
> This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> controllers. This driver supports only the I2C bus but it uses regmap
> so SPI support could be added later.
> The touchscreen can retrieve some defined zone that are handled as
> buttons (according to the hardware). That is why it handles
> button and multitouch events.

Most of the comments I just gave against v2 are applicable here,
please address them.

--=20
With Best Regards,
Andy Shevchenko
