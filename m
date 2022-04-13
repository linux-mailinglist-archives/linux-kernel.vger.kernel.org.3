Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440E54FF873
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiDMOG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiDMOGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:06:25 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF5606D8;
        Wed, 13 Apr 2022 07:04:03 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id bb38so1415799qtb.3;
        Wed, 13 Apr 2022 07:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7k2FVqabmscQZ4JxpUNIhsQJ2p2uLnZJ6vhHbip+cU=;
        b=KGROf9msqOAvoydijjYn0VeidPRRedB/mo7EKuZx9WddWEVkh6gcf5ZRP+JZvJQb8G
         ZHI6cTKJfrNVuFYU4TJbMSWEKOGcvWsplxtc4FheLwN5mEkvS69N15S/z4qwmP4hEZiC
         bV+Fv+iJb9/vGDY36zCF8Ejyk+I6VbGaOq1UM47MOfTZFCSg6A6Dk2osSgihd09YY8CM
         GdOLwh4aZBJgXxDL6R4tJ9sLuPTQm051klLkyDMFomQXwJvdsd4GdLfZ4LdIHIl6kuxI
         trcZiTGE+6xfvyBdo1c/ElAi6c2DuVJkGTHFN6DAgAxa/R8htPw8sioheuFOZ/JJ6V54
         WTYA==
X-Gm-Message-State: AOAM533miyLkFAmL9cPGgfK7yu7O+y5cJKuVgQd/RKJLvUOjnC3XRf7E
        3N2dOW4+8kM89HiccqilmzXhH0uWsyACIw==
X-Google-Smtp-Source: ABdhPJzFfqZxfkKVX8TcauCZOe9gFqky0Z+hrcHzsfRU6bBeQWBcHpU7IBNZyqZHc9HR+FgmZU5iMg==
X-Received: by 2002:ac8:71ce:0:b0:2f1:d5ee:2f6 with SMTP id i14-20020ac871ce000000b002f1d5ee02f6mr420809qtp.56.1649858642117;
        Wed, 13 Apr 2022 07:04:02 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id q8-20020a37a708000000b0069bf1337047sm8737536qke.5.2022.04.13.07.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 07:04:01 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id q19so3910757ybd.6;
        Wed, 13 Apr 2022 07:04:01 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr29615442ybq.342.1649858640966; Wed, 13
 Apr 2022 07:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220413140121.3132837-1-robh@kernel.org>
In-Reply-To: <20220413140121.3132837-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Apr 2022 16:03:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQK9nQF==3Zg8ikwNfQc=F6gHXabvPCxaKprPMoMO+7A@mail.gmail.com>
Message-ID: <CAMuHMdUQK9nQF==3Zg8ikwNfQc=F6gHXabvPCxaKprPMoMO+7A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix array constraints on scalar properties
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Agathe Porte <agathe.porte@nokia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-hwmon@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-iio@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 4:01 PM Rob Herring <robh@kernel.org> wrote:
> Scalar properties shouldn't have array constraints (minItems, maxItems,
> items). These constraints can simply be dropped with any constraints under
> 'items' moved up a level.

> Signed-off-by: Rob Herring <robh@kernel.org>

>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml  | 2 --

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
