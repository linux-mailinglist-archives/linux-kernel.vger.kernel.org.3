Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8B584C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiG2HUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiG2HU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBB22DAA7;
        Fri, 29 Jul 2022 00:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D207B61AA9;
        Fri, 29 Jul 2022 07:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8625C433D6;
        Fri, 29 Jul 2022 07:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659079226;
        bh=fLxpLT/v3uJAppJRz9ZqKAGqo3FC41KKuVJ8GM2Z8/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSCp8NKWaxvfniZv/eZ9PItjbs6Np01rMih4WCedqv1WqzpeD/zpE+9g8JQHkvzRC
         dyczKl9abBwywLXkLTuLU3/J6p3NRQ4Avn9x+BVfEGg++le1WnC1VpsTYmZtSzfXOH
         VKINi1YMsu7f0QVo3ydgkL2LTe96JbcaF1c2YqE0=
Date:   Fri, 29 Jul 2022 09:20:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] ufs: core: print capabilities in controller's sysfs
 node
Message-ID: <YuOKNX4mWCb1LUrg@kroah.com>
References: <20220729090521.v2.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
 <3f96d798-e9bb-15d8-65b9-2383e112c654@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f96d798-e9bb-15d8-65b9-2383e112c654@acm.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 04:23:16PM -0700, Bart Van Assche wrote:
> On 7/28/22 16:05, Daniil Lunev wrote:
> > +What:		/sys/bus/platform/drivers/ufshcd/*/caps
> > +What:		/sys/bus/platform/devices/*.ufs/caps
> > +Date:		July 2022
> > +Contact:	Daniil Lunev <dlunev@chromium.org>
> > +Description:	Read-only attribute. Enabled capabilities of the UFS driver. The
> > +		enabled capabilities are determined by what is supported by the
> > +		host controller and the UFS device.
> > +		Format: 0x%08llx
> 
> This documentation is useless since the meaning of the individual bits has
> not been documented.

Yeah, that's not ok, where are these bits coming from and what userspace
tools will be using them?

thanks,

greg k-h
