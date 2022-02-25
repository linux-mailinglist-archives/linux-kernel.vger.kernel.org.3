Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EC64C4326
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbiBYLNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbiBYLNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:13:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6B1DCCC6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:12:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D752B82D7C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F15C340E7;
        Fri, 25 Feb 2022 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645787564;
        bh=xQ1H7/Dt7IWJD23VHNYn1uDXQpmUaBskwGY0Yu9Lz2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+T9L5XUbNcAQOMJkpbf85JiXq635m0rOcEz5Uxq6psM6vCsmQ9fPed7c8y8ppM/h
         JoiYnx91NxM+UbhmX6K4SDc9pJKxP54yHbBXZ5zhUiypE0Yzzc/5dzPe/quom5gCnw
         D1V929xMFDYqEu3AkQ9HdVbCPVJXcEU1xq6cTlcM=
Date:   Fri, 25 Feb 2022 12:12:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com
Subject: Re: [PATCH v5 3/3] firmware: xilinx: Add sysfs support for feature
 config
Message-ID: <Yhi5qesqaZINe6QS@kroah.com>
References: <20220209082709.32378-1-ronak.jain@xilinx.com>
 <20220209082709.32378-4-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209082709.32378-4-ronak.jain@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 12:27:09AM -0800, Ronak Jain wrote:
> Add support for sysfs interface for runtime features configuration.
>  The user can configure the features at runtime. First, the user need
>  to select the config id of the supported features and then the user
>  can configure the parameters of the feature based on the config id.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>

You are adding new sysfs files, without any Documentation/ABI/ entries.
That will cause errors when you run the scripts/get_abi.pl tool, right?

Please fix.

thanks,

greg k-h
