Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C0559EE64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiHWVpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiHWVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B765B05C;
        Tue, 23 Aug 2022 14:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900B3615E2;
        Tue, 23 Aug 2022 21:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58D2C433D6;
        Tue, 23 Aug 2022 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661291126;
        bh=X30kn0j1tf3o9w7U/F06rH85HS3GWLWJ8x42GeFSqQ0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TMEBwYImcn2yuEmwMv5wrYVjwBQpennI4DII2IiypmekKj0VwDJBQPh7mrNilyOR8
         PbqrdYD0/WOiesY+mVqhdRb/bsyqDiLEyjMXZeKt0PIMYOzHCrQc+aXujxijpzPgiZ
         oBAjBk1yNyjNzacHK8ChplPBUzLKli2YGnr2ve7WH9WL0taZKKye9W1WI0KcA053EI
         R6u3aIsk5eHqBbGqywMiNBZVPYF4bLR3WTimxfHuHboQAOfzKbdwLk1NFFbDADl4zS
         d0GB6WnXm+XC9Xss1xjT9F68pkc+uoRInb8j/daOMPhcIPh1Nh7bA8luYhUO7YRPTO
         aSiQPRFwDyTfQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220823073154.359090-1-krzysztof.kozlowski@linaro.org>
References: <20220823073154.359090-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] clk: samsung: MAINTAINERS: add Krzysztof Kozlowski
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date:   Tue, 23 Aug 2022 14:45:24 -0700
User-Agent: alot/0.10
Message-Id: <20220823214526.D58D2C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-08-23 00:31:54)
> Add Krzysztof Kozlowski (already Samsung SoC maintainer) as Samsung SoC
> clock maintainer to handle the patches.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
