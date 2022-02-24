Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FDB4C3865
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiBXWHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiBXWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:07:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3AA1A12B4;
        Thu, 24 Feb 2022 14:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C762061ABD;
        Thu, 24 Feb 2022 22:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2DDC340E9;
        Thu, 24 Feb 2022 22:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740431;
        bh=13Ra79sp3Ri7hXW3iTbYMkWW/3dT9WXB2rNiao1enXQ=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Ir3UiUC+ymiImwqCWQ5T1AlTaNxJlJmej5ldc+Ec55MV6hPo16Pe8Jbh9OF6Dibux
         7RwakHEOGURBlWueMfOMDpgWL472heWPfgeWdTEHk6mCf5WUa6aRc8LrR9kq3Mzg2U
         KCFLSnWhogROgZi7Ih2lr++1w0erTvhCqXO3ePAyz6L4d8BoBzHfQKobsNib72Lv6O
         H9lNyaQfTdx/p/24WpzsvbR7Zmb7D+UwgSIwnTPj3o9NRIQ6A9bGd//hesTE97NpQq
         wlOkj1xmoN8jB6L1vufkyH4yFH+Ot08pT8OYWJIfHvAc9RvH+RrKkaU9T4eHTgpaVF
         yC9xL575jJz8Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-4-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-4-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 03/15] dt-bindings: clock: document qcom,gcc-ipq8064 binding
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
Date:   Thu, 24 Feb 2022 14:07:09 -0800
User-Agent: alot/0.10
Message-Id: <20220224220711.2D2DDC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:19)
> Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> clocks. The gcc node is also used by the tsens driver, already documented,
> to get the calib nvmem cells and the base reg from gcc. Use
> qcom,gcc.yaml as a template and remove the compatible from
> generic qcom,gcc-other.yaml
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
