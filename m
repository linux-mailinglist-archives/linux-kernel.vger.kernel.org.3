Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B7537254
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiE2TTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 15:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE2TTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 15:19:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EF56C0F1;
        Sun, 29 May 2022 12:19:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x17so3026689wrg.6;
        Sun, 29 May 2022 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ztQcdyrzloMjbqIddHmmicr8ARqs6zTnjkcVf2TU4I=;
        b=lZjEbcz5P5VLsqhwarIzO3bmV0L0rbhkAOTuhs27gAeZN0rdivc1naIZgpg5RLr0jP
         2foIfDWE1s3rQL/Id9cESnt78kPsjE+YrbhkdYDPvWf/jI1gcXIX/2TfQjW8r5mRfeBC
         fRw5PjKE46bGhgnmYX2ddS4ShozeO5WFv3wIRssT0zTsD7dbEOX9TD0O9BtsrKiKURWr
         pHxgFZAMqKGBpUlChO89Ap+czIbvXabealiPgWhyx6VQIXYlbZoHriYgmHiVOrYNNgjm
         dBu+uHViyUrhGlqTLkpzd3AiFNvq/S+22v/WcDiALV1yZUCNwQuAsDS/i2MjjTuLoKqx
         zoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ztQcdyrzloMjbqIddHmmicr8ARqs6zTnjkcVf2TU4I=;
        b=Qwtt9dzScqJqP3y3HQynZJp4YMR02Oy+vuW0OWfr+VgosZ6EGTo8+4zUiwHnZXYh45
         hwMQYGihvJ0VILWeWloFwpWJuqaIPakCOn4clP3bDupX3JFZsxytrF5JJu8M0/QlLIPG
         cCmK7nvw6SXOjmr+EzBwRDeMFnq0dtNSXOHb2s3U1rAOpfCviiPa1FXaQ8UNQvvFr++s
         Y6anuSkSynYP5r4S4Vpn7fWFc7FfTYm3rOM5Hc3ubhUF5PPYh7Du/zgq0Fjg55vw7OCK
         h3hf5KOBqkPVjVJh+MRrDjBxT9uFaPir9aSqBLLMoqUw8K7GhugJRf9m+Jn7wU5Zo/26
         pzMg==
X-Gm-Message-State: AOAM533juDnPKcTYY4JuPs0HUDaIyNskxWIBmsBMrH5xem8EQvjdd0EX
        q0Sq6VaYhcDugvv+DoPgmSI9gIPQkBE0mf59i/kFD6Yfkug=
X-Google-Smtp-Source: ABdhPJxJUW72TCf8hhpo0SFKrfjyWkvZ98QG5o00eQvgVLc+gRAu2Akxu+mFKrJ26n7cHynR4/W0tlJMAjP4z5QPWt0=
X-Received: by 2002:a17:907:381:b0:6fe:9ca8:c4b4 with SMTP id
 ss1-20020a170907038100b006fe9ca8c4b4mr44026736ejb.147.1653851957385; Sun, 29
 May 2022 12:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 29 May 2022 21:19:06 +0200
Message-ID: <CAFBinCDhyY-ebo-JT1gAPSn7nOoX7ZoePsEe-2NviMhyiDu+4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: amlogic: adjust whitespace around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, May 26, 2022 at 10:46 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
