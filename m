Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B8C5A8F54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiIAHHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiIAHHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:07:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8130521819
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:06:43 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y197so7357875yby.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OkrB7u5zO7yhs7suwu7hn8qSqPX9t4VFobbA5eBLtMA=;
        b=F257pApWGKrYCUXD6jfvvpcz01RxcYotLK3hhuKEAwBLQWaXdlYkytdlDHaMhZ0vdp
         fKSwIhYkMkSbSw/rSKe/kuOUHDoZfDS9HaOiR5Zlmf2L9q+6OtGAaoT98B8ubwA3FkMt
         AFbthgCqoCfWcFRQRS11Er3xaYgrTAcJFHhVchvthH3mKqYc9GNxxJArWtH8vz5FVKZD
         murNAJt4g2NSzpFQ88dJEVB57RldbFiXnMQUfcytK4QDFnI3sdKgXc8kMJMgsGOmOY0G
         XPLMXp9knlitf0IzP9NXehUe5Mt2mIyU0Kg8YLJGVM6s8iJ7ld/PS1ZBI3nhqpVPHyzI
         Z3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OkrB7u5zO7yhs7suwu7hn8qSqPX9t4VFobbA5eBLtMA=;
        b=SEsPBqatvIUSnORDtjq1UXUja+a0qDdO6PfxCjTpoZDDVnvHUoQRKJS5SDEbtsROqw
         cwZf03QV5W4XesHvRQfGFbRTrtbxfXcYItz8DHhnd/kpCGfEuyEcecIpJ5nam2EXNHxl
         h0YNvxnjoOsoxpassuXf07F9GFv0BqTX1IOBeP/MYY4ZZ0vjPpmiNLNdvdvP8EOhauVe
         LHMFerh9iv8DYbQKaH/02o5wQVmoXdQKeSuxV3Rt9aSeimihEMwfjJ4p9ZXXQ46ZCZM7
         n9+41VHy/j6cm63Zs9Je75u3NaDovgq+uAv8aVUWeGNOmqxq/pGYaWAvcEeu5ej4yDtP
         Wq2Q==
X-Gm-Message-State: ACgBeo0bC+tCC8u0rJ3yd+Wrf6WikSYn8wBDpjgZqaSkbhdXXfhYnOzK
        FD8RzwxBLIcpqURGABC4JsuMc50uGIRnPP4pim2jIw==
X-Google-Smtp-Source: AA6agR6B1joMY2QehQj/lQc1Wp2scBlnM8pWTOh1nJljf40TrREeO+mjpMy/OatZLnIGjI8y3nxT5YnLNmLsDn2ag4M=
X-Received: by 2002:a25:8a83:0:b0:671:786a:e2cc with SMTP id
 h3-20020a258a83000000b00671786ae2ccmr17400206ybl.145.1662016002769; Thu, 01
 Sep 2022 00:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220829065044.1736-1-anand@edgeble.ai> <e4d6eba8-497f-adb2-6f34-35883b8ec50d@linaro.org>
In-Reply-To: <e4d6eba8-497f-adb2-6f34-35883b8ec50d@linaro.org>
From:   Anand Moon <anand@edgeble.ai>
Date:   Thu, 1 Sep 2022 12:36:32 +0530
Message-ID: <CACF1qneLHv1egFE0r0Rw+cJLh1hESJ95_VTjnT4WxzmBX21sGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: rockchip-dwmac: add rv1126
 compatible string
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 30 Aug 2022 at 15:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/08/2022 09:50, Anand Moon wrote:
> > Add compatible string for RV1126 gmac, and constrain it to
> > be compatible with Synopsys dwmac 4.20a.
> >
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > ---
> >  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > index 083623c8d718..346e248a6ba5 100644
> > --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > @@ -26,6 +26,7 @@ select:
> >            - rockchip,rk3399-gmac
> >            - rockchip,rk3568-gmac
> >            - rockchip,rv1108-gmac
> > +          - rockchip,rv1126-gmac
>
> That's not a complete change. What about the other place listing
> compatibles? Did you test the bindings on your DTS?
>
Yes, I missed the properties menu, will update it in the next version.
>
> Best regards,
> Krzysztof

Thanks


-Anand
