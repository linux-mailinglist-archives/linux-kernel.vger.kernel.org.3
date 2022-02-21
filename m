Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7094BD55A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbiBUFTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiBUFTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:19:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AE522E4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A459B80E6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AA2C340E9;
        Mon, 21 Feb 2022 05:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645420727;
        bh=PG4E8Kd3vZdg3jK6CZHcS/AHhgiPMEFp7Tt8ctcfMqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6xYFodtvguwDbjfM3lubUs8scJtyNE+lMvuOkTdK+CvgE5XFqmBrHoYjO2zMB8w1
         qo7Ffq/NaQF5mVseFIwEiV4eFLN4WVcaBVBi1X1Cc/sIS3viPIpAvW8zqx0v96JNZe
         j+bBhJhkwoRXA6SfYaFv94+vhU7FELhyi1SsXXsM4zalGLEGvoh03OZAreplp48Gt1
         mjsyWGRjf7y0S/gOsszdEVcavQ/oFYC2IC0kGkPgtB4/npTdNwraOsyD/4fTj7y2G2
         tXPrBQ7ibKkU/GZ2frGQWfQIWXGVi5t9kthktvsXtnWqPZvwUlSJ9/THQgCHnvj3Am
         DgNfJ2DKoLbVQ==
Date:   Sun, 20 Feb 2022 21:18:45 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/3] random: remove ifdef'd out interrupt bench
Message-ID: <YhMgtVaw3OjJ/u2w@sol.localdomain>
References: <20220210155012.136485-1-Jason@zx2c4.com>
 <20220210155012.136485-2-Jason@zx2c4.com>
 <YhMUkwfdI/GbxCT2@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhMUkwfdI/GbxCT2@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 08:27:00PM -0800, Eric Biggers wrote:
> On Thu, Feb 10, 2022 at 04:50:10PM +0100, Jason A. Donenfeld wrote:
> > With tools like kbench9000 giving more finegrained responses, and this
> > basically never having been used ever since it was initially added,
> > let's just get rid of this. There *is* still work to be done on the
> > interrupt handler, but this really isn't the way it's being developed.
> > 
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/char/random.c | 40 ----------------------------------------
> >  1 file changed, 40 deletions(-)
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> 
> - Eric

Actually one comment: there is a reference to ADD_INTERRUPT_BENCH in
Documentation/admin-guide/sysctl/kernel.rst that needs to be removed.

- Eric
