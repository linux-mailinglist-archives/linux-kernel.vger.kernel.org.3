Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7773A4D5288
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbiCJTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiCJTsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:48:50 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECCE8BF6D;
        Thu, 10 Mar 2022 11:47:47 -0800 (PST)
Received: from 1nSOlC-0009ZM-Vy by out3b.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nSOlF-0009eo-Uo; Thu, 10 Mar 2022 11:47:45 -0800
Received: by emcmailer; Thu, 10 Mar 2022 11:47:45 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3b.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nSOlC-0009ZM-Vy; Thu, 10 Mar 2022 11:47:42 -0800
Received: from tsdebian (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 2FB2E33AC;
        Thu, 10 Mar 2022 12:47:42 -0700 (MST)
Message-ID: <1646941640.2804.4.camel@embeddedTS.com>
Subject: Re: [PATCH v3 1/2] gpio: ts4900: Do not set DAT and OE together
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
Date:   Thu, 10 Mar 2022 11:47:20 -0800
In-Reply-To: <CAMRc=MerqLPZSCd8+YSAwJPe1_zpOYQK5C-DXirC6dvR4Yss5g@mail.gmail.com>
References: <20220310011617.29660-1-kris@embeddedTS.com>
         <20220310011617.29660-2-kris@embeddedTS.com>
         <CAHp75Vdu1r0S2ZCjH2mjToYZiwQTOiUAvY5v-T7f=u28tVuxcQ@mail.gmail.com>
         <1646933773.2804.1.camel@embeddedTS.com>
         <CAMRc=MerqLPZSCd8+YSAwJPe1_zpOYQK5C-DXirC6dvR4Yss5g@mail.gmail.com>
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=qldI1G0MhynvNJLxA2zlgBbBcyszxhSxkhPR4D1/3dY=;b=UozZi6LC/BJqU3Fl3NQSbnM6+vmVMduRSFnh9yG3g0hLCRHMiwbDz7XFKOgVB29wQ9dZ4DOVWuYE1C3DYErsv0IGNE9FKf7psvOTTC7srf58O+wQ690XsV+drb/3jz6o53CZlcmYFui+nOvDi/9Etkg2elHa1k7k7GqHcqMDveoTBhKcRxFn4vuLREECBL1wPJ5l5e9Znzli2GOIF0m4ze3bOt5sL6tflzEfIHda7R2dZk5GpuX7mFGwJx24zK38KV2d84ooSPkjjxZ3rkv2TY8SmB2RPHDLhdEe8JqaJ0Q7SgUYo4X+y3TShEqZ4rmGnHebMIDECTWy2a4YFajh+w==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-10 at 20:30 +0100, Bartosz Golaszewski wrote:
> On Thu, Mar 10, 2022 at 6:36 PM Kris Bahnsen <kris@embeddedts.com> wrote:
> > 
> > On Thu, 2022-03-10 at 16:48 +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 10, 2022 at 2:22 PM Kris Bahnsen <kris@embeddedts.com> wrote:
> > > > 
> > > > From: Mark Featherston <mark@embeddedTS.com>
> > > 
> > > Same comments as per v2.
> > > 
> > 
> > Thanks, I'll get a v4 put together shortly to clean that up.
> 
> Hey Kris,
> 
> I already sent it out to Linus, please create a follow-up patch for that.
> 
> Bart

Can you please clarify what that entails since Andy had requested changes to the
commit message. Should I just create a new patch on top of the commit already on
master to address the comment changes? How would I address commit message changes,
or is that not my responsibility at this point?

Thanks for all the help on learning this process thus far!

Kris
