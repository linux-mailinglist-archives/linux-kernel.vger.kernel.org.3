Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B74B8603
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiBPKkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:40:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBPKkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:40:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A792BA283;
        Wed, 16 Feb 2022 02:39:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C0F6B81AF8;
        Wed, 16 Feb 2022 10:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECEEC340E8;
        Wed, 16 Feb 2022 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645007991;
        bh=DB6iiEzDggMJyFFPAmF1GTMuUauB5Hbe5CFhk2AY7Tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wNMAXwaNUVM8ubMa5hzQewoHljVee8Dm5txQdLx7DzzF2qsg8B7+VCRSgp/SIlKNr
         i0WUWi+Xh3T8NFlv2BW3WY8KNDTcIAFEz0JRz50pVe1MWRfsKN19pE0qGvwOuUSBQr
         db0S81sMQDgLUR3xGaRaf/wbcOdojmmHnfIyIHLg=
Date:   Wed, 16 Feb 2022 11:39:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5Ya36Z2Z?= <3090101217@zju.edu.cn>
Cc:     balbi@kernel.org, jleng@ambarella.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uvc: fix superspeedplus transfer
Message-ID: <YgzUdO92gzgkqB/9@kroah.com>
References: <Ygow+EB1P84VflBb@kroah.com>
 <20220215021647.4316-1-3090101217@zju.edu.cn>
 <Yguzht2JJtF+8N76@kroah.com>
 <6ca9a5a8.ae1fb.17f0061243d.Coremail.3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ca9a5a8.ae1fb.17f0061243d.Coremail.3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:34:00AM +0800, 冷静 wrote:
> Hi Greg KH,
> 
> Sorry for the trouble, as a new contributor to kernel.

That's fine, maybe get some more experience first before trying to add
new features?  Try doing some coding style cleanups in drivers/staging/
or reviewing other people's code submissions first.  That way you can
learn how things work easier.

> Although I have readed the document that how to submit patches,
> I'm still missing some details.
> 
> > What does "call trace" here mean?  Is this an error?  Something else?
> It is "call trace" when the kernel accessed NULL pointer and handed.

I do not understand this, sorry.

> > You did not read the information that my bot told you to read, for how
> > to properly version your patches :(
> > 
> > Please go back and do so when you resend all of them.
> > 
> > Also this is not a patch series?  Why not?
> 
> I readed the bot told, but I still missed it.
> The new patch only adds more detailed patch description.
> So it is not a patch series.

I asked you to make it a patch series.

thanks,

greg k-h
