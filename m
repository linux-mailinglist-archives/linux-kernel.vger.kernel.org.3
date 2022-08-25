Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32B5A0F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiHYLsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiHYLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:48:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306A74E17
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF7BB828ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83361C433C1;
        Thu, 25 Aug 2022 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661428084;
        bh=su9XwmyvlATrUdkfCKKe1ykSCS2VIIKGl8G4FydUb4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qM/mzNKbsm/SehtQxys0vGbOXa3izItOcTTltNIOZZ5RrzeTyMYjeLNSVuwVrbBBX
         rQqipPgcvfa+jb9Ew7s03iXT3oEFkjZe3ZVR06XmQ3sZ6oPlzgue3qg2u/guiVTwS4
         JVAiNsRPkB3bDnAzDo71mRbhtrlkYqeTXWyQDx0A=
Date:   Thu, 25 Aug 2022 13:48:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] earlyprintk: Clean up pciserial
Message-ID: <Ywdhchx2Mn4DAJAn@kroah.com>
References: <YwdeyCEtW+wa+QhH@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwdeyCEtW+wa+QhH@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 01:36:40PM +0200, Peter Zijlstra wrote:
> 
> While working on a GRUB patch to support PCI-serial, a number of
> cleanups were suggested that apply to the code I took inspiration from.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/early_printk.c | 14 +++++++-------
>  include/linux/pci_ids.h        |  3 +++
>  2 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
