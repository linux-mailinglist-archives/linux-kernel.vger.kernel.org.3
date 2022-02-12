Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14C94B3387
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 08:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiBLHFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 02:05:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiBLHFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 02:05:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76EB27173;
        Fri, 11 Feb 2022 23:05:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7219860AAF;
        Sat, 12 Feb 2022 07:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7A9C340E7;
        Sat, 12 Feb 2022 07:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644649533;
        bh=gTco+1pkyITCw/pHuQznhNFeDlRZKIiQEjNLuUyC9TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1BeN17hMh77B2BXFCn5T0OADvozRN9nnFutzjsdMFWq0mrb9kw6Rmpx9wqCVLs1hF
         DHp+qNXu+0vyAiww4E9SdTqLQOpTTP87q4Rvy/fWi2RG1aa0DAagmlKm+gKIPOU2xD
         YZ8oTTiEIPKKakRE3rU2gDYHU2NnQQWQBPO1SRoo=
Date:   Sat, 12 Feb 2022 08:05:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ahamed Husni <ahamedhusni73@gmail.com>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: Fix Trailing Whitespace Coding Style Error
Message-ID: <YgdcNwgz+S50DUkJ@kroah.com>
References: <20220210130801.377918-1-ahamedhusni73@gmail.com>
 <20220210191838.398373-1-ahamedhusni73@gmail.com>
 <YgYyqEfAcQ0zJhmM@kroah.com>
 <CAFjpAKoLYDeY6FrRAebBkbasgLoxPzvUjQH3hE7iJgSpkNfaRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFjpAKoLYDeY6FrRAebBkbasgLoxPzvUjQH3hE7iJgSpkNfaRQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

On Fri, Feb 11, 2022 at 11:48:41PM +0530, Ahamed Husni wrote:
> Hi all,
> 
> In the patch V1 I had added the changelog in the wrong section.
> In the patch V2 I have corrected it and also changed the commit message
> subject line.
> No code changes were made from the patch V1. Should I create a V3 patch
> mentioning this?

Please do, I can not take it like this.

greg k-h
