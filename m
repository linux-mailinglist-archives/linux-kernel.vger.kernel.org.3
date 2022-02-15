Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB324B61DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiBODzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:55:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBODzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:55:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F411942F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:55:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2F83B80C6D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37CBC340EC;
        Tue, 15 Feb 2022 03:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644897309;
        bh=BvxNL/RFVc1uJpXylwAbdhKDQPT/RCenbb87HvmLBmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssu1nFuwAUbwi6N5yX3DvmCSE0r4PGCXtzxdwRRvbiHRiDyCoRPh9np8ZSvqeZQLB
         y/Ape3MErHrvX+nLd++MVT7V+rYfaph5uAthilu1KLw8YzJLWp6wTVw0RSPmoovh0w
         bf3TUn+YCpiB7y5abjyiSwcl7iIUeTiM4dTscsjK2xmJfdMumFGC/WN+kAVV+MAMtC
         oZtHRdVCOrWXNfvyeYeXO3w6+EZRYL51bf+Mrmp6Gx0YEMJ7zdZwotIDim6dsNaYIn
         gz6+aO7khOPw4UAQQieYPzwq5iIc1BaSWO055zyPLnaTkWNktsEJt4Wm5ytP3NPE8X
         7xIYiPH/ZA4Qw==
Date:   Mon, 14 Feb 2022 19:55:06 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Message-ID: <20220215035506.GA1663897@dhcp-10-100-145-180.wdc.com>
References: <20220215033632.104124-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215033632.104124-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:36:32AM +0800, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/nvme/host/core.c:780 nvme_configure_directives() warn: missing
> error code 'ret'.

Nak, the code is correct as-is, just like it was the previous time you
posted this patch:

  http://lists.infradead.org/pipermail/linux-nvme/2021-September/027339.html
