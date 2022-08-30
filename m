Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF0D5A63D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiH3MsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiH3MsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:48:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FBD12F55A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35B7BB81B33
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E0C43470
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661863686;
        bh=/cAJwBHtM/ZURW3cF5eFVB0hZFmtk7GamSbxXq9JtWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=huSe1YohCQxf4H7e96UWv5Mjs28frLHyOt4kUHnkbsTPI9PHdVXBA90CE0nVX/bQE
         6+ROles0scsg9L0csQEvv9KqOo6vcHjhicLtcimIyF63rlJl+cYcd2YknRk6WvSTqy
         PQNB5BZvnI14eeJK/Lpk9Hyabjfj/6PBLls8VayuHXnmX80FRVtVH7DikPGiIW78/U
         hXh4CSbPjXHRTH1eO1fJbEb0afdIrPxKvrEfkiXg1ZiJYFeT6qNFWxNog4gyugHIbk
         8oGNDGLRR0r0OfKO40aejhv9Hpk0vDX4JqAJ4A6XG/b4U6qhZkP41DIVWR+9caYYD/
         n8G50TLq5B5mQ==
Received: by mail-vs1-f43.google.com with SMTP id f185so6556654vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:48:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo23pS/Yaa2H9aLo1+I+UH1H3kibgoVwmdUtEYbVTzO5XFKeb2YR
        YpK80xdpiRDia0aMhL6amHRlUnVIaFJBFqLieA==
X-Google-Smtp-Source: AA6agR4BFxbKvuMHCS56CHge6iE78gvzzPulVJJ1K3ptPrTy0eibGx4WI+E7FOdKqKeTEMm2IWkL3Jc05bfWSfSp3QU=
X-Received: by 2002:a67:b808:0:b0:388:b23e:8395 with SMTP id
 i8-20020a67b808000000b00388b23e8395mr4860489vsf.64.1661863684738; Tue, 30 Aug
 2022 05:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220829062202.3287-1-zong.li@sifive.com> <20220830083606.1681385-1-ben.dooks@sifive.com>
In-Reply-To: <20220830083606.1681385-1-ben.dooks@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Aug 2022 07:47:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKo5puQ-nE=G9YPon2xFb7MRX5GGj11YPPjnbRJ3yVX6Q@mail.gmail.com>
Message-ID: <CAL_JsqKo5puQ-nE=G9YPon2xFb7MRX5GGj11YPPjnbRJ3yVX6Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: sifive-ccache: fix cache level for l3 cache
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 3:36 AM Ben Dooks <ben.dooks@sifive.com> wrote:
>
> With newer cores such as the p550, the SiFive composable cache can be
> a level 3 cache. Update the cache level to be one of 2 or 3.
>
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  Documentation/devicetree/bindings/riscv/sifive-ccache.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please send DT patches to the DT list. Resend so checks run.

Rob
