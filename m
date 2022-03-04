Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3904CD0DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiCDJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiCDJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:10:37 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4959D14D268;
        Fri,  4 Mar 2022 01:09:50 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id j7so3299200uap.5;
        Fri, 04 Mar 2022 01:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wwmuMoWRvfCtBBLu/hFltTlPEmL6J5ImpGm3gFZ0ZU=;
        b=hMcYxNurzCwZUxIZtZ5BS/vI+Fp1QCr2yfxdmQHWl5Sk14kPb2wrmnp/OSpwWB/2OA
         Kp8vqxQ54+Zpyg8NaKixXkObvxDRqZ5hIGxKoUYbKlFMRAVzvWUrag/1rS43C/viKOER
         kTjp870Bs0rAr4mJBUtE295bmu9RXi/+w3yQc82W5stJMoBAX2da75FthwuAcJlvCWoM
         Ywehz7qN5pvofORgO6yMbW8eP+C0UGZJVTf47bZJWbKuBuHERL61Jdwlt8AxaqiZYpbP
         uJ4htuyY7BzFwZlp3kCBhTdMONGzMk9I3COrpAWmJl5vRqk69AirnEMSju5jpa7JxxPQ
         nvvQ==
X-Gm-Message-State: AOAM531AA788NFMdzYTmOaN1Mg2r+bNFsitIKFj8CghYFof384jv7gKf
        rFov72dR4kI6MqeMhKAcmah2oyQBlXv/Sg==
X-Google-Smtp-Source: ABdhPJyiYSV/AfTujndsARMI806rKvOJUXDD2WYXjy/Tt8EaUNxroeTuh1wNo4ulx2f+YuSPmxIRtQ==
X-Received: by 2002:ab0:154e:0:b0:345:ecb3:3a9c with SMTP id p14-20020ab0154e000000b00345ecb33a9cmr15460364uae.106.1646384989351;
        Fri, 04 Mar 2022 01:09:49 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id k4-20020a1fa104000000b00336fb22af69sm16443vke.15.2022.03.04.01.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 01:09:49 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id k9so4057123vki.4;
        Fri, 04 Mar 2022 01:09:48 -0800 (PST)
X-Received: by 2002:a05:6122:130d:b0:333:33a4:52a9 with SMTP id
 e13-20020a056122130d00b0033333a452a9mr11085816vkp.33.1646384988811; Fri, 04
 Mar 2022 01:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20220301190400.1644150-1-robh@kernel.org>
In-Reply-To: <20220301190400.1644150-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Mar 2022 10:09:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXqsvQy_6+6w8DVCtqNiFERPV29xd3HRqtyz9RY3KXOYw@mail.gmail.com>
Message-ID: <CAMuHMdXqsvQy_6+6w8DVCtqNiFERPV29xd3HRqtyz9RY3KXOYw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas: Make example 'clocks' parsable
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Rob,

On Tue, Mar 1, 2022 at 8:04 PM Rob Herring <robh@kernel.org> wrote:
> 'clocks' in the example is not parsable with the 0 phandle value
> because the number of #clock-cells is unknown in the previous entry.
> Solve this by adding the clock provider node. Only 'cpg_clocks' is
> needed as the examples are built with fixups which can be used to
> identify phandles.
>
> This is in preparation to support schema validation on .dtb files.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Do you want me to queue this in renesas-clk-for-v5.19, or do you
want to take it yourself, together with the validation patches?
Please let me know.

In the latter case:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
