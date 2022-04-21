Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00150ABDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442082AbiDUXRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392628AbiDUXRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:17:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000E49CB1;
        Thu, 21 Apr 2022 16:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75EC5B8298E;
        Thu, 21 Apr 2022 23:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACB3C385A5;
        Thu, 21 Apr 2022 23:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650582887;
        bh=2AUhV09QcV4bVrn9tzKu+nrcgxu6wlvvxLmWeOytq9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyXaGuTekR73pGtwEJeHZNKqU9cy/aBWp4F10gdT7juWedSGhcfUkcda5DXXH9wll
         0QP8S1stfGlGHQzQE8DHtpO4/jhjfNJLSUuz3TIMhP+J1FfjtkozUn/PHU+flGf7sB
         Rpwt6KuleiLgf9rI/dt4xbfLFvu+v7yt/vw8lvScliNp8vmc7zKvS8pQOCoCdvNrAV
         ft5bXptIPU68u6LRzVxV0AXVbIw+oPhuUSUkSHJNDRpnIn8Mfw06Wpx1riWrlt7Smb
         9+dsUWQLuevoeoGMYJUbHPYQp2KJGr+HfhLfk7O4b2zG9Afb/AaW9z0orR89+B+sAq
         Ea3k8vq+10ujA==
Date:   Thu, 21 Apr 2022 16:14:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Andy Polyakov <appro@cryptogams.org>
Subject: Re: [PATCH] random: avoid mis-detecting a slow counter as a cycle
 counter
Message-ID: <YmHlZX4q4xVKZvsC@sol.localdomain>
References: <20220421192939.250680-1-ebiggers@kernel.org>
 <YmG8k1JrVexBGmJL@zx2c4.com>
 <YmHDctbEAmJhinoz@sol.localdomain>
 <YmHhx5IrxDKeqJnc@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmHhx5IrxDKeqJnc@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:59:19AM +0200, Jason A. Donenfeld wrote:
> 
> I suspect what you actually meant to do here is check adjacent counters,

Yeah, I messed that up.  I'll send a v2.

- Eric
