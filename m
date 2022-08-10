Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1455D58F046
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiHJQVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:21:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D875FFA;
        Wed, 10 Aug 2022 09:21:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACCC4B81D68;
        Wed, 10 Aug 2022 16:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBF3C433D6;
        Wed, 10 Aug 2022 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660148509;
        bh=2HoQq0UsSNZf1aWHLoL03WxXB+cIK/OQM6i//CxV3/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGdsQo57SIt0wWyUYwQSNbYBxVxfpAYo6jctS1Sn/ZuvDnZM6fCt+NB/iCt7PkD42
         CDZBt47wZYXesvHz3MRHaofh705M5Rc8gCvS3dyxADmrbRV5d2PELTxHgSlWxDymNC
         479MnjTgePDNRPUvOk0gCReAnq14IWeKSAkRWDGs=
Date:   Wed, 10 Aug 2022 18:21:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Manish Mandlik <mmandlik@google.com>,
        Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com, Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] sysfs: Add attribute info for
 /sys/devices/.../coredump_disabled
Message-ID: <YvPbGms7bzFuWTJg@kroah.com>
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
 <bfc5f964d8dadd6378f2da5b3b6ef4bc9fb847c2.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc5f964d8dadd6378f2da5b3b6ef4bc9fb847c2.camel@sipsolutions.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 06:03:37PM +0200, Johannes Berg wrote:
> On Wed, 2022-08-10 at 09:00 -0700, Manish Mandlik wrote:
> > This patch adds the specification for /sys/devices/.../coredump_disabled
> > attribute which allows the userspace to enable/disable devcoredump for a
> > particular device and drivers can use it to enable/disable functionality
> > accordingly. It is available when the CONFIG_DEV_COREDUMP is enabled and
> > driver has implemented the .coredump() callback.
> > 
> 
> It would be nice to say _why_? What problem does this solve? You could
> just create the dump and discard it, instead, for example?

Agreed, I do not understand the need for this at all.

thanks,

greg k-h
