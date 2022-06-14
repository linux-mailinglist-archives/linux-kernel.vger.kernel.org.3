Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7134554BC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357910AbiFNVCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357780AbiFNVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:02:42 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4A3120C;
        Tue, 14 Jun 2022 14:02:40 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id i16so10722893ioa.6;
        Tue, 14 Jun 2022 14:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/cyFUpUGPUplOfOftDnZp7vPwEuiKwsOzYr7Oqpd9c=;
        b=onBz9JHZIxzRWNHbegpNtm2r0LsDB15nyPjsonqHqclMEHd6g8xmVtqzx7aVggpS8k
         SjbvgKFnt2Dq4tds/imcdrIrpG65nILrmf0GdPW8BNwx2oht0svJjjl8oxWTY/mcsD1W
         09er4xjLLZ6MOmN5E80Yqhn+Yuy3s3ZgvLdElwX4fse3InYSQ1779CkJ+D5g0RM6Ygp/
         oyD74lUaCSh9fiOFOLfap1+ATpiQM8emxoS/QtAtQQRjo87MlQZM99IwLHuyi7Hgr2qV
         uDdQjGnSlvcCbYSJ+K5ofDlxzdHUG/L4JJ1tq9DnX1k7B+Ld1Guv8ILn00mr4YEdfVAe
         STbQ==
X-Gm-Message-State: AOAM533fz0iYrswe9LfbrgCxlXciomx7U3xD2M4sBYyE+3kK9QaZQiiM
        wsNUySBqsQjBLr5qdAQ8eaLYK3Igew==
X-Google-Smtp-Source: ABdhPJwArJB183Z3ToeeqDaidsVtxn45dq7qpYio0HGMdk7IzR5wzQxV8JC6SiQfQp3gbJl4lHM0kA==
X-Received: by 2002:a05:6602:15c5:b0:669:ef95:1cc with SMTP id f5-20020a05660215c500b00669ef9501ccmr3538533iow.140.1655240559745;
        Tue, 14 Jun 2022 14:02:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y5-20020a92d0c5000000b002d5c572f410sm5885426ila.63.2022.06.14.14.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:02:39 -0700 (PDT)
Received: (nullmailer pid 2566780 invoked by uid 1000);
        Tue, 14 Jun 2022 21:02:37 -0000
Date:   Tue, 14 Jun 2022 15:02:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org
Subject: Re: [PATCH v5 1/3] media: dt-binding: media: Add rk3568-vepu binding
Message-ID: <20220614210237.GA2566560-robh@kernel.org>
References: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
 <20220612155346.16288-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612155346.16288-2-frattaroli.nicolas@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2022 17:53:44 +0200, Nicolas Frattaroli wrote:
> The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
> encoding. This patch adds a new binding to describe it, as it
> does not really fit the rockchip-vpu binding, since there is no
> decoder.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  .../bindings/media/rockchip,rk3568-vepu.yaml  | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
