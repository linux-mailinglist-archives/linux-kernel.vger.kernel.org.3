Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9574D3FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiCJDaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbiCJDaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:30:11 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F80128DDC;
        Wed,  9 Mar 2022 19:29:12 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2dc0364d2ceso44475437b3.7;
        Wed, 09 Mar 2022 19:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sB/Rlmk7t9c2S6Emm5XrELMaWA+vqxNSn8GuK2pF0Ps=;
        b=vVYt3aH3oFwDcbSKQmkR32erWw4SqJiHgRGfCf+AChENyOUy5sP5NxCejJKKDetPj5
         W47ijFrEwfPLEpmmjbrDVT7lZaqmC0jBNQfl1LXCtRWWKmLxioy28li/k71+ssKQ0GRX
         AlO/4SGZ/AcZjEqujr3A+yVyP6AcgBGrPnEedu6inx0GWgw2rcQTpAGzS9nAi+um9umn
         MCt0pX2qMhG1EVqgPLRT/McwRrj20NmWevtOiAHvlw8XoMRRJSVgY1h2vEuI7dR0bVUJ
         vjRC+7t96yKNkxZ7sIsbMK8nCNVDMX0ObfWTns1vFcxSPjA45P0DZDeHUOkvoPkMaA6m
         zfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sB/Rlmk7t9c2S6Emm5XrELMaWA+vqxNSn8GuK2pF0Ps=;
        b=d766KB0003qpJJK8LzyNeor2qqi4vNgBLsOLPIM9IPpJvuPO7IcZ5piuH6ulqj/TA5
         uSFYFqnWRQopKNIVgHQiHslx6InWvhsODdzqZq7qjbesT+SIGqWCxVpeVdZnbuQVx3V3
         D/VzkTyrydQB/RZbFSdji4HHaLPdqk/D9YD6mraWywdJUnGKsQH2r5zGQ9/Ed9YlCALy
         0fnVOm4kEOzEq1nbWIYHXkGSId4/DEVWGE62PW665J2lnbYfwY4DoPaWZunNOYkNb3yX
         xx7xH81/P38ofkpOuYZKxpOgC8Tc78vHjWjThRsNX/y2I7gF1B5zRSzxaht6hSix9ME4
         ew3g==
X-Gm-Message-State: AOAM531Og64M62UsqzjTr3c8422iiZGb7/rZtNSaM7K3KVCoWQsGz1wR
        9Zj228nxB7NrkBGGPZBwt8Q7+JGME10CNeALyv0dYzKDWns=
X-Google-Smtp-Source: ABdhPJwKxvaw6I8YpeHRYsI8EXUBUPfXKevndl/YIwHdf4l6r38ARKBMuc9JmHhsRNtBUBD4EmjN0M7hqpYI3kYo1hI=
X-Received: by 2002:a81:154:0:b0:2dd:1e6a:d509 with SMTP id
 81-20020a810154000000b002dd1e6ad509mr2459408ywb.339.1646882951487; Wed, 09
 Mar 2022 19:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com> <20220309162301.61679-20-alexandre.belloni@bootlin.com>
In-Reply-To: <20220309162301.61679-20-alexandre.belloni@bootlin.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 10 Mar 2022 08:59:00 +0530
Message-ID: <CAOh2x=kAyxu_4QCZqt4C58yqOP5VGLsaZ8j3UcoLrSw+Coj=_Q@mail.gmail.com>
Subject: Re: [PATCH 20/29] rtc: spear: drop uie_unsupported
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
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

On Wed, Mar 9, 2022 at 10:26 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Since commitc9f5c7e7a84f ("rtc: rtc-spear: Provide flag for no support of
> UIE mode") which was in 2012, the core changed a lot and UIE are now
> supported using regular alarms. Drop uie_unsupported now to reflect that.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-spear.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
