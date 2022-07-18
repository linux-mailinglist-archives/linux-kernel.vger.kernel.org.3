Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC48257897C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiGRSWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiGRSWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A782ED7B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFC461620
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A861C341C0;
        Mon, 18 Jul 2022 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658168535;
        bh=zyNWEak7xuAKLRfXthOBkxNPNxT5bcFLqsBMm4e7quQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyTPqr2wV3uijFOOSNQ8ZNxWWP9VMwbAL+BP2J6rnreWtEwhIj54ZML5S/IdaqCob
         F0XsWipE1cnosddnCMk4o04d+T4soinygJHtHHpjwnD5vktiXX2SwcGEq2Q9qKEOGb
         fytau8lIqh3gORUEiT/zbaX/De+UKm3jSum1THOrzFYmCszMtvYjVTffgYOj2rPHfZ
         Ap+XMfFfVCv6WDVbLCd/jbU0E9W/a+QGzfkFceypf0EoKau7eZrtRaQu9TuG8y14Eu
         7ZsXAxWxuOdl45c5suL5z79bs5TYJ7vFJZu/KeBh2voTdhLOuV/qWk3RO9qEBB80Z+
         VNFIY4eI2mRjQ==
Date:   Mon, 18 Jul 2022 11:22:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Justin Stitt <jstitt007@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] include/uapi/linux/swab.h: move explicit cast outside
 ternary
Message-ID: <YtWk1abYruK6DIoL@dev-arch.thelio-3990X>
References: <20220608223539.470472-1-justinstitt@google.com>
 <YqJYrImC3Bk40H1H@dev-arch.thelio-3990X>
 <CAFhGd8qTc-=Fjw2LZW4HYJtVyizkLhYRyv-TYLd1ji-9oR9EdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8qTc-=Fjw2LZW4HYJtVyizkLhYRyv-TYLd1ji-9oR9EdA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 11:12:25AM -0700, Justin Stitt wrote:
> Any chance a maintainer could take a look at this patch? I am trying
> to get it through this cycle and we are so close to enabling the
> -Wformat option for Clang. This patch fixes over 50 warnings and
> there's only a handful of patches remaining until we can enable
> -Wformat.

I think this change is already picked up? It's in -next.

https://git.kernel.org/akpm/mm/c/d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
https://git.kernel.org/next/linux-next/c/d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7

Cheers,
Nathan
