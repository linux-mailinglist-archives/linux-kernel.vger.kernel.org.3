Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712C4C389C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiBXWOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiBXWOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:14:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DA2804E4;
        Thu, 24 Feb 2022 14:14:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 281D361AED;
        Thu, 24 Feb 2022 22:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CEAC340E9;
        Thu, 24 Feb 2022 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740852;
        bh=NqUI+D3CJfrplP9u1Wz85YIbJ2otDOyecajcNFrz9DU=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=MfiEdfm0HwovkTYJlNKdIKJXKs+1k9b8zc6e6bZuznUfrNTmnL2/npVDqO0XXSNWy
         t0bumpzxQ/Zc27fJpic1iJOCUCk65I5XfGVbsz1UdfLyC8XeSsPCYRMYDn03AsRsMh
         5urSbSg+QBe+xwSIdxUkJJUsGyamQfsFmTEcJ6eQSLMZkJP/XXnuEXaraX8pIWVlml
         +9Dwu+kTAqX7OF3E2Xvcm5w0t9vK2y3d0aMC1cht63ODWttx7XNozuJWT0idlq2nkI
         O6uzgRUI8/Pha3DLM6fteE+PfDqt5V2l7uZkFq1P7i13yoVINteLIjhgI5yXiAnLzr
         GqwufqMGtaz2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-16-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-16-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 15/15] ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064
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
Date:   Thu, 24 Feb 2022 14:14:10 -0800
User-Agent: alot/0.10
Message-Id: <20220224221412.81CEAC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:31)
> Add syscon compatible required for tsens driver to correctly probe driver
> and access the reg. Also add cxo and pxo tag and declare them as gcc clock
> now requires them for the ipq8064 gcc driver that has now been modernized.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
