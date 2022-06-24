Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F95598D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiFXLos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiFXLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A0C7B365;
        Fri, 24 Jun 2022 04:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9D6962222;
        Fri, 24 Jun 2022 11:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6D4C341D1;
        Fri, 24 Jun 2022 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071081;
        bh=YK2Ek2q6SWaurj+mwbe4aRq+eTo2QFWvVCr3vWvbI98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sf0vzHEIm/e8/H3sL9dW99J+FZlqpKu7qen31FC9Pa8eR1TNWGhCjj40RTEyns/a2
         76QcGHwzr0Np5Uwc87MygP+jT4OSgIMt4hWUavExiBI/9U29Aee9HbQ6cMVML5qltL
         BKO0/SdZ15NcrJpbDvE2yADKEO5DwO7Uu9hdd5tM=
Date:   Fri, 24 Jun 2022 10:31:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhoun <zhounan@nfschina.com>
Cc:     balbi@kernel.org, lutovinova@ispras.ru, jakobkoschel@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: remove unnecessary mv_u3d* type casting
Message-ID: <YrV2aQc8lB6wDEbE@kroah.com>
References: <20220624082651.6804-1-zhounan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624082651.6804-1-zhounan@nfschina.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 04:26:51AM -0400, zhoun wrote:
> remove unnecessary mv_u3d* type casting.

Why do this?  Don't just copy the same text as the subject line.

> 
> Signed-off-by: zhoun <zhounan@nfschina.com>

Please use the name that you use to sign legal documents with.

thanks,

greg k-h
