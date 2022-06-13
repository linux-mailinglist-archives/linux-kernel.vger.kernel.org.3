Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28AA549D25
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiFMTOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbiFMTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:14:08 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DED8CE3D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=lHjgrdlCsJlZNExw2i+5p/H7UmbCDOq2p/NEOrPWfhI=;
        b=LpfJ3oPYuuqg6i3ho0XikhkAPNOBaQbZr82eZv0bUP4ve0Z4PFc69HjP4A1M56gmZKZ2eeqWeEmaK
         /bUI2rk7ZHbhQLN3iywV3rXmHhTZmEd1p2FLPwDnC7hvKoXzu9/hs2Zxr+nrvWNjhCw34+f4LZh6pZ
         RCZs2OIgx//zHcR4YywpNgW/VFVFDy3TU6TxoiGBxMJb2k/wI0CT68I90+bLDAH02G0QrW943PVKpd
         AsUU63h3+s0KtUXIcN+1Au7F8a79oACmCtcr/1pCrG9iPqlQmT2DjilP0pjq9DvnxVpd8eUlSAiHTT
         hgQfucYdZ9sfLrjuWUEjgqP/jBu8daA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=lHjgrdlCsJlZNExw2i+5p/H7UmbCDOq2p/NEOrPWfhI=;
        b=ldsO6NEhLw+vp3UB1ZOzR2Yob+FMPpcyEw0+v01Wvw2DdWcTcV26CW6XMjhQ+5z+CJAUaadOaYIWC
         Icw4EPWAg==
X-HalOne-Cookie: 392d8748579318f935a12eb6f32b987bbdd36c36
X-HalOne-ID: 0764a83b-eb3c-11ec-a913-d0431ea8a290
Received: from mailproxy3.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 0764a83b-eb3c-11ec-a913-d0431ea8a290;
        Mon, 13 Jun 2022 17:12:40 +0000 (UTC)
Date:   Mon, 13 Jun 2022 19:12:38 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: Add Arm virtual platforms
 display
Message-ID: <YqdwBoMldyuh+vjg@ravnborg.org>
References: <20220613145709.3729053-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613145709.3729053-1-robh@kernel.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, thanks!
On Mon, Jun 13, 2022 at 08:57:09AM -0600, Rob Herring wrote:
> 'arm,rtsm-display' is a panel for Arm, Ltd. virtual platforms (e.g. FVP).
> The binding has been in use for a long time, but was never documented.
> 
> Some users and an example have a 'panel-dpi' compatible, but that's not
> needed without a 'panel-timing' node which none of the users have since
> commit 928faf5e3e8d ("arm64: dts: fvp: Remove panel timings"). The
> example does have a 'panel-timing' node, but it should not for the
> same reasons the node was removed in the dts files. So update the
> example in arm,pl11x.yaml to match the schema.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
