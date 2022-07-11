Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784F570536
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiGKOQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGKOQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:16:47 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A14F2E9C4;
        Mon, 11 Jul 2022 07:16:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r3so8933967ybr.6;
        Mon, 11 Jul 2022 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vf+VTyyTWGsnZnHhl+GAHyRGdszNXCGk/WkrL9vpyfI=;
        b=X0asbNSZ/Y7jCOKEBpas/c4n4OwC80T9tb9l/BhDwIDJpeLk0iTbLxlHcXvyemkXSU
         OJC2nqFEO6p9/XMcyD4JBTnH4BLCtqV0Rol9+upzxpISvgbdEUWVeOWm31YoyL4bOj82
         mcgv4yXSZeCV0Y/ks8U0t8DyeDtJ0evxZplTay+u+RbCd1MufmfaA2VLTCAiG94333e7
         dtCNNyGUEd0k58gRIqkDdPIRMR3v2vfZPo711l4OtghEihiQLjPb7PtK5LYelUnO5hFD
         rhueqr7PJ7fqo/L9PZufFXYNU9h/eUX3nxNRYtSbqCpzv66JG96Hzna4Q9UDDxU2LoBu
         IAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vf+VTyyTWGsnZnHhl+GAHyRGdszNXCGk/WkrL9vpyfI=;
        b=md/OLBsVdpe8tGoJAX0fifHUDpdhCzW+yVwNb3GZycsQ8VU1Nit2W+w5Va8WhxSIUc
         PQ7ZzDE5t3tkFvNSwuLJRLfblE35sWtDbi70Zy9U30dn/V5pG6x+uoNzVL9HehNv4hOx
         X7LWtq+FOjys+JSWSmSrBKL5lDag3Pbpjv0vPpL78OHaVic7bEqeBQy/P5JxCdixnAlQ
         0MYClSm1wD2/+cj6nVKUhiSsHDrUS0Xz4rdxtFQiGacsyuWjqDXLNd2j36XMnrAerFtL
         YRJ5+dgYmePmE/GpB95vZlZ/nkt8KZCfyjBE+aLljk4zQDaLBa1/I08XX482CbCYOO1s
         NMDw==
X-Gm-Message-State: AJIora9CnYOm60W9m73DNqXYLuzcccHgmiUCfmhS4wJ5LxRMWFoCJd3p
        4lROKCXEZQY40jIySRS/0SvGXb22sZu1RJfZcYw=
X-Google-Smtp-Source: AGRyM1tjs3lX/e7/uuqpiknfoZcI/CSEGGAMIL8sSGkCYSy5OiaTV9RyVK7prX3xacTNgQEQOM7zwicT+muV5R/LniQ=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr17319442ybu.128.1657549005246; Mon, 11
 Jul 2022 07:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220711134312.234268-1-tmaimon77@gmail.com> <20220711134312.234268-3-tmaimon77@gmail.com>
 <CAHp75VdXsiH9ityqopznRpjxvwOboS_Zbi9iO6nRZ03TuKxTtg@mail.gmail.com>
In-Reply-To: <CAHp75VdXsiH9ityqopznRpjxvwOboS_Zbi9iO6nRZ03TuKxTtg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 16:16:08 +0200
Message-ID: <CAHp75VeCPRVUMHYdNWgPja2eWeStokRDSogW-7ALz10_yEaDMA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: npcm: Add NPCM8XX support
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Mon, Jul 11, 2022 at 4:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 11, 2022 at 3:59 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

...

> >         struct device *dev = &pdev->dev;
> > +       const struct of_device_id *match;

> > +       match = of_match_node(npcm_adc_match, pdev->dev.of_node);
> > +       if (!match || !match->data) {
> > +               dev_err(dev, "Failed getting npcm_adc_data\n");
> > +               return -ENODEV;
> > +       }
> >
> > +       info->data = (struct npcm_adc_info *)match->data;
>
> Instead of above
>
>   info->data = device_get_match_data(dev);
>   if (!info->data)


>     return -ENODEV;

Or

  return dev_err_probe(dev, -EINVAL, "...\n");

if you want that message to be issued.


-- 
With Best Regards,
Andy Shevchenko
