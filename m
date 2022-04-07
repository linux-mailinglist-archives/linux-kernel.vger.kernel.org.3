Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE874F8714
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346852AbiDGSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDGSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7451D117997
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E389F61D82
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9239EC385A4;
        Thu,  7 Apr 2022 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649356123;
        bh=KXuI+L3w9Z+hWbCVUNJjBVgqsQdywLD3Cgb4k1A4MyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSTmqpdXdMR4dTBSJzbShdzgRXW9GFkSV2irjpwGelaRuzHAyMbxykVvNPt4aHEBF
         RfiTzGNF8wCVVZmS2mZbn+j2of8xoZxxZTHxzxGzn/BomOuW423R2HueDdq1gdIqSq
         PgXjawVP5VpA6hV4s7JpUM1lmJ67/18AKuOSSTBE=
Date:   Thu, 7 Apr 2022 20:28:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8712: remove unnecessary parentheses
Message-ID: <Yk8tVxot2znwyWLm@kroah.com>
References: <20220407125947.8525-1-eng.alaamohamedsoliman.am@gmail.com>
 <Yk8jbTSjvsHXpX2U@kroah.com>
 <96a1de63-5b66-b6a6-731e-d7263f3328a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96a1de63-5b66-b6a6-731e-d7263f3328a5@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:02:37PM +0200, Alaa Mohamed wrote:
> 
> On ٧‏/٤‏/٢٠٢٢ ١٩:٤٦, Greg KH wrote:
> > On Thu, Apr 07, 2022 at 02:59:47PM +0200, Alaa Mohamed wrote:
> > > Reported by checkpatch:
> > > 
> > > Remove unnecessary parentheses around structure field references
> > > 
> > > Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> > > ---
> > > Changes in v2:
> > > 	- Edit commit subject
> > > 	- Edit commit message
> > > 	- Fix the same check in more lines
> > > 	- Remove space before '.skey' in
> > > "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86.
> > > ---
> > > Changes in v3:
> > > 	return the space before '.skey' in
> > > "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86
> > > ---
> > > Changes in v4:
> > > 	edit commit message to be clearer.
> > > ---
> > Why did you send this patch twice?
> That was by mistake , sorry

When you do so, please let us know which to take, as it is hard to know
if there was a difference or not.

Realize that for some of us, we get hundreds of patches to review daily.
Being obvious as to what to, and not to, ignore, is helpful.

thanks,

greg k-h
