Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9AC542E10
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiFHKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiFHKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:43:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1923BF8;
        Wed,  8 Jun 2022 03:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89EAFCE2788;
        Wed,  8 Jun 2022 10:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7744EC34116;
        Wed,  8 Jun 2022 10:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654684988;
        bh=hIFwJKRqtr0PqOyjIt5Wcaczq5LJLzov/k92/HzuLY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BU4C8kMyh8XB2Ct5R5cjwIoc9SSwwU5RYTNmHuohfUp//YOak3azYq13ZUgeDAfyT
         NS9863Sqh51gg3e9brI0TcTaViz93oj2JpqAqHj52qGW/wzkOUYe4GLYpHOk53hCBa
         Lo+tBf71RV4QW2VDEQ6MqEtVt+RcMe1hYhuSHYYM=
Date:   Wed, 8 Jun 2022 12:43:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
Message-ID: <YqB9OvE+5SXKXbS1@kroah.com>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-16-jslaby@suse.cz>
 <8ad44d3b-449f-4a30-1a4c-dffd43bbbd1@linux.intel.com>
 <e9f35a26-8f5b-f585-2e8c-19690bf3c770@kernel.org>
 <CAHp75VfPi=BMzw4x2tTv2S5Wa0y6vvB3HUY6GyF3t_ddg_YUGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfPi=BMzw4x2tTv2S5Wa0y6vvB3HUY6GyF3t_ddg_YUGA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 12:38:49PM +0200, Andy Shevchenko wrote:
> On Wed, Jun 8, 2022 at 10:56 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > On 07. 06. 22, 16:19, Ilpo Järvinen wrote:
> > > On Tue, 7 Jun 2022, Jiri Slaby wrote:
> 
> ...
> 
> > > Doesn't this fix something?
> >
> > If you mean a Fixes tag, this is pre-git.
> 
> You may use history.git [1] for pregit SHAs.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

Please don't, it just does not matter.

thanks,

greg k-h
