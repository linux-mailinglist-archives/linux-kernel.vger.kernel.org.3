Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11594B4EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiBNLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:33:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352266AbiBNLbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:31:21 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39D4A185;
        Mon, 14 Feb 2022 03:15:53 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jg20so11714779ejc.3;
        Mon, 14 Feb 2022 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drdL+ntYxWFrqHpoDzo7iEOV0dA7qeSrScjSO9IDrFw=;
        b=UPWppfvY196XnTeDZQyFmBWgbXPWlJPdiNg1uw+xCw/sZmugGupQXfqDHe0g95QoYB
         oerX8C3HaZXgq3oThTKTmPHGqTnRK/sWrf3XAZoCRWvMnyudQKhRZ7rsntZgsTXVS9jx
         5WioIynTmuxq6c5xAVVhac541c9F2/Bs/sXt5RFVy8MmyrGboWF3tvGlTe6TDZZYp4/A
         NtL4AvoXshVXUMuYyq1onkHo6HfOsnaidDQKuL8gX6MukjdwIzw3A8mAUhaLAb9nnYNU
         TU8hwhNMRl5QIoAg0qKctM1i/eW2SbXSoBTQV0YB4iW3WNkuCGdfbvqwthw95OYiwCgF
         DKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drdL+ntYxWFrqHpoDzo7iEOV0dA7qeSrScjSO9IDrFw=;
        b=60JcdwLp03MLwYkLp9KFLybRJqpxGI+MID9nWh2d+oIQ2eqroQoTsRuWSw/4LU2pC1
         WbaiKTEGcEr6YPvynoEe1c+e0JeYXLfcBEFZycB3+1b+SRP7IHPzPcBP+D+OAycab79Z
         ZKcWEGHdYmtfeNE0Y1zzTJBHTbY7MkpuUFY+4+mfAlmArE215vELBVjQwzJMgsV5RYyo
         4oJzWj8CUC7g0dazF3ZVpRIOO+3R7tDaleGbcB2SfpKa/7mypK58OPOoBxUA8jjns4r1
         iQUSdGUVgx0UpO9is+W+H5U2F1gNohiFG5wo99WjLjOdPUx4oTJAclemgLs7mM0vr3sT
         AYXg==
X-Gm-Message-State: AOAM5300zl8uvlo88FUoiOSqJtd45EVHbdaUJWIrZCZbmnLgayN+WLju
        xdu1GrGm1ccV5s3aeW/ETCepRBwus2AU2QcnM2GSdt17tzNmow==
X-Google-Smtp-Source: ABdhPJwcuQMhcG5C2fm3oewmHxc0bevrBbpzNL8s+Ztyii6FZnBdTQApnkpVXcsxv6IYINT9wKJn/TVb+u1i4Rpqe8Y=
X-Received: by 2002:a17:907:2d92:: with SMTP id gt18mr10662467ejc.579.1644837352086;
 Mon, 14 Feb 2022 03:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20220214033620.4059-1-jagathjog1996@gmail.com> <20220214033620.4059-2-jagathjog1996@gmail.com>
In-Reply-To: <20220214033620.4059-2-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Feb 2022 13:14:23 +0200
Message-ID: <CAHp75VeD7rB3RPZ4TYJzvq3=Ush=FFERchJWwD-VY7q1c1Aupw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: potentiometer: Alignment to match the open parenthesis
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
> Fix following checkpatch.pl check by removing black space
> CHECK: Alignment should match open parenthesis

I believe in some cases you may make them more compact, like join
lines (it will be slightly longer, but still readable). OTOH, it
depends on the style of the entire driver.

-- 
With Best Regards,
Andy Shevchenko
