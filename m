Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952FC4B4D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350341AbiBNLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:10:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350376AbiBNLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:10:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CBEE2353;
        Mon, 14 Feb 2022 02:38:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F02D4613F5;
        Mon, 14 Feb 2022 10:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40E9C340EF;
        Mon, 14 Feb 2022 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644835102;
        bh=gsXsm/+icvSvRgmoI2CRR9Na/MuIShp+FNSKlzOdgV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wL5XaGVpImUGm1rKaMK4kn71ClRnW78du8Gexim8kmCLtqdN1wdfOKFi1nb30RHK6
         7Pyb0Ka8IhoByMqOR6+p6sOhcTopWCxWRbzLf81RxXAVSpNx/pYGFHoRb33wx4fbFR
         /0BHK1PiUryOQNtjFGl6u9H9L7ULAI5cLfbZ5eWE=
Date:   Mon, 14 Feb 2022 11:38:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     balbi@kernel.org, ruslan.bilovol@gmail.com,
        pavel.hofman@ivitera.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH] usb: gadget: f_uac1: add superspeed transfer support
Message-ID: <YgoxGyCWQdAwG2gY@kroah.com>
References: <20220214074352.3447-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214074352.3447-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 03:43:52PM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> Currently uac1 only supports high speed.

That does not describe what you are doing here, nor why you are doing
it.

You sent a number of different patches, when you fix them up, please
resend them as a patch series.

thanks,

greg k-h
