Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48DE5A8025
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiHaO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiHaO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:26:11 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 27E78C32C7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:25:38 -0700 (PDT)
Received: (qmail 191585 invoked by uid 1000); 31 Aug 2022 10:25:37 -0400
Date:   Wed, 31 Aug 2022 10:25:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb.current tree
Message-ID: <Yw9vYaqczVlWzONt@rowland.harvard.edu>
References: <20220831152458.56059e42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831152458.56059e42@canb.auug.org.au>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 03:24:58PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb.current tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/driver-api/usb/usb:176: /home/sfr/next/next/drivers/usb/core/hub.c:6040: WARNING: Unknown target name: "pre".
> 
> Introduced by commit
> 
>   9c6d778800b9 ("USB: core: Prevent nested device-reset calls")

I don't fully understand this bug report.  Would it be fixed by changing 
"pre_" to "pre_reset()" in the kerneldoc?

Alan Stern
