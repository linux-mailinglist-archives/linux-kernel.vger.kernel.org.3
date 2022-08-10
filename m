Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFE58EB68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiHJLkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHJLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3D9B7F;
        Wed, 10 Aug 2022 04:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AE70B81BAF;
        Wed, 10 Aug 2022 11:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E670CC433C1;
        Wed, 10 Aug 2022 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660131613;
        bh=B1V4LFTK5V/8zkXzr4XRn5tMf+GZZUZe/xGqRgvRpDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICby4guJOo/LjrveJ7TUsnRmkuGLYuOQF7A5OomlttlEHVvjZRMCu96fb+r+2Hjew
         QJoi+GEOPtJGhz8ErqiHKXgBb8ajkTd/IMoa5HdJMXhAmu8l8PNg1aTtRISkAr97a7
         mcY32IODHVXgrTQ0SOzBEihngyPMPptpUujYjBSTWKWPJA1lLyx0F1zKXi7XBUTkd4
         kTgkN39fxtvJyMye+gwlQJEPOI0whkEL21dr3h53r9rgylo5/01g9wubX3p1MPnldS
         yVqD9LyjZ1B0KujCLk8ll8xbcJaSQ18RMO3bSOkLhZiEsBlguw7bpKpHXh7UcpEo+C
         UJWrcqXQ+pQ5A==
Date:   Wed, 10 Aug 2022 12:40:08 +0100
From:   Lee Jones <lee@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.torokhov@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-binding: mfd: Add Richtek RT5120 PMIC support
Message-ID: <YvOZGKToSuhB3wRN@google.com>
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
 <1660100142-32493-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1660100142-32493-2-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Richtek RT5120 PMIC devicetree document.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v2:
> - Add 'unevaluatedProperties: false' for regulator buck1~4/ldo/exten.
> - Fix indention and remove status for powerkey.
> - Refine powerkey description for more HW details.
> 
> ---
>  .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 178 +++++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
