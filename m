Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58F54EE62
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiFQASx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFQASw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B8062CE6;
        Thu, 16 Jun 2022 17:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F39C6182F;
        Fri, 17 Jun 2022 00:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85199C34114;
        Fri, 17 Jun 2022 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655425130;
        bh=gTkObOqulb/1+sTpWbn1RLB0WFAog+psBwHx7UycOPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAoMs51E6tyuCE4MhXn3BkzrQDTPiJ9jYIENI3lOkwzGLxJzFokbtLhT5lswijmGp
         uSUiarqOSNNu/I2D94uf6M6mVGc1A3GIecdMhVbkZXGfOnIzRsYB887rq6wv6u2pHl
         hR3s/ZkmJzk815SpcD3rv6QAnauUhXZlqrKZ7I8rLuCD2W6ICkWaMgkMJ0+VeBw4+C
         VAYYIDUcxYo0Zs/+T9lrnHo6JLyPgSrzXbpV4LTiCNSLIo5GukiHNd0kbW2hTP4nxp
         czdwQyRvwXFk6L0VYsPVFyK5XPF3Ed6tjtiB7O/nBwlQh4LE5rQgqXmYpni0Zyc4Oe
         cVNUjOGBTBrAw==
Date:   Thu, 16 Jun 2022 17:18:50 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, avri.altman@wdc.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        chanho61.park@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v4 0/6] Add support for UFS controller found in FSD SoC
Message-ID: <YqvIasse5qjsLcO2@matsya>
References: <CGME20220610104340epcas5p1d6cee31aba4dc2952ef09003c9e67863@epcas5p1.samsung.com>
 <20220610104119.66401-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-22, 16:11, Alim Akhtar wrote:
> 
> This series adds support for UFS controller found in FSD SoC.
> The HCI is almost same as found on other Exynos SoCs with minor
> differences. This also adds the required UFS-PHY driver changes.

Applied 1-3, thanks

-- 
~Vinod
