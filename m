Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3FD4C3890
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiBXWNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiBXWNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:13:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701022804E4;
        Thu, 24 Feb 2022 14:13:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A86561B04;
        Thu, 24 Feb 2022 22:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6EDC340E9;
        Thu, 24 Feb 2022 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740801;
        bh=xSw4znLrnkqYgTXK3uq0hlXa+NnT4PbS1gNukKdYN/U=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=AsGgPVAHjbaQ4adGtaMXdHd57pdns9Wqu4cngYeDApFx3S6qD1YAC/0BsiLXqJa7Y
         ntQLpaGL5RcnFyGC6ipqpj2bclpcX3Lgb15W2kt5jfgXG+2fryV2o2Qwj1U0gTddkp
         C36k3aXlak1aFoyklpXu2KkQKCG3cSPo0FxTNX+9Kt1lKA0DTum6LKHNA/wzIsX5VW
         GxmEDTWmmY0CSIgQZQURWPwfOIxS8coRv52QJvZWNXl7J3zvFM2muyTrzu1FDkM/Um
         DzB697K/0bG4lYtIR4RGRqDoTAzPNnzRlJnUYBGe5F53R8kkOvUSfLaEpjBumEVRtQ
         Iq5xHa+xT4hhw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-14-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-14-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 13/15] dt-bindings: reset: add ipq8064 ce5 resets
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
Date:   Thu, 24 Feb 2022 14:13:19 -0800
User-Agent: alot/0.10
Message-Id: <20220224221321.5E6EDC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:29)
> Add ipq8064 ce5 resets needed for CryptoEngine gcc driver.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
