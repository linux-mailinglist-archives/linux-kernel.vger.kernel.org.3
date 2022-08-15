Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D875C592996
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiHOG3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHOG3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:29:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C01A070;
        Sun, 14 Aug 2022 23:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0AD4B80B8D;
        Mon, 15 Aug 2022 06:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB7CC433D6;
        Mon, 15 Aug 2022 06:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660544940;
        bh=msiJ57i3RqcfN26mM82wBD0lWh7NBADgC1IhxLozSbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkmSRmrGWmBg1v/nvxcseOia4EwffJWALIvgjZQWXxz8IQ6lc+KpgyxzKKR1CKCF+
         +y9YlGQ34Zzrl0fZAIhDveNEcLNdedPyjSzcljRrzz+ooOW9mOPXp6xSsOcQo342XY
         lUw94NwSBuVTYWVMaJVMTObfj+XIQc+vn/sRT9r8=
Date:   Mon, 15 Aug 2022 08:28:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Prevent infinite loop
Message-ID: <YvnnqDwLUEiDVfs3@kroah.com>
References: <20220814174404.25923-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814174404.25923-1-Larry.Finger@lwfinger.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 12:44:04PM -0500, Larry Finger wrote:
> ---
>  drivers/staging/r8188eu/core/rtw_ieee80211.c | 3 +++
>  1 file changed, 3 insertions(+)

No changelog or signed-off-by?

:(
