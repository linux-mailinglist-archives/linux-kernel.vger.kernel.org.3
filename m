Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77A555B21D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiFZM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiFZM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:56:43 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B5EEE23;
        Sun, 26 Jun 2022 05:56:43 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id j15so3330077vkp.5;
        Sun, 26 Jun 2022 05:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=wxBv0rqVkr7svlorve8lqrJrpCummteUUicpF5jJzIE=;
        b=cv8OBASz0uocJ83UXvnjAYusBwPdI+Bfw4CQgVdn0pt53xhorb/hSVTbHoO13KL3IR
         lL9u3vNojAet7kGl6SIDwP/CjMdh/wOfqKsJq+JjCb+WI3FVDelmvAuLf11KzMfm0IZ0
         aN+Z/lRytoTSw4QI3Jvx+bd/xV+XKGIzz09HSa+PcIappUnO7+sTXzH8RiCgAkWAOZvT
         58TIjt/g7inSaf8vSpIyDf6l0Na/08/j/HrSD4NxE9aUT/OjO0BOoHZT3zWU/dcPRBQV
         0fExs5uoOEu08IKXnnlJkIpRpQqQf+uHDtkJaPessLIjzk6ZRhxOGfSK2V2vcfWBHvOl
         V0Gw==
X-Gm-Message-State: AJIora8GBxTykefeSCz/QN2ydDNFgr4M86S85o9eRoa4NyRJu6iusxx9
        f41ewwcgW7GIjpPkSMQrern9wgsFK42dVw==
X-Google-Smtp-Source: AGRyM1vzk8B0AqTKqO6UYuKfseam6QK26cZXxpI2vBy4Mw4X861x4RsZ3jF/4xmfiWxIZKJ7BlHfpA==
X-Received: by 2002:a1f:b649:0:b0:36c:d23b:bc4d with SMTP id g70-20020a1fb649000000b0036cd23bbc4dmr2744123vkf.6.1656248202218;
        Sun, 26 Jun 2022 05:56:42 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id z11-20020a67f54b000000b003519349c5b8sm966156vsn.32.2022.06.26.05.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 05:56:42 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id n187so3317078vkn.11;
        Sun, 26 Jun 2022 05:56:41 -0700 (PDT)
X-Received: by 2002:a1f:5f8f:0:b0:36b:fdd7:7788 with SMTP id
 t137-20020a1f5f8f000000b0036bfdd77788mr3021927vkb.22.1656248201811; Sun, 26
 Jun 2022 05:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220621034224.38995-1-samuel@sholland.org> <20220621034224.38995-2-samuel@sholland.org>
In-Reply-To: <20220621034224.38995-2-samuel@sholland.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 26 Jun 2022 20:56:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v67fmRt6pxsFvzP7CWSVZMXEdFe-E6Q8Uy_GuyRVrm4xCw@mail.gmail.com>
Message-ID: <CAGb2v67fmRt6pxsFvzP7CWSVZMXEdFe-E6Q8Uy_GuyRVrm4xCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: gpio: Add AXP221/AXP223/AXP809 compatibles
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:42 AM Samuel Holland <samuel@sholland.org> wrote:
>
> These PMICs each have 2 GPIOs with the same register layout as AXP813,
> but without an ADC function.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
