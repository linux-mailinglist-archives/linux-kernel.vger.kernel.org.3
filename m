Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741B65A0C30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiHYJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiHYJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2544F664;
        Thu, 25 Aug 2022 02:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 916A661B49;
        Thu, 25 Aug 2022 09:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEE7C433D6;
        Thu, 25 Aug 2022 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661418136;
        bh=TZpnsZjSvHGSmy74ghmwxG/kKb7I5dSTTj7dKvDa1vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0RPCrVrpCH4HukbFcYqOVOIr/9wZFYSatmY7v1mtzgmrzRsrURI875nxtTPY/2Aq
         TtNPvPrceys+MaF3zURbyFMoos0OBIiGCUE4/Hu4cfIPH1LI9uB0cbvZY5WOMoXi3v
         dL86ARoTq5KRs+DW3Z8cYrbSe7f2DZp1HZ3KZPKc=
Date:   Thu, 25 Aug 2022 11:02:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Roderick Colenbrander <thunderbird2k@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: playstation: convert to use dev_groups
Message-ID: <Ywc6lFdhKYJ5xPbC@kroah.com>
References: <20220804113052.1117009-1-gregkh@linuxfoundation.org>
 <CAEc3jaApj_=eEgOWzhfh06PXKU7DO1zAsR8tG-SD3vva5duTtw@mail.gmail.com>
 <nycvar.YFH.7.76.2208251036290.19850@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2208251036290.19850@cbobk.fhfr.pm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:36:52AM +0200, Jiri Kosina wrote:
> On Fri, 12 Aug 2022, Roderick Colenbrander wrote:
> 
> > Hi Greg,
> > 
> > Thanks for the patch. It looks good and confirmed it working properly.
> > (Replying from personal email... corporate email systems *Exchange*
> > don't work well with GIT)
> > 
> > Acked-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Sorry for the delay, was off for a bit. Queued in for-6.1/sony.

No worries, thanks!
