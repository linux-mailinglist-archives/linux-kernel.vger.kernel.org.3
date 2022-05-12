Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5125249A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352358AbiELJ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352337AbiELJ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:58:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820E22EA63;
        Thu, 12 May 2022 02:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BBB0B82728;
        Thu, 12 May 2022 09:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178B5C385B8;
        Thu, 12 May 2022 09:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652349513;
        bh=kq14DywiWLmIjJ7CeeAFiu7DThWHwli6FpsxFOYnjgk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aCX1hDkfNTSfVLdYCM6R7yyJEj7szJz/ia3Yl3l8oFqnlmY1z9pocN2VIpi/ok91Z
         hpIH8CXFBQBH/J/D6qUAOUjJyXl1ZfbR+jOBzDdBDtA6EofD9MHPgT4vCARWFp4epr
         SLeCLFY1GTx1cbw8nIerNkt2/bDxkr5b1Wbgqm09yrfpGi6ucObTmPJBvSwN7Aq5nJ
         5Q6UKlxovGvq0qcuQYDrEJVIYspp83PwCvGdvnUnXD5iI0ot9PbKr1qdvWyR9TD3av
         xQ/GNMTqGXaNuEM91wS33lsDpDIsLKTXIHsr+1rze+jmgTX2oxv5t1vlpxycyKc9Jy
         a1RIwvxo5c1dQ==
Message-ID: <445dd693-f797-c4f9-3bf9-04185a54286d@kernel.org>
Date:   Thu, 12 May 2022 12:58:29 +0300
MIME-Version: 1.0
Subject: Re: [GIT PULL] interconnect fix for 5.18-rc
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220506085923.23816-1-djakov@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220506085923.23816-1-djakov@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.05.22 11:59, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains one more fix for the current cycle. The
> details are in the signed tag. It has been in linux-next during the
> last few days. Please pull into char-misc-linus when possible.
> 

Hello Greg,

I was wondering if this got missed or is it in your mail queue? Please
let me know in case anything is required from my side.

Thanks,
Georgi

> 
> The following changes since commit 2fb251c265608636fc961b7d38e1a03937e57371:
> 
>    interconnect: qcom: sdx55: Drop IP0 interconnects (2022-04-14 09:47:16 +0300)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.18-rc6
> 
> for you to fetch changes up to 20ce30fb4750f2ffc130cdcb26232b1dd87cd0a5:
> 
>    interconnect: Restore sync state by ignoring ipa-virt in provider count (2022-05-03 22:24:21 +0300)
> 
> ----------------------------------------------------------------
> interconnect fixes for v5.18-rc
> 
> This contains an additional fix for sc7180 and sdx55 platforms that helps
> them to enter suspend even on devices that don't have the most recent DT
> changes.
> 
> - interconnect: Restore sync state by ignoring ipa-virt in provider count
> 
> Signed-off-by: Georgi Djakov <djakov@kernel.org>
> 
> ----------------------------------------------------------------
> Stephen Boyd (1):
>        interconnect: Restore sync state by ignoring ipa-virt in provider count
> 
>   drivers/interconnect/core.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

