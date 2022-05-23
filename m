Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F353179A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbiEWSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244834AbiEWRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:52:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600EC72226;
        Mon, 23 May 2022 10:41:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p26so20065972eds.5;
        Mon, 23 May 2022 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxwV1CfEuXpa/Ro5Ob8LIp2Apb0tudNYCNQzjQS7PwI=;
        b=bXWA05ojW5/cFfSc8rmYcBcQCXtWKXEQg+WJNjPooDUIPQeuyTxdbyxOuY+WE3wJcg
         cvIhHWlqIEHV7JCMA9UK+MdkG2Nf2i6VKtw1BNWCVraUk0MPtPGp7T3zDr6+yIi6THiO
         Xv+hKtoqFJpQD/5RGaYK/LHNsG2QImRsUsshVf3koVHvBtNtKJDZDxQ7X+vwY5t3FuE2
         MpspJ75qaC+mlNsrwp4yZ9d34ifM+1vNdGCqAvM2x4lpjR5PW2HiZ+cjoOnC3M45gVGI
         GHjp4n/eiQrYSbDIUXNu7iVYRtYR5v646COAb8tib3TkV0Jxx216UEElONxb8FQFaj7R
         hqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxwV1CfEuXpa/Ro5Ob8LIp2Apb0tudNYCNQzjQS7PwI=;
        b=E7LkLPEOVS7GyNOnHpDUUnf+AAuUcpHDPqjZMFqEF0hErKXXuSTk+7RmYKSAfpfOuw
         Ax4tA4wXTTkpQ8BGQYUNOBRtHN3lJaYOsei3suMMY/9Noo/RmbHq5oxV9TsJwuBSE6oq
         pu2C90xDjMURxPttoRWCSuR/ZqQy3eANSmtwRJPCFsCrxkvnTQLXQgonJfV0ue/5coCq
         mhkxdER6OXj2e94aFZ41g7dS7TP/Zv1gkahIsk1W5H+yCqegaRie5ozF8TuSMlIo3ngI
         voLlU6ZGImkVnR8wOt7N8qoiGCFq7iW5lQl+PAdSbbx/FMKmsi6eiAe49k4HPcpyKva0
         tzoA==
X-Gm-Message-State: AOAM533/0zdvEoZSx+js8glFnQ0lkLAsk+sCLA2fytC6h+w3CtfAGnXq
        p+u/6FfjK8PepDoQixgP297jbl82Se0/Cfxc6RY=
X-Google-Smtp-Source: ABdhPJxTo01eW9mCXhiUa+2BxqxlzHLrc4YxjtNwNVqgKRWw5WAJOT3XELCwDaw93jNRgdmr5xO785H1pzc5fjfPbvo=
X-Received: by 2002:aa7:df86:0:b0:42a:ba05:3ee7 with SMTP id
 b6-20020aa7df86000000b0042aba053ee7mr24836246edy.141.1653327664065; Mon, 23
 May 2022 10:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220523164159.11579-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220523164159.11579-1-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 May 2022 19:40:27 +0200
Message-ID: <CAHp75VeuAxMWknoG28v8k-gKCpUQFJbwpq+pTaTVPeY45vQo2w@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] iio: treewide: rearrange iio trig get/register
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
        "sean@geanix.com" <sean@geanix.com>,
        "linmq006@gmail.com" <linmq006@gmail.com>,
        "gwendal@chromium.org" <gwendal@chromium.org>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, May 23, 2022 at 6:42 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> The following patchset resolves problems with iio_trigger_get() and
> iio_trigger_register() call order in the different IIO drivers.
>
> IIO trigger interface function iio_trigger_get() should be called after
> iio_trigger_register() (or its devm analogue) strictly, because of
> iio_trigger_get() acquires module refcnt based on the trigger->owner
> pointer, which is initialized inside iio_trigger_register() to
> THIS_MODULE.
> If this call order is wrong, the next iio_trigger_put() (from sysfs
> callbacks or rmmod) will derefence "default" module refcnt, which is

dereference

> completely incorrect.

Cool set! But it sounds like a set of fixes, can you add a Fixes tag
to each of the patches?

-- 
With Best Regards,
Andy Shevchenko
