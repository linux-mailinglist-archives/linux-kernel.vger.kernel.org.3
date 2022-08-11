Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5AF58FEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiHKPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiHKPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD124F1A;
        Thu, 11 Aug 2022 08:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82926615CD;
        Thu, 11 Aug 2022 15:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA05C433C1;
        Thu, 11 Aug 2022 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660230163;
        bh=BMvQWx5Jj7sPohW5T4ON/wNryGPttA5pOZjS0TD/o2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhgJSfnjSqiFQ2RxdnyoNh4gV/vDqOzan+Yz1JqJMmgpA4df7D9lfuoAo/7WOgW7e
         kevIkcPE5n17Tlgv5iMUiNzPCVDqgIgBWA5G4IAPyzQBpNrKz6g0l5vhAmATa5BReC
         UvoLLhBQNlE8QVdrFkQY3ys5M7aBfu2pC2Hdnq34=
Date:   Thu, 11 Aug 2022 17:02:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvUaEDMbZD70x+hD@kroah.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> For the time being, I agree with your recommendation to not buy these
> devices if you care about camera support.

I second this, don't buy these devices if the vendor is not willing to
get their drivers upstreamed properly.

thanks,

greg k-h
