Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF24F8F12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiDHHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDHHAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:00:11 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB7B1D4C35;
        Thu,  7 Apr 2022 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649401086;
  x=1680937086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XDveWXVaLR/QYk55Nt6b8wyjKKxTT08U/ZfdajNs92I=;
  b=m+GsHMMDFbt6rdZYMVYyo+r8WvfifKqt1In/oS6q0VT54PN6nFdQCSuU
   5I/uSfO91FJnDsPjvgimZaZFnWnEtzqWgszkKm2uwY1UF9U1JsBWqMrm1
   O05WVnxtmPSdhdASZN6ud9zO4E110rvsbK7mgS+Nyfg5U/LPsPgKdsxOa
   T1geEhnpLTZZ4QFrPOoizODmskrD9xGRcFw7mJoiga4sDf27ssHUZUjAs
   IreA6cyLJl9gX1NvxQMvF4pba3P9bE1CNLvcbMwT+Wm0bqwDGgzSDgMTD
   s1S+kL/+SSkll6KfVIKP1SsM/s3jgzWB2NzCao23zwKFhoJ6LbATt1H7h
   A==;
Date:   Fri, 8 Apr 2022 08:58:03 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh@kernel.org>
CC:     "krzk@kernel.org" <krzk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: timer: exynos4210-mct: Add ARTPEC-8
 MCT support
Message-ID: <20220408065803.GA31189@axis.com>
References: <20220407074432.424578-1-vincent.whitchurch@axis.com>
 <20220407074432.424578-2-vincent.whitchurch@axis.com>
 <Yk79acnuZE1Wj/3s@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yk79acnuZE1Wj/3s@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:04:09PM +0200, Rob Herring wrote:
> On Thu, Apr 07, 2022 at 09:44:29AM +0200, Vincent Whitchurch wrote:
> >  .../timer/samsung,exynos4210-mct.yaml         | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> 
> What's this based on? Doesn't apply on v5.18-rc1.

This series is still based on Krzysztof's "dt-bindings: timer:
exynos4210-mct: describe known hardware and its interrupts".  The cover
letter mentions this but not very prominently, sorry.

That patch was reviewed a while ago but doesn't seem to have made it to
v5.18-rc1, but I see that Krzysztof reposted it yesterday: 

 https://lore.kernel.org/lkml/20220407194127.19004-1-krzysztof.kozlowski@linaro.org/
