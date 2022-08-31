Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8735A8134
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiHaP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiHaP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:27:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD86D7D2B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:27:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kk26so29071607ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=x8FJmt7wp3PvGNCLKViqYVQw5hHd5dJ4MBGNxXjX41M=;
        b=JbA1a8+D7PENTWZsG96Pg/isb9YKP2i+tHlAZFscc1BsQKJwT8hrom/cUkdoM08lMo
         0tDGu2/VwLlVij8AJ875AL9yZK/wSC3YIrMSzoBeM+zBF+yKY72MOOvBY7bcAw/5IdGn
         mXkCbjx37RtycfmRA4clnC39FDbHSqZIbUR477Y3v4GujY9PubxhRrsIPNz/AbfqwrBB
         MU8WkWQvDNZobuUnSdFtEBI6+PzCApkJzBoKqerpDEeIgLWXNTawqtU/42kUpAtOnfYP
         gMJh6Wyq72W9mCxX6QZ2ZvU8yQb6VD2RoGFBWXroqRI3yTOYWVkOGfq05+e43NkiwSco
         NF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=x8FJmt7wp3PvGNCLKViqYVQw5hHd5dJ4MBGNxXjX41M=;
        b=ajICyHm/n3L2G/XIaMgyq9IiSPt45ysUZNaDw8KKuXV+fZoNoq2OHHtIR8cWbSAdVM
         qRKUTWB4+RN/57Lu5kSGmRjzU2d+LFtVn4bpcTT/xFFiVTpyAquBRjOzknNrfH05EyFY
         /IM4LTtBbX9MOB0jYIGp15QdbdHcDCEnkqp4JU3I11VGJCL6if6z9DsM5VVDXuGuDzHR
         2uL2k5aH+0qfAmP4m9bpFRdDNVOMMSrs+EyUxjwR/YbBylxKkr8l5dB8FuIzcDnXJwGz
         cP0rk6ZO1RyhhFsn2/0dwg36pxze5lgKdFoEsJu714ym7k/KN8+KImTSFFY+Qxp8kKr1
         /NKQ==
X-Gm-Message-State: ACgBeo09miRUXTV7neSjmN5CrUzwGIEzlVCyUwuta8PZuR7LTaqvYhtA
        kpL8kQPZOJIQnw/mG5p8vKqp9S+EmlvxxuL5l9bV7+OeVTU=
X-Google-Smtp-Source: AA6agR5MfMtj/v1v7FJ13/iWi4aYgGVGRE9Bvs7PrNI+IjoOMswTCHa6aQGHRNoai3kCWekbbogSudeWywj3tpteQy0=
X-Received: by 2002:a17:907:9816:b0:741:89cc:af19 with SMTP id
 ji22-20020a170907981600b0074189ccaf19mr10685864ejc.492.1661959643184; Wed, 31
 Aug 2022 08:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220819072232.8105-1-brgl@bgdev.pl> <7h1qtct8sc.fsf@baylibre.com>
In-Reply-To: <7h1qtct8sc.fsf@baylibre.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 17:27:12 +0200
Message-ID: <CAMRc=MfgEbNAXSz7Ft+EmNqNv5Mz6JhQSExyG8Oqit3PDjFFxw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: make me the maintainer of DaVinci platforms
To:     Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 7:58 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > Sekhar is stepping down from supporting DaVinci. As it's quite low-volume,
> > I will keep maintaining it.
> >
> > Acked-by: Sekhar Nori <nsekhar@ti.com>
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
>
> Thanks Bartosz!
>
> Kevin

Thanks!

Sekhar: whom did you send your PRs to? Arnd?

Bart
