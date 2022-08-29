Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548345A57DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiH2Xqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiH2XqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E17E98588;
        Mon, 29 Aug 2022 16:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A752C61388;
        Mon, 29 Aug 2022 23:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752EDC433D7;
        Mon, 29 Aug 2022 23:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816782;
        bh=QVaf2ue7rS2/KW2MEYsbOa8mov9wyGulpZZV3uEQCMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udwLe6vzml7QcPwXO2cIuPXu5XRo5PE55iGm+k3x0SnchoGhpn+wIDZopvjd0cXCy
         sBCZpWQH5qJyCcqjoi8HzmqHAbmAL6E3JvhbfIs1+4Szdm0p6Qfuk61lF+xolJl2jE
         YKXxhDodUMqib3MzvdK614DhaB21gFXWIbRmsr7P/1POmHKwbgb46Fth74s+NtXn3p
         CLbtxkch72OrdrcHhjEsJPo9ND1rUlOax46YJPHEBge/EzxkQQfhctxox7uvbuQBlr
         Pf3h1f5pLygOf8cLPHHQLrFwuqWGg4bPY10J93gAzZVgggM80ki3IQR0JZIqxRd1Q1
         jOTvnPKEdwO/Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cgel.zte@gmail.com, krzysztof.kozlowski@linaro.org
Cc:     zealci@zte.com.cn, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cui.jinpeng2@zte.com.cn,
        konrad.dybcio@somainline.org, agross@kernel.org
Subject: Re: [PATCH linux-next] soc: qcom: icc-bwmon: remove redundant ret variable
Date:   Mon, 29 Aug 2022 18:45:44 -0500
Message-Id: <166181675990.322065.10141952054506036858.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823133620.211902-1-cui.jinpeng2@zte.com.cn>
References: <20220823133620.211902-1-cui.jinpeng2@zte.com.cn>
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

On Tue, 23 Aug 2022 13:36:20 +0000, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Return value from devm_regmap_field_bulk_alloc() directly
> instead of taking this in another redundant variable.
> 
> 

Applied, thanks!

[1/1] soc: qcom: icc-bwmon: remove redundant ret variable
      commit: 7eb89c17abd2574f627c1277a15f6ff64bec33a4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
