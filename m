Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558BA590B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiHLFh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiHLFhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8440C9BB40
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B27CC6171A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F36C433C1;
        Fri, 12 Aug 2022 05:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660282651;
        bh=j8LIClIe+5hy7z0za377V+HhhbtgAGXCfJDCXlC38+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rB5SiFu3Oq0Y6Nc2gngoDOa3bJb3o5QVFVKJElO7ok9uzidQeVbnANLtety469Ffi
         UkgwQc94BcDmKrTAHpuSXTzesqYyqO4JsfxIFTUcsPG+LWyNTpRdmTM3hBCnr6/zcN
         bhXMfVwswy6tVjrDvzVUZm69ISKsurFiaX/xInGQ=
Date:   Fri, 12 Aug 2022 07:37:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jbaron@akamai.com
Subject: Re: [PATCH 00/11] DYNAMIC_DEBUG for this cycle
Message-ID: <YvXnGaLfPnjUAyLH@kroah.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 11:35:30AM -0600, Jim Cromie wrote:
> Hi Greg, Jason,
> 
> Please consider these for this rc-cycle.
>   - 1-9 have Jason's Ack,
>   - 9th removes unused EXPORTed fn.
>   - 10 is simple var cleanup
>   - 11 is a partial decoupling of dyndbg from kernel/module

This is _WAY_ to late for -rc1, this stuff should have been in
linux-next already in order to have that happen, you know this :(

Unless linux-next is pulling in your tree already?  Otherwise I can pick
this up into my tree after -rc1 is out for the next release after this
one (i.e. if this is going to be 5.20-rc1, it would go into 5.21-rc1.)

thanks,

greg k-h
