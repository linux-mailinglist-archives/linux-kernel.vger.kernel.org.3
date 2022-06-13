Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15865549CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348126AbiFMTEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349615AbiFMTED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:04:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8B99820;
        Mon, 13 Jun 2022 09:53:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id me5so12363069ejb.2;
        Mon, 13 Jun 2022 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m54fqmNxbrKP+pbsMMfsGU6Rr5ZVtnOFyMTR7r0Kuok=;
        b=EghSNnVASL4mrlpgZsze3kfxuLWsXPsiFjrA8ZarthHQmlUhB068B1PVcjon3r3bDK
         6HvmUgSyoSGU2771AEr59ago4joxDJFoj79RLdNGtrrxpRq0+I7tthn/Xop5R2Q/VeP6
         cOIpeep/KWK6b2G86pYZIPPApVzV7GU6c3S6eIvNeJwWyRcNXhPYLUaOLOKM2VW2MrhS
         ai7d8T4PyTQgDo0PRxh/nKHSdZQary8ZX851VlC5qOffmpX4JJ8UwRSwOVuGb60W3lqn
         vGghMBgXKkr1HLRX8azbg76qQg+9TOz77yPwjaS60Yuh4soeUlWmGNQGMIuoR7WVypRO
         +iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m54fqmNxbrKP+pbsMMfsGU6Rr5ZVtnOFyMTR7r0Kuok=;
        b=29evODtA2p8nz/K1f+/xEc0yzCF9fdp3MTy3EHUJphDQSNVxx+1WWjBiw15/6VGN8H
         mpuVFDOTh/D0RH82kXyx4q1sR3wzx2MEiohSCRq9VZHOu5raGEf8QagJufLZUJiEbgp8
         1sceCk2lQB29aa/N6kPVu/vcvomhmAY5qXpY7MGP5xK4cWTAw8NmSERb5+OtKr+Cxhxg
         Jx4TwOIMxIf1+FuaQlQmXDR1rba7Hw9/0GvAlpY30xFp5xQM18QF6QsxFm4wtik4sDRj
         dr3Zun/RXSvg3pcp1YGoHd/x+iJrNkipGPAijPk1+zWYDFfyARoagxOm/miaz2UV3KAe
         +vtg==
X-Gm-Message-State: AOAM531cI0hrrfqPsAiPDFbPPqrZEbj1ykOvKHCHqNU3cJU/tMPv6xtD
        osrrDLYiJqdaLcg0+ysPMkcHsIxf602S7ubfrkk=
X-Google-Smtp-Source: ABdhPJxXdFA8yb3sYRLBzX8f7BYKMkJiPdDsY59o0s2SJp2VixfRBxS6FNX10msWO0RjSMiqaHZxU1CBZCU7x+SLiEE=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr674806eja.44.1655139189796; Mon, 13 Jun
 2022 09:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120534.36991-1-andrea.merello@iit.it> <20220613120534.36991-13-andrea.merello@iit.it>
In-Reply-To: <20220613120534.36991-13-andrea.merello@iit.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jun 2022 18:52:33 +0200
Message-ID: <CAHp75Ve4ZjOsi_MYru_fDB+dsGie6RxXVSuYPQmW_YHLjgA10A@mail.gmail.com>
Subject: Re: [v6 12/14] iio: imu: add BNO055 serdev driver
To:     Andrea Merello <andrea.merello@iit.it>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
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

On Mon, Jun 13, 2022 at 2:05 PM <andrea.merello@iit.it> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>
>
> Add a serdev driver for communicating to a BNO055 IMU via serial bus, and
> enable the BNO055 core driver to work in this scenario.

...

> + * This driver is besed on

based

> + *     Plantower PMS7003 particulate matter sensor driver
> + *     Which is
> + *     Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>

...

> +/*
> + * Read operation overhead:
> + *  4 bytes req + 2byte resp hdr.
> + *  6 bytes = 60 bit (considering 1start + 1stop bits).
> + *  60/115200 = ~520uS + about 2500mS dealay -> ~3mS

delay

> + * In 3mS we could read back about 34 bytes that means 17 samples, this means
> + * that in case of scattered read in which the gap is 17 samples or less it is

reads

> + * still convenient to go for a burst.
> + * We have to take into account also IMU response time - IMU seems to be often
> + * reasonably quick to respond, but sometimes it seems to be in some "critical
> + * section" in which it delays handling of serial protocol. Because of this we
> + * round-up to 22, which is the max number of samples, always bursting indeed.
> + */

...

> +/*
> + * Sends a read or write command.

Send

...

> +/*
> + * Handler for received data; this is called from the reicever callback whenever

receiver

> + * it got some packet from the serial bus. The status tell us whether the

tells

> + * packet is valid (i.e. header ok && received payload len consistent wrt the
> + * header). It's now our responsability to check whether this is what we

responsibility

> + * expected, of whether we got some unexpected, yet valid, packet.
> + */

...

> +               /*
> +                * New packet.
> +                * Check for its 1st byte, that identifies the pkt type.

byte that

> +                */

-- 
With Best Regards,
Andy Shevchenko
