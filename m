Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D9508100
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiDTGYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDTGYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014C73A1B1;
        Tue, 19 Apr 2022 23:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CA18617A8;
        Wed, 20 Apr 2022 06:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0152DC385A0;
        Wed, 20 Apr 2022 06:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650435689;
        bh=0fnhV9YkvBUWpgub55PwLix+EHcctNe6r9w3DAv/eSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRhP6/uh5dQ8KaiZBwolEqJZ+BExpzzEgvp9iKZbROH0T58MpbqaXd0vAI2lOHtmZ
         dWIGdKjFZUEXN+71V2fZuaDLxxoGpvZuaLXjZ0eyhhdpzB97TSAI3ZNmzYqoGeGVk8
         sNAFC6Pf5xLbNSDBV4wMY7E3ACUKpdt0Y3B6NAFyLiEhXXSdjaNpA5EQbnhEIdEtaZ
         JhfmHUarnj594zIFAqsfG2gNCVCk2GKuvATOvOXO8hi2djqyNlb2xRcTVzYijRC+J1
         Yw4EbASjMuUsRJFhYqOeyJGxu2cwOgp2zuWDi+a2eKkyIdzXG0GFUBvedKtAG9XBUw
         1jiym83pzN22A==
Date:   Wed, 20 Apr 2022 11:51:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom: pas: Add sc8280xp
 adsp and nsp pair
Message-ID: <Yl+mZSk8+EhtkICQ@matsya>
References: <20220408220539.625301-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408220539.625301-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-22, 15:05, Bjorn Andersson wrote:
> Add the Qualcomm sc8280xp ADSP and NSP pairs to the binding.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
