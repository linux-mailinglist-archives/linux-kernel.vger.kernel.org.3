Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4191524716
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351083AbiELHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351064AbiELHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738513136F;
        Thu, 12 May 2022 00:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1DE761EBD;
        Thu, 12 May 2022 07:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD938C385B8;
        Thu, 12 May 2022 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652341058;
        bh=offqsrhcg16fhLMHDbpmTPitcqGYTsd1JU4xNXPf3Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3yAILK35ZPK89IZFGaz6LKyO6D5AuiuQibqsyUdXS46CrpYGGAZPf6w+QkFWbnGn
         bMwPRK4lL4kfXqKkhmcQ+rReWyQEIABgsAPIOh5ztmxG+otROgByEL1iJJKUOcB4zD
         6B0hwuarGijSNDRTFP7l2Mq7fb7QjYVBgEbeY+tA=
Date:   Thu, 12 May 2022 09:37:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "guanjing (D)" <guanjing6@huawei.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: dwc3: include extcon.h to fix compile error
Message-ID: <Yny5P5ECkBPiu8YV@kroah.com>
References: <20220510082029.197841-1-guanjing6@huawei.com>
 <YnoiOlkzvJKs/NN8@kroah.com>
 <9aebc16b-cf94-3c13-6bc6-e5a3ad88547f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aebc16b-cf94-3c13-6bc6-e5a3ad88547f@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:05:56AM +0800, guanjing (D) wrote:
> Thanks for your reply, when CONFIG_EXTCON is "m", we will see these build
> error.
> 
> 
> Fixes: 0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is
> present")
> 
> 
> I have pasted the config file in the attachment.

Your .config builds just fine for me here.  Are you sure you are working
with a clean tree?

thanks,

greg k-h
