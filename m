Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1B484116
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiADLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiADLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:42:53 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CACC061761;
        Tue,  4 Jan 2022 03:42:53 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id p37so62498973uae.8;
        Tue, 04 Jan 2022 03:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=m4rgCak0Y9ZrCMU21woyKJsa31R1qg64vWqt4VKQQ3k=;
        b=IzCpAbYVZioYR9Od9vcrXsOz6Mi3CGFvj2dtqdCPKx1W6FmfGj0huYuuqOtX3PJnYg
         Xb+sBVLM2XBMUl7yC+jG5cK+gcGE8E+DfkxfGCSB4MNCesajwW651JonNCF+M20ens52
         OEPLvLLVVyCqQTad3RAudM1ODcBBL/w3r6uSbWuGso4CPYfdv0ZPIs44n9zwJ4JzMahU
         /VjuMw3uPfkMrtHeMOCvgyJScygWCd5fcgxcyFesevMJUm2P1sWzhNgQGArXZPt6MTQV
         5XL/3qe6vU1IOfK8ukgSUGA9sdvUEVxfrP9qL+Sv7xDYKosV5MTy5AWdnqQVOfwPzl8q
         8x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=m4rgCak0Y9ZrCMU21woyKJsa31R1qg64vWqt4VKQQ3k=;
        b=2n+3USbNyGrfnj/hhnaw4U6S5b2O+bUuzamYEEUg7lsqpMOhUCIlsdctI62F8yHniW
         VwjnJZdIEXiv245DzUBwp3NGM5YfFjZPgnXg7T3/kGRKHuNrw9ZE64IlE0oHqOGd+Yor
         ptblnnFB2MZguJUb0ewlGpq+Z49N/X8wkRe6JTwwjtw/PgPy2iEdPUuogLfCqOnqcuPd
         6ZHznw0PEnOlp41+2+/b6eq+9RQlqBh4P7VUBGcwFjCVJoTtqSMg5mj7sOrWfuhXro2d
         c0+0mSckK859ILm2BHW4cMBezdKuBiJJo9ER9XwRNUaea7yAL4jzSq9+g1sp9Bys5YZL
         Y9KQ==
X-Gm-Message-State: AOAM532UzBDHQXFfyX8vksS36oePL/9+OpJdXNKt7uzQKGZA5DKgrhsx
        T9nruKek41NnO5Dy1ackYmJt6leAqWPW31kuewk=
X-Google-Smtp-Source: ABdhPJwpwLdODTduulsppAKKohovKvY52jZQdN90JjMhEfBtMauArOtpJ1OgyT2Kg236K47JxfkmG4BmK+qquIIz/PY=
X-Received: by 2002:ab0:48d1:: with SMTP id y17mr649108uac.12.1641296572254;
 Tue, 04 Jan 2022 03:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-7-andrea.merello@gmail.com>
 <20211028120405.6ffb01d1@jic23-huawei> <CAN8YU5Orbbzq-eDxmrR00xHwXQ=0LU2G3_yEtHGMkbVhmdcqgg@mail.gmail.com>
 <20211114162032.425ab36d@jic23-huawei>
In-Reply-To: <20211114162032.425ab36d@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 4 Jan 2022 12:42:40 +0100
Message-ID: <CAN8YU5NO5mcrPa5ZCB3XnAb=3N3cyXZUT=gH5G+EbnM-En0a3Q@mail.gmail.com>
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

Sorry for the huge delay...

> There is still a units question though.  Should we express the ranges
> in _processed or _raw units?  Or do we make it explicit and call it
> rangeprocessed for example?  For some devices the range will naturally
> be expressed as the range of ADC raw values, so there is definite room
> for confusion if we don't make it clear in the name.
>
> I'm open to other suggestions of how we name this to avoid falling into
> any heffalump traps.

You are right: this might lead to confusion.. Making it explicit in
the name seems a good idea.

I've looked at other iio sysfs attributes in the DOC.  It seems  that
"thesh" and "roc" attributes allows for both preprocessed and raw
data: I found e.g. "<type>[Y][_name]_<raw|input>_thresh_value", but
the related "what" entries written above all seem to omit both "_raw"
and "_input"; I don't understand why.

In any case, maybe we can stick to that already-existent naming schema?

Assuming the pattern is correct, then wouldn't it be
"in_accel_raw_range"  (or "in_accel_x_raw_range", in case it could
have different values for each axis) or "in_accel_input_range" in case
range applies to preprocessed vals, etc ?


Andrea
