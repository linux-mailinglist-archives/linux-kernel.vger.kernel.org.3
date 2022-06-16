Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766B54DAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358932AbiFPGaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359156AbiFPG37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:29:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A1556B10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E5761A6D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284EEC3411F;
        Thu, 16 Jun 2022 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655360997;
        bh=NZ469P3aR2+wNptm85yXJetrNw20aY789hYp+lOYVXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6gK3fsaQYXmn8QOhXFWF8gu6hPfOmd+WzlsumNICIzeCZToJNtpA7UmqDOhTE9Ou
         pWDbkb0sJURBdbUWMD72J0FajA5RCpwv0ghBb/i3BhD138EhvBjvO5b0CJk/nfqiqq
         Vxxf69AgofpNQKr25PEj/O8sMfKI0F9EDzwpqvWE=
Date:   Thu, 16 Jun 2022 08:29:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans =?iso-8859-1?Q?M=FCller?= <schreibemirhalt@gmail.com>
Cc:     arve@android.com, christian@brauner.io, hch@lst.de,
        hridya@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com,
        surenb@google.com, tkjos@android.com
Subject: Re: [PATCH] staging: remove ashmem
Message-ID: <YqrN38V/qS9ljk8+@kroah.com>
References: <YjCTL/2ZJW8EWLHL@kroah.com>
 <3f8d25aa-17a6-e6aa-4b6d-d3388ef35201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f8d25aa-17a6-e6aa-4b6d-d3388ef35201@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 07:27:48AM +0200, Hans Müller wrote:
> It is not only Android itself that broke but also Anbox
> (https://en.wikipedia.org/wiki/Anbox):
> https://github.com/anbox/anbox/issues/2042
> 
> I use that regularly on my system... I know there is Waydroid and I do use
> it sometimes but it is not a full replacement (especially since it makes the
> whole system slower over time and spams the tty).
> 
> Could you consider reverting that change until the Anbox people found a way
> which allows Anbox to not depend on ashmem anymore?

That is a "Android 7-based" system?  That's old, how are they supporting
that anymore with the security stuff that has happened since then?

Anyway, if this were to come back, I need a maintainer who agrees to
maintain it and fix and support it.  Are you able to do that?  If so, I
think it would probably be easier to fix up anbox to use memfd instead,
is anyone doing that (I couldn't figure that out from the github
issue...)

thanks,

greg k-h
