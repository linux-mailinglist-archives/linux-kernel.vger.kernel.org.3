Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55605AF127
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbiIFQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiIFQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F73F311;
        Tue,  6 Sep 2022 09:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC00615B7;
        Tue,  6 Sep 2022 16:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766CDC43470;
        Tue,  6 Sep 2022 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662482316;
        bh=KEpbKt66l9sCTUFfmDd2b3xY1+TFKtKOmYVhS22vNA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgcHueDcUFNEPl7/jEGbgahKcdaWl/BjpGXqCerVbbzqbmdVerP/dZmn5qx9lnjTe
         D9FFGULBJw/XBR2Nlk0HI2O/GmLIiNtoWwtupszE5v+Ev6z6BxiF0z0jRqQqH8r/Zc
         qUy46DLLrNu9l77hnDcwY0gTBx+nFSBh19P4DYOme4GFz3EGD48fJZxcS8hmmrUeuu
         gVtNNhl5xji7ypHhILqSGEpdcHd+U0uC2kiKBViRVEEMWIYOlBIK/mgFIuV3qf9CAZ
         EPv8pkpB2fSpTInIDNMQDXVMGc503sfTxtvw32Ufqa5wJnx6EfyEFnniC0Zq/qI+wc
         lfQ8Wazda/Ypw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: fix syscon node names
Date:   Tue,  6 Sep 2022 11:38:28 -0500
Message-Id: <166248229987.53237.6015317709476261540.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220905091602.20364-1-johan+linaro@kernel.org>
References: <20220905091602.20364-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 11:16:02 +0200, Johan Hovold wrote:
> Some recent changes that added new syscon nodes used misspelled node names.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: fix syscon node names
      commit: d0909bf4fa0fd79f59813952d868d0ad2fab656a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
