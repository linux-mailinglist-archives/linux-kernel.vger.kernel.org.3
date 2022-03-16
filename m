Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405594DAAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353863AbiCPGaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiCPGac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981C593AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 23:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1DD560C04
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A35EC340E9;
        Wed, 16 Mar 2022 06:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647412158;
        bh=WPffMnbLy+mRaNgF3nbJhYoZuUmvH1mApTBnDeQ8aOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgV1V9m1SWB0EHNeCEnd1BWo/M9Mk40nwknqztRUGBEgwz9/uKw1N5UP0qvQCVgnW
         95IFKR86aNtYBUEpW5Hw+5RwBgBce5dW6R/Phm4oBfMPobJe3Zs48EhlNLY/kw7O4p
         8eEepi/OJCvW/37LreNDnvNMzfAMdumJeoYXmJ+U=
Date:   Wed, 16 Mar 2022 07:29:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charlie Sands <sandsch@northvilleschools.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Resolve checkpath.pl issues.
Message-ID: <YjGDtLvysfyVQHLm@kroah.com>
References: <YjEB27xzf+krm3ew@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjEB27xzf+krm3ew@sckzor-linux.localdomain>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 05:15:07PM -0400, Charlie Sands wrote:
> > Always test-build your patches. Applying this change results in a build 
> > failure :(
> My apologies, I ran a build test on a copy of the repository with my changes
> stashed in order to look at the original checkpatch warnings.
> 
> > Please fix up and resend.
> It should now fix the below issues without build warnings.

None of this should be in the changelog, please fix this up and send a
version 2 of this patch, properly listing what changed from the previous
version.  Instructions on how to do that should be in the documentation.

thanks,

greg k-h
