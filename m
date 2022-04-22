Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B850B9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448438AbiDVOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383108AbiDVON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:13:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995585AA4E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:10:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t12so11102970pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7KnDx3MBsXGU+6f03hFeaiX/1ovDgX2SpGS4CvxvKDY=;
        b=q2bhF3xvKQlTLaeB2d4vAiYmlXLkecs/KMghPS5aa2xC2Pb+w5XYwcWBxIwx+JHZF4
         mbUuucvNbrkEooym6ExcZc522qErtzAUV1W5/OUIpmxFjPRN3I1j7Xfc60HUnRi1fuAl
         i2Z8wXMdD3qvhT1/jAkvQBo4fPgStqI7aIRP3FMbnmf0wNP1nvKLJgLMSJ7y/29Jtmjr
         AsjyKrCVacHZEq2364EGTa4Dz4vAmNY9AO8QbSD5nXbJVnaC/eLq/RoW5gXbYoxIk794
         L8R4xffk0MXLVYxWjUFY+HLvKvsh5Wj2CDTdX0G9ZmfKdAwEkAIT1A2gXp5Cbfg0f3vW
         bv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7KnDx3MBsXGU+6f03hFeaiX/1ovDgX2SpGS4CvxvKDY=;
        b=kxoERf3iABkhFeYTbfjvJQcGX4MRL2tStqSEHpAGHlYF9arctMYw1+Gx4nsjcmGEKr
         b9sCV7Us57Px+mkAJW3YDmWeKB3RuTyO42lrFuU/TfG7G+91OLUMZtvLev+NPHpgKHa+
         DQlWGgjb7Fstmsn5m9/3W5xW5oKmyYSpG3uisjBJdk4ZNH5RDR6iT2hxWMQMIsr6qzGc
         RvnFRke1dOxhsa1Ak3f8Plit9PJENmr+6J/+eexM4Ru2efyIDZaQx9q9q9JQfCb7s3ot
         Ve9+jhiSBKB5l0+Kk4IV0H3CGwbrWORew7WUsu66663tKsXrEpzpVjVDqh/1J+gcL45U
         EEUA==
X-Gm-Message-State: AOAM532ax3oWdNjJw7AJHQPSCXks6fkvd9dsIFeA72slK5lmn4ZyWBK5
        NHIKiwYKbos7rojdxiM61pegtgtoRrDUNcgJ5rW3CQ==
X-Google-Smtp-Source: ABdhPJwYFHoUca+/m8OJ6ZB2tOw4pt/Jt1T0oHOVtUwkm0mgQ7orYW9ZEfXsdLO3sdd6qjZz3OXQp5IRLzG67Opuvn0=
X-Received: by 2002:a17:903:32c6:b0:158:ded2:e766 with SMTP id
 i6-20020a17090332c600b00158ded2e766mr4769801plr.117.1650636654846; Fri, 22
 Apr 2022 07:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-3-xji@analogixsemi.com>
 <CAG3jFysyj7sO0qh3FAAeuOQYUSz6nkZ8svX7f4xdfSY980OkCg@mail.gmail.com>
In-Reply-To: <CAG3jFysyj7sO0qh3FAAeuOQYUSz6nkZ8svX7f4xdfSY980OkCg@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Apr 2022 16:10:44 +0200
Message-ID: <CAG3jFyvay13a1zNu6k1LEykYHCvy96NT2AQp9mUTOn-dB_o1Ow@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings:drm/bridge:anx7625: add port@0 property
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Robert Foss <robert.foss@linaro.org>
