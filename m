Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCF532BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbiEXNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiEXNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDD95A05;
        Tue, 24 May 2022 06:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FC6A61636;
        Tue, 24 May 2022 13:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7A0C34113;
        Tue, 24 May 2022 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653400439;
        bh=6XhAFe91uLN8j3psw/ecVh9mNeTClO1Yejx8X4qhAgg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C9suI9g8huTwLf7MaZCbKJo41VmU2pTdhJ+uXnvGz8bTnrv2eTwFYuCu7knorWheT
         62u+cb5Cljq+7V99IibSzNxd5V06LAQBICQR0VH0SyzVvsG/b4NA211J0lI1BzVpsi
         xIrPR77StwyqAH3U43in8obxBZfjMzfvuR45yQukV37Aq9EtDN1Hk3TT2+Nlrw0Ejy
         Jv19AF3w5AC8UJ7XDF+75N/4C6Bz6qE66pZitHn7553vwwQ58DHNXfptTrbHcU3X1x
         NZbJvxTeFGYcHBWXWVVjl3RxZozFkFoEpN3UVdxmgzKSu+QFS4wbh9kolsChJ2V1Mh
         21971d7pDXgog==
Message-ID: <4361fb24-593f-0513-4248-bae4f9745f56@kernel.org>
Date:   Tue, 24 May 2022 08:53:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arm64: dts: Add support for Stratix 10 Software Virtual
 Platform
Content-Language: en-US
To:     wen.ping.teh@intel.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yves Vandervennet <yvanderv@opensource.altera.com>,
        Dinh Nguyen <dinguyen@opensource.altera.com>
References: <20220524102912.792968-1-wen.ping.teh@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220524102912.792968-1-wen.ping.teh@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/22 05:29, wen.ping.teh@intel.com wrote:
> From: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> Add Stratix 10 Software Virtual Platform device tree
> 
> Signed-off-by: Yves Vandervennet <yvanderv@opensource.altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Please remove the above 2 addresses, they no longer exists.

Dinh
