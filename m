Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6162C598CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbiHRTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHRToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:44:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3301D4B0D1;
        Thu, 18 Aug 2022 12:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD1BFB823F8;
        Thu, 18 Aug 2022 19:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40C1C433C1;
        Thu, 18 Aug 2022 19:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660851859;
        bh=rPY2Sny802bupQgHO80LHiaN+qHFvSiRug8RSfwD7yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ow+dC5w7EzavfA5oRx1zTe9KtsEal05g896omdoiOCSZvvw1ub2lKxkrNeoeHwqTr
         U7+ZYHAw5zuJKq7/S5kn9DVP+dqpjIu9TdYd9N387I+nZAqTjYSt0MxCC7ZN6v+1eq
         WdoH/Mfq9YDl2tsCfj011ZVxb/EiylaaNK6PyKSLieI8jTbbIbONFRXBM2vohZsp/9
         LlYZBNiq2Zhc/ZRHo70fJcrPz4w5EV+REhocq0tIlAcC5oAZlbOg9K7HlNsJbex1/Q
         ldLnW2NoaaxsZH8rtyLNsC0vWKVxhBno/WfU2msETZ5I63n/eoRVBe8i2UcoREtcEC
         NsYUzzaQjszrQ==
Date:   Fri, 19 Aug 2022 01:14:09 +0530
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: phy: Update Pratyush Yadav's email
Message-ID: <20220818194409.zicuzhcg36qw5her@yadavpratyush.com>
References: <20220816132131.75591-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816132131.75591-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/08/22 04:21PM, Krzysztof Kozlowski wrote:
> Emails to Pratyush Yadav bounce ("550 Invalid recipient"), so update to
> match one in commit 92714596cdbe ("MAINTAINERS: Use my kernel.org
> email").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

I am not yet sure if I will have the bandwidth to review the patches for 
these. But anyway

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
