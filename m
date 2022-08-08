Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9909058CB3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbiHHPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbiHHPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D1513FBD;
        Mon,  8 Aug 2022 08:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E94AC60FF6;
        Mon,  8 Aug 2022 15:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC12DC433C1;
        Mon,  8 Aug 2022 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659972288;
        bh=4XY3xBz5yQioCmLh6CZ+vJkSZt3r2PnoAwGejge7qto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5IG8qBVtvxtRh2rTlcciIqRrsSdXOJaFyViVj5ViDq/7AyyODBFaPUbVe47hzupq
         3dZ1lFTDEp6MO+e+qHgG0yT8IQ2mGBserPwm1JaFbvR8R8sT8E3ZKfukFo1SQYvVhU
         Yl9o5i3xQiWT1atahADKUcmvOAtCEwZPJWDisG7c=
Date:   Mon, 8 Aug 2022 17:24:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: fsl_lpuart: Remove repeated word
Message-ID: <YvEqvf6rk+nde6vT@kroah.com>
References: <20220808151537.846-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808151537.846-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 11:15:37AM -0400, shaomin Deng wrote:
> Remove the repeated word "as" in comments.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>

Shouldn't this be "Shaomin Deng"?

thanks,

greg k-h
