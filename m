Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E4058F80A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiHKHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiHKHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:01:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4B41D1A;
        Thu, 11 Aug 2022 00:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5413DB81F79;
        Thu, 11 Aug 2022 07:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76B9C433D6;
        Thu, 11 Aug 2022 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660201316;
        bh=0LegDg7v4fhM4AuETmhue5pPKRXRoWa9Os6m6U3leVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDLwtv923XLawqePcp/VWanKefYB8r8l7P57dxcFStR9MG78QOnnv0TvfCCCbG0a9
         98RPu2VUgzM4t75DZo+YBXAPqmuiQhz5j2PCDMnOW4w+PPZt39ATf7wo+adGM/VLC7
         Juqsrokr+L2iSObcRhYYBNDRrBvAZVh878F5U1S+6X0oUObP6j757Nq8aa+7rcjdUv
         I293YWSd+yC5/TCnXsacUaHHFtEAdi9UsH5lmKIxIJkKtHNpS7W36e8vYBGo3ORfRE
         467WVSyBtYfj9JwCzgrOD7A/0gaIZ/GnK+Ri7lKjflWO+SofeqxJ9Xe4qAyaQ+Jmpz
         VwKrclwl8BmqA==
Date:   Thu, 11 Aug 2022 08:01:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mfd: aspeed,ast2x00-scu: Convert to DT
 schema format
Message-ID: <YvSpXfA8o+3FfiPb@google.com>
References: <20220810161635.73936-1-robh@kernel.org>
 <20220810161635.73936-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220810161635.73936-3-robh@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022, Rob Herring wrote:

> Convert the aspeed,ast2[456]00-scu binding to DT schema format.
> 
> The original binding was missing '#address-cells', '#size-cells',
> 'ranges', and child nodes, so add them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 110 ++++++++++++++++++
>  .../devicetree/bindings/mfd/aspeed-scu.txt    |  48 --------
>  2 files changed, 110 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt

Applied, thanks.

-- 
Lee Jones [李琼斯]
