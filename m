Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08155B463
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiFZWdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiFZWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:33:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C682DDD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:33:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mf9so15536669ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O51AM3Qzm9rWVB6oLrltcYSc31aaLTopfeRLV80m1Yk=;
        b=gDLni17NhALEi/hNiPzVgFRh7cP8zgvivg+f5FfBrWXKmrg1ZfqlR/dpgGsuvU8xyA
         s2gLamxDUBAvE4VWjcmMmB6LdzW0OqpGmPC6HF54CN/3jMjGSzbnB8bjcgNAQc/kNn6F
         uCqte+fPbMKqCp1KcHL13Kcclk3RWtO+ua/WreTkTN8rE8KiD8eb+Oqxb+1oWpWQ3xhx
         IHvYoKz6GnK3Wg8Lbq3T3noIe+fwmQ/glEBh58trPhABAv7X8On2N2Jgvvh5FqZsnAyO
         o1SMsqUi0da/Z3AJjmJImlmNXX5SkTkmUldE9MKCLp0a4EfXklkri1+Xg5EoFXL8unoI
         SxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O51AM3Qzm9rWVB6oLrltcYSc31aaLTopfeRLV80m1Yk=;
        b=33egtUuN3eVB0S6oNgmEQOjEZA7sPIwF6BEPBO/erwusM1QaKXmPNzn+bMOPsXPwxO
         2vsvox6BilgyvGR5IAAoDEvdzirCb2cLZdHHpQP3vTQZilYhNO2S5qjfW1AHWUgYcpF8
         unobX+P4x9lV0jnq/OUG9dMYJkJDNfmz5AUC1xCOT+TmPtkBYLofPdmbrmPoyBiEN27j
         y8rYu/Qb5UB7l9ijxHUemgMy+Ao/cP5CUrARlf193Ou0djXHGRiuj5eF4gRkQvH6yx0L
         SlvV5wk73B70l98lte+VF64i/XxlhrHXfBs5QyQGNz4VQ3TBuLKaVmsnUZx186su9NP/
         UDCQ==
X-Gm-Message-State: AJIora+YFfvwlQ43GcHuwTElU6cvcR1nCY8u5OI2LgtAbrMMD3bp2MMG
        yHFMz1FROfmmsQNmAivsNz7ygJPpASapd0zHNcA=
X-Google-Smtp-Source: AGRyM1uXR6Lm+Uqx2z3Aq3NI7bcB199Bsml3RGNzAeBEZ0KTVBjoaNUwUSrUDkKtwStl3kTYGYR3Bb5P7Was8WuQxGQ=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr9736344ejj.302.1656282822640; Sun, 26
 Jun 2022 15:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220617072723.1742668-1-narmstrong@baylibre.com> <20220617072723.1742668-6-narmstrong@baylibre.com>
In-Reply-To: <20220617072723.1742668-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Jun 2022 00:33:31 +0200
Message-ID: <CAFBinCDJmjpix6Y4yN8PbNUvJddEhwFjiLJe+zBLo9vN2oNbng@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/meson: add DSI encoder
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
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

On Fri, Jun 17, 2022 at 9:27 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds an encoder bridge designed to drive a MIPI-DSI display
> by using the ENCL encoder through the internal MIPI DSI transceiver
> connected to the output of the ENCL pixel encoder.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
