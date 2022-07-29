Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5000B5854E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiG2SDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiG2SDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:03:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534B589AAB;
        Fri, 29 Jul 2022 11:03:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sz17so9836386ejc.9;
        Fri, 29 Jul 2022 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dMVlOiaocgAoPdOfqZSeW8snS+xV1uWPxAAS2Q3JzbE=;
        b=bTkXKbA8AR6T6mFn+livhJAnc+Js9e/+KPGkiwgl8j0k86Es1oqWZI2UuhTohf74UN
         01GAjb7H97Kjw0Ntuv3Dp7Jy6mJ8yxHOON3ofWqCJqQhkjub8A8qdoZdSo0xJBRqDWl9
         +WPuS/z2y+DpedUW+QPt37qS7qtx/+Zcu1puKABcH5hB2TjMOzW2juC+YfA7i/Z/cm6l
         07Bza1ShNHI4LOLF/nAHdkKUldQe02qVoqrTQUNwwyAwHtXzDPYf22nK80nNyaniU2Qz
         ZsGJOmmEpIXU6QJtNVSKsewZhMXLBeTIiCr5mLubfhaUpfs2gW0w5r913/z3oU6/f5kb
         073Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dMVlOiaocgAoPdOfqZSeW8snS+xV1uWPxAAS2Q3JzbE=;
        b=pm35IW5KrPhGFEuBTIcig7uDwaC3towdJkiM/feyUWMv3sgNCpEo1i/gd6Oura/MoG
         EiPIdNLYsQpPqXQ4LRx0WbCef1RuaVpf1x32ajOHhoAZhY2nW0zAjKO3jrwGmOGLnTH/
         XKmorsC1RfOrnUOhMkslB1a5849t0brM4JuGexXjFr3ly52prUsRLn9cvibU6+TXv/GW
         ZAFbhV/y12DaXpjZtx4D7ZsjfkRsUBE6c5+LccbFjd8z7ddsQG0FgTghHrfTTBWw9RWQ
         VxMlEMNNvn6sJi4DdWVsa1cV/WcRR8TJCSn4y+1LhMkZuB8NJfC3G5HJyITI2D3MFZN5
         W8Kw==
X-Gm-Message-State: AJIora8CU9tIAAbcRyOwhhTcXPHlBgDwszgPbtOifHT3YQ2wfOKrNLxw
        8HGdWh90CZ7VIwE6EE0VVJjTQ+7r9KSsW41JMC4=
X-Google-Smtp-Source: AGRyM1uumkBbXX4DsHwou1JsDsmVq7uWkTLKd/I0gvQ08D/Ay5NUShb37N/0MlSFziPrZ2NFzK7BwiFgb6+Z0fZX9nY=
X-Received: by 2002:a17:906:9b14:b0:72b:313b:2df4 with SMTP id
 eo20-20020a1709069b1400b0072b313b2df4mr3711785ejc.99.1659117799738; Fri, 29
 Jul 2022 11:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220729172332.19118-1-ddrokosov@sberdevices.ru> <20220729172332.19118-2-ddrokosov@sberdevices.ru>
In-Reply-To: <20220729172332.19118-2-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 20:02:42 +0200
Message-ID: <CAHp75VfGEPVBWbZ16widVCjgCnYAoUurjDj+-2pgC2oBQR12ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] units: complement the set of Hz units
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

On Fri, Jul 29, 2022 at 7:23 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> Currently, Hz units do not have milli, micro and nano Hz coefficients.
> Some drivers (IIO especially) use their analogues to calculate
> appropriate Hz values. This patch includes them to units.h definitions,
> so they can be used from different kernel places.

...

> +#define NHZ_PER_HZ             1000000000UL
> +#define UHZ_PER_HZ             1000000UL
> +#define MILLIHZ_PER_HZ         1000UL

Oh, but then a bit of consistency?

MICRO
NANO

-- 
With Best Regards,
Andy Shevchenko
