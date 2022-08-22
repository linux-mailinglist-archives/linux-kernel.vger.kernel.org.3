Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E059BCD0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiHVJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiHVJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7743F71;
        Mon, 22 Aug 2022 02:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A313B80E88;
        Mon, 22 Aug 2022 09:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80561C433C1;
        Mon, 22 Aug 2022 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661160496;
        bh=oPHBQc6cO/0kX23z60zeYJ0U6/LUz3gRqZYfS3Mh5lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naDSFqBgjg3Lb83YmWgGKo0Vbtd7ipmSthGcBSYrOI+02qYeg/lDl3ElOYeKD/8uU
         g1Mmfv5iHJy1xo8loeuW+k+8MfPScOgLyuj50PNeGeoyUyXeEuU6lpZVcvD/EiQa3b
         EEXv2yw3HXGHpuWgpiylR3EuEIYWnQVvl4Q34ukk=
Date:   Mon, 22 Aug 2022 11:28:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Message-ID: <YwNMLRMl6CpEu54/@kroah.com>
References: <20220815104739.v7.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <Yvnq5o5f+qp5zs1c@kroah.com>
 <CAONX=-fScRJt-j1USO6gKXm780S=XBGHVc_LUziSZDiStc5P6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-fScRJt-j1USO6gKXm780S=XBGHVc_LUziSZDiStc5P6A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 07:03:02PM +1000, Daniil Lunev wrote:
> On Mon, Aug 15, 2022 at 4:42 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Please provide a lot more information about this in the changelog text.
> > What would you want to see here if you had to review this change?
> 
> Hi Greg,
> Sorry for toppost, let me try again.
> Can you clarify what specifically is missing from the changelog?

What changelog?  I don't really know anymore as I have no context,
sorry.  Remember some of us get 1000+ emails a day to deal with.

thanks,

greg k-h
