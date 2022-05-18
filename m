Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4084452B1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiEREvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiEREvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873A183A4;
        Tue, 17 May 2022 21:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318816170D;
        Wed, 18 May 2022 04:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069B1C385A9;
        Wed, 18 May 2022 04:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652849509;
        bh=mddUWqFjVahApHjz2992Fu3x2eZivf5CIBAVp5SQNug=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JRLyl9Z80DWdm5zcHmW/P5eCLNtKApwbNCLboSBg6NDegSDCpd5p6G1T954fvo/A8
         tCMAmc2Sgj1M+yjs+ss8jtJnR/AHDq6sTC6rnmwdT/EZ7qlSapUx7WNccXcHWBhNhS
         v807gVmISMU16DXFVIuHjLrlE52K9U0qaFM79S197LAcktQIwq0nvpvRISFQRD0Z9W
         OCkq7GDdFMsbaBmBXniaLpl9+WYmCS4wPYIxLRN4oOzZBias59GRrOEMFKhLIrHJIx
         98sseOtfNCRY2Wl10cwK4PJqv5lfwry0Ag+kDWQXIy9Z0OOf9H3jRgJe61Ex6wIM9T
         bP05FbFmJMuTg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the wireless-next tree
In-Reply-To: <20220517200024.3bc972ed@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 17 May 2022 20:00:24 +1000")
References: <20220517200024.3bc972ed@canb.auug.org.au>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 18 May 2022 07:51:43 +0300
Message-ID: <877d6j4f4w.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the wireless-next tree, today's linux-next build (htmldocs)
> produced this warning:
>
> include/net/cfg80211.h:1188: warning: bad line: attribute is present
> in beacon data or not.
>
> Introduced by commit
>
>   3d48cb74816d ("nl80211: Parse NL80211_ATTR_HE_BSS_COLOR as a part of
> nl80211_parse_beacon")

Thanks for the report, Johannes fixed it in this commit:

https://git.kernel.org/wireless/wireless-next/c/ee0e2f51e211

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
