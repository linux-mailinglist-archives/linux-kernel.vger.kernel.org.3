Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB94DB4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbiCPPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiCPPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:34:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B027CF5;
        Wed, 16 Mar 2022 08:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19C31B81C13;
        Wed, 16 Mar 2022 15:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60621C340E9;
        Wed, 16 Mar 2022 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647444808;
        bh=ErcNptfdS+iULWkDCthzkd1Qlz8XmSgG7d9SHtOVd6w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r/2kQFJvaZjB7AWFCs8Q52daB1EaPRTWtGum0gkBvfbiNec39Pc9qIC8IAJHvXAxf
         z500tjRlXwl3m5mhyjj12lJFItWBC+6vnYT+di/0gMA/ldgwVAeDQ7QJIxN9z2If37
         KALcW4WG5W/tauDlpQmJgoBsEhkHgNe6E+U4dPsfKidozFEi+m2durbnr6pyry5NC0
         XwSoIjFdAjD0UNZJdLit7d6XCaNMzWC1HPc4lEVFeKGTOJnQuOer3Rb/oX4OCJWSHV
         6A+TxwpXC/fJrQ+ui279dWTFNKXj/vyvyBMUNvrSvnnmO9Y94Ij043kjGE6YEf7Zyl
         gOCG1H1ch9RAw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] MAINTAINERS: fix ath11k DT bindings location
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220308085503.537-1-lukas.bulwahn@gmail.com>
References: <20220308085503.537-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164744480556.16413.9130060448491474487.kvalo@kernel.org>
Date:   Wed, 16 Mar 2022 15:33:27 +0000 (UTC)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit dae0978d4174 ("dt: bindings: net: add qcom,ath11k.yaml") obviously
> adds qcom,ath11k.yaml, but the file entry in MAINTAINERS, added with
> commit fcda1cb81663 ("MAINTAINERS: add DT bindings files for ath10k and
> ath11k") then refers to qcom,ath11k.txt.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file reference in QUALCOMM ATHEROS ATH11K WIRELESS DRIVER, and
> put it in alphabetic order while at it.
> 
> Fixes: fcda1cb81663 ("MAINTAINERS: add DT bindings files for ath10k and ath11k")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Patch applied to wireless-next.git, thanks.

5df2dc0087e9 MAINTAINERS: fix ath11k DT bindings location

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220308085503.537-1-lukas.bulwahn@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

