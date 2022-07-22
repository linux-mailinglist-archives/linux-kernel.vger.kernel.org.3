Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D007757E79D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiGVTpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiGVTpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:45:16 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EEE1121
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=nquW4uTK4EsRfwtuLuO5LJX7Kp99WKVz9jDKp1qtM5M=;
        b=LEOoim3HTfBG6Im2MJvLVsNAGyS2uuOEbXscuyokM/Cq0+jDNjlVMdSZVGzbu08uCGgp2NMKTuBbX
         UQMe5rIIaUj9Pmsl0FPhJ8TjuBkP1JqgsNRmucTpGIuMDBa2CWjPF4vuOik+cZBfoetpaOgJMmaWZH
         NPCjkgnc4OFVG8bJuL9A444xXFUePYsLaZ9dy14NgloFQLs5z1Tjg8+ZHKaTTgcx8i+xS7SOr1Bil0
         1QF/vPpeGyH5KLYMgSnUzMdSC1uw3v3W9dklceReos4x3GPaHg4GlPcMnx+r4aGL/Kc6NvhyGyeSHI
         cv8Dg8ySg6lhHC+K8w0VPrEFVAlJkCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=nquW4uTK4EsRfwtuLuO5LJX7Kp99WKVz9jDKp1qtM5M=;
        b=vjNctA/bG7tR/QobV4rEn85FmJNic46NcaPLTwPjT2TY2KPM14A5VnPI9A2CoM6QTh/fdqjMSdpTB
         GM2I4gaAQ==
X-HalOne-Cookie: 7913dd9b8a246146ee3aa0d23a7b5d241bb96559
X-HalOne-ID: cab67a2b-09f6-11ed-8240-d0431ea8bb10
Received: from mailproxy3.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id cab67a2b-09f6-11ed-8240-d0431ea8bb10;
        Fri, 22 Jul 2022 19:45:09 +0000 (UTC)
Date:   Fri, 22 Jul 2022 21:45:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/1] spi/panel: dt-bindings: drop CPHA and CPOL from
 common properties
Message-ID: <Ytr+Q6kXr+f6dCfi@ravnborg.org>
References: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
 <20220722191539.90641-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722191539.90641-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Fri, Jul 22, 2022 at 09:15:39PM +0200, Krzysztof Kozlowski wrote:
> The spi-cpha and spi-cpol properties are device specific and should be
> accepted only if device really needs them.  Drop them from common
> spi-peripheral-props.yaml schema, mention in few panel drivers which use
> themi

    "and include instead in the SPI controller bindings."

I cannot see you do this in the touched bindings.

So I cannot see how for example samsung,ld9040.yaml picks up
spi-controller.yaml and thus it no longer knows the spi-cpha and spi-cpol
properties.

Maybe I missed something?

	Sam
