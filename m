Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF837490500
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiAQJhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiAQJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:37:46 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D533C061574;
        Mon, 17 Jan 2022 01:37:46 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id p1so29263905uap.9;
        Mon, 17 Jan 2022 01:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uMQ1EIF4RSxPhUl0TWMfaZBTRoZ1vCSmX3Nwyu9qX8M=;
        b=Xbqd782sX51xz52Pu4oPlcgnsZHNH7eODQEq10xb3SAyWtlnRFim3gCeMLGai3guzY
         lB3XAo5tIXRvyZL2F7qjnu9uiiPB0k8R0av3D8RuZOUv91nh6HQCVLbrIhesbPRwrIei
         DQTQLEzVK1bgfVM2t5WGY5+OpHvbAPGLyibVKrHrhL6k5ugYes+BcTXoDO4SyQVsFbKB
         JkehUEXjihrc+Z+9lsZ2yvF6vdOAEgaNzSpkLPhDklxZoMpAFsn8QlMmsfZFD6CxtZwO
         mVX3iQrp7t67upMpiEwELNGAA2y7Lbfv+bgXKg8Bof8j5ra1Jnknidm5WzhO7t0YbhXF
         0Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=uMQ1EIF4RSxPhUl0TWMfaZBTRoZ1vCSmX3Nwyu9qX8M=;
        b=4fnkgYaClp4vnW2vZJpQamAOCHa5NdmvAU78Po+YjPf0NayXR1KfGWuGjkr7iQ7c8u
         5OStAW0mukTDQiaAJk4RvZwayB63xLh0SeLyVfWIlJYrnNpRbqSiEhFImtaFfTgCIU1L
         wVdF+m2fY6+3SLwy7HAQ1Uvnh1nATcYKzSVa1dR7iTDGG3G8NQHtMaojaknxoqrrGgjG
         /1iCorQE4MzXgX91O49XO7IpPBKd5SnJm89ki/sW5I78dJdqD1NqmO10PM9BjCe3z2zK
         kE9P8wjuDie/FXB9MpzlaVf/jrWudOqP5PQOpnviFhIDjN3jFzCXOV1Aou5LQFCG6gQ/
         d/mQ==
X-Gm-Message-State: AOAM531Cc8H63mIQsooQ4UdJU1zV7QQ1RGYJ6ggeol9sHTShZ+IsZevF
        EYhEHVUqC9VeZ4ZAvXLbkvLkVY7unR0F4Fxkiyg=
X-Google-Smtp-Source: ABdhPJz1nOfG1fYXxt25g4Te+KL3K+cs+UqU3JBn/2jq8iRHbWUWaYCgU/42gNiIQaKxB3S9wpGa+K8sWP/RrsHh9o0=
X-Received: by 2002:ab0:702a:: with SMTP id u10mr7066269ual.91.1642412264776;
 Mon, 17 Jan 2022 01:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-7-andrea.merello@gmail.com>
 <20211028120405.6ffb01d1@jic23-huawei> <CAN8YU5Orbbzq-eDxmrR00xHwXQ=0LU2G3_yEtHGMkbVhmdcqgg@mail.gmail.com>
 <20211114162032.425ab36d@jic23-huawei> <CAN8YU5NO5mcrPa5ZCB3XnAb=3N3cyXZUT=gH5G+EbnM-En0a3Q@mail.gmail.com>
 <20220115152749.173b7172@jic23-huawei>
In-Reply-To: <20220115152749.173b7172@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 17 Jan 2022 10:37:33 +0100
Message-ID: <CAN8YU5OT44Wz813tKA62-Dvq3=VoTcoyVE__5UuRw+i7+B7i8w@mail.gmail.com>
Subject: Re: [v2 06/10] iio: document bno055 private sysfs attributes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial inline comments below. Beside that, I've found another
pleasing issue with this "range" thing on this device..

One one hand, things seem to always work as we discussed for the
accelerometer (i.e. range doesn't affect the scale; the HW always
provides readings in the same scale, but with different range and
precision) on the other hand, the gyroscope behavior depends by the
internal IMU firmware version.. great..

Stock firmware has a bug[0], so that the "range" gyroscope registers
do change the scale indeed. AFAICT stock firmware is the one you find
in most (all?) breakout boards, which are usually available (and which
I'm using right now for this driver mainlining attempt). Upgrading
firmware looks like a rather obscure process that AFAICT can be done
only in some specific USB-stick demo-board ("shuttle board") or with
maybe with FAE assistance on custom developed boards [1] (i.e. maybe
can be done by some professional user; I would say not for most
people).

So, I'm now wondering how to handle this... I really want to support
the stock FW, which seems the most widespread, and the one I have
right now; I'd say this means: the accelerometer thing will still work
as we discussed (i.e. the range attribute thing), while the gyro will
have writeable scale, and a (ro) scale_available attrib. But what
about the gyro range thing? Should I drop it, or keep it as
informative read-only?

Then I could also support the new firmware (which I cannot test right
now with my actual breakout board, but I might see whether I could get
a board with an updated IMU), keeping also the current driver behavior
(i.e. range stuff).

But the question is: in either cases (new vs old fw) should the
non-necessary attributes disappear or they may just be RO or locked
(i.e. scale_available for new FW and range stuff for the old one)?

Any thoughts and advice on this whole thing would be very welcome :)
my current inclination anyway now tends to be: go on supporting only
the stock FW (i.e. the board I have here now) and eventually add
support for the new fw later on, after merge.

[0] https://community.bosch-sensortec.com/t5/MEMS-sensors-forum/BNO055-Wrong-sensitivity-resolution-in-datasheet/td-p/10266
[1] https://community.bosch-sensortec.com/t5/MEMS-sensors-forum/BNO055-Software-Version/td-p/14001

> > I've looked at other iio sysfs attributes in the DOC.  It seems  that
> > "thesh" and "roc" attributes allows for both preprocessed and raw
> > data: I found e.g. "<type>[Y][_name]_<raw|input>_thresh_value", but
> > the related "what" entries written above all seem to omit both "_raw"
> > and "_input"; I don't understand why.
>
> Excellent point.  That documentation is garbage.  Events are meant
> to pick it up implicitly from the related channel _raw or _input.
> I don't remember them ever having raw or input in their naming but
> it's possible they did right at the beginning before the ABI was anywhere
> near stable.  Gah. I dread to think how long that that has been wrong.

Ok, great :)

> So I think range_raw postfix is the best bet.

Will go with this, thanks.

> Jonathan
>
>
>
>
>
> >
>
> >
> > Andrea
>
