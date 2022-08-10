Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278E358E909
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiHJIuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiHJIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CC6CD33;
        Wed, 10 Aug 2022 01:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A930A60F2A;
        Wed, 10 Aug 2022 08:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8509FC433D6;
        Wed, 10 Aug 2022 08:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660121400;
        bh=kxqLGEuO/b/nofV0WGOHjVv9TvRvs28sordeYCxzinA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kR4V+yVrH8230+GXuqgWdLtUx+jJLnAPabOYHNGL9PCcA5MEskCIzaSeTreI6TcAm
         MrnSCmGHWN5wdX9BH+/GwWdfwHCh2vIXRDPOhnoeY3bQWKKKSTYmD6M1H5sDXBZFG+
         XKRzYlRxcPgnPF4biG5WRauki32odvi9Yt/b3FAo=
Date:   Wed, 10 Aug 2022 07:03:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v6] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Message-ID: <YvM8KQGAbFz9HlV8@kroah.com>
References: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <YuoRuP2pxgSQ6c9E@kroah.com>
 <CAONX=-f8kHWCEEyqUdpn5wsyMZKa4eJSSCLvPDn3R5mQF9FSMA@mail.gmail.com>
 <CAONX=-eL02see4m6wK74cX2D6rUXJXtZYSRiNhPQVDsS8kU27g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-eL02see4m6wK74cX2D6rUXJXtZYSRiNhPQVDsS8kU27g@mail.gmail.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Wed, Aug 10, 2022 at 07:16:34AM +1000, Daniil Lunev wrote:
> Hello,
> 
> Are there any more amendments you would want me to make or is it good to go?

I have no context here at all, sorry, nor do I have any idea what you
are expecting from us :(

Also, it's the middle of the merge window, we can't do anything right
now.  Resend your patch series after -rc1 is out and we can review it
then.

thanks,

greg k-h
