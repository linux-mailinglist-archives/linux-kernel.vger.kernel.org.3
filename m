Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561854ECCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350519AbiC3TJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344730AbiC3TJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:09:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC5513B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:07:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CA815C0134;
        Wed, 30 Mar 2022 15:07:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Mar 2022 15:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=cvAOyEGtBc9js1
        DsvkUO4so00gLzRIk/BnPZ0/pNBvE=; b=cO5+rq/Ys35FQxCxZY3VnvV26UYfrf
        hKwc06/v/E4RzECYkPUE7+9LA92vijvwOpuY4GjGUXFi9rwkq66svtqrHdWW9XTj
        JXFDJeLdhssGVC0kO0XleAZtLAkdvk4RP2MbAjbDBLSIOzGQ9V7BBLcRZbf2EN3O
        9QrDyaKzoRMhrjvTt099lvsrkFI6c3DmgRSV1RLHKfr1TWauTm0V8USASjPTvcfq
        hX8k08zfZi+S+NBVncub2U0iYzI6q+lHWMwGPYai/N30slHy4FkvwtuBUtdSKEqk
        RpiL/wNHmE8zIU5iN798hx6h2A1kneh+ZGXJ9ruQ0Bi5xacms8r5Q4zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cvAOyEGtBc9js1Dsv
        kUO4so00gLzRIk/BnPZ0/pNBvE=; b=KLZv7MMgmX6jpFtxfPWWPZrDnK+qS2sm8
        khtRW4sKvk1KhJ9Qi6Z+kMWY//Ovv5fLwo8F51hvGqMM1oFXa+ARMPw7VE6csz2C
        42JzsQS4tttQUwQw6P3ZVfhX6xYJkFz7RLg9eQhuymHooC+Pp16wG1KTmKzNT7Du
        uCBsT/c8JhPhs8hY6d2MURQijG9uThfg+r5/J+BDvQ7m6+VICnpmw8O6txo1k7OG
        t9hxrAQXcuk0xml5aHJYkv4VJpVhjq9HpAi4xHL7qfxnO1azU5G159i+uLTB2Uif
        Ee5VYzOSnrTRzABHhn06lTS2gkVOKGWaqf95C7PMPPf0w7b4b9wvA==
X-ME-Sender: <xms:XqpEYoiNukWyDxsLsUNu__yTtaFjcUuylHAyLiZO2kS8A632zZEmRA>
    <xme:XqpEYhCP7Pxkg0gBOEGpxyo0lsPb8vBYQDm9mmP9IQ535XMMn40b2FAajlWNYw2B_
    k-k0B-DHXj6vkcWt8g>
X-ME-Received: <xmr:XqpEYgGiYfOnnqBQfhQSDHvjaprgpD8fX69mv-xXLshkTuSCdshW9SKW0kUgH22e0FvRjWM_q--UGgfDXOo02vWL0e2TVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegtdfgfeeghfevgeelgfefieegudeuheekkedtueeutefgheff
    veegueeiteehteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:XqpEYpRM7tNrw7mZZ-I0eezBbnzdvnqIKse28wa1aICoFGB7KSff1A>
    <xmx:XqpEYlxX94HbVPNPLIkL8hFZrg0sYo1Cg0mU_BB57hUcuj_3eh8F6g>
    <xmx:XqpEYn52g2Ai9YB5eQTN6ncNyWCxwCGkNaKkXtqfhEkGE31QdvukKg>
    <xmx:X6pEYmrWAmzhEnkglb3_KglJvxKtfDHwABcHXQeVnufmNn8rjKjAKg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 15:07:09 -0400 (EDT)
Date:   Wed, 30 Mar 2022 12:07:08 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 9def39be4e96 ("x86: Support compiling out human-friendly
 processor feature names")
Message-ID: <YkSqXNd6yd2WqhDn@localhost>
References: <YkQxVM4PZMrLs9z1@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkQxVM4PZMrLs9z1@zn.tnic>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 12:30:44PM +0200, Borislav Petkov wrote:
> I'm assuming the commit in subject was part of the tinyconfig effort

Yes.

> and I'm also assuming that effort is long gone now.

tinyconfig still exists, and people still use it. The effort to make the
kernel even *smaller* is not as actively developed as it used to be, but
there's still an ongoing effort to prevent it from regressing and
getting *larger*.

I still get regular mails every time tinyconfig gets larger, and I
regularly send responses to those asking people to add kconfig options.
(For instance, this commonly results in making sure that new syscalls
get put behind a kconfig option.) I don't have the bandwidth to maintain
a dedicated tree for new patches making the kernel smaller, but I do try
to make sure the situation doesn't get worse.

- Josh Triplett
