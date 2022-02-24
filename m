Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34C44C389B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiBXWOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiBXWOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:14:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA3124FA0F;
        Thu, 24 Feb 2022 14:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA2F861B03;
        Thu, 24 Feb 2022 22:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A18AC340E9;
        Thu, 24 Feb 2022 22:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740819;
        bh=h3s4/ZPFBmfw6sd61Zr1MCKCfUbsr9CMq5AiMmgLAA0=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=CoggJNTKSQR9hfqtMA/T+dhDzhJdrwF2H4LFEAnlRuEmJvV7ROpEa5D5S08ETXt9B
         8QfJ6QX6cP95tzt7NctkZ9nMuj8uERoG2BoyLTT3MvumW1HTvm8/rY6iyWMm5dVGnu
         mwOY6/Nv7J15+5vDJOE6M4mZPTE3mehb8XsYTH4jEpTXW/veDuS2pw+fQfoetuzfyQ
         2PS6IsG0pTCoz66Uy64eZ2BR/zgIn/A6kCZpjbHP74Q3VKSeJuUqq7ii37bKi+Eziu
         LFk0sGfXMiU0YCAOWp2ax1iqi3GNfv3BARrhNTaMv6RB/4qPO37/d2AU1dV594XxRw
         2VyBp62yJldsw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-15-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-15-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 14/15] clk: qcom: gcc-ipq806x: add CryptoEngine resets
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Feb 2022 14:13:37 -0800
User-Agent: alot/0.10
Message-Id: <20220224221339.4A18AC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:30)
> Add missing CryptoEngine resets.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
