Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6844BB2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiBRHLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:11:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiBRHLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:11:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1831425B2F9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 23:10:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC6D7B82486
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C81C340E9;
        Fri, 18 Feb 2022 07:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645168247;
        bh=d+hIdbP4FcjzoABr76JeTKbmnhBBCfqZICtBBkTZUKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+JysrmpF0/EDrB5xHfEaEQ6p9cdUqaBWI3XOenDKrL3YPKrprayM0DrAhAMyHm72
         xhUPRFlZ0XpJ3ImhtOCNfALdfoGePbAZA7axG/E4Gk6OPilGgS6D60yTbsn++jGpZK
         m37+jsURk0HWwEul1S4mfx94va1vtToF+WAZmr9s=
Date:   Fri, 18 Feb 2022 08:10:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ahamed Husni <ahamedhusni73@gmail.com>
Cc:     Bryan O'Donoghue <pure.logic@nexus-software.ie>, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: Fix Coding Style Error
Message-ID: <Yg9GcPtAOeVtmTyg@kroah.com>
References: <20220217190722.44894-1-ahamedhusni73@gmail.com>
 <Yg6hcX6XK4Eu0KOR@kroah.com>
 <CAFjpAKqy908scQTRJPkMhEz8OyNiR3-N8XD2hiGa+VBLhUf0VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFjpAKqy908scQTRJPkMhEz8OyNiR3-N8XD2hiGa+VBLhUf0VA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 10:22:28AM +0530, Ahamed Husni wrote:
> Hi Greg,
> 
> On Fri, Feb 18, 2022 at 12:56 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > Did you try to build this change?
> 
> I am a newbie kernel dev and trying to understand how things work.
> I did not build this change by the time I sent you this, thinking this
> is just a style change.
> I should have tested the build. I am sorry.

You always have to build-test your changes, as you have found out.

> Now I built the changes by setting the following configurations.
> CONFIG_GREYBUS
> CONFIG_STAGING
> CONFIG_GREYBUS_LOOPBACK
> 
> My change introduces the following error.
> ''''
> drivers/staging/greybus/loopback.c:166:2: error: expected identifier
> or ‘(’ before ‘do’
>   166 |  do {            \
>       |  ^~
> ''''
> I could not fix or find the reason for this error. Please guide me in
> this regard.

There is nothing wrong with the original code here.  Remember that
checkpatch is a perl script that gives good advice, but it is not always
correct.  You must always manually check it based on your knowledge of
the C language.

I recommend learning a bit more C before working on kernel code.

Best of luck!

greg k-h
