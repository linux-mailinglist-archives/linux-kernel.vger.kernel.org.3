Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCDF4D64CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348804AbiCKPmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiCKPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:42:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC81C2310;
        Fri, 11 Mar 2022 07:40:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D656761562;
        Fri, 11 Mar 2022 15:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EF3C340E9;
        Fri, 11 Mar 2022 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647013257;
        bh=SoBHkwKBTF+RKZ7fMiVI6xuvxacDWoy5OT35J4/zXOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyP3WpXbUggMQe1Olk1I/5jtVXJO5+IaWkc+zDdiLoert1PsRn4HjJ6kiPzQn2IwC
         RMLzy/Z3PdGVJPljeWscYYuysNG7ObKL5jOW277LMS6yGTL9GysRm7AcEfvkkVDKyr
         W8LCGHM5+kmDcFxeOCi9NhgjcmgGDV4Buv4uwZWs=
Date:   Fri, 11 Mar 2022 16:40:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.18
Message-ID: <YitteaQ0v9ufCA9b@kroah.com>
References: <20220311121357.19439-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311121357.19439-1-djakov@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 02:13:57PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the 5.18-rc1 merge
> window. It contains a few minor framework and driver updates. The details
> are in the signed tag.
> 
> All patches have been in linux-next for more than a week. No issues have
> been reported so far. Please pull into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> 
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.18-rc1

Pulled and pushed out, thanks.

greg k-h
