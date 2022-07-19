Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B621E57A58D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiGSRkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGSRkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:40:20 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7548CB5;
        Tue, 19 Jul 2022 10:40:18 -0700 (PDT)
Received: from 1oDrCb-0007Qu-VJ by out3b.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1oDrCf-0007de-TI; Tue, 19 Jul 2022 10:40:13 -0700
Received: by emcmailer; Tue, 19 Jul 2022 10:40:13 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3b.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1oDrCb-0007Qu-VJ; Tue, 19 Jul 2022 10:40:09 -0700
Received: from tsdebian (97-120-89-198.ptld.qwest.net [97.120.89.198])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 972732A68;
        Tue, 19 Jul 2022 10:40:08 -0700 (MST)
Message-ID: <1658252354.3157.1.camel@embeddedTS.com>
Subject: Re: [RFC PATCH v2] ARM: dts: Add TS-7553-V2 support
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>
Date:   Tue, 19 Jul 2022 10:39:14 -0700
In-Reply-To: <add23ad7-2539-cef3-8684-10ec8e680483@linaro.org>
References: <20220713221233.8486-1-kris@embeddedTS.com>
         <55dccabb-41e9-dc45-f404-c333f5472e75@linaro.org>
         <1657833995.2979.1.camel@embeddedTS.com>
         <eb993f8d-e72f-aba3-e7a4-1bbd2ac00f6c@linaro.org>
         <1657907657.2829.1.camel@embeddedTS.com>
         <add23ad7-2539-cef3-8684-10ec8e680483@linaro.org>
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
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=RhpSBJFkOCIu0dCkr5jpiAMxUqj3C2Nse+f6TCsQVrY=;b=MtFXuJ1yQgpbpe6iQi5V3UjWWJ3dYyIGfVBFa7pFhP1AbOJ4uZ0HfzyYn6g1T57BImVva+iRME67VjvRh1jsrvwRU/J286A/fqOQFT5hNcxygl9ibLqFdfl4xXnaPW7ikLJ5L64omlBUnyMWsRyhUd27SA6CFwCCFW1OVWTaC7UpqMWuNxcLxItFIQbVCLFFPfpxZfg1XUI4KjAoMzUrOhQpcNoa3nAWIhRABx2VDn1LK7WtGyEZDZL2XHUzwG626H/bnqTMGXB6yj3zTEqlsBmK+OnTtnKPg2pzzhGASBS/ztkJgzyiYeacFQ6mvMmg0nsgiG2OYW5oVy3Rd9/BuA==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 14:49 +0200, Krzysztof Kozlowski wrote:
> On 15/07/2022 19:54, Kris Bahnsen wrote:
> > On Fri, 2022-07-15 at 08:42 +0200, Krzysztof Kozlowski wrote:
> > > On 14/07/2022 23:26, Kris Bahnsen wrote:
> > > > On Thu, 2022-07-14 at 10:34 +0200, Krzysztof Kozlowski wrote:
> > > > > On 14/07/2022 00:12, Kris Bahnsen wrote:
> > > > > > Add initial support of the i.MX6UL based TS-7553-V2 platform.
> > > > > 
> > > > > Use subject prefix matching the subsystem. git log --oneline --
> > > > 
> > > > Can you please elaborate? The subject prefix is "ARM: dts:", I'm not
> > > > sure what is missing. Should it be something like
> > > > "ARM: dts: imx6ul-ts7553v2:" in this case?
> > > 
> > > Run the command, you will see.
> > 
> > I had previously run the command and the output of it did not make sense in
> > the context of your prior comment. Forgive my ignorance, but I'd like to
> > understand specifically what you mean here so we can do the correct thing
> > in the future.
> > 
> > $ git log --oneline -- | head -n 20
> 
> This obviously does not make sense. -- as you can read in git log help
> and several other Unix/Linux commands is marking path arguments. You
> want to run it on specific subsystem, don't you?

I've looked at commits for imx6ul-* devicetree files and that was how
I derived this commit/subject. I see a number of different patterns
and if one is preferred over the other I would appreciate the
clarification.

e.g. looking at commits of imx6ul-*
"ARM: dts:" is used for a number of initial devicetree commits
"ARM: dts: imx6ul: <board>:" is used a few times
"ARM: dts: imx6ul-<board>:" is also used a few times

For initial commits of a devicetree, or modifications of a devicetree,
what is the preferred pattern moving forward?

Thank you for your continued support.

> 
> Best regards,
> Krzysztof
> 
