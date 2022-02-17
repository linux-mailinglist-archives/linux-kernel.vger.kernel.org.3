Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1424BA39A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiBQOvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:51:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiBQOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:50:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9BF29E940;
        Thu, 17 Feb 2022 06:50:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA2C761E03;
        Thu, 17 Feb 2022 14:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F96C340E8;
        Thu, 17 Feb 2022 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645109436;
        bh=FIN1JYSGbW2v56DyB+Gdsuvo/xYvrAhBtJD3iJLWu34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xEZICcpcXD/dxa5D8Nc86ZgTMR9qnd/ynRNb8yIRv2BS1zmSPDa06w9O07Lf2auqr
         h4RCNumfpQC7hd1uZ6piyTC7DSwNIUZSl4U7hh5KNDm/4Ha6U8GMAg41q2mTw76Ovy
         6nABBhjpE5bObzBlMy8iAb8vLtm2olholT4ZlrHI=
Date:   Thu, 17 Feb 2022 15:50:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: n_gsm: fix encoding of control signal octet bit
 DV
Message-ID: <Yg5guD36Usz3cV83@kroah.com>
References: <AM4PR1001MB137883EF5392EE25ED70A912E0369@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR1001MB137883EF5392EE25ED70A912E0369@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 02:03:37PM +0000, Starke, Daniel wrote:
> > > > All of these are patch 1/1, which is odd :(
> > > > 
> > > > Please renumber them properly and resend.
> > > 
> > > All these patches are based on the current version of tty-next and are 
> > > completely independent from each other. The only common part is the 
> > > file they apply to. Therefore, this is not a patch series. Would you 
> > > still suggest to apply a different numbering?
> > 
> > Yes, please send them as a patch series, numbered correctly, as a whole
> > series of patches, all listed as 1/1 does not do good things for our
> > tools.
> 
> I have noticed that all patches have been sent in one thread. This was not
> my intention. I see two options here now:
> 1. Resend all patches one by one as they are completely independent.
> 2. Create a patch series.
> 
> And the following two variants in case of option 2:
> a. Just renumber the subjects and resend all (i.e. without a cover letter).

This is fine, and the easiest for everyone involved, as git makes it
automatic.

thanks,

greg k-h
