Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220E955491F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355915AbiFVIyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355950AbiFVIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:53:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDEA33E95
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:53:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A287B81CF1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD012C3411D;
        Wed, 22 Jun 2022 08:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888030;
        bh=txr9TWpN7SyRToAeY91kQqMM8zLOifOEr5AkcyY8F4c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lGDjOrI2/LRQ6z4A1g+1x8B7Ko9rbzRHPMnL634Q32sUtmsYyvHjP3OvdIgDFHwjo
         3nLtf5lTY7KjdUOZofd45As1wTzFxV33KiirnXaQOaAJT5dgOYxhrae4HWUVHOuP/1
         DNhdpX0YQUXEc0TNQg9xEoUTmjGg5E8DjVDdPAceOtGRgszDVCvXFu/9t/BeWyLtmU
         8dgEWMrfbTbM2lZHClWcPDo25JcCqodkf5S7OLl9dQG061bPl9O87G9TgPgZyQshGz
         f5FbWP/6kxcb/srQdDimrI/TfYvZKubv6Gfabju66AKIAa5Sf3CPATsDcxmcSw7OdY
         Eud2mBkRDnJog==
Message-ID: <b3d688a2-09c4-bac4-45e0-bd3b6b52778c@kernel.org>
Date:   Wed, 22 Jun 2022 10:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm/kernel: Fix refcount leak bugs
Content-Language: en-US
To:     Liang He <windhl@126.com>, linux@armlinux.org.uk,
        rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        linus.walleij@linaro.org, arnd@arndb.de, rostedt@goodmis.org,
        ebiederm@xmission.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220619065941.4066920-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220619065941.4066920-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2022 08:59, Liang He wrote:
> In arm_dt_init_cpu_maps() and init_machine_late(), we need of_node_put()
> to keep refcount balance.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---

Before applying the patch please check it carefully. Previous evidence
[1] suggests that not it was not even compiled.

[1] https://lore.kernel.org/all/202206221602.odN70SHs-lkp@intel.com/

Best regards,
Krzysztof
