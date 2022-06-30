Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651705622AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiF3TLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiF3TLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:11:31 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9263728E30;
        Thu, 30 Jun 2022 12:11:30 -0700 (PDT)
Received: from 1o6zZX-0007xl-WA by out3d.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1o6zZZ-0007zz-U8; Thu, 30 Jun 2022 12:11:29 -0700
Received: by emcmailer; Thu, 30 Jun 2022 12:11:29 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3d.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1o6zZX-0007xl-WA; Thu, 30 Jun 2022 12:11:28 -0700
Received: from tsdebian (97-120-89-198.ptld.qwest.net [97.120.89.198])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 222601ACCE;
        Thu, 30 Jun 2022 12:11:27 -0700 (MST)
Message-ID: <1656616263.4126.2.camel@embeddedTS.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>
Date:   Thu, 30 Jun 2022 12:11:03 -0700
In-Reply-To: <1654112f-839f-1de2-0f00-fbf501824d6d@linaro.org>
References: <20220630182746.3813-1-kris@embeddedTS.com>
         <1654112f-839f-1de2-0f00-fbf501824d6d@linaro.org>
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
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=qMObpzT3wXlxPCBmJZM9zsuJ7xMlvsw1Ae+alyFAqAQ=;b=h/wv8/6TmfbYre87mo7wM6DJ+f19ScmYPA8H8bD2GgUFg7j/avZAAfy39ldpfUgzal09r0trklPlXRIFDqzO2OvpqfSSTkHtlfRv3SCt9eip5QVaVAGif1hvexOKus/Qf/IciKcxf6sJ+Vxxh5vbDh1ztDZ1btoP+VDBEbB7t5vo6+wyQt0REOYuEixpahjSOWVYilttXqamJtV2yDrMbo1nK9nwlbwA70vYYVL70eVYbJpqfgABX3PQjT8dwoeLP2Wm8aW2ksHNcl68K/LM60ECu+/JhqAgrisvRkKXDitTMFjfKM6dwW6rvj4uwH5dG6j+xg2mv3xJswCPvB71yQ==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-30 at 20:56 +0200, Krzysztof Kozlowski wrote:
> On 30/06/2022 20:27, Kris Bahnsen wrote:
> > Device-tree incorrectly used "ngpio" which caused the driver to
> > fallback to 32 ngpios.
> > 
> > This platform has 62 GPIO registers.
> > 
> > Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> > ---
> 
> 
> Ah and one more - for some reason you did not send it to maintainers, so
> patch will be most likely ignored. Please use scripts/get_maintainer.pl
> to CC relevant people.

I reviewed that output and erred on the side of not generating
too much noise and skipped folks/lists marked as general ARM/NXP
maintainers. I'll be sure to send to all in the future.

Forgot about Fixes: tag, I'll add that in a v2.

Thanks for the feedback.

> 
> Best regards,
> Krzysztof
> 
