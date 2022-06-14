Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D773754B27A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiFNNq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFNNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:46:57 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D020421E21;
        Tue, 14 Jun 2022 06:46:53 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id d128so6375953qkg.8;
        Tue, 14 Jun 2022 06:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4e9YVI1qcHuboFx6XM8DW9ECXNo0yy6Zy9E+en0JNY4=;
        b=b0rHqZgh1nq2RMwd56UMKbapYHUzhjN8Qaw5xblMTgeUmQrMRUGArdwu2JL/Wbh3Wt
         cel7QO76YS4FuujNxizkZlffQtg73h5YdETVcqcNe5HMNJ7Yiob6zi+8Glwj0NYNbLP1
         5x5BT5BpjJfps5rrUHBLgdC3Ev5Vm+GD7/4xDqTnw/StO9le+jCVdtE2DciBHs0r7km1
         x2FYFsIVd6H8gk3sa7UTctHXQEfuhBRzIgqiOYIiexBnwknqmao7b33y/lsm3+Liersi
         UZq4GmPPXIO/OUkMZICFirMqmI5zHcW+nP8k5RZppOU7cNtF2uMOfmpMr/oxHdCkP+BN
         E2Ng==
X-Gm-Message-State: AOAM530zpaOdX2GaVcGa2E/BpJ+Ka3zJGzY/JEuXH/6TIm0gs+PomaVd
        h1CiQbvvW305UJAJWUOmP94rjMlSl1iRow==
X-Google-Smtp-Source: ABdhPJxwvRN9T5goLP0u05qzkiD1NCmBL3Xzr8N/NHL2Qh+ouxw+QmS5pC1FDDanU93lHDuKjZ3YiA==
X-Received: by 2002:a05:620a:1a0c:b0:6a6:d021:7be3 with SMTP id bk12-20020a05620a1a0c00b006a6d0217be3mr3817680qkb.667.1655214412740;
        Tue, 14 Jun 2022 06:46:52 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id ff24-20020a05622a4d9800b003051190886dsm6978489qtb.75.2022.06.14.06.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 06:46:52 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id t32so15177387ybt.12;
        Tue, 14 Jun 2022 06:46:52 -0700 (PDT)
X-Received: by 2002:a25:818c:0:b0:664:a584:fafd with SMTP id
 p12-20020a25818c000000b00664a584fafdmr5077802ybk.543.1655214412054; Tue, 14
 Jun 2022 06:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 15:46:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-UybcPx-XexQZvDGQopPYa2POYaxrS-ey+QWu3GBs_w@mail.gmail.com>
Message-ID: <CAMuHMdW-UybcPx-XexQZvDGQopPYa2POYaxrS-ey+QWu3GBs_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: rcar-gen3-thermal: use
 positive logic
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
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

On Fri, Jun 10, 2022 at 10:18 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> When handling the V3U/r8a779a0 exception, avoid using 'not:' because
> then its subschemas are far away in the 'else:' branch. Keep them
> together using positive logic.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Changes since v2:
> * new patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Tested with:
> make dtbs_check DT_SCHEMA_FILES=thermal/rcar-gen3-thermal.yaml

And dt_binding_check? Yep, it succeeds ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
