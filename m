Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1855D122
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbiF1GxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiF1GxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:53:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4FB6B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F854B818E0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16475C3411D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656399181;
        bh=GHMM2s0hzDJuuGa0f9j5aGFlqIFqUrHRXQCHwF5hexQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ptmfrSfAmcwPRl3xfQLgH8u0JQh4NGQq7355LAl6cLVz/9Bi3NoW+/m99fQyMLSCt
         N1Flvv8pcg1esnptYW6UJREtRxUnUZfJLxg9C27KqG028D0WwV92Nnazizn2XdlYbm
         EVqmN/c00tbWNkcC0YtIcOrCUAHMr2KZxGW4uoOJ1ZMGUpbeI0mX8EPe1RcCg721Uv
         pX0+i+vaPvyAFrFSmtBMpQ3fS8CWq6wB+NyyjkASdgCskvAQjkcMr9wvVUYVWZ3SR9
         MxH0oLaMbkqSpEHFRrHghp7sesdxBpDIizEUok7BdFiYMQbKXtE2Ujg9gZhAyN1biA
         v0Lrjbo2MgKRQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3177f4ce3e2so106876937b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:53:01 -0700 (PDT)
X-Gm-Message-State: AJIora/8In3RsiCg7K2S9n7uEv6NqLI46SnQsPGTSlYVg7FS0WnEXoev
        SRCV3wg8141oNgdArnWuEwRCmcgXDu3jb5UaTc8=
X-Google-Smtp-Source: AGRyM1ueU/9rqx8l4OSVQpYFot1Hk2MDp0ngO2AXOayGLNG52Ul0VwB3yLGlaXMbia/dnuIh1O7g09lXcfs9SAzDDhE=
X-Received: by 2002:a81:32c9:0:b0:317:7278:e377 with SMTP id
 y192-20020a8132c9000000b003177278e377mr19228018ywy.3.1656399180136; Mon, 27
 Jun 2022 23:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220627202620.961350-1-ogabbay@kernel.org> <20220627202620.961350-2-ogabbay@kernel.org>
 <Yrqffh0IxXiEZHiF@kroah.com>
In-Reply-To: <Yrqffh0IxXiEZHiF@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 28 Jun 2022 09:52:34 +0300
X-Gmail-Original-Message-ID: <CAFCwf11kj=V=p5iemR5SMuN6X=Cc3aiMmWfMLaKtcYNfhe=+og@mail.gmail.com>
Message-ID: <CAFCwf11kj=V=p5iemR5SMuN6X=Cc3aiMmWfMLaKtcYNfhe=+og@mail.gmail.com>
Subject: Re: [PATCH 01/12] habanalabs/gaudi2: add asic registers header files
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 27, 2022 at 11:26:09PM +0300, Oded Gabbay wrote:
> > +#ifndef __GAUDI2_ARC_COMMON_PACKETS_H__
> > +#define __GAUDI2_ARC_COMMON_PACKETS_H__
> > +
> > +/**
> > + * \file    gaudi2_arc_common_packets.h
> > + * \brief   IDs for QMAN ARC CPUs
> > + *          This defines IDs that needs to be programmed into CPU ID
> > + *          register xx_ARC_AUX_ARC_NUM
>
> What is this "\" formatting for and from?  What uses it?  I don't think
> it's kernel-doc, right?
>
> And if it is kernel-doc, are these files all hooked into the kernel
> documentation build process to generate the output of them?
>
> thanks,
>
> greg k-h
No, it's not kernel-doc.
It's a file copied from f/w team and these comments went under my radar.
I'll just remove the non-standard format. It's not relevant anyway.

Thanks,
Oded
