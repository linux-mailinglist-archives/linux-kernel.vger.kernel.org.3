Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD15852CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiG2PgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiG2PgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9702A863E9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3312C61194
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DABEC433C1;
        Fri, 29 Jul 2022 15:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659108967;
        bh=dc+Yq1KU2LevdXHCY6u4sGEuoDgnzP0NMKytWaNyyMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ev/fhjtfSa1TXvCqtpE5mVwsv7VgFjLuWQEk5xDO0/M+CjbMQ4hax4v2SOm5/fW+L
         /aRCdmFSZ7/hAfn6szljNfpyKvz2bCVAC4T9tCaHT8rJwOif+uACq0PKObaUPS7wf/
         uFB0iZxHp/CpX2xqj9Ajr+ulRt34cPuMS8M8hWqQ=
Date:   Fri, 29 Jul 2022 17:36:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix wrong comment
Message-ID: <YuP+ZECjYV6KyFcB@kroah.com>
References: <20220729152554.8211-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729152554.8211-1-realwakka@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 04:25:54PM +0100, Sidong Yang wrote:
> The comment should describe the error when user calls rf69_write_fifo()
> not rf69_write_fifo().
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/staging/pi433/rf69.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> index 659c8c1b38fd..8c7fab6a46bb 100644
> --- a/drivers/staging/pi433/rf69.c
> +++ b/drivers/staging/pi433/rf69.c
> @@ -816,7 +816,7 @@ int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
>  
>  	if (size > FIFO_SIZE) {
>  		dev_dbg(&spi->dev,
> -			"read fifo: passed in buffer bigger then internal buffer\n");
> +			"write fifo: passed in buffer bigger then internal buffer\n");

This is not a comment.
