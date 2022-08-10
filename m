Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3B58EB20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiHJLTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiHJLTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:19:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B69573308;
        Wed, 10 Aug 2022 04:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C6B7B81BAF;
        Wed, 10 Aug 2022 11:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B59C433D6;
        Wed, 10 Aug 2022 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660130373;
        bh=X0Dx4RYXPPgSwq3dSx31zh+0lkNI4E93qtEQIfX5yyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKoIvevfer1gE+GyoNAShnJTZSSatsRF/xT2hFY10zfqJcBQrdJ9OTAtS4TMwlc+d
         iko40pplaUL4WQj7Xi7Jbqauk17VOKqu/UwaJYGoG9UWmna8xotQOCRrcJ95ydiGXx
         JNOU4nUfFhXdQ0Ue51c5rmj3P3RXBVlDULFsob5/ZdAQT0nxedSaF3yxTKao7fYnYe
         7aH8nOCPpqcTg78w6Cb1XwBMbbsJrr/g/ChxlF27Gm4SuGM1mBlCH5Vzk2MgohYAoI
         fA3VhlDOWSkY6PnbTV2wzrS/yQpHchPKYGGtsACjRMe00lk6qgQPKq6d0sXfZsZpjB
         tJPTxgUXW1E0Q==
Date:   Wed, 10 Aug 2022 12:19:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl-core: Fix comment typo
Message-ID: <YvOUQWzv3ViXbmZR@google.com>
References: <20220802201757.8142-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802201757.8142-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022, Jason Wang wrote:

> The double `to' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/mfd/twl-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
