Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E474543705
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiFHPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbiFHPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:14:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31BF1E8109
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:07:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q15so20724649wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7FVSFKFqN8uE2qMQSgKMpoSH02VLIrw/HMMok5PTem0=;
        b=J+RW6dSVAj4gr2qlN5sTulbZV9cB3VTFegVfME9QVLYlEqiB99LbrpJk8V+32gGtjA
         Sk2EgDGpTVDxKwBxunj22sfC/cLlpl7B36sC4JJE9iB0sjLpf5+O78Ow40/01xidQjnM
         prOxG2mLRLPwLEUS4DaWbV5q0Nkz8453Oj5xRcA1x+/dn12k3+GClNGojWMcQZZqz2om
         6Wg6LA0hKORIZDEOhQpTMY/dPFQfNkOkffQVnbKaueJLf3aqtFRGIqT18SiPlNs0FPop
         XdjwAqs5oolnEZa2Sr/n2EY9Ae1Zj1z/uz9vlAHQLBG/q/fGeH04UG40QWmASZNKYEWj
         3llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7FVSFKFqN8uE2qMQSgKMpoSH02VLIrw/HMMok5PTem0=;
        b=JalRZgNls+xsSeu6Vh+VH0wL+BK0T+rh8PQWySNH6q1rzX8FcvMQ7bN2NmX5QBBe30
         VfxYs3ZpJEZaCRpciYrOYXpRXmHyDI64G16A93L1653d5Y0ekbcOPuPSd5d2QOXwrl6q
         9OPj9Rty2qWn/DijgHrkb/EKzbICaxj/awHf8k4vIqVjn4oTmZsmVIW+K6VbNGJrFj0e
         ewujXCokgUeAob/yNw8D20AquAhuSmj5vncE2CgI1fydfU9/LQVxyqnyb87lGVJ7uldy
         YFM8xrt4tHfIPqSMmge4QQeUXejcQj07eH4HMq6d1AVOQGMJaujpRrq/ZDtcfzBxphu7
         CM8w==
X-Gm-Message-State: AOAM532v+rEvENRcED3P70jbwxIlJgWkPEOpIFViCxQS/cVqwvDBKCyr
        BLNQDRrlAElsQyTC06IEf87mug==
X-Google-Smtp-Source: ABdhPJyGtCRUNwcFNRjDeg3cS77diEwS86hjjHpYqr3Z5xFLriTtn0dXTE6ftKvxCT5O8tkVfdI8eA==
X-Received: by 2002:adf:d1ec:0:b0:210:2c68:a06d with SMTP id g12-20020adfd1ec000000b002102c68a06dmr33701798wrd.37.1654700860263;
        Wed, 08 Jun 2022 08:07:40 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b0039c4f53c4fdsm11996971wmr.45.2022.06.08.08.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:07:39 -0700 (PDT)
Date:   Wed, 8 Jun 2022 16:07:38 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rpi-panel-attiny: Use backlight helper
Message-ID: <20220608150738.xxpk4pvj6w3w3dm4@maple.lan>
References: <20220607185304.1128962-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607185304.1128962-1-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 08:53:04PM +0200, Stephen Kitt wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h.
> 
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
