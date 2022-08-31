Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158B95A7D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiHaMT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaMTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:19:55 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FBDE9E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:19:52 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j1so10876711qvv.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=mwJLeATdgOg1rnZj29Oz/GTglRl8iBOl1EtW0EiIxFU=;
        b=VBkeHywsm9g8hjA9KvTjv2pPkj+/Mfl3u+7ucrCrrovwIMPfEH57SX9UOKZ5X7DKgF
         IetKElzKcKPC1vKTuvHEXejXqHmEUhEp4gBosLe/tnyurDcb3YNBIDApE71TF5IxrJoL
         bnnl9S43i7t2lRfSi6J1RY9g6/5dRp7GRU1JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=mwJLeATdgOg1rnZj29Oz/GTglRl8iBOl1EtW0EiIxFU=;
        b=xjISDloMc6Z5LIc0nq7sLdgzgcRnSCiy4eHu8L3IPBJulqy6c/vJliUGMEjeVXZkt/
         pRxpXxG+y88YYCENWmhBl/hwscDqiNdvH2neKtJVPJLmN96PQdzcgRoVMcX79p+/S/Ul
         otBxC5HkC3NtAidKWbw75NLhu/A/cJUE8YbMqP3w8NWvo300CLTe3JCq6GkqEgyblIuK
         ZgvHYA5qnkyI4r12KSGtR6qGYu3UWjzl2SGXyRYyKKtWmDNpakz6n3c8K5ud24R2c7Az
         AjjrIU+dWSVNaWDcy+htR7QbU0MBk98IzrOSC75UwdcM9ACadLFFkd4RzE2xXSFgh0uG
         lHZA==
X-Gm-Message-State: ACgBeo3GxUhHVMLYndJux53qhKGixmdFDcPG6wz2O61zJULyiW7zEjE2
        azaus0xlI2ykmTCTEvg8MfV7LasvOQzoIw==
X-Google-Smtp-Source: AA6agR7KKVQAW5SvPM2EemzurGrLr/rzek01IBlX3IZTGbTuX4WncaCa/DqdBrTGgsxC8BLi8xx4WQ==
X-Received: by 2002:a05:6214:190f:b0:498:f0ee:5ab3 with SMTP id er15-20020a056214190f00b00498f0ee5ab3mr18772495qvb.117.1661948391743;
        Wed, 31 Aug 2022 05:19:51 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id f5-20020ac80685000000b00342f844e30fsm8307695qth.31.2022.08.31.05.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:19:51 -0700 (PDT)
Date:   Wed, 31 Aug 2022 08:19:49 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/41] drm/tests: Order Kunit tests in Makefile
Message-ID: <20220831121949.xj2bdykhvs3cvvm7@meerkat.local>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-1-459522d653a7@cerno.tech>
 <f6289e5d-98e3-1a0d-f514-136e2b7978c1@tronnes.org>
 <20220829190242.tk2hinttzzmzhnaj@meerkat.local>
 <20220830083027.4iyi2s5r5bto4h2e@houat>
 <20220830122217.h52zswusnlb3iggq@meerkat.local>
 <20220831073026.rjlqkznm6qf2yri5@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220831073026.rjlqkznm6qf2yri5@houat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 09:30:26AM +0200, Maxime Ripard wrote:
> Another thing I noticed when using b4 send is that I'm not sure how to
> increment the version number of a series. With b4 send --dry-run it
> wasn't happening automatically, and I couldn't find anything related in
> the options (except for --force-revision but that wasn't permanent I
> think?)

It is, but I don't blame you being confused seeing as there's no documentation
yet at this point. :) I hope to make some final changes to flags and features
in the near future, so documentation should start appearing soon.

> I ended up amending the commit json by hand to set the proper revision
> number, but I'm almost sure it isn't the right way :)

This is certainly a valid way to go about it as well.

Regards,
-K
