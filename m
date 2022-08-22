Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475559CBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiHVXHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiHVXHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:07:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C87F47B95;
        Mon, 22 Aug 2022 16:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02AFBB81981;
        Mon, 22 Aug 2022 23:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E18C433C1;
        Mon, 22 Aug 2022 23:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661209630;
        bh=kAspNdepd+GVZ8NTWSv69oePbazqAdFOK5zbykqYEM8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ez8PVrEcNObcVAe8En9do21wO3qIzUj21gPTTmnLGMZLNSW9EW1DzCkbx5R5Iqe1P
         swR8LXpq8qjAs2FJwegN73/9jiZqwz4+lCilkQ0eAeAW1xss30hb/tQ16+NB+7tVi7
         U6+7BqF8KZkvR67UEZI1p53j7xO5uY7c5yyY5Irw6L70Q514jCdY1MGqS0+I/uVVZA
         0ZYRPU09hymvqUoxsFI6Cw3onvijHLRARIR4eXeixEXCcGhLdRMCiZWtZLfCErFiwL
         uQoVKhWCXDg96e053yJurHRmmrJYtD7TF37SUCom1PDKmJzxh8ab0EUgfpgo0MZnLU
         pJEDRFd6eWFuA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220613081632.2159-3-lukas.bulwahn@gmail.com>
References: <20220613081632.2159-1-lukas.bulwahn@gmail.com> <20220613081632.2159-3-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: Move versaclock.h to dt-bindings/clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 22 Aug 2022 16:07:08 -0700
User-Agent: alot/0.10
Message-Id: <20220822230710.85E18C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lukas Bulwahn (2022-06-13 01:16:32)
> Most of the clock related dt-binding header files are located in
> dt-bindings/clock folder. It would be good to keep all the similar
> header files at a single location.
>=20
> This was discovered while investigating the state of ownership of the
> files in include/dt-bindings/ according to the MAINTAINERS file.
>=20
> This change here is similar to commit 8e28918a85a0 ("dt-bindings: clock:
> Move ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
> ("dt-bindings: clock: Move at91.h to dt-bindigs/clock").
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Applied to clk-next
