Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3695248C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbiELJU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351899AbiELJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:20:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1852D1D32C;
        Thu, 12 May 2022 02:20:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8999B826B7;
        Thu, 12 May 2022 09:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E07C385B8;
        Thu, 12 May 2022 09:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652347251;
        bh=98xFuDTMeH3sGakLlT0pdW9eUj8Z8lx2s/Z8NS9pIL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9U4uQNYZ1avt0toH2Iq2JMT80MzU7PXW1+VLdAqnX5WgxzuIJPHh1C0Q7rwfxp8b
         kcR/k7mKhZ4INczJj4TMpwmYYZZOudFOjLW46BEievTkRoczE4TJkN1xaYQkvjOO61
         ox/E6v13CmKSszb0qW8sM6C8dmVL8E0efz+qTjxg=
Date:   Thu, 12 May 2022 11:20:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com, loic.poulain@linaro.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     bus: mhi: host: Add support for a new Quectel Module.
Message-ID: <YnzRcFy1zwhdSP5D@kroah.com>
References: <MEYP282MB2374BF134896B003FD8BF826FDCB9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB2374BF134896B003FD8BF826FDCB9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 05:07:46PM +0800, Yonglin Tan wrote:
> From: ylintan <yonglin.tan@outlook.com>
> 
>     A new Quectel EM1xx module need to be supported by kernel.
>     The module is based on Qualcomm SDX24 platform and the
>     configuration should be aligned with EM120 and EM160.
> 
>     Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
> 
> Signed-off-by: ylintan <yonglin.tan@outlook.com>

This looks very odd, don't you think?

Please fix it up to be correct, like all other patches that are sent to
the lists.

thanks,

greg k-h
