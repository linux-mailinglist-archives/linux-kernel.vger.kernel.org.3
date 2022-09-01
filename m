Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9955A9417
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiIAKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiIAKRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:17:07 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB241992;
        Thu,  1 Sep 2022 03:16:55 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id d1so13089052qvs.0;
        Thu, 01 Sep 2022 03:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iFMVcT4IdQ5sgAT4Vpsh6IRTvv9s1H3TO8+JQ00SHhQ=;
        b=cWmK99T34xpyBKRawfAdzNrc/njM/AgeSqii2aKxZ5iuN9dJ4CtdwP3fdumGicUaNN
         uvZNI1retDQG3wdNMmkBSvg6oqhHq5+gvjeKR08iz3lVVx2h6CCBwpIogv0S+mMvZnQg
         mlZQzbDEzA+Dk42RS0cKZhwyVWBbwTaVyWX0wfrfIDVB+lkaQxpcIJxKXd5XEvSvnmvy
         e/4Oh5CsBsrmiN8KRQ+Mr5t5LCWVpBYa1tS3DX9HkoosA3LN6IZGY4ffOz9s3+W2R+yV
         tIgNdqqA/AXtU6nd3b1R6bFz9wfBcQ3GJc8Etw9XwnstKfBe95toBFw7nbMGafU9X+Qz
         EwlQ==
X-Gm-Message-State: ACgBeo3BMpsCd33qbPvi4duZgpijUdQMuRAQgN+y+RTlvaHGHJXzc2iD
        1C9P8TbkBFNvGbsv9Orb8LG32ymkH49keQ==
X-Google-Smtp-Source: AA6agR7dXGdz7GVkhKPsjQWKRefzsInrURt53lCEwtR8koGum3ezBOHqIG0mVzJvHKkjnqQGqYEyFA==
X-Received: by 2002:a05:6214:500f:b0:497:9de3:3327 with SMTP id jo15-20020a056214500f00b004979de33327mr24077987qvb.23.1662027413169;
        Thu, 01 Sep 2022 03:16:53 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a284c00b006b9bf03d9c6sm12079995qkp.104.2022.09.01.03.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 03:16:52 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 123so7920448ybv.7;
        Thu, 01 Sep 2022 03:16:52 -0700 (PDT)
X-Received: by 2002:a05:6902:4c7:b0:69a:9e36:debe with SMTP id
 v7-20020a05690204c700b0069a9e36debemr15547199ybs.543.1662027412541; Thu, 01
 Sep 2022 03:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Sep 2022 12:16:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUKQZcKTJ0v4Rim2gbRMBOeUqN6w6GohXYJyi9mLicGXw@mail.gmail.com>
Message-ID: <CAMuHMdUKQZcKTJ0v4Rim2gbRMBOeUqN6w6GohXYJyi9mLicGXw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas,rzg2l: Document RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Tue, Jul 26, 2022 at 7:45 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The CPG block on the RZ/Five SoC is almost identical to one found on the
> RZ/G2UL SoC. "renesas,r9a07g043-cpg" compatible string will be used on
> the RZ/Five SoC so to make this clear, update the comment to include
> RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
