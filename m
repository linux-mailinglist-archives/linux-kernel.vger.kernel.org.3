Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC458E10B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbiHIU1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiHIU1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:27:01 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5521AB7C0;
        Tue,  9 Aug 2022 13:27:01 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id q124so10548300iod.3;
        Tue, 09 Aug 2022 13:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Zb2mUFuhV/5563JBcGDuPjCytDVMGbor0Cr16TboDN4=;
        b=JPdM2lD1aKXAfjwrRJdmtE+IdG5zhQD+H40FqUuPn/erwiVzy61YcvdvCItRsiiqBs
         jpHYDFDCbwFcB6pSWK0W6TBWH08ifjaCGvqMdXgDOLkePQfY0jhQ860n/z+vYXa4dQtb
         2DYNUej79qfCCVII4bxv3tBfYNLc64S5Ep6mp94g34TJhJ323Fh8mOPxGzleYc1iKYND
         1rIcXlQfgOZDylk+cCahzXsY6ZP3uxabBAUMei3EoHrwrPVg5z9kIz7cfZZWc8Jl091a
         aY5yBpLzEBfK4dyAwH1c0xfyDfEK57dU/sYwO3qi1R+MXav/hBk9eg+CiKrGk33CXhhN
         MHWg==
X-Gm-Message-State: ACgBeo1E2AhNH0d/0FHYNsKUQyh8xw6nliMkxRW7rd5qT3wMd6YfQB7S
        GsDcrt49T2FdhQ/5zSrVWA==
X-Google-Smtp-Source: AA6agR6j2p346k+I02Zk8Bb1xrsh7e5KG6n1XfqqbHRoGaWf9D10TZrdC1haRNCdPLAusLwZhwv7GA==
X-Received: by 2002:a05:6638:204c:b0:342:bb9d:95f1 with SMTP id t12-20020a056638204c00b00342bb9d95f1mr10007590jaj.147.1660076820521;
        Tue, 09 Aug 2022 13:27:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m6-20020a92d706000000b002de73e822e9sm1367117iln.87.2022.08.09.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:26:59 -0700 (PDT)
Received: (nullmailer pid 2337716 invoked by uid 1000);
        Tue, 09 Aug 2022 20:26:54 -0000
Date:   Tue, 9 Aug 2022 14:26:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     kewei.xu@mediatek.com
Cc:     devicetree@vger.kernel.org, qii.wang@mediatek.com,
        david-yh.chiu@mediatek.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        leilk.liu@mediatek.com, liguo.zhang@mediatek.com,
        caiyu.chen@mediatek.com, srv_heupstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/1] dt-binding: serial: mediatek,uart: update
 bingding for MT8188
Message-ID: <20220809202654.GA2337658-robh@kernel.org>
References: <20220809084457.31381-1-kewei.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809084457.31381-1-kewei.xu@mediatek.com>
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

On Tue, 09 Aug 2022 16:44:57 +0800, kewei.xu@mediatek.com wrote:
> From: Kewei Xu <kewei.xu@mediatek.com>
> 
> Add a DT binding documentation for the MT8188 soc.
> 
> Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
> ---
> v2: Resumbit the patch based on the linux-next branch.
> ---
>  Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
