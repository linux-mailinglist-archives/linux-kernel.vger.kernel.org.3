Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2887154DFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376678AbiFPLSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376623AbiFPLSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:18:18 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95212AE3E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 04:18:17 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 3DD3A20223;
        Thu, 16 Jun 2022 14:18:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1655378290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UUep/sgKumAUsqr6plkU9Uit353tpr6e7VY52A43bZ0=;
        b=YiAxJPvvV+VFDy2XSr6BR5cdbKzD76jQII3SIj5C6MB9vm2znMEgKDIWYzacLLMmF22BCa
        2P4Fj4GcyFRd30U/MQKTPEhLpkqnHCaHQNhkFkSDyk922sVXWm3s5eQ+0goo4GUSvksfwL
        vEOXB5MlTAnJd6t5jVutTxtM1GHdNHg=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 9E3FB634C91;
        Thu, 16 Jun 2022 14:18:09 +0300 (EEST)
Date:   Thu, 16 Jun 2022 14:18:09 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, lee.jones@linaro.org,
        mchehab@kernel.org, marcel.ziswiler@toradex.com
Subject: Re: [PATCH v9 00/14] Add some DRM bridge drivers support for
 i.MX8qm/qxp SoCs
Message-ID: <YqsRcUsdZzcwqplJ@valkosipuli.retiisi.eu>
References: <20220611141421.718743-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611141421.718743-1-victor.liu@nxp.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1655378290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UUep/sgKumAUsqr6plkU9Uit353tpr6e7VY52A43bZ0=;
        b=e6Al/EFgjGfUA3ffYQXqQ+pB8jfciIVCkr/eD+HwQH6a28iLeoT9qnBnxvDrWlGDC1G4bC
        TAL1Q6kVagX5RYOxNDpFWm5GRKyYpoyH/lbRI8lnU0IaxOt0UEHvsehRrdGh2jDjrCmlbF
        dWaPE0w3Suw0AqxzNlPev6mdneTk4Fk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1655378290; a=rsa-sha256; cv=none;
        b=Ii1gQgxWnUvB0ovIO8owoWaYk7l8CClPi05NutKtp2BooN+OCcp1h+SO8xtvKtUi3AwY6S
        JuYhzUIkO+r5g+PKmvZ96rYRNc2Rb5XPPu0FpKN5LohB6Xz3q40dZPfhsguz748iYkogqc
        KmCsgUVajSzP3ZwLBJ46j70A4siyNrM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 10:14:07PM +0800, Liu Ying wrote:
> Patch 1/14 and 2/14 add bus formats used by pixel combiner.

Thanks!

For these:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
