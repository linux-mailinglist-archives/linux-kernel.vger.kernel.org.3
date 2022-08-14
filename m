Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB78591ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbiHNG61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiHNG6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:58:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC565FAC8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:58:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M57Xp2CvXz4x1V;
        Sun, 14 Aug 2022 16:58:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1660460299;
        bh=sjM3KeJV4CuvwOwgnQ1pfbnXFj+g/VYTEIPKGdDvRaw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FBQm4XOFExIEMd6+VdgE7l6J3fg+CdG4B5iTQGnLYEXqL1rTG8v/R1Mmg9smz9wxX
         9jGzoapFZh5iILpPCYFl9HYa+60Kr5PhwxDe072zf+LAexo6RiGQXQsCM6eVEVBfrL
         E8rM/E0+8FwAkrG5KeYgvmkLepz4wHaZ4HqBDKuymUKnBrbfqh/mGANQfsdk5ZMZya
         NdsvppSLRvcjvLCUMUcZjpZr7Q4Usucpy9M8X2IdoSDOdRCA3qbBiw9HLhKAWwMkLm
         8mux9nLSiGAKkrrg21dPclvKwTBDjnWWYV/e5kcsDKTStkPFru88eag1QtD4smopFs
         hG5LWZYEkaRcg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
        ndesaulniers@google.com, ruscur@russell.cc
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-2 tag
In-Reply-To: <CAHk-=wiLWWteYdVgXuLv9TA3aGsUaKV8gS3WxBo+NHHn5ZHkPw@mail.gmail.com>
References: <87czd3d8ra.fsf@mpe.ellerman.id.au>
 <CAHk-=wiLWWteYdVgXuLv9TA3aGsUaKV8gS3WxBo+NHHn5ZHkPw@mail.gmail.com>
Date:   Sun, 14 Aug 2022 16:58:17 +1000
Message-ID: <87zgg7b9bq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sat, Aug 13, 2022 at 4:27 PM <mpe@ellerman.id.au> wrote:
>> [..]
>
> Btw, could you please fix whatever your email setup is, so that you
> have a proper name?
>
> Seeing that 'mpe' as a source in my inbox just makes me think it's
> spam and not real mail.
>
> My search for "git pull" will find it, so it's not a huge problem in
> practice, it's more of a "what is that garbage in my inbox - ooh, it's
> Michael Ellerman's badly configured email again"

OK.

cheers
