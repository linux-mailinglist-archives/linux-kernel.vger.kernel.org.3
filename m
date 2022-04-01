Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB69D4EEA7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiDAJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiDAJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:34:33 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E094C26A97D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:32:44 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gi14so1633904qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MicAAIxYy/iDzT2iR5+kPbLoF8E6ss/329hg63ZuCOU=;
        b=3CnCTumz9YY76lxgWN2UlTVuzhev3Nna6J9Du2HqvA02Ij7ZZAjLKRk12K5FieougC
         d5Zn5GbFenpld2+RH3IV09sfmWtBZyk1Xi9A5PPqT8XBxUS4Hm27jFj+tIRNbIMTOuCn
         DPvka0Ye9GhRE0FfJMhXRxRE54vxK2VkbEkY9dPdmEeTQvKxlTdwMYaFo7/SG8p+d/0W
         8AGA75haiy9s12RjV6772ct/rs/eS23jKFaTL26ya6TVYy+VkYskp6iAsh0MTs8ffZMv
         CB0qHW21RXJLAHtsWEQTVIBYi0Qlnrs2d51fNiVgvgUGiA8oQBDRln13hNzk+D4yc313
         29aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MicAAIxYy/iDzT2iR5+kPbLoF8E6ss/329hg63ZuCOU=;
        b=Ki5sLkenATq1dtcT9JBijg2TSf1Kx1d4CCp0ZtqAa0PXNaXpqbGQGoo0rq6KnMhyF1
         fAg+AhTeSgCp8NT/jbpiRnI3PZ+ih68Tbza/sRaURwdTY600fc/o5oB0jEh3VK5QcciZ
         sOND3wUv7fhxu6jtXY4ROMGVdS07QbdqkikJQynpIjlZ+7HoEtWDaY3ZtJxzG1fFO5+P
         U72BpQNIg/yHOTqURoE0co9lr3rg/e9hjEJSuqamTFeaujVukUVB6fEccV7Q3DXgxMXw
         8weq47Wmp369BcjLkNWLSq7zlCk5nDhaNrxENci0YvjPelwbMaiLHLVG12s5ibYKrkU2
         cSnQ==
X-Gm-Message-State: AOAM531lY/rH2CRXLWEY689KS9KY1mq06s9B4A2Pi8ZmRA9mgXh3huFi
        zyudB3yYqlEWUAYkShIDPRVl+f8nDWBG6EHL5K4GsA==
X-Google-Smtp-Source: ABdhPJxMrWFRgnJ0HABbALsyEWn++3TYT3GlrWCdJTKoJ5qhP66rEVIDTbtidg6sinbHg72xQektuQEkP9W4JCYNA8A=
X-Received: by 2002:ad4:4eaf:0:b0:441:7ff6:f639 with SMTP id
 ed15-20020ad44eaf000000b004417ff6f639mr7098344qvb.73.1648805564076; Fri, 01
 Apr 2022 02:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220330190846.13997-1-wens@kernel.org> <20220330190846.13997-3-wens@kernel.org>
In-Reply-To: <20220330190846.13997-3-wens@kernel.org>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Fri, 1 Apr 2022 11:32:33 +0200
Message-ID: <CABxcv==csvqsxM46ce2LecDh4E-UxxD2DG+3E-hCFoyrdtRv7A@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: ssd1307fb: Add entry for SINO
 WEALTH SH1106
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

Thanks a lot for your patch.

On Wed, Mar 30, 2022 at 9:09 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The SINO WEALTH SH1106 is an OLED display driver that is somewhat
> compatible with the SSD1306. It supports a slightly wider display,
> at 132 instead of 128 pixels. The basic commands are the same, but
> the SH1106 doesn't support the horizontal or vertical address modes.
>
> Add a compatible string for it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index 9baafd0c42dd..1ac016a2d847 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -13,6 +13,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - sinowealth,sh1106-i2c

I like that you didn't include a "fb" suffix for this, the existing
ones are cargo culting from the previous fbdev driver to make existing
DTBs compatible with the DRM driver.

I've been thinking if I should post a patch to compatible strings
without the "fb" and mark the current ones as deprecated...

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
