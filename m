Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37285598C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiFXLpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiFXLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016967B36C;
        Fri, 24 Jun 2022 04:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889376222A;
        Fri, 24 Jun 2022 11:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627FBC34114;
        Fri, 24 Jun 2022 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071105;
        bh=/2OHaS3MR1kb2k5L74fvco5RgmKK7foP/ilWbPMO+Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGpUqG7MHtWZJ87v8qMZ8ChuH6aRq0Gij61Z4bVzYhrhQQ75WsPx7c69tzhoaYEa/
         aE7zP6Dl4KJISHZSD46fhRnKFzXrLYqEaopQSxpqsXrgsHRUcnpFJ70meLA4RJo6rq
         9ak1wnwEgWOwgHNYSlzSXlnmIkBDzsReYMuNiYRs=
Date:   Fri, 24 Jun 2022 13:42:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     neal_liu@aspeedtech.com, balbi@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] usb: gadget: Fix unsigned comparison with less than zero
Message-ID: <YrWjCnNJohij691b@kroah.com>
References: <20220623084347.38207-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623084347.38207-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 04:43:47PM +0800, Jiapeng Chong wrote:
> This was found by coccicheck:
> 
> ./drivers/usb/gadget/udc/aspeed_udc.c:496:8-13: WARNING: Unsigned expression compared with zero: chunk >= 0.

What does this mean?  Where is the error?

Please explain the reason for changes, not just the output of a random
tool that you ran on the code.

> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

What commit does this fix?

thanks,

greg k-h
