Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE43E523BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345702AbiEKRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245036AbiEKRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:39:30 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92151D5010
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=iALarvYr6q24+R4Th1G4RXSh7gnuFWx7r3JvoYpd3xk=;
        b=W9xFVeO8LlGUfyYNl9YjYZ9ZctbU8etMQKk6mgK5eNNMwHdKmpY1Rnlvs/tcMhZuFNDgDDj5D5xXp
         rKFTaUrT9umvFG6ucNypFltBnfVrVGggs0wfStO2aYLtgvujAgsIla6xNkv1J4JbPo7Nha+k4HgVA3
         F5yO8ZUKqcdNeVVLUDs/WW1trNoqLrkN+qpGV7A3u5imlgspD7rOfqkhXJePu5ye7AE1s8tzCvPZAB
         doXWdIYAX+qAJv1VW7krOJtgjK5BfTOEWbaGvw0iSuO6eye4XNUjcp/w+FnCMSfiK5ULbPTmD+h+ES
         nGeCfompngqVHV83tGs3mGxM8k8xXpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=iALarvYr6q24+R4Th1G4RXSh7gnuFWx7r3JvoYpd3xk=;
        b=hImXde1zDvSVJkx15NBS5pKNiZbhkQkuYrmlHkQ98BvXln9AlcTSZH6xC64Y7s7D/j8PJ2tjjUnDu
         FOqhaicBQ==
X-HalOne-Cookie: e2cdac57c96ca2243c1cd42b5ad62a44227cc89d
X-HalOne-ID: 4cacf8ba-d151-11ec-a908-d0431ea8a290
Received: from mailproxy3.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 4cacf8ba-d151-11ec-a908-d0431ea8a290;
        Wed, 11 May 2022 17:39:25 +0000 (UTC)
Date:   Wed, 11 May 2022 19:39:23 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/panel: introduce ebbg,ft8719 panel
Message-ID: <Ynv0y6xmtnE+33/y@ravnborg.org>
References: <cover.1652245767.git.jo@jsfamily.in>
 <BY5PR02MB70098FF9BDEDE264B78CFCE0D9C89@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB70098FF9BDEDE264B78CFCE0D9C89@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,
On Wed, May 11, 2022 at 10:58:11AM +0530, Joel Selvaraj wrote:
> Add DRM panel driver for EBBG FT8719 6.18" 2246x1080 DSI video mode
> panel, which can be found on some Xiaomi Poco F1 phones. The panel's
> backlight is managed through QCOM WLED driver.
> 
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>

Driver looks good:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I expect someone else to pick it up and apply.

	Sam
