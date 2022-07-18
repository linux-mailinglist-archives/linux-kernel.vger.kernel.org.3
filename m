Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D36B578A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiGRTPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiGRTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6F12F3A9;
        Mon, 18 Jul 2022 12:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25B91616BD;
        Mon, 18 Jul 2022 19:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5489CC341C0;
        Mon, 18 Jul 2022 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658171750;
        bh=ivffnQS2mswQoB5NrsbpXchrpNQcGZflHS3nnPcl5MY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m7ytv4rl0pplcivw1k7CURCkzP6fBxodsrTF73vTIStFmMTvf3N2wnCi6a5qM/DZD
         ulQC5apEEN1aBD9Ft7U5u6QJ1Y4f2xDIPzYEAN69q6QOZSWQmcqesNQi1mchg2GM2H
         V8ClfaXQiSzgwX8ZsZjSk27aqEtqPXw0ZqYDPagennsXQNnKp63ImBJufiB9TsUZ8X
         HmxU7umMjXjUyfF6M6re65CL92yHE/a0Bss8d1uMNJ9vKOnZ365B/3rAwrb6Yw06gg
         5/MjMj38PZ97YKhuV8fOcV9Dk1nqzD83YjsegYs6Jh72B2twA3KN1HZuokAQwQS6z3
         sROxkfxq7ZA0A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220713212818.130277-1-bjorn.andersson@linaro.org>
References: <20220713212818.130277-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2] clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Mon, 18 Jul 2022 12:15:48 -0700
User-Agent: alot/0.10
Message-Id: <20220718191550.5489CC341C0@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-07-13 14:28:18)
> When a GDSC is found to be enabled at boot the pm_runtime state will
> be unbalanced as the GDSC is later turned off. Fix this by increasing
> the usage counter on the power-domain, in line with how we handled the
> regulator state.
>=20
> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain suppo=
rt")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
