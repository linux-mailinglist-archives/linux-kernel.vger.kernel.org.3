Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2739258C832
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiHHMOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiHHMOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:14:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4C838BD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:14:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l22so10672798wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=0E8nWSXeCZphwzspe4OOM++h3nyUvm9NUwYOHmO50IU=;
        b=R3ZzXhNOmEo2C51jsQI5IGQLZiS8SsHGMvnMZQIHchJySVP8zLPKtIl75+/G+F5hfg
         3AnczWhnwwGRmqPCIeqhLJZb3hZMWgr2TKNmRRIJ6UHHv8fqRu9oD3liDNti+bT7Fb7v
         /ijyp0vvIHHIYV+pUJGAs1pmvA2qAFsDLigzHf5qKO9aktlUHAEgYdrsICdXk1+TD664
         SUpiXZQ2UnTnI3emBdvbCjNdrS3N4MyQ/PJ9PvW9te08+j/88s0TjAsxePCySBZPoFYN
         RjYDyGb9eavdLVlFbIXjxsJvggCgbB+geZOK/7p9jO/JBHwHIc2pN397PqA97gxxcYGr
         K6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=0E8nWSXeCZphwzspe4OOM++h3nyUvm9NUwYOHmO50IU=;
        b=06TqCUi3eRZgjQ1CCgv2zx0Ro0p+EGRY/xRq2JQz45iy6kXCaxBzOmtnGzH1IIHAra
         0bjtV/P/UPAq1L2RId5aEQv+J7nxD6KwiVbyzXt21w8UBCom1OC53qD8CyQM5BAK6TAU
         lSQlfq6NJ/tkxDq2FV9LYGDV5TWHJNyKdXLnAdRPscwK6ewrWPk9N1WkRYy7dEZMkiRg
         A2u0Im2cIdQrMeFnMsKP1i0v/9S5tD3foO4bUZmqMOV/00s0io0q8pvNMF4YqfDc0f0G
         5LQxgxuuxQ3v+VIMkVR/+hZ+QZAzyCXWT4D/0DenX+BzeekxLbCsTHQIseTZlREwryhn
         k+Yw==
X-Gm-Message-State: ACgBeo054A6rc2tjhFPQURzrmY6V5ZbRRfTCkgG0joEHQ+cNj1652lVd
        6OQqrxuEoBwCYl3Mgns5NxXPZA==
X-Google-Smtp-Source: AA6agR59HBaYvdNxcurG6DU2XNVy6pfIHmBWUUY+HMcMLhePYLHVCg7z2EUx4rzOJFkYt9HhDfdlrg==
X-Received: by 2002:a05:6000:18a3:b0:21f:d6a4:1aec with SMTP id b3-20020a05600018a300b0021fd6a41aecmr11297534wri.468.1659960841070;
        Mon, 08 Aug 2022 05:14:01 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id w11-20020a1cf60b000000b003a5260b8392sm6358643wmc.23.2022.08.08.05.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:14:00 -0700 (PDT)
Date:   Mon, 8 Aug 2022 13:13:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 11/28] mfd: intel_soc_pmic: Remove #ifdef guards for PM
 related functions
Message-ID: <YvD+BjAhHOZ3/R8w@google.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-12-paul@crapouillou.net>
 <CAHp75Vf1jfgshfw1ymXu9AHrNy1SUmVRDvDLUYbYKFSrhQq44A@mail.gmail.com>
 <RO59GR.D1GGMPYPNKQG2@crapouillou.net>
 <CAHp75VdJaJdpvGp5v-5r77RWpkGnx06J0x=Dmeyt=R8JGBDgYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdJaJdpvGp5v-5r77RWpkGnx06J0x=Dmeyt=R8JGBDgYQ@mail.gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022, Andy Shevchenko wrote:

> On Sun, Aug 7, 2022 at 5:58 PM Paul Cercueil <paul@crapouillou.net> wrote:
> > Le dim., août 7 2022 at 17:50:32 +0200, Andy Shevchenko
> > <andy.shevchenko@gmail.com> a écrit :
> > > On Sun, Aug 7, 2022 at 4:53 PM Paul Cercueil <paul@crapouillou.net>
> > > wrote:
> 
> ...
> 
> > >>  The advantage is then that these functions are now always compiled
> > >
> > > is that
> >
> > I think that what I wrote is proper English.
> 
> Okay, Google just shows 100x times less the above form in comparison
> to one w/o "then".

> The advantage is then that these functions are now always compile
> independently of any Kconfig option, and thanks to that bugs and
> regressions are easier to catch.

 "This has the advantage of always compiling these functions in,
  independently of any Kconfig option.  Thanks to that, bugs and other
  regressions are subsequently easier to catch."

> > >>  independently of any Kconfig option, and thanks to that bugs and
> > >>  regressions are easier to catch.
> 
> ...
> 
> > > 3. The PMIC core actually is Crystal Cove driver and I have a pending
> > > series for that and I guess you know about it. Have you seen what have
> > > been done there?
> >
> > No, I didn't know. I guess Lee can skip my patch 11/28 then.
> 
> I probably memorized the name of a guy, who sent a patch against this
> driver a week ago or so, wrongly. Sorry for that.
> 

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
