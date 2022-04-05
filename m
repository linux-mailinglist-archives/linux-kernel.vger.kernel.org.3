Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E464F4B92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575111AbiDEXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392156AbiDEPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:35:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121594833A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA5CBB81BA9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDF1C385A0;
        Tue,  5 Apr 2022 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649166413;
        bh=pAirV066m2Mk+Gq9JHNPQKz4ZdQFBmx7aDmrA3JqHZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kldms96GddMs7OjzLMMO6ih82ytSwJcXHcStrjbrMsbg8HssmGCTXFRBWa4cgC6+L
         Tg1OxlJBlSK+FkbKC5Jq5GQBlGRVGA07ftRe+osjG6RILregfrNyTQ0tLhKhfRiJdQ
         i9XFvXJQGTCC7KSdxso/OGukUuDtHscXAhEADDUI=
Date:   Tue, 5 Apr 2022 15:46:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: add space around arithmatic sign
Message-ID: <YkxIS2H0XX6LzDzu@kroah.com>
References: <860d8e222e2b695ce5cb4f48aa46a7f66e05d8e4.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860d8e222e2b695ce5cb4f48aa46a7f66e05d8e4.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 04:39:16PM +0200, Alaa Mohamed wrote:
> Reported by checkpatch:
> 
> CHECK: spaces preferred around that '+' , '-' and '*'
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 58 +++++++++++------------
>  1 file changed, 29 insertions(+), 29 deletions(-)

This patch does not apply to my tree and branch.  Please rebase and
resend it against the staging-next branch of staging.git.

Patch 2/2 did apply.

thanks,

greg k-h
