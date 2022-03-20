Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC64E1CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbiCTQn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiCTQn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:43:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA11ADB5;
        Sun, 20 Mar 2022 09:42:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w4so15447997edc.7;
        Sun, 20 Mar 2022 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4e4Zl1zdi2PDdgomvp1kwsF4rs95DeeBpdKzKoWk40=;
        b=okLI37gOXbcKEuOcsWd7cavyqhQScuhWHoV3NkIgLSIaWkTyLanEUOi0LKt6D/imFI
         ARfhmVlSdGPzFTAaTJPQggsrhSUzkFF9kdncmIgTdxB7+rt5Y+res9zZwkI3DLTOBqTq
         19+D+HmM4r04SprLOsypxTgqzXlN3TE7aobVsSDGkKVGK5WR9E6YMrCQp1XkARPbyQWn
         FT6V1VYr7t+07o2/BAQEdFjSSsKCvsetd+gGIODcQ2OSWL1J3NU95dfJfOzn7ygSk+pI
         rzfApwg2wb4jfMPcneQOxTrxxElqOYpFDee1LfbjDMGssp3VTHVuzQhCZTMdHVZS2UxO
         IVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4e4Zl1zdi2PDdgomvp1kwsF4rs95DeeBpdKzKoWk40=;
        b=FhXeCKafzNq9gfuhAubaUvag4ZlAs/N3UabKo/F3mc5nOaTyPiGTVPyCRDAwIEJre0
         9dfuycD3UBYTfVygnynhxl7vtZJ5ytoMpJXWsOkRiXlQqrStpeelSR6u9zQVGwlvXRky
         03V3mhWAUCf+cEGJ1Gk4QNSLyR3tpfaByYozFwXh4DNvkBTIyFB3eNLFZrCqcX63mXRQ
         sEDMaVkUQBRfhhYPQ0K9pJIFsOq9gYrr5tIK9iMLRrzhF2MI6MibB0BYmFtV3Xn3UTJE
         Y7Ulpxm/CE+QMQxrRkuQbYH1FGKxwJI9O3tcWSfNfdITPXwI7pPs8PMAxFOcO4J03+M3
         XLZA==
X-Gm-Message-State: AOAM533PHNdp8N7t37zvK4P3K1VY25YsCXuEqkM8B3skBKt44PKsFaam
        wSJnZoWjrRJEamTBd0yfKnHDWdfpcPDR5rHAdp7YSc/K3Ln8zZD/
X-Google-Smtp-Source: ABdhPJzJSOY0k2sKsU/jG2OioiH08qdw/gKwGniiadLSAUaAXKzApW1YK4NJERR/3g0P6jklXuSh2nrqyYJu5VcSOTs=
X-Received: by 2002:a05:6402:5244:b0:417:adbe:e9f6 with SMTP id
 t4-20020a056402524400b00417adbee9f6mr18965253edd.282.1647794552551; Sun, 20
 Mar 2022 09:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220225155622.585621-1-ahamedhusni73@gmail.com>
 <818eb53d-0ca5-d0dc-4a06-37615a5c4c3b@xs4all.nl> <CAFjpAKpyDeEKvA9TEK0KbKVHFN8KSMDZKF=L2Azq_7cuAhHH4A@mail.gmail.com>
 <c4368e33-f6bf-5810-85cb-cd31359a42f7@xs4all.nl>
In-Reply-To: <c4368e33-f6bf-5810-85cb-cd31359a42f7@xs4all.nl>
From:   Ahamed Husni <ahamedhusni73@gmail.com>
Date:   Sun, 20 Mar 2022 22:12:20 +0530
Message-ID: <CAFjpAKqSFwH4QJL3U0YWz9NF_i3BuHxA_jkGPgt97wDpPGe1fg@mail.gmail.com>
Subject: Re: [PATCH] media: av7110: av7110_av: Fix Switch and Case Same Indent
 Style Error
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

> Either just fix it here, or post a second patch that removes the spaces
> throughout this driver. It's a very old driver, predating the much more
> strict enforcement of coding style that we have today.
I have sent the fix as two seperate patches. Please have a look.
https://lore.kernel.org/linux-staging/20220225155622.585621-1-ahamedhusni73@gmail.com/T/#t

Thanks,
Husni.
