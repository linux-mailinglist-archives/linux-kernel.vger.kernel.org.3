Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8B4EB6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiC2Xue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbiC2Xu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:50:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2182BCD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:48:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lr4so29781275ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjRkKcTIdEtSJ5qdAlFxYDjytEDuq9kJF/JdJHhM/W0=;
        b=Npg9tE2QGOUSet55NeMISOUe/KIPJ3btjDh/22dgXKu1PpUjyv7Vk4Y/oRPiEkY82w
         hcBWY3k/GnJzyqfD4xQV4QmOaihQ9S571CWdWE6Cu8zWij4iaT8ZVKe3C07i5W1s9yHA
         u4s+WgscKOGxKTYoLeUTkD75HZzK1F9xtclR9/zvyzyl8m6FfkdAbAJxj6cFf3Qy5Q6y
         BCC2yBo3UCRTBxjsP+uR8EWlc+sD8rIIGt0T5lBt4cOWoPSu3m+SUniVC/lX0MAT5zCl
         k6YdzBgp18h/6qfbpOIIuQ9CDuXGv22P10E/2zK5bCpdPdeAZVEvspBdUAunRZvcM3Wm
         mI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjRkKcTIdEtSJ5qdAlFxYDjytEDuq9kJF/JdJHhM/W0=;
        b=avJXFYxdMzijMRhX4pH15oK4njhxehntCLSe8bms0KEMHWxPnmhuyuKhXPaa12Y1n1
         OUC7vbBsyzhhXWf6/4QwQtAqs9qBRdCBcvFjXQNEGZOVab0uQxVExPFcW304ynMKBdRV
         GCWLbyXYHyxS5Gy374ojd4BdyCVGBkGjsAYkCrF4WFSvHrfWF2J6+U7qYMSiYTl7j1xW
         98I19himAo5VnQdXK0JGe/yxTE2uhI4+5rNgBNCnZckpNjq/omkY+OK7QquXnZNa/hZD
         T4zzO1V9c/HjNp/UH1wYahoas70qKShyXMxgl/VXgfjF2pwDKX0RdcIjGO8XX0yIYSY9
         xFHg==
X-Gm-Message-State: AOAM530UTPPYdczmzWVWN8evoQIt66k8HJlSQFS5XWGbEioKB/z0ufso
        /SXViav6Ziv5orp5Ujc2JWU+gbe7cJe4HzV5/103Bw==
X-Google-Smtp-Source: ABdhPJzx3gWELIECgfbIZ7X/BnP3w6wKOVDzcjJ3/ACk+h5YKfJf8FHobuoDG15x3ba5Y2mpQHNA+QM/IqRkoW+athY=
X-Received: by 2002:a17:907:1622:b0:6df:d1a2:d4a3 with SMTP id
 hb34-20020a170907162200b006dfd1a2d4a3mr35877982ejc.542.1648597722027; Tue, 29
 Mar 2022 16:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com> <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 29 Mar 2022 18:48:30 -0500
Message-ID: <CAGS_qxoEZmAHVHQHJsnaALXmmODQono24qLbQr98FKqRUXmCNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: dev-tools: Add a section for static
 analysis tools
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     corbet@lwn.net, mchehab+huawei@kernel.org, davidgow@google.com,
        linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        dan.carpenter@oracle.com, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 6:22 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Change log:
> - Brought generic tool characteristics to the intro paragraph
> - Made explicit that these tools run at compile time
> - Added a note of caution about false positives
> - Updated Coccinelle info to make it sound better and be more skimmable

This looks a lot nicer to me!
Thanks for doing this.

Daniel
