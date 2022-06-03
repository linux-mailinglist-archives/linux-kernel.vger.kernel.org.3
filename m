Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630E553CBE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245260AbiFCO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiFCO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:58:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D1539834;
        Fri,  3 Jun 2022 07:58:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u8so6392615wrm.13;
        Fri, 03 Jun 2022 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/R/4ToixurdvYBbWBR8c1EK1LIIPY8prRBRCCAJql14=;
        b=L89/jjviPQbdDtiZaCn6CI2qnSZbvNAjCSTKxAXOYk0u+j4nl+51icI4jgGLXmEunr
         mU9ErCTPBea39/n0UZdGXHlkC28VQs7BJVKWNUROGluAz0M9NhW65LfVv66HpWp55viK
         SQP+z2shn97ZcZggMVy476j+O4xufb6UqE6E8O1Q5p7I6l4GhK94680PbODhY6lBNlP4
         4WTsOIN9CJfYf/Mn3GT6HAMIS3/tF/kYTKphowxHKV87r/2pX+kyOyLyRzfYe0n2fw0p
         rNyVeDaBeHfGMmfXFBFji9ePerTaWaRoAnXCSQYBRM1bDQrh3Tg6SOHGP6PcQ5ILeiYr
         B6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/R/4ToixurdvYBbWBR8c1EK1LIIPY8prRBRCCAJql14=;
        b=ibCR/nOc7IEW4HdfG3+xN5sXlpnP6kWTibz7cOIfM3lYo2dNkiVkGsWUdC5K9P1HHt
         9v3PKm68wlvuFVPp7UYm4l2gDw1AwCMUQdWwTy4DvelKn/BgHvezWstwlU7gZo1XQZwU
         JseYMl5aL/ehah+9F3Ub4kocJVaOJROUTbczvRUNiCvJWOW/0hiNpjcEKtLc4R6tDVEE
         L/SNWCs4omW4Z+aJ/hDDyxXeoEohegK8wVyVvWbEWBQEenOqHl8LcQ8OSJBkwcOmVq9Z
         2IFsxXF9Hvk4nD3L2nHv8CFDBg2Uej0IxzbiuvnDndN8gpFFaHa8v1HijkTja+TXgjJC
         pNeA==
X-Gm-Message-State: AOAM532j678LGSH0OUZe76CNamLPXZTp+Xy94C15klk1VBvvvpV+QTU4
        Qe2gDlVg61vXstu134giO4r9wynnWfuomlaMsvmEhzg7
X-Google-Smtp-Source: ABdhPJwLkLEf+cqEIWjgsz9My/14MKmdEsJ2CQwAp3vAoyWObhmuS6Arp6/K91rdmeLKIRwQ8ndqit+2uQwKakVcnu0=
X-Received: by 2002:a5d:68d2:0:b0:210:31cc:64a6 with SMTP id
 p18-20020a5d68d2000000b0021031cc64a6mr8289615wrw.679.1654268292227; Fri, 03
 Jun 2022 07:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220603151600.19cfa617@canb.auug.org.au>
In-Reply-To: <20220603151600.19cfa617@canb.auug.org.au>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 3 Jun 2022 07:58:14 -0700
Message-ID: <CAF6AEGtYS1LYowjf-OiN-C1+4JFTWwOOpP__4iDLo-dFy0t0Tg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>
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

On Thu, Jun 2, 2022 at 10:16 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   8caad14e7224 ("drm/msm/dpu: Fix pointer dereferenced before checking")
>
> Fixes tag
>
>   Fixes: d7d0e73f7de33 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Fixes tags should not be truncated or split across more than 1 line.   So:
>
> Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")

Hmm, checkpatch seems to not catch this (unless it was a recent
addition that landed after what msm-fixes is based on.

will the truncated subject confuse the scripts that look for patches
to backport to stable, ie. do we *really* have to rewrite history to
fix this?

BR,
-R
