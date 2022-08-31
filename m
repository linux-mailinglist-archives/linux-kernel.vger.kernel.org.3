Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6555A80DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiHaPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiHaPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E352DE7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C045E60A71
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C970FC433D6;
        Wed, 31 Aug 2022 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661958345;
        bh=Q6d3pDRoHtTi4NS/RK8aEsh0CDoq9zHRXkuK0tuD5mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAzm/pYjBtK92yRC1zmrWaRRsimNleP4z4iPkPHSjZMtGi8dzdDwzhd7zFXiZUXlb
         0MnMkn8CIhLn36hDhWXHfoRgGKOLdxlroVcndMB7GKmE///z6RtRXJ9n7UVpx8B/KF
         wFRWt8qZ2Ke8rYx7eVqmMLhgJnb6OdsykqKmPNc4=
Date:   Wed, 31 Aug 2022 17:05:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] staging: r8188eu: remove redundant variable
 ret
Message-ID: <Yw94xsOp6gvdS0UF@kroah.com>
References: <20220831144529.304636-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831144529.304636-1-cui.jinpeng2@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 02:45:29PM +0000, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Return value directly from rtw_set_wpa_ie() instead of
> getting value from redundant variable ret.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Again, please read the documentation for how to properly report issues
found by research tools.

> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

And again, how do I know this is the correct address, it was sent from a
random gmail.com address.  Until I get some sort of confirmation from
the zte.com.cn developers that I can accept patches from patches outside
of their domain, I am going to be safe and not do so.

thanks,

greg k-h
