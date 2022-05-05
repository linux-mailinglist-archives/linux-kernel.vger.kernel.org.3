Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477351CAAB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385890AbiEEUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiEEUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:35:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFBB5EDF6;
        Thu,  5 May 2022 13:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 668AB61EE6;
        Thu,  5 May 2022 20:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8940FC385AA;
        Thu,  5 May 2022 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651782729;
        bh=6X2GGjvnvPeSiQ3mLgGVNfuTmKYoy0LuWyOjf65aFrk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=qUrR0MoH+gBd28U+v4+aUcyRTwaDZnGCKnnoXlICVA/Bp4LDQBYcq8KBWjPH6oD7F
         QT9DFEnHItM9t1Bcv3OujRdFcBnjNGXk2T09OVxBvNYWW4c/xylCezhgSx8weOPuyP
         I21EkB33rMDviQjmTJASvCtK6pT0qPIaaUtSKvRcQXR0Vx8B98mNQ5i17pvCPfA6Z8
         kaRxixIOJ09lzNW3CpcxvjjhD/RPfRmpPBheEBwGHbbn+wMv7Yynl6EkIBHEsaxQYb
         Xury8HfKemeth4XAU/D4myxzlRYFiQdQO2vfkgpsB4pMAWezy6lkwYpCyEK9H5+6Ob
         xvoOmvUp3pv/A==
Message-ID: <4671050a-20dd-2397-4f6a-f7e54f7d519b@kernel.org>
Date:   Thu, 5 May 2022 23:32:02 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon:
 add BWMON device
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
 <20220504081735.26906-2-krzysztof.kozlowski@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220504081735.26906-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.05.22 11:17, Krzysztof Kozlowski wrote:
> Add bindings for the Qualcomm Bandwidth Monitor device providing
> performance data on interconnects.  The bindings describe only BWMON
> version 4, e.g. the instance on SDM845 between CPU and Last Level Cache
> Controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Georgi Djakov <djakov@kernel.org>
