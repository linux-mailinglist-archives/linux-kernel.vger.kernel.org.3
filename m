Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E44E9662
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiC1MVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiC1MVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB2B87B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A4660A73
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361DEC340EC;
        Mon, 28 Mar 2022 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648469991;
        bh=xfLoFLYLQdeXldJ2/Q7pbJ+KMONwzOD70l2ztYR4DzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9IEI4pQH0K1n8SpASLCyEm5OZExno934w5JG+PlvWreQ70Gtrd3n1gk6EOWyJPDd
         rPKiI0Xx0tbaUiA2Q08QoP+xthzJ/yO2X0ANMVGLms1AawVYrIzveUxP9PV2izdlHm
         GspqHxBLPUlo4xBty3uz17tNYKq/gKyDLibyzolY=
Date:   Mon, 28 Mar 2022 14:19:48 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "Wangjing(Hogan)" <hogan.wang@huawei.com>
Subject: Re: [Question] kernfs: NULL pointer dereference in
 kernfs_dop_revalidate()
Message-ID: <YkGn5EU3mkUha2U6@kroah.com>
References: <685d8898ca614138a9c15f8042e3d291@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685d8898ca614138a9c15f8042e3d291@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:59:49AM +0000, Zhoujian (jay) wrote:
> Hi,
> 
> We met a kernel panic during boot the new kernel using kexec, the kernel version
> is 4.18.0(with some our changes), here is the stack:

4.18.0 is _VERY_ old and obsolete, sorry.  Can you duplicate this on
5.17?

thanks,

greg k-h
