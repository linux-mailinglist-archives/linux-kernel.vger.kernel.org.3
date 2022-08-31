Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5525A7DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiHaMnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHaMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:43:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BC925CE;
        Wed, 31 Aug 2022 05:43:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f14so10685864qkm.0;
        Wed, 31 Aug 2022 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5tRe0udrOzgvmzmVe1TJfRXs9QUgCv6/ooryrQ8LL0E=;
        b=GudmD5Nd8mmMc/sqJS0qDmKTlZc/qGH+NwbB+EtE9tfjZxH/7/PKo2UOJHKbR2U6NU
         9NqXSzQr0QKZt8CEq901VRrf3y499jtMjto/7uWUFncsFkPSt3Be6Yqh+nphYXif/hOk
         7/K4JNjm5kvean7oixyXbECcP7RoG3WR8JQI97UzcG25zhQwKXKPe0c481f9pnKRdVXP
         KCptRWkbD23qWS6VY1J+qLmnnEWOVoFDI5bewXuaRn7nFMoy3lW1Wy0jybr0EVKfxZAb
         H/kkebegl/FHLDrPT4f9UGM8Mz35s9vjCqzlOFByhokWczigz0eNkdgO1Hi/GQDlJ+0c
         9MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5tRe0udrOzgvmzmVe1TJfRXs9QUgCv6/ooryrQ8LL0E=;
        b=DXE1icVzAnp+7rflXxczpQ+lvNu94y9uH90bENfcr9gbUxTkjV+0obaMmi5drVlLYg
         Fnp9zsRe5Lv9JfGg3KZDlrmFJjcFG31T21hv0/yHj0A8xpdstLkEQv3fo68tmVs3pGNO
         8wxh4wsvwZMuEufPMU/V6ADNpe3ESQMeHlGxYUYSeIuY2QV3uUCoQfkipg4N8aq3iDFF
         hklJLApoC8yKLYCrm1PPrXF0xSem0SU1m3/+h2DurnziEUV2gpnV5121a9URHjT/1kq0
         xtGAiIL2qWDKWWi1eaNIReWIiwsfk7smuPd87vJ+pKz+6ZB0nIBcBWiEM3fY+sE4wjUg
         Fmfw==
X-Gm-Message-State: ACgBeo2BdIK1AqK1l9jhIchtSA8ezGtAvTnwuCtWw7sLUwFe7fdK+ZbJ
        z5Jv566weIrSCqRa9B5rAS8U520idevC2xForqrGmkahGjk=
X-Google-Smtp-Source: AA6agR5PK7pRe0Eks80SVQBsPZG5FPESZc9foSYIBUYFn36C70hyDeIVP+KIVawwKV+ML2F4ckOA5o7padIb9dv+ut4=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr15379328qko.383.1661949809875; Wed, 31
 Aug 2022 05:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com> <20220831100506.3368103-3-vincent.whitchurch@axis.com>
In-Reply-To: <20220831100506.3368103-3-vincent.whitchurch@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 15:42:54 +0300
Message-ID: <CAHp75VeMxjwtORMBRUMk0ynEpL354WaRGczo_Mi1SjveEmGAbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: adc: mcp320x: remove device_index check for TX
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Wed, Aug 31, 2022 at 1:05 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Replace the device_index switch with a TX value computation based on the
> number of channels in the chip_info structure, so that the latter has
> all the information needed to handle the variants.

...

>                 return ((start_bit << 4) | (!differential << 3) |
> +                       (address << 2));

At the same time can be put on the above line and removed couple of ().

...

>                 return ((start_bit << 6) | (!differential << 5) |
> -                                                       (channel << 2));
> +                       (address << 2));

Ditto.

-- 
With Best Regards,
Andy Shevchenko
