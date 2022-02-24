Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086DC4C387C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiBXWKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiBXWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:10:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A629285737;
        Thu, 24 Feb 2022 14:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26152B829C1;
        Thu, 24 Feb 2022 22:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F3BC340EF;
        Thu, 24 Feb 2022 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740603;
        bh=dH0g5E+gevTO1aBlG1NdufWFaR0Nlgf5v9qt6ZfiRn8=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=mm0P7bsQZRFtebvFCLVN0EB7tN8dtggw2d/FsqLj3xmr/ehXzwH4sNzEvMc3kV0My
         QHExBTLlotOlML/W2cF4tqMj0t0LXReytG+Osk318PDesydaN8Fy9gviJEZCoU8O+O
         FLtJC+KL7OpTwgDKuGEJaj/a2kAVzJ1kfWDEVqxYFt2UxMjmRug4Bh8qwZ8sOHl7Ff
         nNQFWzA3O2NJ/+FtzkghDrFocQTycBl0C1H+w0BeAtWUfOpAUNYuoSqQeNjw46Zbqr
         JEZADaIwJwkunlvaNnUPo8QgN9Nb6EKLU8O+tdDH9g96teu7XKq7xWak1ovlwXvyrV
         7JAZiRc7SUcsQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-8-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-8-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 07/15] clk: qcom: gcc-ipq806x: add additional freq nss cores
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
Date:   Thu, 24 Feb 2022 14:10:01 -0800
User-Agent: alot/0.10
Message-Id: <20220224221003.B7F3BC340EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:23)
> Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
> clocked to 800MHz. Add these missing freq to the gcc driver.
> Set the freq_tbl for the ubi32_cores to the correct values based on the
> machine compatible.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
