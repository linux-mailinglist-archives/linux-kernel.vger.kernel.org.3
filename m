Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59AE4F6D93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbiDFV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiDFV5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:57:39 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2D57B37
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:55:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id v15so582284qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18K4Koo+gSDcc2mYQoqx/5md7n9d+vojvdjDwRnfQkQ=;
        b=Kvts+vyOdgj5qb/yrmcCtgFddEpMAYJ6Vtt+e7K/TdG5zlgevkxRZJ7mT6fCAextWP
         CkBNmJNYEme2Prp18S+VCdHLmsbnxtU2/GL7oLXhZyLH1ZbhmnD+NEIAXbAYNfNwDH0P
         xne4EbAvbRql8bNt00hQfBSFq9neL63asMKnw0R8vSI+6e1KKIwyBEfnMLIWLMnwxMY2
         UymboPIBOVUTC8THIxgFIWNXTLThaSoUhLGzr/yflxFTA9qQ/j4XZtytj7c/YrpAuTU3
         U1JW4JHshQKqmHCC3SAvRIuphMsmKxiP3pyGPi+vtdE/Ad4rYIqpWQTm/V3S581T+70y
         qWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18K4Koo+gSDcc2mYQoqx/5md7n9d+vojvdjDwRnfQkQ=;
        b=srMpp4K34NuD/Qg2nmhvtO4y6tl1I3qbqUtvZ/oWvjxtGyvww1gcn3aNufK2cXEJDK
         m+DQdKrnaGscsqTVWGGurgc+pvuTWjPebD4IzU7bckV1ybnEETJlPzy6tBnnWiFFRDD0
         oUkUfP6cS9r8q4dvBKG/q+L+i08XFMrvyYxE3oF8rwDrVcLK5OO6ohbKmN3gNHfSRfq2
         Q8v6jglZdrey6GinC9CymrGij8rA6U5PXHS/FZFjKkAwzMpt8Kx7dLmCM9ULvuqXn4CY
         +Bgs7o1kc/fOcqcNbyr39S2MNIu5MVlzJjLHZv/n8GENhFCOKKyQprEHhadpt43o1+Lp
         WqFg==
X-Gm-Message-State: AOAM533Qgr3aMVrqf56QNji+FESsNYwPq4Up/XIJi54/D5fZYlTfFR3Y
        tL6gi+YXEE01UloqwkH+Hm/aLmcieNTmb6I739aYjw==
X-Google-Smtp-Source: ABdhPJzrSfiA86e2SS1hOhDbnO4gW9TDF++9F+ETBBY4qKTwTrC34JSvWVKrwHQPm+7n0fPZ0ApGvCzsI+S+PYVc3To=
X-Received: by 2002:a05:620a:892:b0:67e:60a9:83c2 with SMTP id
 b18-20020a05620a089200b0067e60a983c2mr7245120qka.670.1649282110221; Wed, 06
 Apr 2022 14:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220406172956.3953-1-wens@kernel.org>
In-Reply-To: <20220406172956.3953-1-wens@kernel.org>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Wed, 6 Apr 2022 23:54:59 +0200
Message-ID: <CABxcv=k=dRPg3S5LrY+bcrEJ91CxoLdsRjVx+sLM7GYEKdv8Gw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/ssd130x: Add support for SINO WEALTH SH1106
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

On Wed, Apr 6, 2022 at 7:30 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi everyone,
>
> This series adds support for SH1106 to the ssd130x OLED display
> driver.
>

Thanks for re-spinning your series. I believe that gave you my
Acked-by for most of the patches in v1 already? But it seems you
didn't pick them up.

You addressed the comments I had in v1 so those stand, for all patches:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
