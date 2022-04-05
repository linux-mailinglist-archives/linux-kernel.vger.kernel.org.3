Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF04F45A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377946AbiDEU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454613AbiDEP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:58:44 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8EE3FBE3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:05:27 -0700 (PDT)
Date:   Tue, 05 Apr 2022 15:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649171125;
        bh=t+hIRZtv/5J72gOq5YhoXVrS/FiYqIfmQiB83JSrhzM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ru1fLrLFoyieVqTtaX1uC01gDuQjSCnK7Ljdh8R2cG0as4M3vxMFjpQAwOaqHjrW7
         kFnCqk1G2nuLsNvZVQqJWP2RyBmiolkuND1Q4BSdDlmtCO3xFSwT60C0Xe8QeBOzwL
         6B78G9ucKB8GMYB9ezsonO3HFyGQF2YUzl7skwJceOlQcYOGX5zuhoQmrgnKL1XFU+
         DeVBOmCBbpFFauC34ukoOlILVXl8mt3fZ4n2PJur0FFm67z1Igl4YFGbHFzm9D4MK8
         iIEJLG5sYsqQttjfEwpRcqquHdxyEXwnsdY34nDXP3WeLho1BxlAQP7NfIyKEXoBOh
         kft73uhSV1RIg==
To:     Randy Dunlap <rdunlap@infradead.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/format_helper: fix a kernel-doc typo
Message-ID: <qjTlHAInyuxpFWsTWPGXoVeByVdVe-NF-kg-FUeLWQbKy9SovMzCcK-eDsijpDt1roaSubDr-8kBGKQSt_7CXFa4-BxQ6SrGSNeoZrdiq-s=@emersion.fr>
In-Reply-To: <c544d79e-90ec-7bbe-77ad-de96a700d711@infradead.org>
References: <20220403232902.1753-1-rdunlap@infradead.org> <ttcrpLw9HkdhAH5SkXylXDBi9SBf7LWgOeW09ZvTF4U4_zKJAOXBQZlFxfw6NKY0Hip6dXBFape6zkX09cstuOno72c-c00wmZ_VbNDg6xs=@emersion.fr> <b20bbd22-895c-9e74-e579-d2f3561a2fe1@infradead.org> <BzpH4s8ZYn84kTlJQ3BHVMQzZlESb2Fk6v-uO5KBaaeBNMvRvC98lpuBLUNLE3a5bdoYTb5JRvo6EU__5AGJ79LUirSppO39I1t1xlwx-fI=@emersion.fr> <fda186f7-2cf4-a69a-d68e-58073d35cbea@redhat.com> <c544d79e-90ec-7bbe-77ad-de96a700d711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 5th, 2022 at 16:39, Randy Dunlap <rdunlap@infradead.org> =
wrote:

> On 4/4/22 23:26, Javier Martinez Canillas wrote:
>
> > On 4/5/22 08:12, Simon Ser wrote:
> >
> > > On Monday, April 4th, 2022 at 23:35, Randy Dunlap rdunlap@infradead.o=
rg wrote:
> > >
> > > > On 4/4/22 09:04, Simon Ser wrote:
> > > >
> > > > > Both doc patches pushed, thanks. I had to manually edit them beca=
use they
> > > > > wouldn't apply cleanly. Next time, please use git-send-email (see
> > > > > https://git-send-email.io/ for setup instructions).
> > > >
> > > > That's odd. I did use 'git send-email' and I don't usually have any
> > > > problems (AFAIK). I'll check those setup instructions.
> > >
> > > Hm, maybe the issue isn't git-send-email, but the way the patch was
> > > generated? I had to manually edit these lines for the first patch to =
work:
> > >
> > > --- linux-next-20211217.orig/include/drm/drm_file.h
> > > +++ linux-next-20211217/include/drm/drm_file.h
> > >
> > > I changed these to:
> > >
> > > --- a/include/drm/drm_file.h
> > > +++ b/include/drm/drm_file.h
> > >
> > > This wasn't enough for the second patch, I had to re-do the changes b=
y hand
> > > from scratch.
> >
> > Yes, I believe the suggestion should be to use git-format-patch instead=
.
> >
> > To make sure that was is posted can be consumed by the git-am command.
>
>
> Considering that I am not using git, I think it will be difficult
> to use git-format-patch.

Ah, okay. Would you consider using Git for you next patches?

(FYI, I'll pass next time I hit a patch which doesn't apply cleanly.
Nothing personal, it's just that I don't have time to deal with broken
patches.)
