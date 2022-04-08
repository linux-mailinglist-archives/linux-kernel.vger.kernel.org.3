Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA24F9794
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiDHOF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiDHOF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:05:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1510F6CE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:03:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q19so12995608wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CAJU3Ppjclja8o7yRvgHZKi2NtEeXwWdxUmSNaygYns=;
        b=C4S2gyOjm7hdek5UaS2XaGgjMr8pUub4kFbmITm+4lgCbyJ27ExZTID44lf7oA17yN
         wz7yPBdeZeGWnuBd3GFcyf+fe9mgruhscWbT7RQnYhm1SBg/b5jhFTIhPoQ+/b9yPuUh
         DgDpTV9KahF1CiahTbABAC3bg99zQVr/Rme3aYDPmk1Kqmt+JEcxknUUERm5wDmFORZz
         PWfRRv5z3x4b84yPJq3pC7ylGfCa59GDYLHsumQsts5elvPp5K9VdWXagIhR4pKtrGcx
         Q/c7+RaZ/AD9TJlftVyfLnrEM91Byrr3FoU+Fm9pB0JBvpS70zZxJhbOgjVPwAfKbDrB
         PxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CAJU3Ppjclja8o7yRvgHZKi2NtEeXwWdxUmSNaygYns=;
        b=FCml1EjjfzR4vX7P6IOI3dLlEoAIYr596Qe0AkNdOV8zp7JSXM0shAbHbxs0UOAbTO
         aY/b5xY314FiULqB1vCn6U0EM2TcvRaBIs/5n3h5oUFimQXuC3ReIqkBKoTyUb3XcO2e
         Ks8yqJzvvCGRZB4pHmsv/12camxlQ06PnIKLkMeiLqJdVXY5V6FnGuUG+Cbw5QAzOTwc
         nfLq2wuGaeTuFFmZ8wI1ou48vQqEmB5nMZhx04PtSzV4/75hXdn4yMx5bxGmVithtYFB
         xnUBKu3zpuFrV98SUZue2tD9nozoD0MLA0oJQKpLJiQrmG4kEk338nW1O9zzw1FxcnWZ
         7/1w==
X-Gm-Message-State: AOAM533EAYn81CbmIzOc8syvlobLNGNQNb+T0T6zmJmefwZtkBjaO+Xh
        sl3FWNtTDOJsAqJaZzhnpLKh6Q==
X-Google-Smtp-Source: ABdhPJxzSNsl97gJmGPQadE3+Yhw4Adqx+WK5eiFZD73CBrsS4jqCqS2ni1cS2RpRJdmHLPq3fU+rw==
X-Received: by 2002:adf:8066:0:b0:206:1563:8b2b with SMTP id 93-20020adf8066000000b0020615638b2bmr15038183wrk.582.1649426601269;
        Fri, 08 Apr 2022 07:03:21 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id e37-20020a5d5965000000b0020610e2631esm13423384wri.107.2022.04.08.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:03:17 -0700 (PDT)
Date:   Fri, 8 Apr 2022 14:03:16 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        will@kernel.org, qperret@google.com, maz@kernel.org
Subject: Re: [PATCH 2/2] watchdog: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YlBApO66qMP7oC3c@google.com>
References: <20220405141954.1489782-1-sebastianene@google.com>
 <20220405141954.1489782-3-sebastianene@google.com>
 <20220405211551.GB2121947@roeck-us.net>
 <Yk3ARqLLPssVIM2/@google.com>
 <ebc0923a-48c1-ccd4-6b89-c4ba9ac48da4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebc0923a-48c1-ccd4-6b89-c4ba9ac48da4@roeck-us.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:52:05AM -0700, Guenter Roeck wrote:
> On 4/6/22 09:31, Sebastian Ene wrote:
> > On Tue, Apr 05, 2022 at 02:15:51PM -0700, Guenter Roeck wrote:
> > > Sebastian,
> > > 
> > 
> > Hello Guenter,
> > 
> > > On Tue, Apr 05, 2022 at 02:19:55PM +0000, Sebastian Ene wrote:
> > > > This patch adds support for a virtual watchdog which relies on the
> > > > per-cpu hrtimers to pet at regular intervals.
> > > > 
> > > 
> > > The watchdog subsystem is not intended to detect soft and hard lockups.
> > > It is intended to detect userspace issues. A watchdog driver requires
> > > a userspace compinent which needs to ping the watchdog on a regular basis
> > > to prevent timeouts (and watchdog drivers are supposed to use the
> > > watchdog kernel API).
> > > 
> > 
> > Thanks for getting back ! I wanted to create a mechanism to detect
> > stalls on vCPUs and I am not sure if the current watchdog subsystem has a way
> > to create per-CPU binded watchdogs (in the same way as Power PC has
> > kernel/watchdog.c).
> > The per-CPU watchdog is needed to account for time that the guest is not
> > running(either scheduled out or waiting for an event) to prevent spurious
> > reset events caused by the watchdog.
> > 
> > > What you have here is a CPU stall detection mechanism, similar to the
> > > existing soft/hard lockup detection mechanism. This code does not
> > > belong into the watchdog subsystem; it is similar to the existing
> > > hard/softlockup detection code (kernel/watchdog.c) and should reside
> > > at the same location.
> > > 
> > 
> > I agree that this doesn't belong to the watchdog subsytem but the current
> > stall detection mechanism calls through MMIO into a virtual device
> > 'qemu,virt-watchdog'. Calling a device from (kernel/watchdog.c) isn't
> > something that we should avoid ?
> > 

Hello Guenter,

> 
> You are introducing qemu,virt-watchdog, so it seems to me that any argument
> along that line doesn't really apply.
> 

I am trying to follow your guidelines to make this work, so I would be grateful
if you have some time to share your thoughts on this. 

> I think it is more a matter for core kernel developers to discuss and
> decide how this functionality is best instantiated. It doesn't _have_
> to be a device, after all, just like the current lockup detection
> code is not a device. Either case, I am not really the right person
> to discuss this since it is a matter of core kernel code which I am
> not sufficiently familiar with. All I can say is that watchdog drivers
> in the watchdog subsystem have a different scope.

This watchdog device tracks the elapsed time on a per-cpu basis, since KVM
schedules vCPUs independently.
I am attempting to re-write it to use the watchdog-core infrastructure but
doing this will loose the per-cpu watchdog binding and exposing it to
userspace would require a strong thread affinity setting. How can I overcome
this problem ?

Having it like a hard lockup detector mechanism doesn’t work either because
when the watchdog expires, we rely on crosvm (not the guest kernel) to handle
this event and reset the machine. We cannot inject the reset event back into
the guest as we don’t have NMI support on arm64.

> 
> Guenter

Thanks,
Sebastian

> 
> > > Having said that, I could imagine a watchdog driver to be used in VMs,
> > > but that would be similar to existing watchdog drivers. The easiest way
> > > to get there would probably be to just instantiate one of the watchdog
> > > devices already supported by qemu.
> > > 
> > 
> > I am looking forward for your response,
> > 
> > > Guenter
> > 
> > Cheers,
> > Sebastian
> 
