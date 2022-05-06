Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A195D51DD0E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443511AbiEFQMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443560AbiEFQL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:11:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63996EB22
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E1B6CE3764
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE0AC385BD;
        Fri,  6 May 2022 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651853245;
        bh=6X2hMLK9syCGnQ6i86SAh139iWBlukYJvCLaWxrJbQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ridMCBYtJRjzkSwTQwWivatVkVagzfPJs9AJw64MuOZHRC2MkAFLMTg0mtjkOEI9W
         Gn08Kniaieg20voYvVhDxYYXck7gP4dke3d1EiGuSAWrGeB1lXhZfdS9R4Lm3WD9hO
         hi2W7CtP0QoiLvi+rxuTM/eBbuJAF2SQkDzKitZs1SDiwWRi/SQYqzHy1z+pv50arc
         v46rrqa5TaXsokEO+0XGRIb37M7Q7LlOm/7Qff8AX6gOENIwVmbgw35ynzOj+9aVEZ
         U0xhtv5sDZRHmaB6PRb2/Bc1FvDu6KTL2RfYbZAQjE6HGFuaumFohZhfOyl8d52W51
         71VqTtvx3yLiA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        iommu@lists.linux-foundation.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, joro@8bytes.org,
        robin.murphy@arm.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: check return value after calling platform_get_resource()
Date:   Fri,  6 May 2022 17:07:06 +0100
Message-Id: <165185069794.2780907.13021484269981123590.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220425114525.2651143-1-yangyingliang@huawei.com>
References: <20220425114525.2651143-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 19:45:25 +0800, Yang Yingliang wrote:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: check return value after calling platform_get_resource()
      https://git.kernel.org/will/c/b131fa8c1d2a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
