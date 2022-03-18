Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255A84DDA52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiCRNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiCRNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740132DCBFB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CF5661932
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39ECC340E8;
        Fri, 18 Mar 2022 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647609337;
        bh=j5OtfUoGb0kK/dvJAhq8RWVrz120loFMxy8wBHigS/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCRNuFUR8Py0J8ZhtbmYtdamOZNV95/1RMTsejJqU7CQswzSAV3SHUgfYeP2Lwkx3
         y6GYyS8nAHexPqdEP+bq20aPD6w63RaciMFRa+RkUfHvKKOXkY7simwZZyQJUbpHPO
         1SdpalTjaS7XcsPHeVe1eUUHsTMRwkmQT+7eyimQ=
Date:   Fri, 18 Mar 2022 14:15:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: edd: Remove redundant condition
Message-ID: <YjSF9fmBHciZl6Lc@kroah.com>
References: <1647511520-26455-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647511520-26455-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 06:05:20PM +0800, Haowen Bai wrote:
> The logic !A || A && B is equivalent to !A || B. so we have
> to make code clear.

But the logic here is:
	(!A || (A && B))
not:
	(!A || A && B)

as you write.

Is that the same?  I don't want to have to dig up my son's logic
textbook...

How did you test this?

thanks,

greg k-h
