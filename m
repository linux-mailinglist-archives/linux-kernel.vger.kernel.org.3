Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0460A503544
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiDPImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDPIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:41:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF390CCE;
        Sat, 16 Apr 2022 01:39:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p15so18912690ejc.7;
        Sat, 16 Apr 2022 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdQ3f1meuqUiTKqJBFXcf6/BHrqM9M+dmR+/B9DSwzs=;
        b=bAVoeB7Jn4k5j4WJmk0ilOh+g4NXX+hnPncMGU7vKFwSPRrVsc+m/KQo4IAU0ksVKg
         UzEVbmR3kPbccu/r3N9ikhsIZrfeSVYlcdeTbA+BovjaElxgHRe1K3u4Vz3SyRIBDy8k
         bYwhwNKZxpq3Zq6to4TV9P9btOvufN830zyk8yY1QdKnIWp8a4hkBypmV7YJYkjOhH9d
         LUvWV8DQwLVgRmUvt4+BP3tEmubynVVCMqGIaJ3NBHI6b97rWCqBMwJO8+DT+IDLcNs/
         1q8agqw93nkA65ggmSdE1zajAAEsYB8Ja1ISJZuJPvlJHWhUTWAMBawgwO30YfC2c+vn
         2BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdQ3f1meuqUiTKqJBFXcf6/BHrqM9M+dmR+/B9DSwzs=;
        b=rhUTVklHCoDMTeC98qEN7VZKlS9X77sYknvYNkUPGrABgF4L7CMh+44LTC3L5gEFls
         7QFjCcPRuSJ6MYk1xexQMTLsD7yRgV1/LLX7ZkZv0k/xZOAFqdW/to7LJ+LSKRvk2ugK
         +JSKPF6+dPMftjbXktySJOL21vc1hNkVCnrhJvpssGU6oEes9NV72qwpVZAcl1VUUvHG
         lzOXXffrjGPnQDFD2PkcY1rGZVMuKg1xK7xyPBlGAAafnPNt+PYiiIJQ/F7XGRVANq2B
         jiHI4p5gvdFeJOFNd11MFhSyu8gOM/vu7GAdF2VZPE4GaA5AqefA/rbBnBqQPDFuhbdI
         2Q5g==
X-Gm-Message-State: AOAM532HhIJY9waaQylG2D87FR2Wg6hhPYP/g2Iq7cGfQp/2UdOuf2JX
        0zlv01cpsb3IjdhOlI8kkCOyaS4YX8saxlvK4XCRv83m8oxAVw==
X-Google-Smtp-Source: ABdhPJwJb1KSpXvuOFOb1pzMWgRhZcp+hSKsBEBLulAyHFu+bvcNIOjbQH8CJAds/zfDBBHuKM5OxuX6MqkBkHJ03uA=
X-Received: by 2002:a17:907:160b:b0:6ef:5da0:3e38 with SMTP id
 hb11-20020a170907160b00b006ef5da03e38mr2000876ejc.579.1650098366734; Sat, 16
 Apr 2022 01:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com> <20220415130005.85879-5-andrea.merello@gmail.com>
In-Reply-To: <20220415130005.85879-5-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Apr 2022 11:38:50 +0300
Message-ID: <CAHp75VdmJFqA-EVZfJNQekwsybrPzBnAn18tW1c1a+qfVrOx2w@mail.gmail.com>
Subject: Re: [v4 04/14] iio: add modifers for pitch, yaw, roll
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

On Fri, Apr 15, 2022 at 4:00 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>
>
> This patch adds modifiers for reporting rotations as euler angles (i.e.
> yaw, pitch and roll).

s/This patch adds/Add/

Please, read the Submitting Patches documentation where it explicitly tells.

-- 
With Best Regards,
Andy Shevchenko
