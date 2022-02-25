Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA234C4AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiBYQZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiBYQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:25:30 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79FD1B8BE5;
        Fri, 25 Feb 2022 08:24:58 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso6766801ooc.12;
        Fri, 25 Feb 2022 08:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G0wL1tv9YDLjyJO0SII7J8zFNPKMiKxbobcDr5uPVqY=;
        b=M2REpp3SfMvAMrDKYiOBCry8M8admoWwncmyYmaEUIUrFFW1jz4ay7gMUNsTWsVCdm
         LC3phwaK7XKo+gU1/33OUKrtrTGEiKrjK1byx9WjtePD33h4qEFNCvGxX4tJYS7AGggd
         UHjKtrq28qTajF9vBezIRu9TKW2hco5VOqOEjX1kOyoHshawRYboAT7kHtn9BhE2u8w0
         gQj6eFpqR+U70BtT0wSl13SSdJ1txp0Aek/fnFgDy5+6LXx8vDbgEPmPfKIt+LzfGsLW
         5B/3CypoS6MqxPCYGfXro1MZg/lP9p5zJ9GkQ4cRGa8Qgihn++PBDeOArRXcHdsvV+/3
         8bxA==
X-Gm-Message-State: AOAM532v01h7AiptHZmSLm7zR+C5FCKd3SHE5h81nZyTnG/PJVaMmsKo
        MuB/8TF5JNUIENl1RsQ6OgGUs8QFhw==
X-Google-Smtp-Source: ABdhPJx4x+GM9t3AVElZNRESE/E8edNaWjEH6rKwJcyOKoE4Rl4sXZh8pp0Ur1ZaT4jMhHpksSu1NA==
X-Received: by 2002:a05:6870:4396:b0:d0:feba:c243 with SMTP id r22-20020a056870439600b000d0febac243mr1772969oah.34.1645806298214;
        Fri, 25 Feb 2022 08:24:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bf39-20020a056808192700b002d51f615f1csm1511394oib.34.2022.02.25.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:24:57 -0800 (PST)
Received: (nullmailer pid 1036935 invoked by uid 1000);
        Fri, 25 Feb 2022 16:24:55 -0000
Date:   Fri, 25 Feb 2022 10:24:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, linux-mediatek@lists.infradead.org,
        runyang.chen@mediatek.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH 1/4] dt-bindings: watchdog: Add compatible for MediaTek
 MT8186
Message-ID: <YhkC17tHJbd5Sd6J@robh.at.kernel.org>
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
 <20220216014505.28428-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216014505.28428-2-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 09:45:02 +0800, Rex-BC Chen wrote:
> Add dt-binding documentation of watchdog for MediaTek MT8186 SoC.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
