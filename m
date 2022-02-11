Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C64B2A63
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351528AbiBKQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:30:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbiBKQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:30:34 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8538CC9;
        Fri, 11 Feb 2022 08:30:33 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso10915594ooi.1;
        Fri, 11 Feb 2022 08:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+ea0IEfTZrMh0IhDAaSVg57B+FUPCOErvn8EicNrgc=;
        b=vMi+9B5p+2MYqIgAOGNlfSOrDlj+O3Aevo8+riOoHCb9l5g/VHYHHxMrXV+X+NLIFz
         iXcEn2kYUPyzNe7LI26FRF603Rk1/cUbuTryna2oSJB1Hz2HHMc5HxVimk2VQOJ55Rhv
         hxePoqqGnf6DGN57qYo1m60osK9KGQYRh+/nrTE4+BLFzFXPmHorIJGDKBJvb+S01GJt
         Lq2Nm51ScfQjZMsZokL+iKNsvSOhVbEOSCcbS+G1JzXq97bKQAAcCrC571Dy0xXKx3yt
         fYlioLZKZNE+lVw0IJAV88dKmEmAHguUIRimi78NTI5slpIgmUF4knCLIIMseSskOyVx
         f98g==
X-Gm-Message-State: AOAM530LYmC0/vSO878aK1qEQfvfrTJO+LMHhKTpWGTlSKDB7nxDPjIv
        X24ovkIjfWXrUBlKpIkMmA==
X-Google-Smtp-Source: ABdhPJzN7lVVxKBXptRaeymjIsI1pgzaiTr4CNynMhpUy+I+IKeZYI+egotN7FgkGqdUuvbNvfZ48g==
X-Received: by 2002:a05:6870:e2c2:: with SMTP id w2mr405572oad.65.1644597033013;
        Fri, 11 Feb 2022 08:30:33 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id a128sm9559996oob.17.2022.02.11.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:30:32 -0800 (PST)
Received: (nullmailer pid 474520 invoked by uid 1000);
        Fri, 11 Feb 2022 16:30:30 -0000
Date:   Fri, 11 Feb 2022 10:30:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Ctera Networks
Message-ID: <YgaPJjOUNm7HAysS@robh.at.kernel.org>
References: <20220207212014.28551-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207212014.28551-1-paweldembicki@gmail.com>
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

On Mon, 07 Feb 2022 22:20:13 +0100, Pawel Dembicki wrote:
> CTERA Networks Intl. is a company based in Israel.
> They manufacture NASes, network devices and provide software
> products for cloud storage and IT security.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
