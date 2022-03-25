Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634E84E7DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiCYTkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiCYThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:40 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26E5185476
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:22:07 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id b188so9177706oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:user-agent:references:in-reply-to:mime-version:date:message-id
         :subject:to:cc;
        bh=30HnVT2o3reQZo63OrltbI+OfYNP2j0YqcMmacNl+p0=;
        b=o7VUwpdrsAT9+dZRq7E7nbHA3vtSO4Zb3PikloQPss2pIBW60nVaMdcLkclXCSfOnk
         qc7wr65NRit/egcPCcwnvIO1UkzmSY6Y4QT+lq1OOvJ5uabY/EGOmhBRly02/Mg0Cezp
         ADk7WZJvqIptO8KeNhkNBRwb+TooeHesT6NVl7QZNmU5Vsvb8u5YtnNiGq3u5Egwe0fN
         dPHULLWMtNyj61PdB0ANxfFH34zk8E0/W84nklF85pqL4wjLOG8XC7d4JDJSLB6nlSDD
         i8SPNdLnNQI4Ydr1SM02AlPjMlttGqx++wFQJU+uRQhxQDjY1dtGeMBTNX+6OJaPgCz0
         +ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:user-agent:references:in-reply-to
         :mime-version:date:message-id:subject:to:cc;
        bh=30HnVT2o3reQZo63OrltbI+OfYNP2j0YqcMmacNl+p0=;
        b=O8xRlQRIS8E7seTGjqUk4T/+cKG5hFTU5ywUkKqrlFrYBDZXl7Z0zBSv8ZCMFfInc/
         IF2Fvtu4tjjJZiQtAP/WEafPoZaRUlr4dQ904nwMo5f3AobFah7BZRSYP3syenkG9oqk
         gcohmOnMNMcAYMBBRzXknnHG+TnBs/cmMsvhr4h06csiFVeHA8+7f0up7LLhUl+D0QwU
         Bs5NjRjfQ1f7E4KxUEVsUEIhKxSyU7j2dxx7hAqDxulkco+JFo1JOa0rnr9PoJZeVOqi
         42lIq3UXekyk8ev0ZDN2GBbQu/zJl4quTC3gqvVNtvhOVNtlQRT7kIN/B/Co1CcgGg4c
         1CKw==
X-Gm-Message-State: AOAM532pBsU4oMz5C5Q33uyBOrz9kHiaQmXbzc4/FPwndLYRDdaqYJaM
        7cHfpfYs+JvNZZqUkPdEjjPtlexQGZ/kAbUstJFhrWmorhQ=
X-Google-Smtp-Source: ABdhPJzkv3FApupEr6ZcvHiyizzGLadsyrPXz2DnM470Hnd1ln6bsvI6D5r0lg6iZSsst6EnF/KlN2WTBVJUE+zMqsQ=
X-Received: by 2002:aca:1712:0:b0:2ec:e1a4:1ad1 with SMTP id
 j18-20020aca1712000000b002ece1a41ad1mr10538652oii.78.1648230216155; Fri, 25
 Mar 2022 10:43:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 12:43:35 -0500
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220325171511.23493-1-granquet@baylibre.com> <20220325171511.23493-2-granquet@baylibre.com>
 <8baedbe6-eb60-02b4-a6b8-fe3abc566335@kernel.org>
In-Reply-To: <8baedbe6-eb60-02b4-a6b8-fe3abc566335@kernel.org>
MIME-Version: 1.0
Date:   Fri, 25 Mar 2022 12:43:35 -0500
Message-ID: <CABnWg9s3vmpCFFai_BMjagqHehk2vbP0ST_tfWvOxmtubPm14g@mail.gmail.com>
Subject: Re: [PATCH 01/22] dt-bindings: mediatek,dpi: Add DP_INTF compatible
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 18:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>On 25/03/2022 18:14, Guillaume Ranquet wrote:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> DP_INTF is similar to DPI but does not have the exact same feature set
>> or register layouts.
>>
>> DP_INTF is the sink of the display pipeline that is connected to the
>> DisplayPort controller and encoder unit. It takes the same clocks as
>> DPI.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
>This is v1, how did you get Rob's review already?
>

Because this is not v1... I'm not really good at this... this is actually v9...
I just didn't pay attention enough before sending the series.

What's the standard thing to do? resend with the proper versionning?

Sorry for the confusion,
Guillaume.

>> ---
>>  .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> index dd2896a40ff0..53acf9a84f7f 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> @@ -4,16 +4,16 @@
>>  $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>> -title: mediatek DPI Controller Device Tree Bindings
>> +title: mediatek DPI/DP_INTF Controller Device Tree Bindings
>
>While at it, remove "Device Tree Bindings". It's about hardware.
>
>
>Please also rebase your tree as you use my old email address.
>
>Best regards,
>Krzysztof
