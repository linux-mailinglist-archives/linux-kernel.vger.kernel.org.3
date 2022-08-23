Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5980659E3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbiHWMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350191AbiHWMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD49AFD8;
        Tue, 23 Aug 2022 02:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5665B81C97;
        Tue, 23 Aug 2022 09:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD06C433C1;
        Tue, 23 Aug 2022 09:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247885;
        bh=GWrWHEXhlQQswpA6DAPgI155pHAU0QDTGhRNbc94k9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBhK42w6clG5tr9KERqU1VeCyWxJ5UMAC+OfOYEokZdnOV57txXemTdBlPQaDZtIl
         3hWXnnnijc0vkhG87pnFobGsKKcbHtF8pHUxJ3G68S5zHs7XCVCSYnN/T+Y6pLRqGt
         08K9JjxmWnuGCCvhROi5+P+6dG+8uRVQY1SrbWEk=
Date:   Tue, 23 Aug 2022 11:08:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH 2/2] thunderbolt: thunderbolt: add nvm specific
 operations for
Message-ID: <YwSY+SfCSioF/VQM@kroah.com>
References: <20220823090423.5249-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823090423.5249-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:04:23PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch depends on patch 1/2.

That's always implicit based on the naming scheme here, you never have
to say this in the commit message (hint, look at all of the existing
patches on the mailing list for how they are structured, there are
thousands of examples.)

> Add nvm specific operations for ASMedia.
> And add tb_switch_nvm_upgradable() of enable firmware upgrade.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---

As the documentation asked you to, you did not version this patch set,
nor say what is different from your previous ones :(

thanks,

greg k-h
