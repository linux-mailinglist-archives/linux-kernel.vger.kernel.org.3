Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D693C4B631D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiBOFvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:51:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiBOFvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:51:52 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7D77647;
        Mon, 14 Feb 2022 21:51:42 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h9so16801154qvm.0;
        Mon, 14 Feb 2022 21:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iytJY9QGZHgK1dR7TRPlRfso2KgivSYIHxmNeKfZdsI=;
        b=dGCZJuImpISwcylMeDy7jztHJX1LTHvxJ/hDdJyyJfEw7baQk+ZA/B+5N5e8pDZRPg
         AunIC0bQysjAao0JMBU6Ps/exYHloD9TOOvF3DIGIWGWt8wcm6FKqTrhgf2wryJuwYFM
         vkn8CDHe0lTFepxz18DqiyMnf2dKQNTEU9th4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iytJY9QGZHgK1dR7TRPlRfso2KgivSYIHxmNeKfZdsI=;
        b=0npTYWJDGEl1zdu62rSfjzCSfKo5Ag1nglcmYunujak8Ur/K0WLwo0LXRiplwis716
         m/tbdiyLzLnI+I3SIFcQ1xJQvJ+RaGeGABa5caAc9cx33czyHc+N0C7z8pH2IllAf3ja
         Shm4rIxuQG6HVXKhNhYBN+x6oFmRpWTY0u1jc7kiOnFID6NYkVcBESC6ECjiEGhmTPoR
         DlcCoN/dVzBbdJKvdUer9du8s+tzoNhELNVvTCBX51u94NrP9FDO++y8fQ7HE23I38Ne
         dVABbE0jlVgd66j/j/ZAQo55C4Sn9HG2Pyj311uuS33nj9gCo2z4eJSXXzgUJB+setWm
         l6sw==
X-Gm-Message-State: AOAM530fwbL6qpvQBbQd7AmzpwYhomH+bl2Um7XAqpPJHpg6ic8/y6Ni
        jMK68wQaBY8vRRsL4yprdvek2m36SzH0tJrwHAtTKUd3
X-Google-Smtp-Source: ABdhPJyviT6pQp+V6F57xIT2apVk7qMUv7vZUfJEXbd3ulavwnbHnrmHmHTrsCKbBGiomLGp5xGIQpfdT5bWcMLIClg=
X-Received: by 2002:ad4:5dcb:: with SMTP id m11mr1565762qvh.130.1644904301705;
 Mon, 14 Feb 2022 21:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20220214042538.12132-1-potin.lai@quantatw.com>
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 15 Feb 2022 05:51:29 +0000
Message-ID: <CACPK8Xcs7y2d9AGfizv9+Lr_Ri3gaq2gmwXMFt=04z7s9XmAMg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] update Facebook Bletchley BMC
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Patrick Williams <patrick@stwcx.xyz>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 at 04:26, Potin Lai <potin.lai@quantatw.com> wrote:
>
> This patch series update Facebook Bletchley BMC devicetree base on EVT HW
> schematioc design, and rebase SLED numbering to 1-based for OpenBMC
> multi-host.
>
> - GPIO:
>   - adding more gpio line names
>   - include interrupt line in io expander for gpio interrupt monitoring
>
> - SPI flash:
>   - adding dual flash BSM module support
>   - switch to spi2-gpio on spi2 due to unstable signal issue
>
> - Hwmon Sensors:
>   - adding INA230 sensors for monitoring
>   - fix ADM1278 shunt-resistor
>
> - MDIO Bus: enable mido3 bus
>
> - RTC: switch to external battery-backed rtc
>
> - OpenBMC: 1-based SLED numbering
>
>
> LINK: [v1] https://lore.kernel.org/all/20220211014347.24841-1-potin.lai@quantatw.com/
>
>
> Changes v1 --> v2:
> - update the details of new added gpio line names in commit message
> - add battery-backed rtc information in comment and commit message

Looks good. I made some comments on the spi2 patch, please fix those
up and I will merge.

Note that the convention for patch names is:

ARM: dts: aspeed: bletchley: Description with sentence case

If you could update your patches to follow that it would be appreciated.

There's no need to re-send your series for the openbmc tree; I can
merge those once we've reviewed the ones for mainline.

Cheers,

Joel

>
> Potin Lai (10):
>   arch: arm: dts: bletchley: switch sled numbering to 1-based
>   arch: arm: dts: bletchley: separate leds into multiple groups
>   arch: arm: dts: bletchley: update gpio-line-names
>   arch: arm: dts: bletchley: update fmc configurations
>   arch: arm: dts: bletchley: switch to spi-gpio for spi2
>   arch: arm: dts: bletchley: add interrupt support for sled io expander
>   arch: arm: dts: bletchley: add shunt-resistor for ADM1278
>   arch: arm: dts: bletchley: add INA230 sensor on each sled
>   arch: arm: dts: bletchley: enable mdio3 bus
>   arch: arm: dts: bletchley: cleanup redundant nodes
>
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 303 +++++++++++-------
>  1 file changed, 194 insertions(+), 109 deletions(-)
>
> --
> 2.17.1
>
