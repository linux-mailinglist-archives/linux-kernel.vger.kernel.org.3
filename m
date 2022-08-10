Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ED458EB62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiHJLjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHJLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:39:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7276949;
        Wed, 10 Aug 2022 04:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C99AE612A4;
        Wed, 10 Aug 2022 11:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19797C433D6;
        Wed, 10 Aug 2022 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660131585;
        bh=KA6QqoATlRfAAZ7bUCq/+kmWXNGltuff8660hhoplWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQPLKSPughz9Qn+Mfu19Z7lvYLVY+DGvrM3ut+bFMiBsH76YIqq1eBDozYulspfFC
         tuNOPOwsYdK7f7F/DsA73WNXjy5nXdSbOXfoIAzJTNJeoEpgedrw8oYnAfk5CV/zzY
         XhSI/Q87j/I2L+d1mderyG+VoL/5z86SIfNxIXoVoQ1abQHYySdPrNi+8yG5AFDmva
         L5GSjqI1nuPZBsuGaXYme9pd/K93oqkqZeZ61z0uFozlA85HEl4C4xNtLPjzIvAS39
         7WVQkwigfI41h44+81nskKV4zN5jrRXA5NjUtaZ6eJty9qDpiBVmTfGtHeBq9kW82D
         MRHNAP/KJVlLQ==
Date:   Wed, 10 Aug 2022 12:39:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.torokhov@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mfd: rt5120: Add Richtek PMIC support
Message-ID: <YvOY++4KsVtd7rOz@google.com>
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
 <1660100142-32493-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1660100142-32493-3-git-send-email-u0084500@gmail.com>
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
> Add Richtek RT5120 PMIC I2C driver.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v4:
> - Add "Copyright" string and refine for GPL version string.
> - For the last uncertain terminated element in struct arrays, put the comma
>   for it to keep the extensibility.
> 
> Since v3:
> - Use a 'dev' variable and dev_err_probe to decrease the LOC in mfd.
> 
> ---
>  drivers/mfd/Kconfig  |  12 +++++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/rt5120.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 drivers/mfd/rt5120.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
