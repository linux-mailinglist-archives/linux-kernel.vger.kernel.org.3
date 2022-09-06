Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A109E5AF129
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiIFQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiIFQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:52:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3674B494;
        Tue,  6 Sep 2022 09:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 576F2B81964;
        Tue,  6 Sep 2022 16:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569EFC433D6;
        Tue,  6 Sep 2022 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662482317;
        bh=eQ5+XKXqdtGnzidAkNykrhk1JJxorB0+TRmNZOG3BCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QG1zgRJMPAYtixifKxff3ih22fSuWn5LwI2SgKjTmOg0oMDYlCXInr9uoq72tGWhf
         4DmjaQHRXlNZ9BhzuNbrM0UNwPFtRtgSEuIOp4Z5f3mOd6tSCt/mj+VfXsJv12ve/2
         NaZ2gXBxbYO996Gev4OeuQ/1YmJuJVJN8DX0dy7jQ1LYwY6lnNBzhccJLnp/0eDnFP
         rlmRtcuNaWNwRPKTgOcHYn8kmF+gf8IErbzNMRX4qtXQ5DUZm4+WL9hwFChXyObTqg
         N/u8mS/D9NbdS63yiwq7Hf5thvLAuW17odp/JqQQC9t3/Y+oR+9MjDngVUocELqqM6
         vr6Jl/DzTAbsQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: mark USB controllers as wakeup-sources
Date:   Tue,  6 Sep 2022 11:38:29 -0500
Message-Id: <166248229987.53237.16880330839276179089.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902081652.12631-1-johan+linaro@kernel.org>
References: <20220902081652.12631-1-johan+linaro@kernel.org>
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

On Fri, 2 Sep 2022 10:16:52 +0200, Johan Hovold wrote:
> The primary and secondary USB controllers can be used to wake the system
> from suspend so mark them accordingly.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: mark USB controllers as wakeup-sources
      commit: ae240fbffbad6b2f1fc7f2d2f0bb8cf300c489a5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
