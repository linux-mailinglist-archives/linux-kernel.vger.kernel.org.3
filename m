Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0853784F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiE3Iyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiE3Iyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C968B79803;
        Mon, 30 May 2022 01:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FAA60F5D;
        Mon, 30 May 2022 08:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24D5C385B8;
        Mon, 30 May 2022 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653900858;
        bh=yEKVmMWK6lyNhSCmKPWhzyc4BzhgTKEYjm2tPlbe8uo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=X/KDvl6KPIRfTvroX/sm7epzNqtcT4vTaafU5hMARos7ERYM6vWOgchH7gLo4Tx+1
         f0+TKkogF6+Z9sqW9ayj1GZT5Xg6LgzPR97rBQ5bMQV24EVwwaA5qlLN4rJ35edSSn
         1kqFZX9P/bb9s9pyEpyiZgZO4iMGM3IHRMrl0aPH9nuU/Sg+MaOtgKVfXeueO3ZTL4
         rxTlIuak7mSOD1VQd7o+BmzmiYnXAOU99r3mRugXG5//Bhj5Q13jygasATQLN6vOyB
         aM27ya63BbEEeKkLK1LLG54xcfp96dkOTd34zGf8287vfqdJsz+tm34YRXxqWqg3su
         WBRk7iklIfj+A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: wireless for-next branches
References: <87a6b3qrms.fsf@kernel.org>
        <20220528102053.3733f275@canb.auug.org.au>
Date:   Mon, 30 May 2022 11:54:13 +0300
In-Reply-To: <20220528102053.3733f275@canb.auug.org.au> (Stephen Rothwell's
        message of "Sat, 28 May 2022 10:20:53 +1000")
Message-ID: <87ilpnpfii.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> On Fri, 27 May 2022 11:58:03 +0300 Kalle Valo <kvalo@kernel.org> wrote:
>>
>> We are experimenting how we could take "next-next" patches during merge
>> windows and avoid accumulation of patches for the period which is in
>> practice three weeks for wireless patches. To do that could you please
>> change linux-next to pull from wireless trees for-next branches instead
>> of main branches? So the new locations are:
>> 
>> git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
>> git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git for-next
>> 
>> The idea we have is that wireless-next for-next branch is not updated
>> during the merge window and then the "next-next" patches will not be
>> included in linux-next until the merge window has closed.
>
> OK, I have switched to using those branches.

Great, thank you Stephen. I now took the first patch[1] to wireless-next
main branch but you should not see it in for-next branch until the merge
window is closed.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=d092de2c28dcf752890252dedefed98f00a631fe

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
