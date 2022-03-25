Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B564E70AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358548AbiCYKK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357855AbiCYKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DEE3DDD5;
        Fri, 25 Mar 2022 03:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65BF60F90;
        Fri, 25 Mar 2022 10:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0D2C340E9;
        Fri, 25 Mar 2022 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648202952;
        bh=eyce1/xSBeTyjY0v43VNDgFQNPcxEbscZUL/X4uC6yY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cAdtU5fIAqHbF60Zc9Kp6EIoEq4oXsgOoGd01hUTOOfWahd0TAX0J32i5SAvZG5NY
         oE9zqjIh6fuTGJoSSaEgXZJfCi3n5sEO4qx2L5FZJNIW4w7aBS6fZJK+wpqPSZx47E
         EGrczuaOLDqpAs+xdCVm/Tap/vHzAHbRLiaUfMwDCjHKFxmqp4uc15j4GosoeLhcfK
         S2hGC62FggN8BR4EJ2F2GGGb/M+ZdDhqECqsL5stOC8j2IQokJNj8sw7u1XrpMkLDH
         A2NF59B3m0geeOsf/8UAR/2ZCH5QG4e42Qo0nlsh4Hzld6RfDq6Uuhqv7gkH1i5Ida
         o4/BHNJl0LIPw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <b43-dev@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] wireless: broadcom: b43legacy: Fix assigning negative value to unsigned variable
References: <1648109173-28403-1-git-send-email-baihaowen@meizu.com>
Date:   Fri, 25 Mar 2022 12:09:09 +0200
In-Reply-To: <1648109173-28403-1-git-send-email-baihaowen@meizu.com> (Haowen
        Bai's message of "Thu, 24 Mar 2022 16:06:13 +0800")
Message-ID: <87ee2q8htm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haowen Bai <baihaowen@meizu.com> writes:

> fix warning reported by smatch:
> drivers/net/wireless/broadcom/b43legacy/phy.c:1181 b43legacy_phy_lo_b_measure()
> warn: assigning (-772) to unsigned variable 'fval'
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: modify title of this patch
>  drivers/net/wireless/broadcom/b43legacy/phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The prefix should be only "b43legacy:", I can fix that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
