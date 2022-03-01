Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FBE4C97D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiCAVdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiCAVdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:33:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8AA76E05
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBAEBB81DC7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 21:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E9AC340EE;
        Tue,  1 Mar 2022 21:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646170384;
        bh=zE5U46KEpiwIEu/kdY8+1tmSvfPUtdtjtmQqm1hgKqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCd8bX5e5w0bK9HR+1GZFoX4DBLQmRuWh04a36e21zm0vzMvjxmOgrvUN0Eazy1ds
         FCaWt2mRzcLdNNJyEii+QExTNGAJw3ekERTmMT59ts0nSpDZrscwF/d454HdPbJV9r
         aHt+JbmZfaX1F5bCfycXd18FM1WJ0soVucNb3nFg=
Date:   Tue, 1 Mar 2022 22:33:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel =?iso-8859-1?Q?Sj=F6berg?= <info@samuelsjoberg.se>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: fix Lines should not end with a '('.
Message-ID: <Yh6RDn1+q6yfo1EG@kroah.com>
References: <20220301205936.3096-1-info@samuelsjoberg.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301205936.3096-1-info@samuelsjoberg.se>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 09:59:36PM +0100, Samuel Sjöberg wrote:
> Fix the following error reported by checkpatch.pl:
> 
> CHECK: Lines should not end with a '('
> +                                       retval = ms_transfer_tpc(
> 
> Signed-off-by: Samuel Sjöberg <info@samuelsjoberg.se>
> ---
>  drivers/staging/rts5208/ms.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

This does not show up on lore.kernel.org, are you sure your email domain
is correct?  I get a failure when trying to verify your email using
normal tools, so I think it is getting dropped.

thanks,

greg k-h
