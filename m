Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2294CD521
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiCDN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiCDN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:29:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B2B0EA9;
        Fri,  4 Mar 2022 05:28:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08C9660BAC;
        Fri,  4 Mar 2022 13:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D6AC340F1;
        Fri,  4 Mar 2022 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646400495;
        bh=yZMqIxoqyeGa2JmenJnbSmIT9NyAGI/hqxTy1CFoDh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lMYeUu3Ws9N8vvpvraRsaPqc12QqDnuDdpFhgAgh6U14EL2zBZxbFEglqbsGpVWqW
         ZC7Hv8YM9e0M5rLQRi5pUovd4ABe/M+23v13aOu1DIOYU88jw2jjOGEOPlDAonN5yl
         I+wp8Lbe1CH7XO4XVRhx6emsfYhmsmXeMzN0OEKsHzVQRyAcQr4+qoiU7RMnfqExsA
         bmEvcvnPl1yCGJgLYh91UY4diYbSB2gjplY9ul06ku6Ha8pFzEae9DL7epsOCS0nWt
         bF9FehCKMGw2d6ml9amy0rmiFC5MhUO5zee8Kfnr9F02EPLT8p33z/MTFwMeQi5KVA
         gh3eIOodNiy8Q==
Received: by mail-ej1-f43.google.com with SMTP id r13so17527813ejd.5;
        Fri, 04 Mar 2022 05:28:15 -0800 (PST)
X-Gm-Message-State: AOAM531rG+Y+NJdezxq0J1P0/46lb/I0Sdb3JOknzz4Nww1GXgvdUhFJ
        dsdS0cQlhaChWsw8dyuEZxjCDInc8wn+J45bHA==
X-Google-Smtp-Source: ABdhPJwsWTMTO3mBwuIRNYj40OghtiEfA8WstnyTFMJABOxY4zGpEMxYQriLDSJixa8T80d/GM8t56a1Ea9fZRc0DOA=
X-Received: by 2002:a17:907:298f:b0:6da:b3da:19e with SMTP id
 eu15-20020a170907298f00b006dab3da019emr3088105ejc.423.1646400493372; Fri, 04
 Mar 2022 05:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20220301190400.1644150-1-robh@kernel.org> <CAMuHMdXqsvQy_6+6w8DVCtqNiFERPV29xd3HRqtyz9RY3KXOYw@mail.gmail.com>
In-Reply-To: <CAMuHMdXqsvQy_6+6w8DVCtqNiFERPV29xd3HRqtyz9RY3KXOYw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Mar 2022 07:28:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKX7XrSS1OktT6OfPgyxte6_+AcGh4uV0Abdf2Wi4eCFg@mail.gmail.com>
Message-ID: <CAL_JsqKX7XrSS1OktT6OfPgyxte6_+AcGh4uV0Abdf2Wi4eCFg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas: Make example 'clocks' parsable
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 3:09 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Mar 1, 2022 at 8:04 PM Rob Herring <robh@kernel.org> wrote:
> > 'clocks' in the example is not parsable with the 0 phandle value
> > because the number of #clock-cells is unknown in the previous entry.
> > Solve this by adding the clock provider node. Only 'cpg_clocks' is
> > needed as the examples are built with fixups which can be used to
> > identify phandles.
> >
> > This is in preparation to support schema validation on .dtb files.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Do you want me to queue this in renesas-clk-for-v5.19, or do you
> want to take it yourself, together with the validation patches?
> Please let me know.

You can take it.

Rob
