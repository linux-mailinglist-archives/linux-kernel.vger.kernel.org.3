Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8653D38D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 00:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349532AbiFCWRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 18:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiFCWRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:17:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904AE18382
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:17:29 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t31so16105656ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxzrEA8REDaWwoEI9SXIgLGpIqpF9GSswLISAQIrJrw=;
        b=i0f4i2hSBuOwU6Z41zZp12Xn6+SOGWUZoafYmhtlRSD81/YGKiB1a3m9qdHb90RuKw
         qVRQ9b2yETSdL7OWP0uGpezSJSoI1oKCTTrN4ZsFqGvUDpToHAVB4Qpv/GsVsDDF8Wx2
         eJQ0KBbU3MkUuanKZ+0Bs8ScSTt7loYEkVUyfdYbXrOLue05KM0lxYKXm6UJV4GGXRrb
         EX+zfLF3pDx5Llz75rqxEW7Y4X7BV+ZZhiCDfugMQiZ10IYeDO9mX9vNM1hSaH4NuRzK
         3K1yZswoM1W83g6r0fQRP4EgkK7wT79byzWjUbX/MRrrqbb9CW5UNK08uOiKje6SRTOw
         myRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxzrEA8REDaWwoEI9SXIgLGpIqpF9GSswLISAQIrJrw=;
        b=7yyXQ9Fw+oj4TNmiBwYSTk0qc4bUkvFRdqBfLBmM5jS5fxiiZOTz7gmiu8POiVeTws
         NTJy7vd1ECkUeutDwkH5YUyfDTJSBqRsXYKGla8kcwxeeS3lsctv38dxE6fS/2lz+FYX
         NhKIdHIjVjJb2prZRIw18oiF/IhxR3fzZWt00Esl+ETQJgpKOeaZ8OPipgz14XGeoDjQ
         zpWC+HptO4NNJtFVkW1b4534oaudujUvjOqyDIbZRvv1YyXtH9jXV5OlI4m8EI2NUE+B
         HUfCY/n7OTfXlj44t6qI2kYpCLPTeeBRnMZW4TFsBQUoMCXzgLEnsIrE4aq64K9x1l0A
         vUTA==
X-Gm-Message-State: AOAM530y61xWzOJZvDZrSy1laJBj6dgSpWZDM0EFu2lh0o3YqJ10mrH4
        RCRE/cM4cakQReglXz3qIytI/M122015JktGhWucc9E5UBA=
X-Google-Smtp-Source: ABdhPJwY0Fv0WkN3GP24DF4ef8lrbyIIqDa/jyBs+8pVca4YN0rLWkYrK6fB3G72aScon/VocRlxYEWULbwUdPCqnb8=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr13248417ybp.492.1654294648626; Fri, 03
 Jun 2022 15:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220526014127.2872254-1-robh@kernel.org>
In-Reply-To: <20220526014127.2872254-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Jun 2022 00:17:17 +0200
Message-ID: <CACRpkdYRumCbt4tQs2+KeMdVjEt07J=0hAUynTHKeQ3mC1o5kQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: faraday: Fix typo in example
 'timeout-sec' property
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 3:41 AM Rob Herring <robh@kernel.org> wrote:

> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples.
>
> The correct common watchdog property is 'timeout-sec', not 'timeout-secs'.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This kind of stuff is exactly what we wanted schema to find and fix.
And now it is delivering. Success!

Yours,
Linus Walleij
