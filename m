Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5457BF44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiGTUhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTUhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:37:51 -0400
X-Greylist: delayed 604 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 13:37:49 PDT
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF0622BD8;
        Wed, 20 Jul 2022 13:37:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 761E3125CAF;
        Wed, 20 Jul 2022 16:21:58 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=u+GuoWlBG33c/AK7UMiDpiQVnxq6c+R/USfLvd
        6Hsb8=; b=AWU9bSoqAulqrt9x8y6d+RZE8+idTvowVlTykIjcY6fwxsHzvpC77s
        WC0mn6SwNoigg+Z6XbAAVOTxxT16SvRsO3QqLY/TQiNQMWVZr/WIX1dajWyQ0lcb
        tVCzqshCM7QxPp2LLVUE0lsBDqGyBD5gf9eLRCRsPZulrw0bbx5MA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D2E3125CAE;
        Wed, 20 Jul 2022 16:21:58 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=u+GuoWlBG33c/AK7UMiDpiQVnxq6c+R/USfLvd6Hsb8=; b=tDWbhUKacircgw5p5fNNCe7ds/o2wQYMAlg4Azoo/hugaAKgzjONfyBEhMV/Vu/SUO0BUNMDjYdoxC2/+ZHPeDTqGIczma1B7GFQ0ksGFcPxthKg0Kealixzy3SnFEgwownRy/3UTIQ/tbw9bkCHT/uIV5pdxPKJy/duQ554pHE=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2FE7125CAD;
        Wed, 20 Jul 2022 16:21:57 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id BA6E336CF17;
        Wed, 20 Jul 2022 16:21:56 -0400 (EDT)
Date:   Wed, 20 Jul 2022 16:21:56 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
cc:     Olliver Schinagl <oliver+list@schinagl.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
In-Reply-To: <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
Message-ID: <1163467-64s-p66r-r077-35s058258150@syhkavp.arg>
References: <20210414184604.23473-1-ojeda@kernel.org> <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl> <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com> <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 9ABA17EC-0869-11ED-AC82-5E84C8D8090B-78420484!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022, Miguel Ojeda wrote:

> On Mon, Jul 18, 2022 at 8:56 AM Olliver Schinagl
> <oliver+list@schinagl.nl> wrote:
> 
> > Secondly, and more importantly so; you argue 'who cares about people
> > with disablements, atleast its equally hard to read everywhere' which is
> > a very poor argument :p
> 
> No, and I want to be __very__ clear about this: at no point I have
> argued "who cares about people with disabilities" or anything like it.
> It is insulting that you even suggest it.

What "people with disablements" have to do with this anyway?
I don't get it.


Nicolas
