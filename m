Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641EC51C654
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382789AbiEERnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382768AbiEERnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701765BE46
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CCAFCCE2ED7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0861C385A8;
        Thu,  5 May 2022 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651772398;
        bh=Fea/rsoxEnUkTCcBFJAwvQ9RkVxQQI5m8J3zJBHz8TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJacyXw5JQdV1zxZ6e/r0qhwiQ+k9EW9VNgnv6ulXAQEKa+weAJyctY+gywsr4JPE
         9N0/t+LD3x8bdacDkRd6+rFAYvjPnHJX4mwFjH2oujFKe34RRPzFp1eDpk5f7UseK3
         qEPJngQfmEl1LHxs7NInu4wJGfSJLUD4z6ajdnl0=
Date:   Thu, 5 May 2022 14:23:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "zhangjianhua (E)" <chris.zjh@huawei.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] vt: defkeymap.c_shipped remove unused variables
Message-ID: <YnPBsEiaUfbEI+Ef@kroah.com>
References: <20220429014814.988829-1-chris.zjh@huawei.com>
 <YmuIEoOnJqYLy3CE@kroah.com>
 <53e36000-ad70-9de7-74ad-16bd81dae530@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53e36000-ad70-9de7-74ad-16bd81dae530@huawei.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 11:10:55AM +0800, zhangjianhua (E) wrote:
> 
> 在 2022/4/29 14:39, Greg KH 写道:
> > On Fri, Apr 29, 2022 at 09:48:14AM +0800, Zhang Jianhua wrote:
> > > The global variables 'funcbufptr' 'funcbufsize' and 'funcbufleft' have
> > > been initialized but not used, they are redundant and remove them.
> > > 
> > > --------
> > Why this extra "------" line?
> 
> This line "------" means the end of commit message, if it is redundant, I will remove it in next version.

That is not used in kernel changelogs at all, sorry.  Please don't add
it in future changes either.

thanks,

greg k-h
