Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63934B4CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350055AbiBNLJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:09:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344989AbiBNLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:09:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1A5DD943;
        Mon, 14 Feb 2022 02:38:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31E9DB80E04;
        Mon, 14 Feb 2022 10:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DB9C340EF;
        Mon, 14 Feb 2022 10:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644835067;
        bh=sAhyEkEtiuyJYz6mXmbObP3UouIsoVZZu36wiNw/T8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqqT3TaKiMwKgu5rMfM5hWbBED4IG4BjRngeaFUMI+UYO5cyliQgcZFUColerXD8j
         SMdEN1r/HAI1Wi/OGnE9pkpMHNZwnmQMDpEs0mOyoqAnj/GGRXQvflkQOfCJWu55sn
         6MVBd05oNlpA4R58dxhfVSBl3YfNXf4QXmb0y3MI=
Date:   Mon, 14 Feb 2022 11:37:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     laurent.pinchart@ideasonboard.com, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH] usb: gadget: f_uvc: fix superspeedplus transfer
Message-ID: <Ygow+EB1P84VflBb@kroah.com>
References: <20220214055224.18075-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214055224.18075-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:52:24PM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> UVC driver doesn't set ssp_descriptors in struct usb_function,
> If we use ssp UDC (e.g. cdnsp), UVC doesn't work.

I do not understand this text, sorry.  Please try to reword it to have
more descriptions.

thanks,

greg k-h
