Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6456854D370
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349399AbiFOVOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346733AbiFOVOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:14:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BA955346;
        Wed, 15 Jun 2022 14:14:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g25so25635285ejh.9;
        Wed, 15 Jun 2022 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFiJWZyjgj7yLljlIGD+CfiM/7XdC+qPawIPNYD0GPw=;
        b=FhT4sJzoPFZC/gYPr+fV/OwAoFJCcU91LCb5J+fhV9zZlOOv7biXpxCIe1PUzQTlmO
         4UNfwQPimmXpFtSunprG/mBRju8bs8vkgE2FFK3VHnDsdM+VDYLeytThIY8FQLJcSkNt
         ae8FjaQMO7u5YgYDtS4/8kVri7Wgi+MiJaESPRQh6n3I3+5WS9rqDNQuwfdgM97Vt6fb
         0yGOJirmsbrvABuvSOStTjzaBc+5nKyms06ziSUTBpEI6tVHyKk4Tz//NY8gfBcWMSqq
         FOHUDzsrW2uBCmF1qlHeYD1sOdDbJWo/McN8jX/qZxn9aCI019kVVUhXoUSoXeHu44Na
         zk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFiJWZyjgj7yLljlIGD+CfiM/7XdC+qPawIPNYD0GPw=;
        b=wQrV42kJU8rrpWGWQaV5scXw4rBG6Cc+vez/7bocObAfsN2aoYkT/qhfgcUKyXdezE
         w8qg31jQx4mpQ5Tta7DNMO9Wuz0vowkLnBIWVcj34pcJCioFBHTji9VsWwxlLuwbCgWD
         wzbVWWiapK0miV/7p+ON0WBwEozlDBJOG/e7He2A+72xnUni+AHEpKcTHx63v+cY6Xzg
         vu/bv6kB+aJC88xwxzuqy6ns/HENYAH0OGH9eHRMQ9Ew5c5HNQCaJf5JRpUmn7jOHX9H
         Ku8DGKSGeUiEmU8lrjEnkrPy509cpn9OrFiuwdFW0mu8HcyLhE+Kl9EoX6QbLJh1GUSS
         cZyQ==
X-Gm-Message-State: AJIora/6kGT9Khe2ATmBzN+QG0wDtGjU5PN9V09kPVX73KmRNCJ7N0XH
        nrddyNRXQ5BSbhPGBKv8M/ZzqgRGxqS+az37aeY=
X-Google-Smtp-Source: AGRyM1u9REE1osB08QHKj6YyZqbLsn8iF32qND5beRcZGcbuwGm/p10Bur0itHl5couuX0nOvASp1vpkL8WS+iqthX0=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr1639766ejc.132.1655327661439; Wed, 15
 Jun 2022 14:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120534.36991-13-andrea.merello@iit.it> <202206160409.GTDk9b3k-lkp@intel.com>
In-Reply-To: <202206160409.GTDk9b3k-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 23:13:42 +0200
Message-ID: <CAHp75Vd7zF=rC7VYAnqc7cz52HfcLdVWwE6kuifwv3L8JiFBxg@mail.gmail.com>
Subject: Re: [v6 12/14] iio: imu: add BNO055 serdev driver
To:     kernel test robot <lkp@intel.com>
Cc:     Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
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

On Wed, Jun 15, 2022 at 10:57 PM kernel test robot <lkp@intel.com> wrote:

...

> >> drivers/iio/imu/bno055/./bno055_ser_trace.h:91:23: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]

>     80              TP_PROTO(size_t len, const unsigned char *buf),
>     81              TP_ARGS(len, buf),
>     82              TP_STRUCT__entry(
>     83                      __field(size_t, len)
>     84                      __dynamic_array(unsigned char, buf, len)
>     85              ),
>     86              TP_fast_assign(
>     87                      __entry->len = len;
>     88                      memcpy(__get_dynamic_array(buf),
>     89                             buf, __entry->len);
>     90              ),
>   > 91              TP_printk("len: %d, data: = %*ph",

Obviously it must be %zu

>     92                        __entry->len, __entry->len, __get_dynamic_array(buf)
>     93              )


-- 
With Best Regards,
Andy Shevchenko
