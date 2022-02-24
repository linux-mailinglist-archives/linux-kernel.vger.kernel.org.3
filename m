Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB34C3855
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiBXWE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiBXWEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:04:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A601C6ECA;
        Thu, 24 Feb 2022 14:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6DC561A9D;
        Thu, 24 Feb 2022 22:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127BDC340E9;
        Thu, 24 Feb 2022 22:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740262;
        bh=eJHGdo6CUke8ydbEhmGdO/ZDUKPvm6q30tPSCfmsAl0=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=g9Uu+BPWUdYRQlQ4xhzfIZBnuXA8F6vW5S/d6W0ChuQun7d3RSFjwQLsGYNUC3Kp3
         oPrqIMJFDPGarrFoTf2XYsSwk5HBa/Q807lqO7ZXa6D2w7spqfA680nmaXXGq/d6I6
         pE6g1/u/tOzznNowBDgFgFYj5uNQwD2GVWTpPHJ/IRWlezqv8z9n/OiqwfsFNCnV3G
         aBjg5dcou4YXh03M1yY+ItH1SAi51/W2YZH7ABGZdl4WwmTC/uFg1/9kEroonI9gOq
         2MhxRYZ0Gv5qOgIA+hrWciVygiZzCzvPpKsCrzuzw12jXeluGO7uMWU65rJA+rCFeh
         /dYePXkEDEY0w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-2-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 01/15] dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
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
Date:   Thu, 24 Feb 2022 14:04:20 -0800
User-Agent: alot/0.10
Message-Id: <20220224220422.127BDC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:17)
> Split qcom,gcc.yaml to common and specific schema to use it as a
> template for schema that needs to use the gcc bindings and require
> to add additional bindings.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
