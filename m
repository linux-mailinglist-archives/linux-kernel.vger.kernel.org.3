Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B85E4CBE9B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiCCNO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiCCNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:14:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E626C1704CD;
        Thu,  3 Mar 2022 05:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646313216; x=1677849216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ma2qRpZmEUOKw4dAaXn2anSNBJxLgIsqf7L4gdroyXc=;
  b=IT/ALg5Of+VrwgELoruyecOXbnwlFf/A3uA1oNh5PRKAbG9KBPFbdT5t
   ZYhoq+aBzV3jjF5uyifWO2gTIV0VNBt++MHBNwSCWSpZI3f5hW2RPv4zN
   q1KVI6UskcK3Zcm02kQNLuhyE9DP2Ms9v1H1MJhyGOC9+SY8CCw7utPl4
   YKeC6tWbnzX2ZAcllKWL1YDZvdJqPPGxnZchX8Lba4Yqcsgt079AWH75w
   wDOUhoLxDt78sBP22T3lO2lHBEUmamsMLZYUeEXrtFbtQ+RclOXGxVlLZ
   kDLaAbbP1zll7oALUdbwQRIB/x6cV7fstrFtSagNy9XtU7M+uBoIMXozG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="340102488"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="340102488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 05:13:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="686498504"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Mar 2022 05:13:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 03 Mar 2022 15:13:33 +0200
Date:   Thu, 3 Mar 2022 15:13:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YiC+/ccRvR/+mAkT@kuha.fi.intel.com>
References: <20220223102353.3833578-1-xji@analogixsemi.com>
 <20220223102353.3833578-2-xji@analogixsemi.com>
 <Yh9dBlrWm3OicQWa@kuha.fi.intel.com>
 <20220303024757.GA4159259@anxtwsw-Precision-3640-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303024757.GA4159259@anxtwsw-Precision-3640-Tower>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:47:57AM +0800, Xin Ji wrote:
> On Wed, Mar 02, 2022 at 02:03:18PM +0200, Heikki Krogerus wrote:
> > Hi,
> > 
> > This does not apply on top of Greg's latest usb-next branch. You need
> > to rebase this. There are also a few more nitpicks below.
> 
> Hi, I didn't found tcpci.h in include/linux/usb/

I'm asking you to create the file.

So create a separate patch where you move the register definitions and
command definitions from drivers/usb/typec/tcpm/tcpci.h to
include/linux/usb/tcpci.h

thanks,

-- 
heikki
