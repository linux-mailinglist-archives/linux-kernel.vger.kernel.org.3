Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88AA5AA746
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiIBFeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiIBFeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33603B6D5E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA73961F23
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3DCC433B5;
        Fri,  2 Sep 2022 05:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662096842;
        bh=lYtl6Ualnpv5CvRP0gN02tu05BtshFAzUAyR5XSZwao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1CWpYcqjahwLYngXg2gbA4YUX2z7WSbjTMb3sYzrjEFW6uuOh7QrW2x8P2U7VPg5
         VHEiGKOpxNjTQMbsji7XqeDkLQK5g/WwQnhp1bB4RD5FvSXlaDlSfriioRe2xipwXv
         Ew4xiMp3kLpAp6l6990veb20FV44LAymD++yVFAM=
Date:   Fri, 2 Sep 2022 07:33:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        lu.fengchang@zte.com.cn, makvihas@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Zeal-Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Driver: r8188eu: Remove the unneeded result
 variable Return 0 instead of storing it in another redundant variable.
Message-ID: <YxGVxtQgY2vhJBPh@kroah.com>
References: <20220902032628.316333-1-lu.fengchang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902032628.316333-1-lu.fengchang@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:26:28AM +0000, cgel.zte@gmail.com wrote:
> From: lufengchang <lu.fengchang@zte.com.cn>
> 
> Reported-by: Zeal-Robot <zealci@zte.com.cn>

As stated in the past numerous times, I am no longer accepting patches
from this "tool" unless you provide the needed information that I have
asked for.  Please work with your managers to fix up your development
process, this is not acceptable.

greg k-h
