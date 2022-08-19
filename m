Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A19259974C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346918AbiHSIbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346799AbiHSIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:31:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CF2E97F0;
        Fri, 19 Aug 2022 01:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 655B9B8265F;
        Fri, 19 Aug 2022 08:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4EDC433D6;
        Fri, 19 Aug 2022 08:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660897886;
        bh=Q5Be1+hLtbVanl/3s29/HhIQGdBUTkMhqA84NGRkgPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbIqDyC5m+19uwKDAmIDnMoi+9l9Zyi6X/Yu4gyTdJ8XcLTGvN9OOGqw82yfsaNdW
         SF1QgzqJRmBzMOm9h/Emw36LgJCWolwwnoIS2Yh3cAPSjjsaiUa3y3b3EarXjFIaMq
         FKQ/T6hKuttebtgj3WPxwMo9PEW+GZpxyyUWhpMo=
Date:   Fri, 19 Aug 2022 10:31:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Youn <John.Youn@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/25] usb: gadget: f_tcm: Enhance UASP driver
Message-ID: <Yv9KWyevXLegwQcK@kroah.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:26:01PM -0700, Thinh Nguyen wrote:
> The Linux UASP gadget driver is incomplete and remained broken for a long time.
> It was not implemented for performance either. This series adds some of the
> required features for the UASP driver to work. It also makes some changes to
> the target core.
> 
> This is tested against UASP CV and DWC_usb3x controller. It still needs some
> fixes in the target core, which will be separated from this series.
> 
> There are still more room for performance improvement and fixes. However, this
> series should be sufficient to bring up a working UASP device.
> 
> 
> Changes in v2:
>  - Remove most target core changes from this series and only keep the must-have
>    ones
>  - Split the task-management patch to smaller patches
>  - Don't send failure Task Management response to target core, reducing
>    dependency
>  - Add UASP bringup script example in cover page
>  - Make various small updates according to feedbacks

I would need a review by the target maintainers before being able to
take any of the USB gadget changes into the USB tree...

thanks,

greg k-h
