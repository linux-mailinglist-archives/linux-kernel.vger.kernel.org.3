Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5592E5B16AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiIHIP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiIHIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:15:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E694D4CC;
        Thu,  8 Sep 2022 01:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8361B61B7A;
        Thu,  8 Sep 2022 08:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F611C433D6;
        Thu,  8 Sep 2022 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662624908;
        bh=XjL6Hae4mcuNJIhhYWQQFddskamLCNXubw7NlP7YEbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNFdNB1qfMCWjDdjAMWub5kgr9TbDZp7K4+1ROTAXsv+xWK4npTIXAoNuos2+B8lM
         mUWH2vDuBO3hEUooYfZ/euTDpZFMZbYhywdswvxZw/9Z6oimTadJQfQsb+QzhFW4oA
         ABz9AOnkSS2lK+20xB3o3ZH+6cpvYjYvnUznCEjIEp7/uyO4+4TZD/kQJ1C7nW0KUp
         zpLdaT2XqbmIDtGaI4ydbf3qO/fEA+ZAjnLltVV3cLQcy7oIlkUyq65ctemNS+8h3n
         n913GgMP8GMsUi8YzWeQsLEpRw9+W9XSsVQGECf4bKPIzTMlQ6PX2hTauxjaGVWJsd
         WS562qKAUsJ8g==
Date:   Thu, 8 Sep 2022 09:15:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 1/5] dt-bindings: mfd: qcom-spmi-pmic: add support for
 PMP8074
Message-ID: <Yxmkh30LtXSQssxx@google.com>
References: <20220818221815.346233-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818221815.346233-1-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022, Robert Marko wrote:

> Document compatible for the PMP8074 PMIC.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v8:
> * Add to dtschema now that its available instead
> * Drop ACK as we are dealing with dtschema now
> 
> Changes in v7:
> * Fixup commit description
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
