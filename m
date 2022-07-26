Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F2581622
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiGZPK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiGZPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:10:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CBE655D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B5819CE19E9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F9AC433C1;
        Tue, 26 Jul 2022 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658848251;
        bh=Ve3kJopSs2GE0hsDcrtwFJkWj6Nvx21L402wTn5aSw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ey0DAijPvLnK4bfKUSDWiyI4CdD2YLHtQNKvPqxonvaip1mmJEFPnDWamjrQq6xDQ
         BnUtc50uPchU5gwsEweasVZ3R3SKzt5Uu7tROvEcbDXl+cMENbyzCNCAaMM6xMubPK
         igWAR4lKo3tuZEODfPM07jwesz730pTTUK1cEFE4=
Date:   Tue, 26 Jul 2022 17:10:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vishnu Dasa <vdasa@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Message-ID: <YuAD90UfLnf1Ojso@kroah.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
 <Yt7bfyANrfdPxdS8@kroah.com>
 <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 06:29:25PM +0000, Vishnu Dasa wrote:
> 
> > On Jul 25, 2022, at 11:05 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
> >> From: Vishnu Dasa <vdasa@vmware.com>
> >> 
> >> Remove Rajesh as a maintainer for the VMCI driver.
> > 
> > Why?
> 
> Rajesh is no longer with VMware and won't be working on VMCI.

But employment does not matter for maintainership and has nothing to do
with it.  Maintainership follows the person, not the company, you all
know this.

So for obvious reasons, I can't take this type of change without Rajesh
acking it.

thanks,

greg k-h
