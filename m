Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581B54C432A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbiBYLNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiBYLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:13:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F921D0B9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:13:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C31A6182F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47434C340E7;
        Fri, 25 Feb 2022 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645787598;
        bh=rzGPkT4JIzlzbexRP8aEU5rh0rRoABm8ajxfnujtt8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBCZrZPRd3Nj8TnqRWa5yoB/zM4CQ6JODJ3uHI69k0isWipkWGOcfiMDQ9twmQERE
         Pc7xB1QQQAu9hwGSD7VsyiUouZVSkxHIsGjfOqOSjVCyKKwK2xJmYweyW5yF0n2uCA
         iSXdYE7dubgxHJfVEVWzQetquJ8G4XzPcFlA/nP8=
Date:   Fri, 25 Feb 2022 12:13:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com
Subject: Re: [PATCH v5 2/3] firmware: zynqmp: Add documentation for runtime
 feature config
Message-ID: <Yhi5zLXSKwo3yXCt@kroah.com>
References: <20220209082709.32378-1-ronak.jain@xilinx.com>
 <20220209082709.32378-3-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209082709.32378-3-ronak.jain@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 12:27:08AM -0800, Ronak Jain wrote:
> Add documentation for sysfs entries like feature_config_id and
>  feature_config_value for runtime feature configuration. The support is
>  added for an over temperature and external watchdog features.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v5:
> - Update kernel version for sysfs documentation
> 

Ah, here's the documentation, sorry about that...

