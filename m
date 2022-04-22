Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85950B714
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378730AbiDVMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiDVMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDEB1117E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B99561FE3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA3C385A0;
        Fri, 22 Apr 2022 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650629630;
        bh=j/lVI1HAP2t9wbTnL3WGWXv6TkG3VkokTfeFPNhHL5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSGSQoY+iOVPARNf1I8eswh5y4nOs1nqwaN0gMqn2IfM82G8MuJ1MC2H9P3eT8zeY
         +4MGf/XNubekvgveiVQw/aqyn2xNXGJF09OJKS8GKNu9aJiYiQRP3D13+aZaQ0B3NZ
         /O+4m4GbV/e6Mii84LxT0f75OharNsScFqExngbs=
Date:   Fri, 22 Apr 2022 14:13:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH] devcoredump : Serialize devcd_del work
Message-ID: <YmKb+xWkfNGiYBHD@kroah.com>
References: <1650364077-22694-1-git-send-email-quic_mojha@quicinc.com>
 <11ff242b-195c-de75-d3d2-3e7b17a2ef3c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11ff242b-195c-de75-d3d2-3e7b17a2ef3c@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Apr 22, 2022 at 03:33:08PM +0530, Mukesh Ojha wrote:
> 
> Hi All,
> 
> Request you all the review comments on the fix of the described problem?
> 
> -Mukesh
> 
> 
> On 4/19/2022 3:57 PM, Mukesh Ojha wrote:

You sent this 3 days ago, please be realistic.

If you are concerned about the delay in patch reviews, please help us
out and review patches sent to the list.  Otherwise, don't start to
worry until at least after 2 weeks.

thanks,

greg k-h
