Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA0580FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiGZJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiGZJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:18:24 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931D72981A;
        Tue, 26 Jul 2022 02:18:22 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E3B5E240004;
        Tue, 26 Jul 2022 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658827101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eMPxwGGLuK4IaY+cx04zGWguw85HqB8nrDHBjS2bvE=;
        b=LIXKMkHO0ZoUb78Q5z2bxUyE/iB1Kd5JHG/epodcYEqn/M7hU+N4v+yfwdGHQ1dboD9yYt
        uAe0YYDTCdLFavOWUo3TmpoAHfhZn0Pt0x+CU66KzadS8G+ngisxlsym9Wf07oCcJxbRlG
        RgYVUF2OpN4cyCDG7xe6RyvC+StobEQFth/d0HeQao8omhT4sordQeSYXA3TEzvSVq5WKW
        2OeUayWj05LLtOO+ztCC/uCxevkc8liSOYdSFHOV2kSvXFm9PFRmjPpwF0HDKgkHOb3EPL
        lMIdKzh3qLzMlX0+nJ1uplyTR8loOcvsybjgEjjSQ23ZPC471FBhI/BujVYByQ==
Date:   Tue, 26 Jul 2022 11:18:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     samuel@sholland.org, a.zummo@towertech.it
Cc:     jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, icenowy@aosc.io,
        linux-rtc@vger.kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] rtc: sun6i: add support for R329 RTC
Message-ID: <165882703251.3139893.611019968302494887.b4-ty@bootlin.com>
References: <20220626042756.58961-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626042756.58961-1-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 23:27:56 -0500, Samuel Holland wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner R329 has a RTC with a similar time storage with H616 but a
> slightly different clock part.
> 
> As we have already handled the R329 RTC clocks in the CCU driver, add a
> compatible string to RTC driver to allow probing of the RTC.
> 
> [...]

Applied, thanks!

[1/1] rtc: sun6i: add support for R329 RTC
      commit: b9d982385d0544132bc398b7a7e062d9a554d941

Best regards,
-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
