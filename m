Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1655A5C92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiH3HIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiH3HHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD8C9E88D;
        Tue, 30 Aug 2022 00:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA5BC61231;
        Tue, 30 Aug 2022 07:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7672EC433C1;
        Tue, 30 Aug 2022 07:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661843222;
        bh=FMfNnM+I09AoWhN6ovBiEHCCKZyla04MjnYb5+HBX/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYYXLxk559HkJfjNSMlOUQiSfxmgGkTvUoP5TmcQofe4V8571S7IOiT3f1TjQqmVC
         Ku6V/1aJq5Hc5UCnmkQD37kIleKUeuZVmTXaSJ+CpT2Ri/M0wF1arbetLW//AJL+ZI
         pFOtnDyS+pmha2UuFVX7wxLKtGZTGAKvrE7UB1GeDwO6/GA90m1TBYdZWL6S/kWoea
         DUXujmq8LXDmAhBjOvP3HQxYaF9o33MXsZ7Fbu9KItTzPmO3ATd69PiZkwnIxNO3r8
         RfyPzFfNgvGHBWVmJijLNoKyd5ygV+WwE/vH3xwWducmXNQsex03NR0OA/+4Vlx/7H
         vVG9imQyidGnQ==
Date:   Tue, 30 Aug 2022 12:36:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <Yw23EkV/P3fuNI4C@matsya>
References: <20220823145649.3118479-14-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-14-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-22, 09:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).

Applied, thanks

-- 
~Vinod
