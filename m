Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844E953BC7B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiFBQ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiFBQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:26:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C02B12D7;
        Thu,  2 Jun 2022 09:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E21161598;
        Thu,  2 Jun 2022 16:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18768C385A5;
        Thu,  2 Jun 2022 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654187177;
        bh=2LEc1OMNJeep+b/p/YqRmR8oeDUhY7ial64PPodp4K0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjpYP6/F6hn+ycgWTaRXN6WkwFsuhomLCOdGnTunfji9nbIk10Eq366O0sQmVu2Od
         p2cJ4BlmxfHUMHBbv4sZO97sShxJFD2j8u1jDtynxNGImqw3Tu4S4UZuOKdTatOQIn
         3kBHwYmuCSh/bU7U49a2FxA1D2spiIHHWG7/UKvY5P4htXnQwOLSe+jG/p49fjAv9j
         AA9TTlOq0/qnCTQNYkiNvfATG+lmH5O4pXA8z9TRC2LtQX+03D4H9SUsXypSHkv3Iy
         duDUOHVWFto1YImK64b8xZD8ZoovoS0zcG2nM/JtewxFJilMYsMV5/6OTA8RXeBxbO
         iywX4D9YrDYhQ==
Date:   Thu, 2 Jun 2022 10:26:14 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: show the install image name and path
Message-ID: <Ypjkph5u49gyj9dN@kbusch-mbp.dhcp.thefacebook.com>
References: <20220602015050.3185028-1-kbusch@fb.com>
 <CAK7LNAQot2kMxmisAE2XP3ukPSGBJkLWWYzrTcjV9exSVQKupQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQot2kMxmisAE2XP3ukPSGBJkLWWYzrTcjV9exSVQKupQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:52:24PM +0900, Masahiro Yamada wrote:
> 
> You said "useful for *my* flow",
> so you can do whatever you think is useful in
> ${HOME}/bin/${INSTALLKERNEL}, can't you?

Thanks for the suggestion, that works for me!
