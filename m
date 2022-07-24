Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8823157F4C1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiGXLFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 07:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXLFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 07:05:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F385FD5;
        Sun, 24 Jul 2022 04:05:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h9so12217508wrm.0;
        Sun, 24 Jul 2022 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=llWSD/1tigN8QC7/xrC43dUKhdUQnd/sBtJtC/hQ8rY=;
        b=i7EaF9gLrvcbCIQaJ1ZqfaciJXGvL7DneOGxBz/RzEBG1sIpOIwJImkpEpqFNDELlT
         YtZWmpvsyUVLw8ymFTAlx0gjDcwSLSxX3vSckeymdI/6dO5c9mgeetx5E3sQqBkkcHK1
         uMChKoUI0/Fs0vBxAOpeYwiqhogtthpttKJ5FmvdiMZuMQ1Nwn0A710vx78kcho51ku9
         p0OrgA+9uPICv6feHFpRibDsG4Rsk4/I9Qs7CRl983dU9J7A7ixZK11O6Kiatz/xry01
         8KV/vaWI7q2Wflt3DAMYeHvOFEBKm6O+chZ1rMrF6mjx3mRzVBg9pm23VJZq49cMupfL
         uDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=llWSD/1tigN8QC7/xrC43dUKhdUQnd/sBtJtC/hQ8rY=;
        b=2NQSH4rKPmxSR1Y+PQlz9igABkDeIfEtiA1FMhloeyulPhBB57DWz2AJwqYjSlB/1s
         jhiVV+pJLkwxO9vkatKcHDiX+MbLu3IBLylXJCHMMAumkdo396+Havbnhah3hoUGVmg2
         lkdOzb9hHXm5jKJ/QvjO5oIpyu6kwjdnLdzI4zGFohzY1dUSWf8usfCtdW/lYt543ZdE
         L0ncHuFgdITOpF0Z1CTv75K4reWGcfOd5tvNRVrxhcTh6kQDzbqW8VouQ16r95v0BSqY
         8rbjUcttzIW5oAa0mx33sAgQV3is2fks6I/pff5JHIkhrUGLezwn9aKNzDzT0mLf9bti
         hoDQ==
X-Gm-Message-State: AJIora8s9HVf0NSOou4pTbwJNBHXCohaKlXNOg2S/6IPl2bz74s2CkVD
        4QCAX7ju/rAKa7Aa195xEFIxa2AFyYA=
X-Google-Smtp-Source: AGRyM1vtPRjpSI0MVgOH/qlNsyRfdRl1+ycDDtlgOvrAxvlYK9c//teLmOlmFrFzBEMPyBlEX/QqCw==
X-Received: by 2002:a05:6000:11d0:b0:21e:610f:6274 with SMTP id i16-20020a05600011d000b0021e610f6274mr5034351wrx.611.1658660711587;
        Sun, 24 Jul 2022 04:05:11 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b0039db31f6372sm12629439wmq.2.2022.07.24.04.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 04:05:11 -0700 (PDT)
Date:   Sun, 24 Jul 2022 13:05:09 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Nikolai Kondrashov <spbnick@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
Message-ID: <20220724110509.GA30492@elementary>
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
 <5d4ef0df-083f-a00e-fb41-1ce1df6e9473@gmail.com>
 <20220720173656.GA3725@elementary>
 <47970684-1158-cee8-9ff5-d7dca70a54ae@gmail.com>
 <20220720175444.GA10744@elementary>
 <3cdbcfe5-bb7e-2677-730f-f250e2d33f0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cdbcfe5-bb7e-2677-730f-f250e2d33f0c@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 09:13:39PM +0300, Nikolai Kondrashov wrote:
> On 7/20/22 20:54, José Expósito wrote:
> > Hi!
> > 
> > On Wed, Jul 20, 2022 at 08:45:55PM +0300, Nikolai Kondrashov wrote:
> > > On 7/20/22 20:36, José Expósito wrote:
> > > > I don't know about any broken device handled by the driver, so there is
> > > > no need to add new code yet :)
> > > > I'll try to keep an eye on DIGImend's issue tracker now that the code
> > > > present in the upstream kernel is being released by many distros.
> > > 
> > > If you have the time, backporting your changes to digimend-kernel-drivers
> > > would get you feedback much faster :)
> > > 
> > > I can do a release once we get the code in.
> > 
> > I already opened a PR a few months ago:
> > https://github.com/DIGImend/digimend-kernel-drivers/pull/598
> > 
> > But more code has been merged since then. I'll try to backport the
> > latest changes this weekend and ping you on GitHub once it is
> > ready for review again.
> 
> Ah, sorry, I rarely look at DIGImend notifications 🙈
> 
> Could you send me an email once you got something ready for review?
> 
> Thank you!
> Nick

Sure, the PR is ready:
https://github.com/DIGImend/digimend-kernel-drivers/pull/598

I included the patches present in "for-5.20/uclogic" but not the
patches I sent during the last couple of weeks to the mailing list,
just in case changes are requested.

In addition, I created another PR adding the XP-Pen Deco L tablet to
the web:
https://github.com/DIGImend/tablets/pull/52

Jose
