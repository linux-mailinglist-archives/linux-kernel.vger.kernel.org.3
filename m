Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3411C505C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346247AbiDRQfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiDRQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:35:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94DF5F50;
        Mon, 18 Apr 2022 09:33:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g18so27753272ejc.10;
        Mon, 18 Apr 2022 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6NnvxV5qL9NnGjNNDDtELj+QJhJNh9Ym27WGbOtR8U=;
        b=Q9WVjDvc4iq5YNDF9pKm+fycSlar1F1EPKpzbiYdwmDBp7qFkzQX/h30+dzyQE5EOf
         pgtSROIN4Ug90VBYzTA54EhL1lB1pB7rCYiibxhA8HyzmulCH4VSXBk2iomAk3gc5I8B
         m5tGz2z/wpAnC6GeLN/+EMID9AYgeqggdwXQGByPacTJFDW3KwM0+XW4Z7rgcZaVOK0Z
         Z7qWXJGDT3ilHpmB02naFOrHtgUMG9A2bKYNc1wu9wca23pUm4naNjCnyOfJCZmDa2F+
         85aT7HCcQfFr8roAn+B5sRL75fkg5v/cm1TNQAFVaRtaUAFBz8kriOeGuqHq2pSOCY5e
         FS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6NnvxV5qL9NnGjNNDDtELj+QJhJNh9Ym27WGbOtR8U=;
        b=0kShC5DbTLO87iuWdUFKA4Oc428PMHaL+AYe3mKcaLMSUbJxaECbIiiqhMpGiCKAZs
         nmTrLJtUcSeP6XKoim9QhRLA0WwB5UljkLIfCZp+RhUNlkCOaav0SX/wQGh4huC6deM2
         AFMQNJI3u+hqn8tSmRJa6iPdrfs2av8FNYYJEyyi60ruNS0bwvReMFbGF3MTQ47RY6T3
         plt8sDkdo4x21THqvWNAt7ygYyWisXWtFnuDxyI73W5cJlW4ObZ08JftYU1sSci7nb9j
         YRFhRWzkyFL+anYYW86ABS9JV93cPxWeFfLBjr4+a7JYO1a77d4O6A5aruFVFGbRF9eE
         cMmQ==
X-Gm-Message-State: AOAM5321wsvMfYXrAjL9cRkQp3h0XQUWPNJeeXopDNiJNgx1G7bJMcIH
        QC4zQH+JUTOYYzQ7nc2innkcIxusXbJXDyq75po=
X-Google-Smtp-Source: ABdhPJzb62oRc+jDzjG130f9eLGOoW7V3FDFdb4f5pL/6iy13FqhFLtC3njnctFBpDljJp57BLrHvZPhmKucqvdz1Gs=
X-Received: by 2002:a17:906:6a15:b0:6e8:aa5a:f386 with SMTP id
 qw21-20020a1709066a1500b006e8aa5af386mr10374632ejc.649.1650299580303; Mon, 18
 Apr 2022 09:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
In-Reply-To: <20220407154338.4190674-1-p.zabel@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Apr 2022 18:32:49 +0200
Message-ID: <CAFBinCDHjxGKAQqZSaDGOXdMBeS+iut0RuCgkmezL0BJ3x3u1A@mail.gmail.com>
Subject: Re: [PATCH 01/14] dt-bindings: reset: amlogic,meson-axg-audio-arb:
 Convert to yaml
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
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

On Thu, Apr 7, 2022 at 5:44 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Convert the device tree bindings for the Amlogic audio memory arbiter
> controller to YAML schema to allow participating in DT validation.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
