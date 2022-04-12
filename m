Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F914FE2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352632AbiDLNlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiDLNlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6738D2DD43
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:38:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 028E4618F7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F87AC385A1;
        Tue, 12 Apr 2022 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649770728;
        bh=If4KJxS1/AVf307xWkNZDRnv4N5rmqUpTEKgaBEdAsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7esKDYjUXe0+ELyCyQfNazoS1s5EBVql/1k7Jpr+CgQLqu6dWGk98m30pJl1klQy
         ON6oRW1/Eo4aCzDefZ6DUd49Y2WuuIKgbFul9C9XkctvAjZeoxxN087dlfTqM+rJ34
         SoSxSmpIIaF4w4SAkmXbA3C9CPO9r5/Pm3PY905s=
Date:   Tue, 12 Apr 2022 15:38:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] staging: r8188eu: don't set _SUCCESS again
Message-ID: <YlWA5XkVDd9UJ81v@kroah.com>
References: <20220409151557.207980-1-martin@kaiser.cx>
 <20220409151557.207980-3-martin@kaiser.cx>
 <20220411101834.GW3293@kadam>
 <20220411183918.4mw5x6tatslii7mg@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411183918.4mw5x6tatslii7mg@viti.kaiser.cx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 08:39:18PM +0200, Martin Kaiser wrote:
> Thus wrote Dan Carpenter (dan.carpenter@oracle.com):
> 
> > On Sat, Apr 09, 2022 at 05:15:51PM +0200, Martin Kaiser wrote:
> > > ret is initialized to _SUCCESS, there's no need to set it again.
> 
> > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> 
> > I liked the original code better.  Otherwise you wonder, is it
> > intentional to return success on this path. 
> 
> You're right. The original code is easier to understand. It's not
> obvious that this check should return _SUCCESS and the remaining ones
> return _FAIL.
> 
> Greg, could you drop this patch or should I resend the series without
> this patch?

Please resend without this one.

thanks,

greg k-h
