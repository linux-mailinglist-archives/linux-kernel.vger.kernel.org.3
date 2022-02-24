Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF134C3891
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiBXWNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiBXWNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:13:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7306D294FF4;
        Thu, 24 Feb 2022 14:13:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E119B829C1;
        Thu, 24 Feb 2022 22:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B6DC340E9;
        Thu, 24 Feb 2022 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740788;
        bh=bOhOAscowBqvT9V6Xz3saBNQ9t4VZgwRryeLpgYrD5M=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Q8thwQEWUOcb3Ftd99PJRCYWlVozwtW62SnD/rTO/2/aYqMPJ0F64Li4KvRJGBOAb
         t0i061cHWJNeTdhgZqH//5shy+sGP65QgxcAixpHyYSWRIAVN+myX+crnUMgG835gx
         GYE5o98vzNlFEI2/VmYrcQuNTL/kepEMtHCceGwz2/3NJ66KNA0ApGP5+OGor81fOO
         JYL7mwQOuxkqRYbnUc87CxVcZ3bJIlz0zZ/YHsBslKl6JrwFHIaYGnDZSoNmWd1REI
         1U4J6e8KCYKMsnbSUeXp3X5Ismw6uzd+Oxzp90rfZAie8qkLGnCevM8gvnc2qXKzBr
         SanSy0NoZ6nGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-13-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-13-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 12/15] clk: qcom: gcc-ipq806x: add CryptoEngine clocks
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
Date:   Thu, 24 Feb 2022 14:13:06 -0800
User-Agent: alot/0.10
Message-Id: <20220224221308.C0B6DC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:28)
> Add missing CryptoEngine clocks and pll11 required clock.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
