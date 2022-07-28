Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA958486C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiG1WwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiG1Wv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:51:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C14F1A1;
        Thu, 28 Jul 2022 15:51:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lv5Vx1qmBz4x1N;
        Fri, 29 Jul 2022 08:51:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659048713;
        bh=JddId/71HJJ4bainsai6Zd4G+egkNDy/Bpv8mjqhd1o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UHgrRSsSBo0LKfF+3SWgSYSy16szwpZcEKdO9eD09QBV+L7WudC1qtrX+ZEbno4Na
         LViJXHscU+GHvW8lmaiTWi5PIp0X1BcXUdLNTwrsrbKQa9Cdz3kEVfciBcbiIt7JwS
         clOt3C2HfakqrylUxYAfvBHpOGyH0YCX0L3vMGqCESQil7EE4vzS/sztu4HIwGHg5t
         nWfYntY9tO5okEg80p57knmCKyjJoRXA9dF+m9aiY3JPZhsP2ZLoMq4qO13YaUd8fG
         Gi8wWTUVyT1sGK80I+/g8EKhDWFeyz4ZXkW6h+ZWYxtRpdzq59wSIk2o7OY6no95Am
         T5Fc/OL406nCg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu and
 powerpc-fixes trees
In-Reply-To: <ff2ea1b1-8039-369b-cc4c-b1d01d5cb02b@amd.com>
References: <20220726205458.0b5ca446@canb.auug.org.au>
 <87leseabci.fsf@mpe.ellerman.id.au>
 <CADnq5_OkWWO+hNz-n+bw5Wptn3JsfyuXe+ScXYTKwFz6JJf8fQ@mail.gmail.com>
 <ff2ea1b1-8039-369b-cc4c-b1d01d5cb02b@amd.com>
Date:   Fri, 29 Jul 2022 08:51:51 +1000
Message-ID: <87v8rgc0l4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com> writes:
> Hi Stephen/Michael,
>
> I made this fix:
>
> https://patchwork.freedesktop.org/series/106824/
>
> Could you check if it fixes the issue for you?

Thanks that fixes it here.

> If so, could you undo your revert?

Stephen is on vacation and not doing linux-next today, so I guess for
testing you'll have to do a local revert.

cheers
