Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC81B53D396
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347921AbiFCWWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 18:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiFCWWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:22:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CAD286F5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:22:34 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l204so16084107ybf.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbsgqnojhBY4V415x3C0fDTOg6GG6s3cxgXrWlI1RRs=;
        b=vZZr8iprlZrWBkzFpxmomNEmLN9CfD1JTqvF5qBt2o84s3Xa1T3qgGz+J56QLbL77Y
         axL+HiOLq3EM348vIMSvMR3cKiVUQleIcPWU6FyP/WdnPf7Wyv0dAhCe4Ih5s5mBZgz0
         Qbb56h5a9ZsaC3sjzoGJyPva2YcruT0CwIuHWOXxJuEZCt4AtSSHktbAvLiahcdrtc9f
         44FVXHppSQbz4wpplEo9W0JSGAdQHIrc7ejPd5QrJg38OtoI1ltsMOivLzRMArYgCsiG
         uqjA21xhWQvcY/cCJ0xxTvIWYxj9OTF/nTnRAiiWyh/aeoR+FZ2sqRihoW856/AiLq6W
         ZUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbsgqnojhBY4V415x3C0fDTOg6GG6s3cxgXrWlI1RRs=;
        b=3/dnp2C1/FUhZT7jIUKksYfs82Atcm2QUia5H2rrxMzQglCrMEvaWWMzOzj2ij3Lrr
         8lY4+sm1draMV2tR6682GQ/Hlsgq7eQpQNRl/421+0aT130FC9KMWvJkGEnb9cTD/Qx5
         mdeBmhozesX6rRwRsHSvJJDTx8/CdKZLah3+XlRVbIBRDVtz4eqUWt6lX+ogNU6DtJsR
         LUvtstDOIiI2jo9Adx6saNbCHvAsVSX2SUouPX3NH17oHsMBOh44VPq3AOgYMo44JPmf
         f3EnXY+GjsQOJvtfZwWOZhncb0fZyOgD8jf6W3JXwwESbh5LDFdcZ3pTLCW95qzwPvOx
         hU+Q==
X-Gm-Message-State: AOAM531HUX9/yszn+6DywYUzAUGVKGzQr3N/oR2k4V7HYdC/eEiEJkY3
        aLQ4yEsnnEtwTA0Nh1G4tEEy8qR9iCN3p8i8MBDoUg==
X-Google-Smtp-Source: ABdhPJzK4KSQwxvyeYkM8nwzhwDrVml+dsYJsEDSZ3ExN3FHy9LipBWD2wRf514AHIUo75t/iR/84tr5YAR01oNzZTU=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr13266629ybp.492.1654294953955; Fri, 03
 Jun 2022 15:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220526024956.49500-1-samuel@sholland.org>
In-Reply-To: <20220526024956.49500-1-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Jun 2022 00:22:22 +0200
Message-ID: <CACRpkdbuOm1EQgGsanb50oSFseDmgVrmf_FE1FgL7JUJJiaGtA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: a83t: Fix NAND function name for some pins
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vishnu Patekar <vishnupatekar0510@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
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

On Thu, May 26, 2022 at 4:49 AM Samuel Holland <samuel@sholland.org> wrote:

> The other NAND pins on Port C use the "nand0" function name.
> "nand0" also matches all of the other Allwinner SoCs.
>
> Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Patch applied for fixes.

Yours,
Linus Walleij
