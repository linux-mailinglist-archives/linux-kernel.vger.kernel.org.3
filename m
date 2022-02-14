Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8864B4F14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352837AbiBNLnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:43:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBNLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:43:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6526D966;
        Mon, 14 Feb 2022 03:35:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id h8so10241687ejy.4;
        Mon, 14 Feb 2022 03:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3J6eRdmKEMyvk87DRaAXQaXppLltRQ4LA3+XirchFxA=;
        b=Jxj6DU6co/Vr+l0USdm3w6jdGohzXgvtlk4K9zaYfE0UE4fdpkJAyE/f1L6xu9wbM1
         Mqbsc1yN5iOCWpdx4mwscUBQKWmakAqK6CtSMVMInBBVoH3LH4b332zMPONbVj8QlwPn
         A4v0pyA+4yAkOwnz2ao5qWpbsvC9ddJi86XfaYxa4E7gjTGN256xy2ADMSX9uJheYc0x
         DxPPaUbCKnDjXsz6//BWmUZNSdj0DAY8D6DoFwkTGkFkxEOIvPtSj80E5zWdcRCQ4MQ0
         NgSAdtEIMgEYCzFhzTGdgnrFwrS1pNtPlk+JbFvdNPK0bgY2ogk0R/TAJw8IDI/8yn+u
         IpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3J6eRdmKEMyvk87DRaAXQaXppLltRQ4LA3+XirchFxA=;
        b=B0Y1/WKMOBw5wcqlmv2Rbj+OXAN6fs45Sx8AjTDbkhyYWHW4UUI9al4nti8rvGWo+T
         9rIvylBwRPDpC1xkWB0M4w4shifAxw4RFirPwpls7HoDOUE97P0FgAu2xGJgFha6clvt
         ItYuAdc+dEqqkx1F0bXqMu6iz4W/mRmwEV10rRF6S63fY1z2gxriaXd9n1p64dwCyO2s
         KhEfO5GaDPnqTmJZoJD6fzcqi9NcU0dz37mJ32/1UTkzG1ybR8QWy/1SURwQ3CZeZoAq
         Rjbd+FaAlCfoUpIif8lYpnxsrd6k0ypC4tO05auBxIM1n3ktFjDEJ/QrVypUc/LmPedX
         Ymog==
X-Gm-Message-State: AOAM5314EXjd26mGI5Fu2yJhAIqDD66D/ET/+vxryHQ4HotzO4G2GeoY
        E4oGMUv/9K6jUymrjzBl04R6zlrOifPa+JeyLW7hz4dwtWJWzw==
X-Google-Smtp-Source: ABdhPJz+0EzQshm9MotYZJdj3ES6556nBEyrExLmu/yNZmkwHFHdZvwtOR6XSqnFAqEpMlN1s7uDxdYixPE6r9IJ7Xs=
X-Received: by 2002:a17:906:604d:: with SMTP id p13mr10880088ejj.639.1644838507355;
 Mon, 14 Feb 2022 03:35:07 -0800 (PST)
MIME-Version: 1.0
References: <20220214033620.4059-1-jagathjog1996@gmail.com>
In-Reply-To: <20220214033620.4059-1-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Feb 2022 13:33:38 +0200
Message-ID: <CAHp75VfUgqNUAShjbsXhA3mJ9YTDwtoxNDiFMX7iu-MgGFFCpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] iio: potentiometer: Add support for DS3502
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
> Add dt-bindings and support for Maxim DS3502 into existing ds1803 driver.
> DS3502 is a 7 bit Nonvolatile Digital Potentiometer.

A very good start! A few minor comments to be addressed and one patch
has to be split to at least three.

-- 
With Best Regards,
Andy Shevchenko
