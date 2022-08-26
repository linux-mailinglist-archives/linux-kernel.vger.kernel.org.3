Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4335A2340
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbiHZIiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbiHZIia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:38:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE26D5E84
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:38:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z2so1264211edc.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yIFcteN6sC/bfaP1WTd/RHoQds62wkqs1tJOKGjVr+0=;
        b=TeZv4iLFDzDlcRMZdcxFYD8iBhkkl6ru8OscF0CczIJjoMszenrw8WXPQMojvZNMOK
         yrAvVSDX9JVbS5BynSn+dLfRkI2zFiGvM0Oe6uKk7WyPVO9RJDVe9sqHugHczQfpCMDR
         ewTeM6bWdEy+c/W+FBLIRWgyGjZ+hn85AjjApkYMhNowxNh4Am5N3s80e9FzA7pkCxNV
         lI7T3WYv0MOOPYrSMD+bRtrut4zCc0dtxaV2bGCTh3VL/N5UfavBSYgyu6xT08ZKdnCf
         dJtGcL1ZgCr1ZZfPa1GrAiGI8cd4GsttG4+r/CH5iYJs6K1jAgkud5zOone5CA+39eU7
         sLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yIFcteN6sC/bfaP1WTd/RHoQds62wkqs1tJOKGjVr+0=;
        b=0ZwxSQ79StM9D5qFwDkHg1xv7KVrmfNi1atW4g8UMGZr8zobktmxO2Blp/24MoPSGr
         GItLfteuu5hshwudvb9byBvAa3z5+beMQTV93Q1jKbZ2XJMlRgiEh7Kja7Ywon5Q4f/Q
         7quoYKpQHbGHjc/J5Mvv2Cx/2hu9Iw9hK6fkeL/gbaNbBDyFFRPHhqdzkpQDcBl3w8Zg
         lGjL8xY6mMfxyZnzGjkNiTaUXNQX47xvmtwDS/wKlDw5zNT/Vywk92EAU9kAmK5UYzsZ
         Gpyk0atgZTVfU1Q3InCx0hMmawgkD7Sr7Jk8SvzgsUIOYzBSJSWBp++2nN2rkeT+V5Ic
         eB8g==
X-Gm-Message-State: ACgBeo2QZ6+s6rsJpc+Tz0sQ7ekKsYxEN6Szgv2KwTQ/pZPaY1AQyh1a
        fGQpJlqf667FzeBvRgaE4wtV+YxgK3H/ME3iCVCGDA==
X-Google-Smtp-Source: AA6agR7ozWh1h3e0/Xth50fQGocQFY1NAJzq0Z5PFKq8ZMWLhAvNOdudXPHZBKkMRV1id5Oh5mABiceM7paZHMDcSNk=
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id
 ew4-20020a056402538400b004316d84b451mr5948537edb.46.1661503087619; Fri, 26
 Aug 2022 01:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220819024541.74191-1-michael@allwinnertech.com>
In-Reply-To: <20220819024541.74191-1-michael@allwinnertech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 10:37:56 +0200
Message-ID: <CACRpkdbx+r8SLRAJKjMHGn1MzmcqmXhorXoPxouooMv6VJL89A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: Fix name for A100 R_PIO
To:     Michael Wu <michael@allwinnertech.com>
Cc:     wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        mripard@kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 4:45 AM Michael Wu <michael@allwinnertech.com> wrote:

> The name of A100 R_PIO driver should be sun50i-a100-r-pinctrl,
> not sun50iw10p1-r-pinctrl.
>
> Fixes: 473436e7647d6 ("pinctrl: sunxi: add support for the Allwinner A100 pin controller")
>
> Signed-off-by: Michael Wu <michael@allwinnertech.com>

Patch applied for fixes!

Yours,
Linus Walleij
