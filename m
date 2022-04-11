Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906DC4FC30B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348810AbiDKRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbiDKRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:19:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A1140AB;
        Mon, 11 Apr 2022 10:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45C40B8172F;
        Mon, 11 Apr 2022 17:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB12C385A4;
        Mon, 11 Apr 2022 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649697407;
        bh=KEdgu5lNU5+HyVwZRaK/BbilKd+k1nntwkrHK/f5xnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4WfzENQiux5OP9lf3StinCx+vgGkRS2A4laKy+HlRnRR6VsoFKFgMfzCtt4fhKhG
         06WX+RdkGEg7LtoAnDYIsiujqtlfhRQQxe57BnIPBYZIaQAf5FXxSs46hFUMGtKDDp
         V5w6uiUOcg/YmAr35lpe/CWzFkC7S66429CnY5yjCCaVNPASm5cZ41xa7eS9n2UDsU
         +aRzR6SSjR10oUpgqJvfrwFoE0fdUqdVDy/wLjdweRJrL6jyOX/y4ntmZidVCJIIMT
         xfBQ2S01tcotR5teWGVrpZglhFLZJ66S5j5Xb3EknMRysXsizb2BQp4bBmOBrTGg7H
         Up2irQS7u3vXA==
Date:   Mon, 11 Apr 2022 22:46:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Girish K S <ks.giri@samsung.com>,
        Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>,
        Vasanth Ananthan <vasanth.a@samsung.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [RESEND PATCH 1/2] phy: samsung: Fix missing of_node_put() in
 exynos_sata_phy_probe
Message-ID: <YlRiev97AAS1GvnQ@matsya>
References: <20220407091857.230386-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407091857.230386-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-04-22, 11:18, Krzysztof Kozlowski wrote:
> From: Miaoqian Lin <linmq006@gmail.com>
> 
> The device_node pointer is returned by of_parse_phandle() with refcount
> incremented. We should use of_node_put() on it when done.

Applied all, thanks

-- 
~Vinod
