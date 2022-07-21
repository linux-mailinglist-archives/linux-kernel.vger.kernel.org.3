Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC957C482
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiGUGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGUGca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFC9BC31;
        Wed, 20 Jul 2022 23:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F288761D3B;
        Thu, 21 Jul 2022 06:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4533C3411E;
        Thu, 21 Jul 2022 06:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658385149;
        bh=IZ4SwAa6ua+WUWdHHIwzyOEKRHQHmxbchOdJNXwyJTU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HV6hxcT0IdNYJG6PkgD1AgTC9gt6OfrMaozgwv6v5Ua8gfUc4y2KF0zwY7cakrlrf
         mMQz5iNL8wubg/y1Zv7sZSwW6fgsKOkG1ENLiAn+9Kb8mUI/yhe+GGAe5ttMk9RBYe
         9HYpepMBetEUyeMnHq64d/5N9ICfWm128tA5fjgrpJanrxEEqEbDeWIh2LS7SgGrUr
         H+69txgezlPrpl0Sr7gShfAn9xW4DH5LwGRtG+eaW+endr5/kRHKu1aufgltam2c0v
         BGJgoRwzMIyEmQET5rpWZ1XNrKnKNQDKK7uVOek9r01WUEf28BKmoWD2659D/yBY9U
         KBviV9QDAgTJw==
Message-ID: <c7d1f98c-a294-1112-26c6-4cdab0185e3d@kernel.org>
Date:   Thu, 21 Jul 2022 08:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 1/2] thermal: Add thermal driver for Sunplus
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com
References: <cover.1654660009.git.lhjeff911@gmail.com>
 <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 09:30, Li-hao Kuo wrote:
> Add thermal driver for Sunplus.
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v10:
>  - Change the setting of compatible
>  - Mosdify the setting of remove funciton.

This driver was never compiled :(

Best regards,
Krzysztof
