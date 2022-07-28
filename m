Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63A5838FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiG1Gud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiG1Gu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF0501AD;
        Wed, 27 Jul 2022 23:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0466F61AF0;
        Thu, 28 Jul 2022 06:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A882C433C1;
        Thu, 28 Jul 2022 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658991027;
        bh=QnsMv5n+oml6tSg5a/IL8irjZHBGgpq3vTxxpSrgmyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNwkeX23cHuQPEH1YLhh/+Euq7sDWwhTOpZbWzB9peOm6q1x0p2o0/6XLOaPcKVmi
         MjihxSxsd0GH8SACQVQZSsz0KFfJ1F7bzRG8oqrPVY0YmyMcjOavyBy4r6DPR+L9Xg
         WVo9XoYMn1Em0QQbB+31BFFXH8y5HABBnj06DBfg=
Date:   Thu, 28 Jul 2022 08:50:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ufs: core: print capabilities in controller's sysfs node
Message-ID: <YuIxsD+ExIF8QYEx@kroah.com>
References: <20220728144710.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728144710.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 02:49:25PM +1000, Daniil Lunev wrote:
> Allows userspace to check supported by the controller/device
> functionality, e.g. write booster.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>

You have to also document this in Documentation/ABI/ when you add a new
sysfs file.  Please do so here.

thanks,

greg k-h
