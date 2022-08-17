Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174FA596C16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiHQJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiHQJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:30:38 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54315A824;
        Wed, 17 Aug 2022 02:30:37 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id cr9so9956458qtb.13;
        Wed, 17 Aug 2022 02:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5akdc5q8OTZh41BRXQ6ueXN+MBAsEQyZP/YjElcO8FE=;
        b=Ao7etct2jPsOO6PHSHBf0/De4GNGHNC1bzQ5nRNc2NcckuB8eHOjbjOn106RFG4n0e
         sr/3OiQ0K1aP2/yqq+KAw3MuK+5GJWK5YLCjS2tNxPFx8TTKo9w33snG1KliXjzLOHBK
         V8xKGtQrCO6K8NYB53liZKyFaZnk+jFkjvrA3CvezN91/gq/IRktigfYeenszRxFGAuv
         avONSN2ogjDNgrCzpUEAFj1V49hd+nYQZVDAK3/T/qCJn3erNw3fcjZXyXB+MdUSYmHR
         cK6D6/zYxtQLvunaRRRA0OExkWj5uwLIhtyRnsjcfg6l1ptLgU2V+bumJwopRj02S+4R
         ynSw==
X-Gm-Message-State: ACgBeo0XGvpPEqk+BpYRCERozo9LPRlSI3XOMXQkR4N94UE+Su1GUvN5
        +LO/YW1xj6MLet7lEjYF7d3P6zOiPyOQ7A==
X-Google-Smtp-Source: AA6agR75wkMzjymVQi/umHde2bRdVhNH/oEzu2yj9HscihiWd4t6QmZZ1rv75XG2KZ6mQ4kPLbYj1Q==
X-Received: by 2002:a05:622a:1116:b0:31e:d8e4:ac30 with SMTP id e22-20020a05622a111600b0031ed8e4ac30mr21796777qty.660.1660728636684;
        Wed, 17 Aug 2022 02:30:36 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id l23-20020a37f917000000b006b97151d2b3sm14056322qkj.67.2022.08.17.02.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 02:30:36 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-32fd97c199fso191646627b3.6;
        Wed, 17 Aug 2022 02:30:36 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr18433198ybq.543.1660728636000; Wed, 17
 Aug 2022 02:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220816174150.GA2428940-robh@kernel.org>
In-Reply-To: <20220816174150.GA2428940-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 11:30:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWgfGgNGmj88z=Md5RAL8CHxTKj6ywsGwS2HN-vHKMq+w@mail.gmail.com>
Message-ID: <CAMuHMdWgfGgNGmj88z=Md5RAL8CHxTKj6ywsGwS2HN-vHKMq+w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Rob,

On Tue, Aug 16, 2022 at 7:41 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Aug 15, 2022 at 12:17:08PM +0100, Lad Prabhakar wrote:
> > renesas.yaml lists out all the Renesas SoC's and the platforms/EVK's which
> > is either ARM32/ARM64. It would rather make sense if we move renesas.yaml
> > to the soc/renesas folder instead. This is in preparation for adding a new
> > SoC (RZ/Five) from Renesas which is based on RISC-V.
>
> Please post this as part of the above.
>
> bindings/soc/ is just a dumping ground for stuff that doesn't fit
> anywhere. We've mostly cleaned bindings/arm/ of that, so I don't really

Note that the target of this move is not .../bindings/soc/, but
.../bindings/soc/renesas/, so it's a bit less of a dumping ground.
Perhaps this is also a good opportunity to split renesas.yaml per
family or product group
(renesas,{rmobile,rcar-gen[1234],rza,rzg,rzn,...}.yaml?
A fine-grained split may cause headaches with RZ/G2UL and RZ/Five
sharing the same SoC Base, but a coarse-grained split keeping all RZ/G
(after all RZ/Five is part of RZ/G) or even all RZ series together should work.

> want to start that again. I would propose bindings/board/ instead if we
> move in this direction.

.../bindings/board has the issue with the same boards used with
multiple pin-compatible SoCs, SiPs, and SoMs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
