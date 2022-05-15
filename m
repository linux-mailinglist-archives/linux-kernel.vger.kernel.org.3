Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73F55274C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 02:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiEOAnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 20:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiEOAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 20:43:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5003B576
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 17:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19A07B80AF4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48AEC340EE;
        Sun, 15 May 2022 00:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652575381;
        bh=LAVgnr6LgzuDFvxro5KBprq2WxTmqblco3dGzPX5FrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DwjFRQx+CtkEprW5HkPAsvx9kol3dyNmzaBycv6TzM6IVw0/Hpf/Jz6gcHr8bpsbv
         yokV4dq0HFD3JxB9adyrvNP3rkUukuFYRx/XwTlQfPEWWIeGn+76OLX3eeWNOVMA9L
         StB9WIWFyItMZVJa4gQU27MNxAW5ucFn7j4iHdPFIVcxTqTQQRYPgbkGMGf6HHt0Vf
         pvD4ecUw/KqVl9/GKBFZLH8jhdDOvIKLZowyohp6+HI6kFU4mOO4Ro1ucxUF/nuYwG
         +hqL3KlAlr2ujfoxpwLSlEBcWWjj6v4eXWy3dycRyPZJ5HBRZgzV9DEgNEWpi89/8Y
         Fl/jkoZzsvZIg==
Date:   Sat, 14 May 2022 17:42:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] random: handle latent entropy and command line from
 random_init()
Message-ID: <YoBMk1lKmF3B5kZC@sol.localdomain>
References: <20220512124839.20755-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512124839.20755-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 02:48:39PM +0200, Jason A. Donenfeld wrote:
> 
> While we're at it, rename the awkwardly titled "rand_initialize()" to
> the more standard "random_init()" nomenclature.

One nit: there's still a mention of "rand_initialize()" in
arch/openrisc/kernel/head.S.

- Eric
