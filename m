Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7FC5997E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347440AbiHSImc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347373AbiHSIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:42:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032645F216;
        Fri, 19 Aug 2022 01:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 944D3B8264D;
        Fri, 19 Aug 2022 08:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1887EC433C1;
        Fri, 19 Aug 2022 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660898545;
        bh=wTDEJg8it2Gajcny7zd/FVxMn6f7QGiSJ0pgylSRs64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NN0iW9CaztWGcoIdGc1rrYC+JoAiXDxUAtOpTfacUU54YWNz7hsJ08I5gzAlY4Ih8
         0GO1y+u5B6QLBfjeFBX2QhrblX99a2t9aHCLaVuFrYvA6PAtxtVLhrfCL2rk3OUhHd
         OxbZomcf8HRGwZiniy+tB3hcsRSoPGRwaaeT0rggYorxwwvKLkh2lZNfL52t1dtAuE
         4Agft0SK46fkMSLHkWaF1aZ14ZVquhX2m3RV01s+WI9FflSWCzYJmCeTpLp+WFJamU
         b4zmXBqQguOAJLJSkHlfiHWIim7sZXV3EZ+Nl8rsEeg2KVtybOnHo8Wp3RRoxjuDX7
         oZ9KexchYZSPA==
Received: by pali.im (Postfix)
        id 6C6CD761; Fri, 19 Aug 2022 10:42:22 +0200 (CEST)
Date:   Fri, 19 Aug 2022 10:42:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add active-low
 property
Message-ID: <20220819084222.ru4olyfntunlm3f3@pali>
References: <20220818172528.23062-1-pali@kernel.org>
 <f635d5a7-6817-cd62-e395-63e346775716@linaro.org>
 <20220819065620.wvmy3kigvvbwo4bo@pali>
 <20220819080814.GA6653@duo.ucw.cz>
 <ae1c301a-60e4-5112-6681-8896a7479207@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1c301a-60e4-5112-6681-8896a7479207@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 August 2022 11:38:29 Krzysztof Kozlowski wrote:
> On 19/08/2022 11:08, Pavel Machek wrote:
> > Hi!
> > 
> >>> Although the question is - where is the user of it?
> >>
> >> I was planning to send updated powerpc DTS files with these
> >> register-bit-led definitions after accepting dt bindings.
> > 
> > We need device tree people to ack them, first. But a note saying "this
> > is for Turris Omnia router" would be welcome.
> 
> In general the process is one of:
> 1. Send DT bindings with driver and DTS changes,
> 2. Send DT bindings with driver in one patchset, DTS in second but you
> mention the dependency.
> 
> You should not wait with DTS till bindings got accepted. Why? Because
> for example we do not want bindings for stuff which never is going to be
> upstreamed (with several exceptions, e.g. for other systems). Also
> because we want to be able to compare bindings with your DTS
> implementing them, so we are sure you described everything (especially
> that you said running one command to install dtchema and second command
> to make the check is not possible in your system).
> 
> Without DTS here how can anyone be sure your DTS actually follows the
> bindings?
> 
> Best regards,
> Krzysztof

Well, last time I was told that first needs to be accepted bindings
documentation and then device tree files. So I did it like this. And now
it is again feasible and different steps and ordering is needed...
Sorry I cannot known all requirements which are moreover changing every
day.
