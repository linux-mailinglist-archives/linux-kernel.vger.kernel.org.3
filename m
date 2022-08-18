Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE7598127
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiHRJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiHRJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:56:48 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44874B14CA;
        Thu, 18 Aug 2022 02:56:47 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id cr9so703657qtb.13;
        Thu, 18 Aug 2022 02:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WblwjE0ozAGvkxyVKtKYWCJ3rNKd/nqrE/2ZX5oPs6Q=;
        b=AfXxExT0chVP8BHh/7d+QRXcBf++mkGGhnuDQajIlPRRCqYmiGH20DHbrNLCV9Apmv
         P4E71s1450IwVb1CdSSx8VNVrys+uhSvIa3ZmMxYOcCq9ONnuwzO7X3RvYB/u1/D8ucU
         3ItqYqS5gNWpckxJ9QafLZhjk89j2JwdXldwFiE1x+TbD1Qpp3uCsSQyIgggj61AzkYB
         eDjKLV7MVpevD/KUN6QkRmQkUC2pyQlO6EAoQu0aazZLpQCqIRLGkL9fWVeQup9qUNd3
         FXoZsiZRidK/DKQMxueBWvdL3yjMDoqA1i1+MY215OY0GtGDfUHCJtVeaRmz/Ba3mTvB
         kbKA==
X-Gm-Message-State: ACgBeo2vSAxOZGDVRHzz3MRgKAE0MOZp4P9Bh0AJ/j2GIncU6UaY0Ia+
        Kr5IFPLPyrmjgJ838fumcn7tN28Vo2vi5g==
X-Google-Smtp-Source: AA6agR54RKvtxVEGMkLlhQoqZrMDJF+g5j7lf3t8qvKwh82oL/gQxgmhgNBaYqngoZhnJDrzccBU1w==
X-Received: by 2002:a05:622a:1454:b0:344:5909:ba42 with SMTP id v20-20020a05622a145400b003445909ba42mr1826117qtx.634.1660816606274;
        Thu, 18 Aug 2022 02:56:46 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b006b5cc25535fsm1136253qki.99.2022.08.18.02.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 02:56:45 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-32a17d3bba2so27105097b3.9;
        Thu, 18 Aug 2022 02:56:45 -0700 (PDT)
X-Received: by 2002:a81:1204:0:b0:322:7000:4ecb with SMTP id
 4-20020a811204000000b0032270004ecbmr2030815yws.47.1660816605419; Thu, 18 Aug
 2022 02:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220726205858.1199-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220726205858.1199-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 11:56:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkp6CGKzZkf_rx9OKwKbkecsyqEcMHgBhaVNFWhnCbgg@mail.gmail.com>
Message-ID: <CAMuHMdVkp6CGKzZkf_rx9OKwKbkecsyqEcMHgBhaVNFWhnCbgg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas,tmu: Add r8a779f0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:59 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
