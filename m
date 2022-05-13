Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA00525B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377146AbiEMGFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiEMGFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:05:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D91291E73;
        Thu, 12 May 2022 23:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EEBCB82C3F;
        Fri, 13 May 2022 06:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA62C34100;
        Fri, 13 May 2022 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652421910;
        bh=05TDIcrSRouSVVg0LE7Qt2qs9UfyFi0Y3KQPeMWX/1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQhVVudblIX45ryI2VqOBKEmGom3ZuBUiWodG8e9njvegID+E3q4ztW87XIW0z7zX
         cvfB8wWSGb1gVlpmY1ei/Y7Q3Fb4+ryWdNB1zcCfOUggLuj+pN11YA9MrBj+ykNXkS
         L04gYD953Am0+Jq7GssSqQwceVfiuUF9GgtbCaao=
Date:   Fri, 13 May 2022 08:05:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com, loic.poulain@linaro.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     bus: mhi: host: Add support for Quectel EM120 FCCL
 project.
Message-ID: <Yn31EYLyfrHaTe6S@kroah.com>
References: <MEYP282MB2374B995796DE1B2D23FFA02FDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB2374B995796DE1B2D23FFA02FDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:59:11PM +0800, Yonglin Tan wrote:
> From: ylintan <yonglin.tan@outlook.com>
> 
>     This patch add VendorID/DeviceID definitions for EM120 FCCL project.
>     It has the same configration as Quectel EM160R-GL and EM120R-GL.
> 
>     Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
>     Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I signed off on this commit?
Please NEVER add these lines from someone else.  THat is a legal
statement you are making there, and I do not remember making it.

>     Link: https://lore.kernel.org/all/YnzRcFy1zwhdSP5D@kroah.com/

That points to a response from me, not the original commit.

Something went really wrong with this submission, please try again.

greg k-h
