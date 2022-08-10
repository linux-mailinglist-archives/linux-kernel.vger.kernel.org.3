Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51858F044
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiHJQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29717760F1;
        Wed, 10 Aug 2022 09:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9988E6119E;
        Wed, 10 Aug 2022 16:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E360C433C1;
        Wed, 10 Aug 2022 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660148491;
        bh=6uH1swK4sC4dGeNsKgkQqY37IStoSw0yk8dMI2BQyME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYNdAauK/lq0OiXvYYSKJZ87sbE+U0c7QyE8qbYIU9YNIaPab+PLRbge8RSmKjdEB
         BdZTYL6axQogrsNzsB01kF8JvkQIA7RsLj/RDeEwHE8YtoZ+TQstkxOq3/Q8H1vvIm
         5LGntgYxueJ+CbPpnsa8jU9/4HatqAwS1BAzV2yo=
Date:   Wed, 10 Aug 2022 18:21:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com, Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] Bluetooth: btintel: Add Intel devcoredump support
Message-ID: <YvPbCAawZk0EJlrT@kroah.com>
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
 <20220810085753.v5.5.I61857ea92be43418b8ce16839f79a4704cc89fa6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810085753.v5.5.I61857ea92be43418b8ce16839f79a4704cc89fa6@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:00:38AM -0700, Manish Mandlik wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> Intercept debug exception events from the controller and put them into
> a devcoredump using hci devcoredump APIs. The debug exception contains
> data in a TLV format and it will be parsed in userspace.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
> ---
> Hi Luiz,
> 
> The implementation of btintel_coredump() is currently under internal
> review. So I'll send it later as a separate patch. This patch includes
> only a placeholder for that.

That's odd, let's wait for that to be submitted, as we don't add
frameworks without full functionality, right?  How do we know this will
ever be fixed in the future?

thanks,

greg k-h
