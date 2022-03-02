Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B74CA8B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbiCBPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiCBPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD815CA0C9;
        Wed,  2 Mar 2022 06:59:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A6FBB81FF0;
        Wed,  2 Mar 2022 14:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2209C004E1;
        Wed,  2 Mar 2022 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646233195;
        bh=Jhsap+PkSgxDrt7pvTl2cBBZSrc2xf7495eMI/c4pZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZRuRYb4AQIGNWUjBDgwaf1uy24hGJgFGcQd9sPZuA9SOJ+aVj008dpXBEq8VFOHL
         VXXfihl8rhy+MXireYBoGEXgR8N681Zuqguu53kLuD7XturTcLA22ZRKLW+nMNe3B9
         UjgEssVfMVkj4GdncAQhBbf0hJQ1WtQrI1zDWxJ8=
Date:   Wed, 2 Mar 2022 15:59:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/1] tty: n_gsm: improve standard compliance and feature
 completeness
Message-ID: <Yh+GaDd5UlB/D5Ll@kroah.com>
References: <AM4PR1001MB13789D432A1DB69A1B35B0A6E0039@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR1001MB13789D432A1DB69A1B35B0A6E0039@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:47:20PM +0000, Starke, Daniel wrote:
> Thank you for this quick response.
> 
> > I'm sorry, but there is nothing we can do with such a large patch here at
> > all.
> > 
> > Please break this up into "one logical change per patch" and we will be
> > glad to review it.
> 
> You are absolutely right but this is still work in progress. The attached
> patch was only for reference for all those who would like to look at the
> changes in detail or try out the proposed work. This was not a request for
> code review yet. Also, it seems that the patch was too large for the
> linux-serial mailing list so I have uploaded it here for reference:
> https://github.com/siemens/linux/tree/dstarke-siemens/n_gsm_rfc

You need to provide a set of patches for people to review.  Random code
dumps and random github links are impossible to review cleanly, would
you want to to so?

thanks,

greg k-h
