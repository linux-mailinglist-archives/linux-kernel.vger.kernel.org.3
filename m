Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB85550A0F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiFSLMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiFSLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:12:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09447BF2;
        Sun, 19 Jun 2022 04:12:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z11so5354404edp.9;
        Sun, 19 Jun 2022 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=065h+KQsfVelWa30bCNnk4G+lWtioBc+KPUalxR/LAM=;
        b=OMoN9genkSzO9y8Nb05x9N8A7WJYU9SdAsX6JW1jpqFcnUoJVilI9dQXdooNEuh96E
         VCOwg1huVghpDAajPoxForq9L/CwVkY+76VLQGbxEwqk7lkQd1B++elmRU8vkuZhST4t
         BcYa0gv3VkumqkjqNd8lUzIlABUsqGlKjLJwnpMmngExeawBpirNtf+ZXYmmoiyg9h8I
         baUUEY83mjf4i58n0l4aOXtEZOX6dsvJmkpg8uOcLRcc7a20WbNGLW2BJ4meT/SbZdWe
         OHKiZcqJ4Nw5VWPtY1qnaAKTV2rjBf5fKx0xY0w8NWc5MmZEA+xqQxi2U/7BSAKpKTL4
         M0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=065h+KQsfVelWa30bCNnk4G+lWtioBc+KPUalxR/LAM=;
        b=7o/7hWTDZTouKuaX8kTmF+5KNhU1gQmgA05AR+NrtJcfQlFlttCUp+mCt6UrDDQdSn
         g2AR4N9MXhjprqqTataUpNC54rEsSPMMxTAkmhPxn7/yBSLZdkMpdr18BL347/0Y1MIK
         7pTMsyOVeKiBct+SRgnebjKO5IYV0jHcA5a5NDMI7JJrTBRyHAEKgCuAH/NvOOeoJvoU
         m2j4wSDTOCBsRKe6uhRC51GFCoKIVnBGLxftdUhaRvs+LbbFTDxPPMy028K18yengw5d
         HB0oGwySC0TZ6krphOojBFJYLBJwD6kc20GcE4XhX353UhlHg/NuSQAKs685+vEgE0t+
         7BXg==
X-Gm-Message-State: AJIora94zwY5wFIHvJfaHgLbd+z+UAVbL7nUhPDSw7Vt5zI0pk4udc6S
        erQql/0Shqjm6ykOo8lC4YU/i8Hf7YwjaOxPJHI=
X-Google-Smtp-Source: AGRyM1saLcudqsFi+QL9+2JCvTmt70ofdrGj+8I24+9oRFl8UZipNSZ5l0QcqeD8924ga8iLWxJEAoF46ErZLkcnGWc=
X-Received: by 2002:aa7:d29a:0:b0:435:705f:1319 with SMTP id
 w26-20020aa7d29a000000b00435705f1319mr7575701edq.54.1655637166579; Sun, 19
 Jun 2022 04:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <CAHp75VfrzQFq4u0vMtPM7LRYNcQQC-padQ1yyFijbpWx8_LwBQ@mail.gmail.com> <20220619121743.2b259153@jic23-huawei>
In-Reply-To: <20220619121743.2b259153@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 13:12:09 +0200
Message-ID: <CAHp75VcG-rkyJ6Sy_ya5Asrzp1hBAofY1qvK+o4iue=FmNGXxA@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Add support for AXP192 PMIC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "wens@csie.org" <wens@csie.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "quic_gurus@quicinc.com" <quic_gurus@quicinc.com>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
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

On Sun, Jun 19, 2022 at 1:08 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 19 Jun 2022 00:43:07 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Saturday, June 18, 2022, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> > wrote:
> >
> > > Changes in v3:
> > >
> > > * Update pinctrl driver to address Andy Shevchenko's review comments
> > >   from v1, and fix a few other
> >
> > I believe I gave more comments than just against pin control driver. Even
> > though, some comments are still not addressed in the series, including pin
> > control. Am I mistaken?
>
> Hi Andy,
>
> Maybe, it's a question of clarity/misunderstanding? You had some 'global' comments
> at the end of the pinctrl review. Perhaps not clear enough you meant
> they should apply to the rest of the patch series (and more generally to
> the driver being modified I think).

Yeah, I think that is.
I don't remember if we have somewhere a documentation on how to
respond to the review comments, in which the point of addressing
comment everywhere in the series, and not only in the place(s) where
it was given.

-- 
With Best Regards,
Andy Shevchenko
