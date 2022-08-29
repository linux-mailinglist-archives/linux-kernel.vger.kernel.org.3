Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C415A5275
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiH2RAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiH2RAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:00:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0CDA457;
        Mon, 29 Aug 2022 10:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E60CAB81184;
        Mon, 29 Aug 2022 17:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0DEC433D6;
        Mon, 29 Aug 2022 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661792404;
        bh=vbK+NKnTY0tLEtHzVrjwosQhoAXqqJtC+umeGRGzjEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVbR3HowOrYum8oIip+mLhL7HWD+e8KPZkkHJsyxoo9VTRf7orQxr/9u/uyDi9Kmc
         OToVf1WmeQjQHq8cdiODqDuITjR/kAJNQkL1oRF9jpr1Cy59scPef9UOWnWFRcgwrX
         oR7BBVtyvLKvzdwkt2RJQ3jqIbQxqvAQgQfb/2YHjUs6+sMwBIywjubRksDt7d5YKb
         skuTgjXEsZ1P26AuVeWcC7On8qFsxh+8RdOxUEn4mBzm22mB7GSjLjysXwMxc5Z46N
         +mP/EJey55vOfDKVcZAptWyiddnIV21laLQ+EfLOVCSGBafwuGIZ7WdB6dftOwAVhG
         jrwrJxB7ERBBQ==
Date:   Mon, 29 Aug 2022 22:30:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 00/14] arm64/dt-bindings: mfd: qcom: SPMI PMIC fixes
Message-ID: <YwzwkOyFIIcOgj7t@matsya>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-22, 11:43, Krzysztof Kozlowski wrote:
> Hi,
> 
> The Qualcomm SPMI PMIC DT schema conversion was not really tested and several
> issues in the bindings and DTS should be corrected.
> 
> 1. The DTS patches can go independently.
> 2. The binding change continuous work of PWM reg fix and depends on it in
>    context (diff hunk):
>    https://lore.kernel.org/all/20220827145640.3530878-1-bryan.odonoghue@linaro.org/
>    Binidings changes and above, can be taken via MFD tree (fixed commit was
>    merged in v6.0-rc1).

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
