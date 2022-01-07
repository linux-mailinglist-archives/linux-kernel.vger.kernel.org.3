Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C99487938
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347862AbiAGOtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiAGOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:49:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0B6C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:49:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o6so23029465edc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dnEOn1mC1NQNiRRaMsSZyymmcEfa5G6V1qN/15a9UQ=;
        b=iuJctLNVE4gZM+UBz6bkyQrYSKd1uj/sStmLfgQR8PjcV9kLke8VTHACz/8Lv3T/As
         VlQXC/J7zVGA7ak4YqXx9l9KSp2vBHf7rTItU9zcSDG8jG0XaKN6x/Nq5/IW+OlilRTU
         yksMYNjbnYgsaK8kQ1LoFkW1YQR1FsKpvBtQ8JovzxwukOQyJva680O1M2fr+NR8D0QX
         ZB2HnWsblwLp82DduO1VW7Gf4t63fCYTy/S35cWx3JXTOgwFucXOXnkJ67ruMOjtxgNI
         97u2Wk1Rb0uPTbFpwhUS/4ydszpzBs+MgHg5bj2/LjgGZj+5QDIEzK5Gkq2bFFRQkMlL
         6+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dnEOn1mC1NQNiRRaMsSZyymmcEfa5G6V1qN/15a9UQ=;
        b=aQulAX0ccYVHSQarBkmrAKTggwr8ZGPK0BsEi5En2bj9oBDXGbYMc+GMnUpflvKfSs
         TYot2DTf455WGNkFtvq7/+E+0qs+WJbaRPqzNENpzLSVNMv+0XsRr7TTOjOSfi75lwwC
         Y3hdzFpPnz4e+6twtr4OS0w7cQ10GPZGxxMAHY5fxS2BxGA7mIOjFg3hucgK4PIylsm9
         snQsOO++z0MpzvNg9NFPdaqFpzQdLODffC3kGl0HFildMicHecbTTZNe58xDe3+ETpLS
         JKhng0pzUbDqHhZRB8W5ZzQWUmcqUQH+wSBmYsnXbPLS/5iQceYltzCpcQphm6fNEmPi
         nklQ==
X-Gm-Message-State: AOAM532gAeSXnLJHHb8u+LNP33dDjzAppE0bMUTxGv3BREQX8RUxL4hZ
        IfkUayLb7bVkdRG5LXdlVKyD6UXZfgep1F4Qb5lajfqHvv0=
X-Google-Smtp-Source: ABdhPJzN3pVqGwcR4vRi218vGlOqSjc9kF4Vh5J6EPiCGi91K5VKP4xOZeqaWmkwTnRhe/zkk8mKg0GjthCz3mecVcA=
X-Received: by 2002:a17:906:314f:: with SMTP id e15mr50797272eje.658.1641566950552;
 Fri, 07 Jan 2022 06:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20220106175019.3116389-1-festevam@gmail.com> <Ydc2EHf5f12w4YcW@sirena.org.uk>
 <CAOMZO5Czbr=vuvZdqc6+odAQv0M-LJEQVz6uke8OXnoG6wLqwA@mail.gmail.com>
 <YddLe8cCvj5fVBTQ@sirena.org.uk> <CAOMZO5B63zHEiZc-Z1AR8za6eWXX8y0wbYLmrVkXC85ewFSqbg@mail.gmail.com>
 <CAOMZO5DQEEHYJHv08nC=uYXbFtL9VTAatNAB8V5D_JHiQ0q=3A@mail.gmail.com> <Ydg/tOqbeT1Cg6sh@sirena.org.uk>
In-Reply-To: <Ydg/tOqbeT1Cg6sh@sirena.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 7 Jan 2022 11:48:59 -0300
Message-ID: <CAOMZO5AJy7arJM9v9A6n84k7yzWEoBxX5zTakK50dL6obSR6WA@mail.gmail.com>
Subject: Re: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 10:27 AM Mark Brown <broonie@kernel.org> wrote:

> I would have expected this to be prior to the call to _init() rather
> than actually in the call to _init() but OTOH this should work fine so
> meh.

Yes, I can call it prior to _init()  as you suggested:

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 21a0c2562ec0..f7811641ed5a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -647,6 +647,7 @@ int regmap_attach_dev(struct device *dev, struct
regmap *map,
  if (ret)
  return ret;

+ regmap_debugfs_exit(map);
  regmap_debugfs_init(map);

  /* Add a devres resource for dev_get_regmap() */

Will send a patch shortly.

Thanks
