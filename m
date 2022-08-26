Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6287C5A2015
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiHZE4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiHZE4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351C9A9EB;
        Thu, 25 Aug 2022 21:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4D0614CC;
        Fri, 26 Aug 2022 04:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BA1C433D6;
        Fri, 26 Aug 2022 04:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661489804;
        bh=b+RI5o5YmlV7YRcmNodCky267Qbp9qGWKb/djtyTr9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8dMCOkiJ9+1adaxVvCI57NYV6wTFuDAeUni9Yq2MvC9OqpXw+XQgW2U3PPN3j932
         a8GYAIdcPzqmZix6WwmN1GX4WQhUY69UKWRU7Elphidac1fuTk/wEb9LLyXZ1nutdt
         bjW1SdQLyyaqyFqHjQciftd6YKPLYjjC217N+5PGPYRoc2NaL5RK5mH9PTJEdJpufY
         1sze9Taxeln4Lf/rI3mGr4YyCt760DIxjcGFpFdqS4tsDQBqtFZQ8+RJNO5qFcduD9
         K2HUh6pBrX3PTD+hHCmPRhV1EQY2DlgHbw44IMV4T4T280r+zYu3uIy+lIIrN1rDvv
         fidonidW8OFwA==
Date:   Fri, 26 Aug 2022 10:26:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: Specify which LDO
 modes are allowed
Message-ID: <YwhSh3Toswds25Gi@matsya>
References: <20220825164205.4060647-1-dianders@chromium.org>
 <20220825094155.7.I6799be85cf36d3b494f803cba767a569080624f5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825094155.7.I6799be85cf36d3b494f803cba767a569080624f5@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-22, 09:42, Douglas Anderson wrote:
> This board uses RPMH, specifies "regulator-allow-set-load" for LDOs,
> but doesn't specify any modes with "regulator-allowed-modes".
> 
> Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") the above meant that we were able
> to set either LPM or HPM mode. After that commit (and fixes [1]) we'll
> be stuck at the initial mode. Discussion of this has resulted in the
> decision that the old dts files were wrong and should be fixed to
> fully restore old functionality.
> 
> Let's re-enable the old functionality by fixing the dts.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
