Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6D4B4ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352024AbiBNLg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:36:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351888AbiBNLfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:35:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC95113E95;
        Mon, 14 Feb 2022 03:24:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jg20so11762032ejc.3;
        Mon, 14 Feb 2022 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iy1Cz+zs1JEAXLXhqhcX9TK2+/+UIJdUp67WG5w40hs=;
        b=gYkOBtZZABcgpF/thuvjIupfs7FIan0Ynvg/bIMX1ajqZCmkFQuY/dHAojvsYq9nBD
         kcblzBoO208ukgToDuQJYqNBMmEAoqxYVriDkSOCehOQzQSfzHQUvM3EQE5+qJqxejVl
         ROCuhGs4qwhpAOVcNMiJLItVJnqd3haEFiwe9aqEYaCWn7JeXpLLMCYJaGbWXOFhGxzb
         6gu5CuISR4GldSuwp5HvZB/r8WxzOpTBxVcKud6eRsp/Tg1ps+Bu2HdCmjWY7IHcBGd5
         gbC1IptsQyGLEQQRYFCA9rEX1mKgBJRDlv4ncNTaj7lI2Rk/b9CBz466LBg1S07jSSdQ
         yI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iy1Cz+zs1JEAXLXhqhcX9TK2+/+UIJdUp67WG5w40hs=;
        b=0caEPc2oz7xhKty/rJXGyBEWrqCQyix8aHItYkCekRGQoxtGFif5FKcmELRzC0r0dm
         gZeM0ByyXyQQAv7uVF+C6abw9HMLjK1e8IQZdvi0npOfWTE/mniaAkluYZeAtOGMAb63
         bb1WkRhsM/BQMHfK/iid5azJI6zzi//c+a+sLBfjfqepca+Qdi50U/rxp9ZvQRKyzGMy
         OtexeQYTiYfo/bu2pHbRum0Hf1CtTRP7QxWnpHyTnJLm+CfZ4adqgiAc1hUjX76Nae0K
         Mpr9z1AEvmWIy2Gi4IBCTas9MBpuSOQXKxN7YOwruJKcbvnjLeqhhPR8xo/7xYipEau0
         yuKg==
X-Gm-Message-State: AOAM532+EsKtGWx3BFhXjWJEF1yrPERgjdLh3mAgfXEK+w0/OWD8hw9q
        mmRkXblyKPcQmBR2649EZQF6SdzDTcOJdyx2sepY9DQMDZ9e0Q==
X-Google-Smtp-Source: ABdhPJztH97hs/hzxJ06YxLEpyVt5dSU/fl8YH8A+MrGtW16j8ov1p2lxpUGCpvLJHjKJ1qy+/RfSZbiF/DzUGCDFsQ=
X-Received: by 2002:a17:907:2d92:: with SMTP id gt18mr10690121ejc.579.1644837841277;
 Mon, 14 Feb 2022 03:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20220214033620.4059-1-jagathjog1996@gmail.com> <20220214033620.4059-3-jagathjog1996@gmail.com>
In-Reply-To: <20220214033620.4059-3-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Feb 2022 13:22:32 +0200
Message-ID: <CAHp75VdUkVQJOebA3V+F734e5hXO3XWFAT0HVQqKdCQgPbqdNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: potentiometer: Add available functionality
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Feb 14, 2022 at 5:36 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Adding available functionality for ds1803 driver which
> will show the minimum, step and maximum values
> it can accepts through sysfs entry.

accept

...

>  struct ds1803_cfg {
>         int kohms;
> +       int avail[3];
>  };
>
>  static const struct ds1803_cfg ds1803_cfg[] = {
> -       [DS1803_010] = { .kohms =  10, },
> -       [DS1803_050] = { .kohms =  50, },
> -       [DS1803_100] = { .kohms = 100, },
> +       [DS1803_010] = { .avail = { 0, 1, 255 }, .kohms =  10, },
> +       [DS1803_050] = { .avail = { 0, 1, 255 }, .kohms =  50, },
> +       [DS1803_100] = { .avail = { 0, 1, 255 }, .kohms = 100, },
>  };

Please, do it rather with additional data:

static const int ds1803_range[] = { ... };

   .avail = ..._range,

Also, looking into the next patch, can you move the structure to the
place where it's more appropriate?

-- 
With Best Regards,
Andy Shevchenko
