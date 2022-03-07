Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9514D0BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiCGXKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbiCGXKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:10:21 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7543625C;
        Mon,  7 Mar 2022 15:09:26 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so19846061ooa.10;
        Mon, 07 Mar 2022 15:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DEjj6mipEEYLP33vOJE2V/BDkDeTRAuZ0r17MrEk9aE=;
        b=C6dFjvs6qNiuIISSYPFzunKtmqb1f/HbXEZABXUjVkHZSKI2DlQ4y7rEaZBQXznIBd
         7sjU/0VsXoitL2hgIFwK5uzp+nRUElHvhpQJKbGUMAIusEp/KjV9BlkHM2Mhp65IKNcH
         0fG8Yrxph09QYfhQlYMEYxWPPtkj9PeVWNhI4rO8er6duPl8h9xSPReGcA+n9dYuJ31t
         aH5CKJHZEZ1DSAr+xGJH9LITVCmpJkocF2cJWLpSglaAd3DAJi0/4HnSC665BMV4A6Ud
         cSuLR6d4o28NunTYR//iI9l4bXUtntZCcPQ87C5hipTkRfFniEXEI6z/F7LPfMVarvW9
         hNcA==
X-Gm-Message-State: AOAM531+Pl8i1C/mfOdGQyJEBklfm/zZ5xVMzsEBF0wuMkkxKXbycoXQ
        ez+pGEgf20ypwyQa6phnuA==
X-Google-Smtp-Source: ABdhPJyDVQwg3MsMXAkIeGiYt7mgMtzwhkpaixFw/cjv49b8I42KVzQxkNn5uMKaxpWqXbqHoOiGZQ==
X-Received: by 2002:a05:6870:70a5:b0:da:b3f:2b20 with SMTP id v37-20020a05687070a500b000da0b3f2b20mr753668oae.191.1646694566133;
        Mon, 07 Mar 2022 15:09:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bq3-20020a05680823c300b002d4f8fe4881sm7328738oib.39.2022.03.07.15.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:09:25 -0800 (PST)
Received: (nullmailer pid 3432748 invoked by uid 1000);
        Mon, 07 Mar 2022 23:09:24 -0000
Date:   Mon, 7 Mar 2022 17:09:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     robh+dt@kernel.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, matthias.bgg@gmail.com,
        fparent@baylibre.com, chunkuang.hu@kernel.org,
        yongqiang.niu@mediatek.com, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [RESEND V6 3/5] dt-bindings: display: mediatek: change to use
 enum for mutex
Message-ID: <YiaQpKN3JawgEl/A@robh.at.kernel.org>
References: <20220303065725.23384-1-rex-bc.chen@mediatek.com>
 <20220303065725.23384-4-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303065725.23384-4-rex-bc.chen@mediatek.com>
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

On Thu, 03 Mar 2022 14:57:23 +0800, Rex-BC Chen wrote:
> All single entry cases in mutex can be merged as a single enum.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,mutex.yaml      | 24 +++++++------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
