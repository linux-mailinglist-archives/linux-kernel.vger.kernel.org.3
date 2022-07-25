Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334F5806D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiGYVc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbiGYVcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:32:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA9C60;
        Mon, 25 Jul 2022 14:30:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j22so22892022ejs.2;
        Mon, 25 Jul 2022 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hG6d5UoxHzM3cTAhPbPewA+gfVWFpNNpNHiESxa2M/I=;
        b=hUYv/m11ctMGaI38/nWpbh4grCb8qsdJY9IzCA9Spxs8E0xNlb58l4+DdK7Aj7G8I1
         eLbR1GmTT4h80wt/tm2+3xCMiIa6mbJdfRNHpByY2eMShJavGljyfmh5ZAHW+FG0DOJk
         hovjz7kgX2g2FTuYAAkU879Q5Vmjzz8zRqG+fbTZ3oi/2t5K4LfrU4fLegN3xsCyRH82
         JQQBw+UnmUk9lQwIPOssovOWcYEvb6Bf/leWsA+bzsimgnnmmGU55z7Fl6DUzbdVH9AL
         ubEJEgqrjOPMZ2LHnS+tW7CmAAB+1CXgYvTvbJSvZut4WGg5prJ3f5KO/lkUlV8Owhyg
         45PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hG6d5UoxHzM3cTAhPbPewA+gfVWFpNNpNHiESxa2M/I=;
        b=btp3z5H8I2oLfdKK/h5+bGHwugSkBl99qTOddJEy0sgctg4XM6gg3CYPDDrd5KmBum
         /Kh8o7GcR7B8bAGDRS35hhZNk1v6sAByHnj/1CWGhQBefYAeOTXR9BlGMnMVrwioFgC6
         l5quSK0NAoKt9LfrngXuDDnn7XtOMo6vYsXFe7n38moRNBYfzI9zgq9nqNM3B2Rm6ANa
         iW/KOEhJBBABZQwl0+KAKPE41kkoXpCKTJsjgO3AFU6VBFyjZfRZgFh+ekEir/g7CD3Y
         socgimapAZHDTT0EtwEpaOFTo2rj5NqIk2gg0egyWJNP8hYGEt8F6HREkL6azuHfwy/5
         zsMw==
X-Gm-Message-State: AJIora9DxFvslLqJhzkzRPLFQVCkRWCcOrCXHXzOMBe431xhRdGV5OB6
        l7Jw9nVTgcwp7t2oi+fteII4ielDG6M+veF7v40=
X-Google-Smtp-Source: AGRyM1s0wvsIZHHycPFxyzHmwkc7yXG2GZIJ1xIpDPc8GWj20AW4SBVxC6aj9eUN+kvENQaZZ6DkeVCfCdcAZwg5QH4=
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id
 nd23-20020a170907629700b0072f9aad0fcbmr11312748ejc.161.1658784607947; Mon, 25
 Jul 2022 14:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220725184439.7618-1-ddrokosov@sberdevices.ru> <20220725184439.7618-2-ddrokosov@sberdevices.ru>
In-Reply-To: <20220725184439.7618-2-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:29:31 +0200
Message-ID: <CAHp75VcpY1vwHCOaJNb-qw+3gsMyv9mJe+QaWrjiTKOdj1xfYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] units: complement the set of Hz units
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 8:44 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> Currently, Hz units do not have milli, micro and nano Hz coefficients.
> Some drivers (IIO especially) use their analogues to calculate
> appropriate Hz values. This patch includes them to units.h definitions,
> so they can be used from different kernel places.

...

> +#define NHZ_PER_HZ             1000000000UL
> +#define UHZ_PER_HZ             1000000UL
> +#define MHZ_PER_HZ             1000UL

mHZ perhaps?

>  #define HZ_PER_KHZ             1000UL
>  #define KHZ_PER_MHZ            1000UL
>  #define HZ_PER_MHZ             1000000UL


-- 
With Best Regards,
Andy Shevchenko
