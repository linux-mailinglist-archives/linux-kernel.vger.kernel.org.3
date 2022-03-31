Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E004ED3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiCaF7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiCaF7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:59:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D11B6099
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03A01B81F6A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AECBC340ED;
        Thu, 31 Mar 2022 05:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648706232;
        bh=PyjRVZSlbGKAR6UehNDdnoGgntb9T9gi297dJHWkNVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfjP5Suqu8RiD29EZCdLBdodO1i4fOW9wVXex57mfeHPQKfyyRseOH8V8Q3Okib3B
         88IxCrsyNdxlYPe4UH6ZhslE5bJNpMplRhQvO1wL8lch4fTT5TNqFkudTEuZhXgGQ8
         kfgDJIjuLp12HAEQMWxXC4Lg8b4EIpkuP7WtebII=
Date:   Thu, 31 Mar 2022 07:57:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charlie Sands <sandsch@northvilleschools.net>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH V2] staging: r8188eu: Fix sparse endianness warnings
Message-ID: <YkVCtnEXPn8S8CC5@kroah.com>
References: <YkSnBW70kruOyN9h@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkSnBW70kruOyN9h@sckzor-linux.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 02:52:53PM -0400, Charlie Sands wrote:
> This patch fixes sparse warnings about the endianness of different
> pieces of data in the driver.
> 
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for
> RTL8188eu driver")

Nit, this should be all on one line or our tools get upset.

> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> ---
> V2: Added the "fixes" line to the commit at the request of Dan Carpenter.

My tools picked this up from the v1 patch thread, no need to resend.

thanks,

greg k-h
