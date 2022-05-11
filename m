Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E95232B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiEKMJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbiEKMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:09:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CBFAE25C;
        Wed, 11 May 2022 05:07:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ba17so2297645edb.5;
        Wed, 11 May 2022 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxIW6h+xypAi4uHDqYvQlCn4iNNtT8TT6Dj5XI5z4OU=;
        b=BYsmLskVQcQq1JrIuIh0lbybwd4wvw3AxfFgZwoIOb9Kfg49kFYYrMMRAsILkrzJR2
         6U5jdwFR4sI4lF247mjUQwpqKUn39/qAMhc8E3YACJ0hej990YaAXH3YMijT/Zqhiumt
         OzjGQqypHYptOJhZCXdjLNh016MTDQ3s8jidBXe2BscJNI/SQpRemeyrGbNYV7rhsM4u
         3btjTtjYGbIl5DrUVc67yYW/PHjmWS6B9VF//IPCOCXEG9msVTzOezlo/Ok2kNv8A061
         gzjkaKfEyRZnEG/du/EsIsRPXFCkdjj8T5PGct69qTtL6MTjO1nVC53KRP6hlLi3jMWI
         U+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxIW6h+xypAi4uHDqYvQlCn4iNNtT8TT6Dj5XI5z4OU=;
        b=VMgOjR30ybHY8mOFIH/WpeUkG57bFztYGyRBYWpcJz44DBgSVA8Gos3Y7n1690KhEt
         ZxcO4H5YuzDSmz+2jlVny3TE3T319/oej0nWeGycURQ3FNWxXQoR6bxqj/1tGlLieTnW
         4d9jCSWdJtyBcMmx7Xf//rV38Aj92w1ZoNfyeXOl/MosOQvoPrWNjxYUriS3iXXYZyg5
         freQ2joFOBU9HFh2u/3HUxzVGL4Eu6jlDg1igZfVuHb2DAgMiDmtOgxO6gltjSCWcPRc
         Y+L7kbSf9RQspcPDwMnG9oI+RCSoYuKg9W9peLq6u4nC3u15fAvh4lRFB451MfA++9L4
         xg+g==
X-Gm-Message-State: AOAM530m5WcmwdWk8f+KMD49RjaJFhZLNO2z0YzdGn8HEefJjMmZbp54
        VrpF4s/GUdoEHtOWZJ1Pvc/svpfu+5dB8BPwv6Q=
X-Google-Smtp-Source: ABdhPJyn+VJrijVJhyhzoNEW2S+P5R27VeDdu+EvF6J2TEhGsMmoFt/teFNVb7+OcOyZ3maH8Pxbd5aYmLdapKwnYcA=
X-Received: by 2002:a05:6402:34d6:b0:427:cc9d:a130 with SMTP id
 w22-20020a05640234d600b00427cc9da130mr28447655edc.356.1652270831846; Wed, 11
 May 2022 05:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220511115911.54960-1-max.oss.09@gmail.com> <20220511115911.54960-4-max.oss.09@gmail.com>
In-Reply-To: <20220511115911.54960-4-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 11 May 2022 09:06:59 -0300
Message-ID: <CAOMZO5AboNfb_E-4QVurZ6UTYephsOakW0QrAU8xRAMe8_zRow@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: imx6qdl-colibri: backlight pwm: Simplify
 inverted backlight
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, May 11, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:

>         backlight: backlight {
>                 compatible = "pwm-backlight";
> -               brightness-levels = <0 127 191 223 239 247 251 255>;
> -               default-brightness-level = <1>;
> +               brightness-levels = <0 4 8 16 32 64 128 255>;
> +               default-brightness-level = <6>;

In this patch, you are still changing the brightness levels + passing
the polarity.

I would suggest that this patch only touches the PWM polarity.

The next patch could fix the brightness levels.
