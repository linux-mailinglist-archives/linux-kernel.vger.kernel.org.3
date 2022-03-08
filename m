Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424694D1416
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbiCHKBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345586AbiCHKBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:01:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F04D424BA;
        Tue,  8 Mar 2022 02:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C884B81852;
        Tue,  8 Mar 2022 10:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A211C340EC;
        Tue,  8 Mar 2022 10:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646733610;
        bh=i9OsW0AxWUwQAqlooc3ym6MdFnqZBd8K+5Fvlrk6mtU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ckuT8PXN7SFaIJqlzPOteFj+N41XPUi/lgSmPd73URwm6TZgybje+FEe++jWtUObn
         B0WKkxsEHzpzIdfW4TqdKsEbhtXvD/LFaSLzqXnlR1dR+0Vi0JWrcAAlXxLaEwRc36
         aMSFEtLBEBU5mopwbCP7GEenk9ts3TpohdI7eFUyQ7gDTXV+8jgaFi+uoZ6eiA09Dm
         1D7938BniNvXaWXOgVS8giW362QJ+FzLA5avakNRIHx6jo8PVU90RCYeo7ItSIvvlS
         zfjyxpRcTcy6rWrcDC84EyMxQVi/FHphI2oUziOCuHFdxUpp6CvtSW9MuRpSL3BtdH
         iajV0MXm1oyEA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     ath11k@lists.infradead.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
References: <20220308071827.9453-1-lukas.bulwahn@gmail.com>
        <87o82gsvqf.fsf@kernel.org>
        <CAKXUXMwhMuUCzATH15GD7was8SkHqcYz-8swTMdE+wuE0yvknQ@mail.gmail.com>
Date:   Tue, 08 Mar 2022 12:00:04 +0200
In-Reply-To: <CAKXUXMwhMuUCzATH15GD7was8SkHqcYz-8swTMdE+wuE0yvknQ@mail.gmail.com>
        (Lukas Bulwahn's message of "Tue, 8 Mar 2022 09:57:02 +0100")
Message-ID: <87k0d4sr17.fsf@kernel.org>
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

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> On Tue, Mar 8, 2022 at 9:18 AM Kalle Valo <kvalo@kernel.org> wrote:
>>
>> + linux-wireless
>>
>> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>>
>> > Commit dae0978d4174 ("dt: bindings: net: add qcom,ath11k.yaml") obviously
>> > adds qcom,ath11k.yaml, but the file entry in MAINTAINERS, added with
>> > commit fcda1cb81663 ("MAINTAINERS: add DT bindings files for ath10k and
>> > ath11k") then refers to qcom,ath11k.txt.
>> >
>> > Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
>> > broken reference.
>> >
>> > Repair this file reference in QUALCOMM ATHEROS ATH11K WIRELESS DRIVER, and
>> > put it in alphabetic order while at it.
>> >
>> > Fixes: fcda1cb81663 ("MAINTAINERS: add DT bindings files for ath10k and ath11k")
>> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> > ---
>> > Kalle, please pick this minor non-urgent clean-up patch.
>>
>> Can you resubmit as v2 and also CC linux-wireless, please? This way I
>> can pick this up directly from patchwork.
>>
>
> Sure, I just did so, see:
>
> https://lore.kernel.org/linux-wireless/20220308085503.537-1-lukas.bulwahn@gmail.com/

And I see it in patchwork now, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
