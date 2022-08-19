Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886A359987A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347986AbiHSJLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347625AbiHSJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C41BF2407;
        Fri, 19 Aug 2022 02:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5844614FE;
        Fri, 19 Aug 2022 09:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB99C433C1;
        Fri, 19 Aug 2022 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660900287;
        bh=uAkHHobC34cPBPeShVHvaduEVI3uKIvQiDRzhq4jE6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPJjaye26tCuFJ76nUR84t2liP8dTNzchoWf7z+/KmHHcDuYfpWWqjTT1FHQH5Nc+
         6Qcgq6c5UlePL4t5x8hNSA7EwI4OYW0HhozyYoxazAqQKw0/YM7+ZtM88XN/B7zi1Q
         VuDhbObKFezed+oWqdEa2w9DsJGlUDGTR/yVPNckIM90xcoQVrraJkI19fLxije+5t
         Kbe28jhfrcykv9aGylqtHBUTNH3tHsqOxKsyUavuaqXm6Tm1sNCQM6hEVyQaK+KZPY
         9fvEESMUOYbUkY1Mx6I+B6lwm9Pkpohk7NdOccZMHGC+dU77BBOeDBF4UJ9grdSyGw
         NRAvalLvLrX+A==
Received: by pali.im (Postfix)
        id 4ACC1761; Fri, 19 Aug 2022 11:11:24 +0200 (CEST)
Date:   Fri, 19 Aug 2022 11:11:24 +0200
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
Message-ID: <20220819091124.gr3cxxufysi2oo3o@pali>
References: <20220818172528.23062-1-pali@kernel.org>
 <f635d5a7-6817-cd62-e395-63e346775716@linaro.org>
 <20220819065620.wvmy3kigvvbwo4bo@pali>
 <20220819080814.GA6653@duo.ucw.cz>
 <ae1c301a-60e4-5112-6681-8896a7479207@linaro.org>
 <20220819084222.ru4olyfntunlm3f3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819084222.ru4olyfntunlm3f3@pali>
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

On Friday 19 August 2022 10:42:22 Pali Rohár wrote:
> On Friday 19 August 2022 11:38:29 Krzysztof Kozlowski wrote:
> > On 19/08/2022 11:08, Pavel Machek wrote:
> > > Hi!
> > > 
> > >>> Although the question is - where is the user of it?
> > >>
> > >> I was planning to send updated powerpc DTS files with these
> > >> register-bit-led definitions after accepting dt bindings.
> > > 
> > > We need device tree people to ack them, first. But a note saying "this
> > > is for Turris Omnia router" would be welcome.
> > 
> > In general the process is one of:
> > 1. Send DT bindings with driver and DTS changes,
> > 2. Send DT bindings with driver in one patchset, DTS in second but you
> > mention the dependency.
> > 
> > You should not wait with DTS till bindings got accepted. Why? Because
> > for example we do not want bindings for stuff which never is going to be
> > upstreamed (with several exceptions, e.g. for other systems). Also
> > because we want to be able to compare bindings with your DTS
> > implementing them, so we are sure you described everything (especially
> > that you said running one command to install dtchema and second command
> > to make the check is not possible in your system).
> > 
> > Without DTS here how can anyone be sure your DTS actually follows the
> > bindings?
> > 
> > Best regards,
> > Krzysztof
> 
> Well, last time I was told that first needs to be accepted bindings
> documentation and then device tree files. So I did it like this. And now
> it is again feasible and different steps and ordering is needed...
> Sorry I cannot known all requirements which are moreover changing every
> day.

Here it is:
https://lore.kernel.org/linuxppc-dev/20220819084433.26011-1-pali@kernel.org/
