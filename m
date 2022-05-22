Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E419530639
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351532AbiEVVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiEVVc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:32:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6931221;
        Sun, 22 May 2022 14:32:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a9so10089542pgv.12;
        Sun, 22 May 2022 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3OR/Kmh2JnSnKKS3+ncrHc5sLSNg/DCoWnWM76fU65c=;
        b=gX0REAKHdflNjIemZSFgXuDUYDvJ5PoMB8gYReB87VKnfZM8YBNMm2N1euXJSzsty4
         d2QLicPOwOis+GVrMfSbtoD50k9cYT6AHqskidY0EpFOe7+Z5ju2Sed86fgON2RkEOqr
         tH9JUjRpm9LFBRLsHpBnP2TVFRAhORZdX4uU0pfpimzhmBnn99/za0OSb9tmYDLA90pw
         ExAw4dkuAghhARC1kJHelFel5XTT1+TRONyjWuXMTcefGgITOstkeY90edNz5nEYmdnc
         oq4lhzcrVcjKnd49b4AENVPiSBxfzyEwqkwObjR9ygfzq+F0cNovFCTTCQqD7G03lVRx
         +gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3OR/Kmh2JnSnKKS3+ncrHc5sLSNg/DCoWnWM76fU65c=;
        b=QCUCIjLFslnRA+biOIrvYRBTAJekuz7I2XqkiEfGUyrIdwI1dFjVwZHYxMwI3AtOwG
         25UhKd5lPPpzxG1HHektFhD8yg8ZIo+joUYFxKDs9Q7oWBytQ6mXikDxMfXmhgiyzNm6
         AQ0UAlGJu3oHCENlQfm/YfQytsmXlHV/B60pjAuIm4CETQAHNldpZ6t07uWEDLHKOYAS
         FIWU+xuEPTJcanrrMmfa0685uoW4TJrgGlR31qTWcefXs3JZg0jbs44y317zazVpK2vZ
         VmnPodxVT8mRTJ+Ubun6pc6aySF0ZH4qFoUdF+CveV26igk516Zk5m58nMq62XCGNtMu
         dbSg==
X-Gm-Message-State: AOAM532Gj+r5s7rlIfKVo3Nk3/djT0XqVy4rqWiMH47NVcC8jXLDU1dY
        LLmytv4IY4PVy3D7IexITN0=
X-Google-Smtp-Source: ABdhPJxP3JPqH02AHqbiN1izT+2dYEHPbp8DqBRkko/evSO60sWw2FlxPFTMtSPIq3kBbLGoJ+GAxQ==
X-Received: by 2002:a05:6a00:e0e:b0:50a:cb86:883c with SMTP id bq14-20020a056a000e0e00b0050acb86883cmr20796278pfb.11.1653255147053;
        Sun, 22 May 2022 14:32:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d84e:5dcd:9d68:ebbf])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902e55200b001616b8bad48sm3534926plf.303.2022.05.22.14.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 14:32:26 -0700 (PDT)
Date:   Sun, 22 May 2022 14:32:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        swboyd@chromium.org, linux-input@vger.kernel.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: HID: i2c-hid: elan: Introduce bindings
 for Elan eKTH6915
Message-ID: <Yoqr59t0v23xmKby@google.com>
References: <20220519155925.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519155925.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:00:02PM -0700, Douglas Anderson wrote:
> Like many i2c-hid touchscreen controllers, the Elan eKTH6915
> controller has a reset gpio. For the Goodix GT7375P touchscreen the
> decision was to add a new binding rather than trying to add a new GPIO
> to the existing i2c-hid binding. We'll follow the lead and do it here,
> too.
> 
> SIDE NOTE: the Elan eKTH6915 is a touchscreen _controller_ that's
> included as a part on some touchscreens. The reset line isn't truly
> necessary for the functioning of the touchscreen, so it's possible
> that some designs won't have it hooked up and will just guarantee the
> power sequencing requirements with RLC circuits. Thus, we'll mark the
> reset gpio as optional.
> 
> Note that if the reset GPIO isn't used there's actually no true need
> to use the "elan,ekth6915" compatible instead of the "hid-over-i2c" on
> Linux. However:
> - Officially using just "hid-over-i2c" for this device violates the
>   existing "hid-over-i2c" bindings. The bindings say that you're not
>   supposed to use "post-power-on-delay-ms" without specifying a more
>   specific compatible. Currently the Linux driver doesn't enforce
>   this, but it violates the bindings to just use
>   "hid-over-i2c". ...and if you're going to add a more specific
>   compatible anyway, might as well do it right.
> - Using this compatible means we don't need to specify
>   "hid-descr-addr" since it's inferred from the compatible.
> - Using this compatible means that the regulator names match the names
>   on the Elan datasheet (vcc33 / vccio) vs the generic hid-over-i2c
>   (vdd / vddl).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
