Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021924F08EC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356865AbiDCLJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356239AbiDCLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A333A16
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 473AA61035
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EB4C340F0;
        Sun,  3 Apr 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648984068;
        bh=ae0jltCb48+Ke4PQpK6k3uFtZb+n1BcGsnMWDqiF28Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcYV+L9e1E30l+3EXxRrwcwECGEYr3PCM54Nmj92a+5eU3ffp0aQmp5TugrZqCaZJ
         r8yiRoOm3wfYPQhM2CSD7Sz8GjBNVtJKy86hFqBK39O2N5wsuUVjsEmFtoaZ29jeAh
         kYMuh2tRPc6V1iMsqK+I2dt3bKD23GWKAIDg1Nm8=
Date:   Sun, 3 Apr 2022 13:07:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, jerome.pouiller@silabs.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: remove space at the start of a line
Message-ID: <YkmAAmpl1/pdkdy5@kroah.com>
References: <20220402114831.14977-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402114831.14977-1-eng.alaamohamedsoliman.am@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 01:48:31PM +0200, Alaa Mohamed wrote:
> Fix " WARNING: please, no spaces at the start of a line"
> Reported by checkpatch
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/wfx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index b93b16b900c8..e575a81ca2ca 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -170,7 +170,7 @@ bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
>   *
>   * The PDS file is an array of Time-Length-Value structs.
>   */
> - int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
> +int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
>  {
>  	int ret, chunk_type, chunk_len, chunk_num = 0;
>  
> -- 
> 2.35.1
> 
> 

Someone else already did this change, sorry.

greg k-h
