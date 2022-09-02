Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCC5AB78D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiIBR3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiIBR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:29:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A9F8F5F;
        Fri,  2 Sep 2022 10:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C01BBB82CE8;
        Fri,  2 Sep 2022 17:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2AAC433D7;
        Fri,  2 Sep 2022 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662139739;
        bh=Y4zv07NX7Af0mypsr8VN1DC6DfzrXJ+O+npkp3h71Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSfjiyiqimzqCPXlykQvTii1/uNQQ7Sc0nX4lQOUJU8+WlKZvMf2cZq3MHoxgmq4r
         /K1JSGy9NAlDgdvENO7vywavNy1sThPLkMDY0O33LoRCQd2yS04ulV1t3oT3p1HYIm
         +8TOCMrfp83kQ+MXFmmfUwdty9RwrS0gv7qK06wtQCmyJVL8rdGLpx3jUIQLs7PZxT
         9WgArCKNopqdnvzfzMKgQ2ResayQKDFrdfQx1K5hVeAwvuLjylq8zDOQ0RFjalhr1E
         oUpsKbS7BFfUo8tYKv0kASHqEfH1F6CvDgtVHp1Lm+/CwX5nS0WKKLrwb1s0v513QH
         Wa+1dC8/Inehg==
Date:   Fri, 2 Sep 2022 22:58:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: phy: Update Pratyush Yadav's email
Message-ID: <YxI9ViXF7gMc5KcM@matsya>
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

On 16-08-22, 16:21, Krzysztof Kozlowski wrote:
> Emails to Pratyush Yadav bounce ("550 Invalid recipient"), so update to
> match one in commit 92714596cdbe ("MAINTAINERS: Use my kernel.org
> email").

Applied, thanks

-- 
~Vinod
