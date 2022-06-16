Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B754DCF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359686AbiFPIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiFPIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305595DA70
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C951F61D65
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3586C34114;
        Thu, 16 Jun 2022 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655368454;
        bh=ublYzMeBpkL2nDn9W49uM/lBkV7LItyXZeOAeOSTvnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EparsVpl12W8ZIRY6gWRAcOYfQHxqJmn0mijxiKXbQTdPQvBbbhzl2wZ2jSaBn5kZ
         cxYO93OcwABGS7AuSVarZ83HT+k2lkP+IN6v6noIaUiGVz+mvHimAgTBzMq3IyvvLo
         /L7AERIkxUEX+VOFm0vFC86DClOvQzm3+jzEor7Q=
Date:   Thu, 16 Jun 2022 10:34:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hans =?iso-8859-1?Q?M=FCller?= <schreibemirhalt@gmail.com>,
        arve@android.com, christian@brauner.io, hridya@google.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Subject: Re: [PATCH] staging: remove ashmem
Message-ID: <YqrrA0ddWsRi2vH7@kroah.com>
References: <YjCTL/2ZJW8EWLHL@kroah.com>
 <3f8d25aa-17a6-e6aa-4b6d-d3388ef35201@gmail.com>
 <YqrN38V/qS9ljk8+@kroah.com>
 <20220616063104.GA5494@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616063104.GA5494@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:31:04AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 16, 2022 at 08:29:51AM +0200, Greg KH wrote:
> > That is a "Android 7-based" system?  That's old, how are they supporting
> > that anymore with the security stuff that has happened since then?
> > 
> > Anyway, if this were to come back, I need a maintainer who agrees to
> > maintain it and fix and support it.  Are you able to do that?  If so, I
> > think it would probably be easier to fix up anbox to use memfd instead,
> > is anyone doing that (I couldn't figure that out from the github
> > issue...)
> 
> I'm very much against this.  ashmem is a mess and we should not maintain
> it for some kind of retro computing group.

I totally agree, and was hinting that if someone actually had the skill
to maintain ashmem, they would know it is easier to just fix the
userspace code instead :)
