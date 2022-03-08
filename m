Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDAA4D11F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbiCHITi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiCHITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:19:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91AB3ED34;
        Tue,  8 Mar 2022 00:18:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B8A4B81606;
        Tue,  8 Mar 2022 08:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FECC340EB;
        Tue,  8 Mar 2022 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646727517;
        bh=ygSAw4GGLQGv6N4KsfuHh/vPdd3G0JUAnVR+GtrH+MY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HmwMHu211dwZoi8TsqIQveHsiyeoAzPeKeLKxG4Z5/kFSaVuSwlqy6RwHndHUjrCr
         rdb6jH2F9lwM6rYZoA+1omJZwx8qy0WGf4U4m7UM+myis5xw/GKzkcAWzO7/6xHA1r
         ygxJKJIqsJvaUb1eH3I7O4wR1Cwvl+YcJEZIhcykRwMRxkksBHRQsjBjxjTwwZsA2K
         o1RKI3XQ+VwThy26OhqgVwP7Uv43AshzzJzcc9Qqt68hEag30x/TDxqD7VRnC2d+K2
         /+290UB4AXgi2xvI6ZT2AuMfxMO2qMEhG7Uwp7jHbBa1X/KigKPX6e+ldC0s/6TWCx
         ku2Li4FbSDOXA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     ath11k@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
References: <20220308071827.9453-1-lukas.bulwahn@gmail.com>
Date:   Tue, 08 Mar 2022 10:18:32 +0200
In-Reply-To: <20220308071827.9453-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
        message of "Tue, 8 Mar 2022 08:18:27 +0100")
Message-ID: <87o82gsvqf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-wireless

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

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
> ---
> Kalle, please pick this minor non-urgent clean-up patch.

Can you resubmit as v2 and also CC linux-wireless, please? This way I
can pick this up directly from patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
