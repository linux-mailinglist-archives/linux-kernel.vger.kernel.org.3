Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E3E59F7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiHXKhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiHXKhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0AE2DAA6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D65461901
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7986FC433D7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661337451;
        bh=I0cd3WdTf5/zBAmu6OTcaBtCLTvCR1Zj2ub50uiUdRA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AMgkgKUTM+KbJiQvsqxlDklS/cS8YY6ivNu4GsDhfnbFQwC+48wXaxvykBpWAE6AS
         RP0mm848TK6MxmmJWQbJ9oM6UTiLtpd1drKSdU91lr3BvuZO86X4il5BAA4icgPuVD
         w4pJAhUZsTRSpDw+h2w+zEPAUOqLX0ebMenLH32MsfO8O0Rej5x94vETchKrEvcOt0
         xgQ5TFvSHLUJZ7zvKc1XoyEAr+FBqEXCLkcdYOmRZSz1QdfidOCEm7xn7lQgyBKmSH
         J3dVBWQAVzYj+CS+HD1vGiuPh+QolzDfau0kLiQ4f1zWhYMvpMnUqVr2a8KvBCcWJj
         rD8iQJ23IAyog==
Received: by mail-ej1-f53.google.com with SMTP id ca13so21403763ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:37:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo2pZOXBnDsq77xnFQa+aInuNeQDXPY+oE5DtenPlwO/0eyiASrp
        Ta+iq1aFP3pm4FYQVD8TUbGLJPCxog1gmtDApzs=
X-Google-Smtp-Source: AA6agR6xxyqTl7+HyFIm4H6T5uvQGlwuQI7AV5Ynsj9TdJBoYnlQJCXJrD/4b4WJz2Ijr+W97qcmsyDIKRQxbxO15wA=
X-Received: by 2002:a17:907:7610:b0:73d:afe8:9837 with SMTP id
 jx16-20020a170907761000b0073dafe89837mr2521634ejc.606.1661337449638; Wed, 24
 Aug 2022 03:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220818211550.3272321-1-arnd@kernel.org> <20220818211550.3272321-3-arnd@kernel.org>
 <20220821055537.GB25950@lst.de>
In-Reply-To: <20220821055537.GB25950@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Aug 2022 12:37:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3x5qvEdJJXTMzgu0jXjzXh6LqQRESpGM2XPHiYHm7scg@mail.gmail.com>
Message-ID: <CAK8P3a3x5qvEdJJXTMzgu0jXjzXh6LqQRESpGM2XPHiYHm7scg@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: footbridge: remove leftover from personal-server
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 7:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 18, 2022 at 11:15:48PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The machine was removed a while ago, and the checks are
> > now useless.
>
> Curious, should entries for removed machines be kept in the mach-types
> file?  Because that makes it really easy to leave dead code like this
> around.

A long time ago it was common to add the entries in mach-types before
the Kconfig symbol got merged, an  Russell just updated the list
periodically to drop stale entries. As we remove most board files in
a coming release, we should probably do this as part of the bigger
cleanup then.

        Arnd
