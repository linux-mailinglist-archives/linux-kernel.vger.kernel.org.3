Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D665AAAE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiIBJGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbiIBJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F64940556
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D286111F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832E0C433C1;
        Fri,  2 Sep 2022 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662109537;
        bh=vxRLf6HfrjpAiqrqIrgsiApd7SWvqgd8XNi/3rbw2CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ib24uYNzY3DTEMzcQFgQn62rCuVAmOMQNJHpDj4Jvt/DC+XuRkCaJg09X+PxFkFx1
         Iizzso5lCU9121xRD6ixloQorWfFCTynt1jjHbXJsrt8Ls9o0FeWA4RqKH7Xl+p/WL
         4xpbBIUCKwbSJy+v4LsW0z5gwoj+ZKDZ0l848Oik=
Date:   Fri, 2 Sep 2022 11:05:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     cgel.zte@gmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, lu.fengchang@zte.com.cn,
        makvihas@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Zeal-Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Driver: r8188eu: Remove the unneeded result
 variable Return 0 instead of storing it in another redundant variable.
Message-ID: <YxHHXgdSLRSKtCyR@kroah.com>
References: <20220902032628.316333-1-lu.fengchang@zte.com.cn>
 <20220902085446.GN2071@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902085446.GN2071@kadam>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:54:46AM +0300, Dan Carpenter wrote:
> On Fri, Sep 02, 2022 at 03:26:28AM +0000, cgel.zte@gmail.com wrote:
> > From: lufengchang <lu.fengchang@zte.com.cn>
> > 
> > Reported-by: Zeal-Robot <zealci@zte.com.cn>
> > Signed-off-by: lufengchang <lu.fengchang@zte.com.cn>
> > ---
> 
> There is a lot wrong with the format of this patch.
> 1) The subsystem prefix
> 2) The blank line after the subject
> 3) Line wrapping at 75 chars
> 4) Your name is not capitalized
> 5) Greg doesn't like Zeal-Robot tags.

I don't mind the tags, what I mind is that the users of this tool are
not following what is documented in
Documentation/process/researcher-guidelines.rst when using it.

thanks,

greg k-h
