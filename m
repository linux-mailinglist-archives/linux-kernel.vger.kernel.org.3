Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3354C461
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbiFOJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344055AbiFOJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:11:07 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A000D1EEE6;
        Wed, 15 Jun 2022 02:11:06 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id 68so8244902qkk.9;
        Wed, 15 Jun 2022 02:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzuzNj3cCEjxWnQR4aBrGmsmoYEYXTl1hettMgyzjzA=;
        b=YI05pBCixSzZBIyVUbC7Dd+txjlFAIvNixYy8Axk9a4lvS14lKGjFh3l8CY15IwqPF
         SjiWWiEDh6+q/4JvBc+rrDUdVUiE3VgrXplapycOFzyDjUYXwvfGxforrlUI62XJ4u92
         uRquyPaK9HFyKUrzl85HeQwzuXnnQI7uNn+RaPX41RT4+ySH8NsQTGMlIiE7/VT5QaeZ
         ZYwWTnd1u05GoIW8bC8URXXiFJ6NELp/Ja8B5AI+Qx9u4fdEJwOejxD/uakKcPzNlrOh
         HamzA8I0+xNLGNifQDRJF0YtjQCAO4/cnJwYQRUq55anDPxngtHRHgawU2XpvuKVW+Jc
         Hq0w==
X-Gm-Message-State: AOAM531GFoAxS+PAXmVzQr9LSG0mXPkI1bsYuaEL8f6bztVF2aPYsM0B
        3hc5nkjiZs4zpKBSUGiHXjeUsf9RS4i1sA==
X-Google-Smtp-Source: ABdhPJweeTcUHTr0iGazn5JxGX0pb0TZhYbxC1wdCDy5K4OnEUVWxKmK1HO1gwPPc7sY3/2gpf07Ew==
X-Received: by 2002:a05:620a:12ed:b0:6a6:b27e:a030 with SMTP id f13-20020a05620a12ed00b006a6b27ea030mr7222960qkl.659.1655284265553;
        Wed, 15 Jun 2022 02:11:05 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id bl19-20020a05620a1a9300b0069fc13ce20asm10867159qkb.59.2022.06.15.02.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:11:05 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id p13so19463216ybm.1;
        Wed, 15 Jun 2022 02:11:05 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr9584271ybu.604.1655284264985; Wed, 15
 Jun 2022 02:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220614193005.2652-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220614193005.2652-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 11:10:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWPz=areGSfTtSa74ubeUAMBtDmS+RyaX8+Uh8edm7eTA@mail.gmail.com>
Message-ID: <CAMuHMdWPz=areGSfTtSa74ubeUAMBtDmS+RyaX8+Uh8edm7eTA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: spider-cpu: Enable SCIF0 on
 second connector
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Tue, Jun 14, 2022 at 9:30 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The schematics label it as SCIF0 debug port.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v1: added alias

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
