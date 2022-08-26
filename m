Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704405A270F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbiHZLry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbiHZLrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:47:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62045CCE2C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:47:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sd33so2662979ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6I1saXwykcy6QayrIDGL5n32r08at8PoZmfVUTcYUCU=;
        b=X2Fmrrv3asyl2W5nL1jiASlsERZ0mKPSNWIwo8PhVQ45WlvZUrFHDb7DPqb1185Mcs
         0z0o4jS394BMi+2ciyqOriJzpAK9hyPDkFdSJ+F4j/rWXNPZNbH8Gf++gfvDCQVEGhdh
         inPE8COluT9LpiHfaQRCKs3roYaZF2h5piAg5xdW7HryQ5QQnfPnT7WsG0J3uPmeCSJ0
         51wdyeu4IXh9etE96mcyB4PYI1ykou3wh41TxquW8+FATgxjU5mCtCMio3g9oWQURMuf
         wqnndLhihzxwQouxqndndmbqYwMTdMPqf5hGRnhuzfvPHxYCXibzrWis6BgU7xfbajvx
         5zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6I1saXwykcy6QayrIDGL5n32r08at8PoZmfVUTcYUCU=;
        b=c2sBo6Eo9C/rAjd1NEjYbLBCeZ0ebMv09UhhFfhGWzN6QyQTPZF/MZAVzJShgDdGaI
         2XrFt8p6LDfWrIlUfM27yO0bEqIZr+/BQMG0aiCF7z6N9tjd94Hp6OK2yl115luv3xAn
         Grgnz2lX1Hfx/V0fXkmQw2WRRNzXoPidzhP+HvVQbJPBrTapkSaFliLrJC1XUCzYObAy
         6JjO3KOZO09g49ucsTpCs/MWqXpdGFDbPVZw6CihUJ5cy32c7r50Ycdzkm3s9dyTojUa
         5NCYyuR8OXXSnZJHkQT4gaXyYFFiSg25kMR2GR178a9VyXLTgYhIlvewaFtg04UNtwWD
         KUjg==
X-Gm-Message-State: ACgBeo0xINP/96o4iGAgBgkJ0VxsNmzPAzbM682fZuJG1lMP+RjdKgTt
        WfEuKDLBo255r/4OjPzSh2OVchr9rYJa5MB5pBEsYQ==
X-Google-Smtp-Source: AA6agR4b4g6N1PbpW7cvmvO/x0YA2aTRLqfpsYqXh165oRYCKTU2oImycDVfMp2rZsEx3rrMZIY2UqLFUuMUPdk0jWA=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr5381175ejs.190.1661514462901; Fri, 26
 Aug 2022 04:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220804114105.41326-1-wangborong@cdjrlc.com>
In-Reply-To: <20220804114105.41326-1-wangborong@cdjrlc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 13:47:31 +0200
Message-ID: <CACRpkdbh1W4E=aq=+pApiiBWhRyASuk4iHDEmu38xssht-4h0A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: nt35510: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
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

On Thu, Aug 4, 2022 at 1:41 PM Jason Wang <wangborong@cdjrlc.com> wrote:

> The double `the' is duplicated in the comment, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Patch applied to drm-misc-next

Yours,
Linus Walleij
