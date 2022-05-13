Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6852601B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379460AbiEMK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiEMK1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:27:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236634EF65;
        Fri, 13 May 2022 03:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB635B82CE2;
        Fri, 13 May 2022 10:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DFBC34100;
        Fri, 13 May 2022 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652437621;
        bh=pTA4HXvpS8DuEF4nFjoqNWh0DGB6tDjhLzkQfFBwJMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9O4imyBJIqCEIV66j0/sr7IDdE3NmIgmOiSNxBHVusss9fc0WI91dN5mE9gwwd+a
         i98oyMTXx4H6wi9X1dl6N42uUc/cRAZu1s4rImNUDykrYRwuIHEQsik3VTb/oPtiSM
         pa70tzuwhT0NePaqI+keZqPxfteFyyfad5QZPZtI=
Date:   Fri, 13 May 2022 12:26:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     christian.koenig@amd.com, sumit.semwal@linaro.org,
        hridya@google.com, daniel.vetter@ffwll.ch, tjmercier@google.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] dma-buf: ensure unique directory name for dmabuf stats
Message-ID: <Yn4ycnpSV2dKU0vv@kroah.com>
References: <1652434689-6203-1-git-send-email-quic_charante@quicinc.com>
 <Yn4u0AG8iC33S3jO@kroah.com>
 <2a45f1e1-39d5-76b3-8fd3-c1f8b288afac@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a45f1e1-39d5-76b3-8fd3-c1f8b288afac@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 03:48:23PM +0530, Charan Teja Kalla wrote:
> 
> On 5/13/2022 3:41 PM, Greg KH wrote:
> >> Reported-by: kernel test robot <lkp@intel.com>
> > The trest robot did not say that the dmabuf stat name was being
> > duplicated, did it?
> >
> 
> It reported a printk warning on V2[1]. Should we remove this on V3?

Yes, that's different.

> @Christian: Could you please drop this tag while merging?
> 
> [1] https://lore.kernel.org/all/202205110511.E0d8TXXC-lkp@intel.com/

Never ask a maintainer to hand-edit a patch, it increases their workload
:(

thanks,

greg k-h
