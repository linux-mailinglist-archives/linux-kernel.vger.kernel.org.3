Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560294D931F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344721AbiCODqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbiCODqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2ED3980A;
        Mon, 14 Mar 2022 20:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2BD6115D;
        Tue, 15 Mar 2022 03:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4209C340E8;
        Tue, 15 Mar 2022 03:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647315923;
        bh=g0CA66lKAx0OQ2SEAnRDsT0k+T4CucnjwTX0rXodWq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMcm1XCTNwM/soOxMmPjNvHbPXZY2OdIRhuse5Bdz8T02UxYBbrXlVH8FDMOb+skA
         4lpFef0vn6HFQ3rdNZWHT8e19b5Bq5ETrH9Kj2o5nlhMz9xfn3j5cgJ732Il1g5xaq
         Xo9shmxzJu4sm3YhgrLrTP09fKxmLbNu+kPzJjKewB2mkInVyEqQY4Hr3ImLAm9Wvx
         25tqNSqznH0tKA33r226Y9R610Wh0YQ79uYGV/5CtWxrSajyFg2hFigK9wFf+9W7h9
         K/btR+oSRtv3gzap3rswMDPfY91/KJAtyD/tyHxpKYh8fGpouHAa1VzLX9HCaflQ03
         1Z/qc09ENGcaw==
Date:   Tue, 15 Mar 2022 09:15:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Add support for PDC interrupt controller for
 sm8150
Message-ID: <YjALz3Lo2h5G7oZu@matsya>
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-02-22, 00:10, Bhupesh Sharma wrote:
> Changes since v1:
> -----------------
> - v1 can be found here: https://lore.kernel.org/linux-arm-msm/20220119203133.467264-1-bhupesh.sharma@linaro.org/
> - Collect ACK from Rob on PATCH 1/4.
> - Address review comments from Maulik.
> 
> This patchset adds the support for PDC interrupt controller found
> on sm8150 SoCs from Qualcomm.
> 
> Here we add the device-tree bindings, pinctrl driver support
> and the dts support for the same.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
