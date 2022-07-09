Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8686D56C810
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGIIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 04:31:51 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D1466AD1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=mO4Lux4zExqJwsq693AgROuTl+x+kJdHNbYuPHKBSt4=;
        b=TgVX/ijFEvLZEAqewwRTuyPLSpy25GpVpFYJQKtA8fSYi5/MA0aNiH7u2/YEYlkiQoa6P7ORPk6PG
         yOZWahlzVNMziT/ht5UMBtysZT773tSz69WcQwX5+dpfwmO/jUAtMNc+rxn/5vS9c+gc7+20uZP3Dk
         ZJDw7fVFLkItZnveY70UQbGYe2Vow5SSniP6aJKrUUbkrSsOjkqmE4zxLTg9MlQbFB6+ZboyeAqFDu
         DMxtTpXco05ux0xRTZMnnAHWhL5rz0aPeUrDLSbIEFjCWkePOuAxphr804WR4N2R1cO5RvEsrks+tW
         tO1dnb8c1kCYG1n3bkdfOvHyvTpU1jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=mO4Lux4zExqJwsq693AgROuTl+x+kJdHNbYuPHKBSt4=;
        b=w9p/xLtYiE38/MV3LPBUup56d572jke4BSd/+BvCTTJzjswWF+S0dSaRFE3NsFFCB3Y8WIOTP/EFY
         sICDM1ZCQ==
X-HalOne-Cookie: 7fd59b46a51611b99b6b071a385538c9ebf1830c
X-HalOne-ID: 91d73c41-ff61-11ec-823c-d0431ea8bb10
Received: from mailproxy4.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 91d73c41-ff61-11ec-823c-d0431ea8bb10;
        Sat, 09 Jul 2022 08:31:46 +0000 (UTC)
Date:   Sat, 9 Jul 2022 10:31:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/ingenic: JZ4760(B) support and random changes
Message-ID: <Ysk88cZO1iQhX/I2@ravnborg.org>
References: <20220708205406.96473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708205406.96473-1-paul@crapouillou.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Jul 08, 2022 at 09:54:00PM +0100, Paul Cercueil wrote:
> Hi,
> 
> A small set of changes to the ingenic-drm driver.
> 
> The most notable thing is that ingenic-ipu is now its own platform
> driver.
It would be nice to know what is achieved by this change, I could
see the code being a tad simpler, but the cost was more EXPORTs.

With the added explanation, which you can add when applying, all patches are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
