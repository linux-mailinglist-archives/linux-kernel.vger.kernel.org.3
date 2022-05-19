Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4852D95F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiESPwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiESPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:51:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1114CD43;
        Thu, 19 May 2022 08:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98D9EB82567;
        Thu, 19 May 2022 15:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8E9C385AA;
        Thu, 19 May 2022 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652975461;
        bh=r9Wo8B3nzcUu8zDEETKXZj2bCnuLNN3Xnn23m34TtgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Zhf/Yo6O4nlyGEVC9StXVCXAphUO2SgZ1qOaBFzTg3MTBt0i4Hp50mVW/t56+bEt
         nPB6GWjxIxIEvBwxwHJQmFpyutbl0GA8QP0w/PgBWhAdgYU/qk+BtUwfftv7DlLFKF
         H1A1Rf+EumQdBp2fZ5cBKNp6dUPrORWly1/E1uNU=
Date:   Thu, 19 May 2022 17:50:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v2] binder: convert `BINDER_*` ioctl `#define`s into an
 `enum`
Message-ID: <YoZnYkRjC+TfdB1i@kroah.com>
References: <20220517102813.10310-1-ojeda@kernel.org>
 <CANiq72=4YKUoUjbs3484mdjsDCXX1V6qf8MrzhW0FN3ZbbDaAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=4YKUoUjbs3484mdjsDCXX1V6qf8MrzhW0FN3ZbbDaAg@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:39:42PM +0200, Miguel Ojeda wrote:
> Hi Greg,
> 
> On Tue, May 17, 2022 at 12:28 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> > bindgen (a tool which generates the "raw" C bindings for Rust) only
> > works (so far) with "simple" C `#define`s. In order to avoid having
> > to manually maintain these constants in the (potential) Rust side,
> > this patch converts them into an `enum`.
> 
> Given the discussion in v1's thread [0], I think we should hold on
> applying the patch (just letting you know here in v2).
> 
> [0] https://lore.kernel.org/lkml/CANiq72=_UAF5DRHCmW4qNt-Wi3yV6vPEjdLhBTijG_ZGgfpaTA@mail.gmail.com/
> 
> Cheers,
> Miguel

Yeah, I'll drop this from my queue, sorry.

greg k-h
