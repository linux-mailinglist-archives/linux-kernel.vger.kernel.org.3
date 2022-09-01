Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8005AA352
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiIAWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiIAWwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:52:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1043974E3A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:52:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w19so569799ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc;
        bh=Dhwd+COjDW5ThjQ0eGNlcg2FwWXLsRihwwituLHXIZw=;
        b=Qg20bj9HVOA0O2Dv7pbgLFpIerRd3OpfYftDq4iLQONPRjHm8OE5FicN0K1WL1v+S3
         bISpN5k4Xg9gTk37HMqAreo6nvuLyU3JTBpgQLIjzDvBJIqAXMP5MfRK4NHoGkdf8jpo
         3glN34VMEDD6Gh+Zf1murR+o5lg06tWVopJIiQgpwbgHGnSUZUKhfMxhxUfv/PKpvsCf
         qwtgF3sgpUqP0AbUb+d/a1esSHZ+I5KHKcW+5WE2OKOtNa+X+J/AAtNMS15RdoIDBSEy
         T+m/BQNhtbsQ6WmcJD2FSngsG3cTf0OyGVh/5RtK7l/wyzsThnJPsLTNCVmQ7lejIS6h
         shRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc;
        bh=Dhwd+COjDW5ThjQ0eGNlcg2FwWXLsRihwwituLHXIZw=;
        b=w5w4QVVs/zdKyCQ/RBC65GUAp+OUTs19KklK6+KsvP3Tlmo3XwzuJgNWwvkPaIX177
         1j4R8R+3R3ATbqlIJJx18Hv82pD9QByXO2ZU+nKHkWjHw/rFF2daCIpHBFuNic8P1nLI
         K3xxoKOk3ndBvWwMAWeF0dD3rf4LN9r024bytfF16ihLkmMCR32wWhTrvFUZ4TnKM49T
         WP+q+UWQ7pf2WLIZ0l4KGsO+rzZN31GGk5K/kKxfw7bmPrNagIql3+BlE4GhbgdhPyhj
         520HJ94v0OSAs2+wXrPtEF6kaPmeJkWdh9sNvKYhLGNYS9pTlQdtbMfc6QxO1jDkW9zE
         bvXA==
X-Gm-Message-State: ACgBeo1KTvntsvBSHAbf3glBDdyFT16T0/P/Rny83VlleAZvjEMNfdku
        Nrc3qzdH4hQB3ctxqkRmTRw=
X-Google-Smtp-Source: AA6agR5VyqkvxxIZF1flgFAUFyuS1vlvIP1xurquBEUnw5mRA/4PMLSVlwqN/Hy1Kir2419wd9jhSA==
X-Received: by 2002:a2e:bd0e:0:b0:268:c03b:cf56 with SMTP id n14-20020a2ebd0e000000b00268c03bcf56mr1277850ljq.393.1662072729392;
        Thu, 01 Sep 2022 15:52:09 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:9c45:8fa1:8ce7:8852? ([2a02:a31a:a240:1700:9c45:8fa1:8ce7:8852])
        by smtp.googlemail.com with ESMTPSA id w9-20020a2e1609000000b0025e15fe421bsm29224ljd.17.2022.09.01.15.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 15:52:08 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <768daa58-d1cd-7e9d-4f6e-722f2b0afab9@gmail.com>
Date:   Fri, 2 Sep 2022 00:52:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [PATCH v2 20/41] drm/modes: Properly generate a drm_display_mode
 from a named mode
Content-Language: pl
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-20-459522d653a7@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-20-459522d653a7@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

> +        if (!named_mode->tv_mode)
> +            continue;

As mentioned in the previous email replying to 19/41, this makes it impossible
to specify DRM_MODE_TV_MODE_NTSC_443 as currently defined in the named mode
successfully.

Best regards,
Mateusz Kwiatkowski
