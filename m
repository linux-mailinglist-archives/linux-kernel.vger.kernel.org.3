Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E74CE516
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 14:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiCEN4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 08:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCEN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 08:56:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7BE1CABC5
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 05:55:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 491DCB80C70
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 13:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E65DC004E1;
        Sat,  5 Mar 2022 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646488527;
        bh=BQrokMzSMloe/hyjVeBHCLDN0uRptwXDCXljI99iSGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjIAle22LuRoNHbItvtz5QjSdGbq1MZjYCdl1AcMg7OlUzfENaPvI9sCCynbnn903
         oxjhERhiWX0Hb8MU9JkY7ZF54ZL1HDQii67RN47huVWuAo2CtdIyOPQsGbAgRbrm8z
         OygsfFEKIuzNf8aqHKsAagzzfYBaQq7n2iL5yjXQ=
Date:   Sat, 5 Mar 2022 14:55:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     Juergen Gross <jgross@suse.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] drivers/xen: use helper macro __ATTR_RW
Message-ID: <YiNry3TtIPbEh1Yr@kroah.com>
References: <20220305133823.158961-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305133823.158961-1-zhanglianjie@uniontech.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 09:38:23PM +0800, zhanglianjie wrote:
> Use helper macro __ATTR_RW to define HYPERVISOR_ATTR_RW to make code more clear.
> Minor readability improvement.
> 
> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

Is this the name you sign legal documents with?  (I have to ask...)

> 
> diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
> index feb1d16252e7..fcb0792f090e 100644
> --- a/drivers/xen/sys-hypervisor.c
> +++ b/drivers/xen/sys-hypervisor.c
> @@ -22,11 +22,10 @@
>  #endif
> 
>  #define HYPERVISOR_ATTR_RO(_name) \
> -static struct hyp_sysfs_attr  _name##_attr = __ATTR_RO(_name)
> +static struct hyp_sysfs_attr _name##_attr = __ATTR_RO(_name)

Why change this line?  That's not relevant to this change :(

thanks,

greg k-h
