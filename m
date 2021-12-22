Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304D047D1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbhLVMkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhLVMkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:40:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC69C061574;
        Wed, 22 Dec 2021 04:40:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so8068628edc.11;
        Wed, 22 Dec 2021 04:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3we7U5LcUazMGSwOo/jCUNu/Z/IZrx6owVs1sXCGNU=;
        b=Liuneh8q2xKHO2+PIe0dy2fGqEu/ES6bhQwGdBvGcLKxSuf9wqTaYUHVtl/naFgMnx
         8yuTfxBdbZEIxx6EzBBIAuJJ+1EgyHQm/O0ZSZdueGr1Vw7EX29temBhcqF4WxXZe7jC
         ueyiyMhVS3t36m6op0s6V3dHGxkaVCHWTCj7pxVUu0FchH0k8Y8UKY2fC/ONUI+AfzuV
         4Pa0ZjguTQE4xkHt0o3eaB0Vd+EC4e7jOmo0G1Ws1m0/HEnqA5kHD8ltIZjwD7NaSUDw
         fK/0dM3LRFHkPMv8Uyqu8Z9nrd78fojl5uoUaA750JMu84idKg0EMblh5sGhKd3A2E/w
         FaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3we7U5LcUazMGSwOo/jCUNu/Z/IZrx6owVs1sXCGNU=;
        b=L849YOgf2mULpeU3BVxTk8FI8zqwqP1D5DXSe3c9FBJHmo0oeuYtnyAqgPjQuSJgkF
         aWYKQq5AB04Z1+B6iON+Szr5G6nvwKrK9rW4n0ncEC8DktaT37A5vGJDB+AF/lp+1pBP
         TgKQSSmhH6qjZil0BxJLKCa5YJ02f0QY8Bk49GvcRgnRr4c10yciLzqG3Y8K0kr0vN3I
         9XSGf/PDXlHBqNUYtdu4hvEKuA/hcFE45pDQSPXOwPqp9AbQybdUFqSzuU+tiY01Satc
         qS923AcWMpUEgEPORrVlaINxfnAed3he5WTeuqeK4JlShlgk58iAFx/I9T7kYRhh1lz8
         bVqw==
X-Gm-Message-State: AOAM531U1IT8ZjmOVW1JWhWejcZFs/7GwY6ac0zAIO2uV7tt2tdpnk3s
        wBSl/cyxcEtJ99RABp79ezukgGecWZKwnPFdvXs=
X-Google-Smtp-Source: ABdhPJxReAOg2unycC4N1KbyWWK7SHYagXoLLqRd1kla0Z8iXoq/yoKYbOs0BbHleOYcvuPxgk7pT2YSGXfMR1W25so=
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr1298568edz.258.1640176812095;
 Wed, 22 Dec 2021 04:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-12-liambeguin@gmail.com>
In-Reply-To: <20211222034646.222189-12-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 14:38:13 +0200
Message-ID: <CAHp75Ve4RuJLMdpdKe14nobuZHRNKA7tWt4yE82+noF5p+xxpw@mail.gmail.com>
Subject: Re: [PATCH v11 11/15] iio: test: add basic tests for the iio-rescale driver
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> From: Liam Beguin <lvb@xiphos.com>
>
> The iio-rescale driver supports various combinations of scale types and
> offsets. These can often result in large integer multiplications. Make
> sure these calculations are done right by adding a set of kunit test
> cases that build on top of iio-test-format.

...

> +       int fract_mult = 100000000LL;

Perhaps also change to use the prefix?

...

> +       *nano = (s64)tmp * 10 * fract_mult + tmp2;

I'm also puzzled what the meaning of the 10 is here?

...

> +       err = 1000000 * abs(exp - real);

Prefix?

...

> +       err = div64_u64(err, abs(exp));
> +       return (int)err;

return div64_u64();

-- 
With Best Regards,
Andy Shevchenko
