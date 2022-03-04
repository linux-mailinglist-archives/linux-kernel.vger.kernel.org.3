Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDCE4CE096
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiCDXK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCDXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:10:56 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277927B8C8;
        Fri,  4 Mar 2022 15:10:08 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id z7so9407784oid.4;
        Fri, 04 Mar 2022 15:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JW+rxnZpE9+fHEQrxDlG04ae248q2vaFTXN8LAiNdGI=;
        b=6aZfavgP3uZmPoNBDusmIhadoeF/Cn0hjthPyjkNmcBhA7c8sEIxzSJtKnJqseKB5a
         D5IZ4bzrcG4+79OAfSjyHMlUljMmXLO+5scEyPD+jLZvyYh7Jpeu+Sa2ledB92noPv/j
         G9HmSKz2BoR+mZN3t0Jr5LJkCLlCkg5/rwMYH/u+7LWQEXFmvZ/NmtVfw2e9qMZw76RU
         tUefloDqeTXpluyhvaILNFQ57qfI5o4m92JKxOuBrGWwZHh7Nwf01CkqUg/jktqNyBf4
         ThZESlYp7sfRpRKETiBbDvEvXrMuxMnpXu7Pr0WtjjfsgVbNWUesBEcOup+mCyq4e+En
         cI/g==
X-Gm-Message-State: AOAM533Gmh5rf6qNF6DBwZ0HeZFWcr0cfZaYsCibz8Gl2oixlKHPvs/2
        xEi7Yp0c012ZtnSoVfzK5w==
X-Google-Smtp-Source: ABdhPJy9RdDp8xAHMMBepzvrVL3O5MwKYsIJ1gbpJkxbzCBhqvIZ4bNVu4BUg/Vl7bnetGqDDVqZQA==
X-Received: by 2002:a05:6808:11cd:b0:2d5:3f90:b9e with SMTP id p13-20020a05680811cd00b002d53f900b9emr474875oiv.113.1646435406761;
        Fri, 04 Mar 2022 15:10:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a12-20020a9d5c8c000000b005ad51592bd8sm2900602oti.49.2022.03.04.15.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:10:05 -0800 (PST)
Received: (nullmailer pid 633452 invoked by uid 1000);
        Fri, 04 Mar 2022 23:10:04 -0000
Date:   Fri, 4 Mar 2022 17:10:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-remoteproc@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: remoteproc: mediatek: Add interrupts
 property to mtk,scp
Message-ID: <YiKcTH9alpE5FExj@robh.at.kernel.org>
References: <20220225225854.81038-1-nfraprado@collabora.com>
 <20220225225854.81038-2-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225225854.81038-2-nfraprado@collabora.com>
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

On Fri, 25 Feb 2022 17:58:52 -0500, Nícolas F. R. A. Prado wrote:
> The SCP node can have an associated interrupt. Add a property for it.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
