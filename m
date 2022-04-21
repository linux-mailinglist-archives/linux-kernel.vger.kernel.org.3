Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7450250969B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384427AbiDUFXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384413AbiDUFXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:23:22 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9378DFA0;
        Wed, 20 Apr 2022 22:20:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 51ECD8158;
        Thu, 21 Apr 2022 05:17:43 +0000 (UTC)
Date:   Thu, 21 Apr 2022 08:20:33 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] ARM: dts: omap: align SPI NOR node name with dtschema
Message-ID: <YmDpoSxtooRYCffL@atomide.com>
References: <20220407143304.295610-1-krzysztof.kozlowski@linaro.org>
 <165044570802.75184.5076185924334450922.b4-ty@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165044570802.75184.5076185924334450922.b4-ty@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [220420 09:07]:
> On Thu, 7 Apr 2022 16:33:04 +0200, Krzysztof Kozlowski wrote:
> > The node names should be generic and SPI NOR dtschema expects "flash".
> > 
> > 
> 
> Looks like no one wants to take this, so let me take care of it.
> 
> Applied, thanks!
> 
> [1/1] ARM: dts: omap: align SPI NOR node name with dtschema
>       commit: 4a229458a98f973b50b7f36d44ed5c2d4c77e0c4

OK, yeah this one should not conflict with other patches.

Regards,

Tony
