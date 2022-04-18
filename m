Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEAC504D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiDRIE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiDRIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:04:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EEDF74;
        Mon, 18 Apr 2022 01:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41317B80B4F;
        Mon, 18 Apr 2022 08:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD9FC385A1;
        Mon, 18 Apr 2022 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650268934;
        bh=fe4Gj9t5aCrhJPrCO9ZGJ+Wm5Ujh0iIRr6dFRRvS0KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUeLCenPIldHZ+jAgTvdK/wEX6F3rLkehuK8xJSEe1kU8RPI7OaABa2RpEQlAtpRQ
         mnOah4Wq7/+TVSKoCfMJOv7wJ+rFhPpdxAL+VFkuhPt2CVu/xr0TOHtQsAESEPB8p7
         DMBsOWv7akiXma2TQPM38z6SqcPOaqypPuSCM3HVlLqQQre69wIiSTkuQeNn+faU3/
         vKwddeAdrzq1lypI4ioxpk6yWlNdJK8c2S32Rz8CYityYI5vD66C2xCVgqeeb9koQ5
         rMCbcyGScWY9xfTNNo8/BBagfGR+C94R9IlgW2yvngNzXA3xqa65HnQo0u6E0U65DD
         C4WzWfk6miQPQ==
Date:   Mon, 18 Apr 2022 13:32:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8350-hdk: Enable &gpi_dma1
Message-ID: <Yl0bAmkyTGMuAkaF@matsya>
References: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
 <20220412215137.2385831-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412215137.2385831-3-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 14:51, Bjorn Andersson wrote:
> Some versions of the firmware for the SM8350 Hardware Development Kit
> (HDK) has FIFO mode disabled for i2c13 and must thus use GPI DMA. Enable
> &gpi_dma1 to allow this.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
