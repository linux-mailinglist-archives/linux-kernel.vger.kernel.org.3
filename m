Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA94C3849
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiBXWA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiBXWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:00:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9712757AC;
        Thu, 24 Feb 2022 13:59:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC1DA61A55;
        Thu, 24 Feb 2022 21:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7BAC340E9;
        Thu, 24 Feb 2022 21:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645739995;
        bh=EKawEYlQKuzpckmYCNO4MFcpdsfYGcjsssX0gH3Qu3E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XVCdSe4/LSFX5zu48hQh31O05rft27OQOmE5vfJc+e1QsHYwmVxg64lR8H6SWiB6B
         pMTB0/X+R0vuBN1M1OmtIh9x3nhjt5lzcwtcl5TdfOg/SdtlEsOFiesERePmFu5ENL
         By59FTEJlYsbhLQaetM46t8gWT2BIoSAlpSUGrGuqtebO8JHX79XCT7N+flf3BFAHZ
         Ol16QWQcQk2EAY1YOx4Gm25LnqYZ4OiggeH4Cyr8M3R0KEVowAnVrbqiTq7m3qTFVt
         qFOfV3JLc903jalwPi/MW+fgaAd/VpKwNg49FE+G1ltNrBxeVv22UewePYuSqWEp4Z
         5oA9Oe/Mf46gQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220223044516.3776637-1-bjorn.andersson@linaro.org>
References: <20220223044516.3776637-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add sc8280xp to the RPMh clock controller binding
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 24 Feb 2022 13:59:53 -0800
User-Agent: alot/0.10
Message-Id: <20220224215955.3C7BAC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-02-22 20:45:15)
> The Qualcomm SC8280XP has a RPMh clock controller, so add a compatible
> for this to the binding.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
