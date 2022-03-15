Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CDD4D9A80
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347972AbiCOLks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245326AbiCOLkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE527BCA3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5323F614BD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A66C340E8;
        Tue, 15 Mar 2022 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647344372;
        bh=cqZ4RBrsaYDm5GZEVqiWic6mtYnEEO67SXJygUzGTVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPVO9+uAzkp/IjfjhKAV91u85/CGX0Zlrz7DUoddoNtq+1xcO8iEzJTdseGE8ufrV
         cv3RPF0FPRYqGYVgDSjAQ+C3TIyaPHwPV3oPVYJz8Fk6V7GNyxysHyo30JXtLTCAYN
         JfmaR2K5e3CfPAzsWVPK1fbEn6jfYlG/3Sz010ZQ=
Date:   Tue, 15 Mar 2022 12:39:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        mb@lightnvm.io, ckeepax@opensource.cirrus.com, mst@redhat.com,
        javier@javigon.com, mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        rvmanjumce@gmail.com
Subject: Re: [PATCH v2] uwb: nxp: sr1xx: UWB driver support for sr1xx series
 chip
Message-ID: <YjB68RMXRRZqQI8O@kroah.com>
References: <20220315111227.2388583-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315111227.2388583-1-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:42:27PM +0530, Manjunatha Venkatesh wrote:
> Ultra Wide Band(UWB) is a fast, secure and low power radio protocol used
> to determine location with accuracy unmatched by any other wireless
> technology.
> Its a short-range wireless communication protocol. It uses radio waves to
> enable devices to talk to each other.

<snip>

Why did you send the same patch twice?

confused,

greg k-h
