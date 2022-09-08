Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DBF5B15FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiIHHts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiIHHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:49:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBEF2AE09;
        Thu,  8 Sep 2022 00:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2848B82002;
        Thu,  8 Sep 2022 07:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA465C433D6;
        Thu,  8 Sep 2022 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662623381;
        bh=VLz4zF2cFIZah0mzXJv9INlKuOYVvHTMbPaOn9fvfk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQca3d3V3Z5hfxfgK0pa1Tg5vKIPlPJjiul08xEEpaKEEoWT5iNBCG9WbJdKwFn1p
         DDUs+0lLnYaUuo3SQXc2374fF/DCPWEJCPmZ2HG7+Jibs6Bl2HYbC006oI1UUDqYRU
         eozYcNaJAFeByaPjsOo4IW975Cf6OuZ9c08OLJK/Lux3iDoKYQQf7UsZpVx6YpdE6+
         feo9LOQkwGTGQ6S8TeflQMWHDFa1f2R4utKFgUBssgnUBiE3FaJHkGVG+DMtduIoCr
         2fZ27Srwxq2cwcHQmsBIqpZ0I2HsQex7SR0oGqRfuYLSM+UKr88m6zzid+SwrisC5j
         iFhTQaIcfMdKA==
Date:   Thu, 8 Sep 2022 08:49:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v2 01/17] dt-bindings: mfd: qcom,tcsr: drop
 simple-mfd from IPQ6018
Message-ID: <Yxmej9ejrZh9RfWL@google.com>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
 <20220817145901.865977-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817145901.865977-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022, Krzysztof Kozlowski wrote:

> Commit 7677ed11e9fa ("dt-bindings: mfd: qcom,tcsr: Convert to dtschema")
> converted bindings to DT schema literally - including the
> qcom,tcsr-ipq6018 expecting syscon and simple-mfd.  Such configuration
> is not used in DTS and there is no actual need of it.  The TCSR block is
> purely configuration block and should not have children.  Any child
> device should be simply moved outside of TCSR syscon block.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 40 +++++++++----------
>  1 file changed, 18 insertions(+), 22 deletions(-)

Merge conflict.  Please rebase.

-- 
Lee Jones [李琼斯]
