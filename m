Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A450B93F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448240AbiDVN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiDVN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:58:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3251B58E7F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:55:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so11024802plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=wQEwtOESIF1V+T+aeC5OuSC+0X51M61506bJtFDGuveJFUMYM1ri71xvQKAT5XtBtN
         MfpHng3FshycvKJNhPfUhBHHBIMd+c5/fNK7NDkttTF/ciYM8GqVzTdwZNzeIwMcO2Tp
         PW+dwCV67FG1/j6GqKJv25GLYOK7UOcPQlG/iBRBRZzlfQEooCHFUJUR7zbq4JQCfgsD
         10OvrghvQ1FVEIwKY9relISU+/dpnhwYfoQmTrAlWsSd5CY7Ktxyr/Q1tlXR7ntflM3K
         gK/qbijjC+UurFLSFFTrFqi20ulBg2iPm9vmyO4xigwy2SefqVseJ9LPtdabEIsT8YkH
         OZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=lvU5NTKwlsC2s9BL0rXztSiLYb7i4bO946RhcKN5A5I3E/lrPcKvGBkIwf+eEoxqtz
         BbVnry/vJ6R7gW4/WPCPuzdRLoTY88oHYc8pj6Kzq3NZ8wpaesd+K88a5BCIcmy7xrVL
         r6GduKxBKceTjSlfbdPDL7lXx93c1WV9s5XId0UxAUZw8m8JUolCHKoFhkX5dbbOOlkz
         snIRtMn9y7JIcjybom2QWA/bsnt1mXaRo+7/k1aXEWNrSHvk1CeLOwj2pUQdhR6SZsFy
         C0UtzGcGqBMew22M2l4v8qsf3M2R1yqnfSH5nvnQURPQFPb5o1swJ6oP0WYi900I3Iy4
         AykQ==
X-Gm-Message-State: AOAM533bXm0DM1nwwcdC6V4apM8cHj4v+juMei8YyVH5SEf7J87U2DJ9
        HiM5uhkDfuWEwbCMISp8EZidGAIR0gy1pzIs+jDn6Q==
X-Google-Smtp-Source: ABdhPJx4rl5aJnGHMIo11ZB1vNhuKtvivqC7qTKNYBL0zgo+rxkco0TSEXwd5AXTYQFZdMPenBr3Q00w+wFzFxEs/aY=
X-Received: by 2002:a17:90b:3e84:b0:1d2:c015:2182 with SMTP id
 rj4-20020a17090b3e8400b001d2c0152182mr5519714pjb.232.1650635725767; Fri, 22
 Apr 2022 06:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220421131415.1289469-1-robert.foss@linaro.org> <737ba7a0-400e-4fa0-82e8-f27f62d7c870@baylibre.com>
In-Reply-To: <737ba7a0-400e-4fa0-82e8-f27f62d7c870@baylibre.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Apr 2022 15:55:14 +0200
Message-ID: <CAG3jFys67PdAPXJvu8ZR9R6iOuMhYQ1Wi5CZTOSaOabJ3W=SNg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: Fix it6505 Kconfig DRM_DP_AUX_BUS dependency
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     andrzej.hajda@intel.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, hermes.wu@ite.com.tw,
        angelogioacchino.delregno@collabora.com, allen.chen@ite.com.tw,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
