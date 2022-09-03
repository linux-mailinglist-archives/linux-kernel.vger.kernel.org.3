Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06D5ABD49
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiICFwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiICFwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E4BDF09E;
        Fri,  2 Sep 2022 22:52:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA77260B40;
        Sat,  3 Sep 2022 05:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC991C433C1;
        Sat,  3 Sep 2022 05:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662184322;
        bh=F3Gz08j2D0qpGnArLAejhPPWsB8Hh1kub7w90bzsnvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1aGEfYUmAOOAh0xQqETTlIyUp0Ye56KQR3bJiq8JMXkg4SITihr4qH5cBm67bNNs
         9FFGJj98S5MJF421b0AGUKinCV25+4eWZkXecB2qjGpzFYvFyw5r9ncgbt8cNS9rdd
         FsLdmdlHmBQh0W7tMSwyZMXNmBP9Fp/AhG6SuAK8=
Date:   Sat, 3 Sep 2022 07:52:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: aiptek - switch to using dev_groups for
 driver-specific attributes
Message-ID: <YxLrlMJovq0smNT+@kroah.com>
References: <20220903051119.1332808-1-dmitry.torokhov@gmail.com>
 <20220903051119.1332808-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903051119.1332808-3-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:11:19PM -0700, Dmitry Torokhov wrote:
> The driver core now has the ability to handle the creation and removal
> of device-specific sysfs files, let's use it instead of registering and
> unregistering attributes by hand.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/tablet/aiptek.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
