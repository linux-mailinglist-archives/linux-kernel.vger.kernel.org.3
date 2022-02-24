Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13E64C3850
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiBXWAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiBXWAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:00:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9CC2757AF;
        Thu, 24 Feb 2022 14:00:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6879CB829B4;
        Thu, 24 Feb 2022 22:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F5EC340E9;
        Thu, 24 Feb 2022 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740008;
        bh=ZvQnAZ1fi/BDFZMCxYv6D6GlGegwtmodwDChRsYPwxY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qcnHP1wXi3m4KJoMg7izpOu7FRwNQKQ+7TbiQYkyKBHL4VJno/MzIFZnod3I/fWHM
         Wm+9cTVPgM5KAIX44u20CgkelMqqEBuQmHs4nTv+EkeKnx2bx8gOQKYFJw/fGkp+Pn
         JLnoyC0w8Zseud+x/xdLXpx2bIIMEE1IVLSGblafN9FEwAlPKVV0baTbjg9xqVa6fG
         PIpgyt4VrG0Ahgvwg//7cZHKWxZJbMvF8SP+wiZCx54QPiZFTRPjqhu+T5uV4KASbC
         TfyAbCO8S7KRg+IJh29Dp4cMGPLwbQ+lfQ18wW0FK2SAhqoPksQPQo+dgIiwEJaMTX
         C6vzL4fAb38bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220223044516.3776637-2-bjorn.andersson@linaro.org>
References: <20220223044516.3776637-1-bjorn.andersson@linaro.org> <20220223044516.3776637-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: rpmhcc: add sc8280xp support to the RPMh clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Thu, 24 Feb 2022 14:00:06 -0800
User-Agent: alot/0.10
Message-Id: <20220224220008.02F5EC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-02-22 20:45:16)
> The Qualcomm SC8280XP platform exposes 5 clocks through the RPMh clock
> controller. Add these, and the relates active-only variants, to the RPMh
> clock controller driver.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
