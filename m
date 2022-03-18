Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB14DD9DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiCRMlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8119058F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D97261881
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2A9C340EF;
        Fri, 18 Mar 2022 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647607217;
        bh=ZA323EVVkXsmrdgSxcki3reK2+6GUk4NIqkVW8J3lxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8M3Q+5b4i20eSyD5Ow4JukOI793myUSpQcHWKSJX6m1cHgfE4xgiSbl4+2sluHc/
         iBeteaTjkyIx+0ZFh+JqpgDGCbzHvI1u5ZWA+A+tzizSQo6By3AWqmg/cVt+Jj59jP
         MIlu9yGYSVHixzIMnkVi3k8LYtlAvmBN+sWS76V8=
Date:   Fri, 18 Mar 2022 13:40:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hatim Muhammed <hatimmohammed369@gmail.com>
Cc:     linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com
Subject: Re: [PATCH 6/8] [Staging]: Removed an unnecessary #if
Message-ID: <YjR9rh/TEhp0K9wg@kroah.com>
References: <20220309091213.13203-1-hatimmohammed369@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309091213.13203-1-hatimmohammed369@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:12:13AM +0200, Hatim Muhammed wrote:
> From: Hatim Muhammed <hatimmohammed369@gmail.com>
> 
> This removed #if had 1 as its condition, hence it's body will always
> execute and its #else block will never
> 
> Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>
> ---
>  drivers/comedi/drivers/s526.c | 49 -----------------------------------
>  1 file changed, 49 deletions(-)

Your subject line is very odd.  Where are the 8 other patches?

Please fix it up and resend the whole series properly.  I've dropped all
of your pending patches from my queue now.

thanks,

greg k-h
