Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C544AE86C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiBIEJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbiBIEGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:06:12 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE55C061577;
        Tue,  8 Feb 2022 20:06:11 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id q8so1285560oiw.7;
        Tue, 08 Feb 2022 20:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b6SaNmycVybeDF6G9H1cZ2sPN7HYXMYSiZUwDNcdJwM=;
        b=yRrRwzQpeeJbtx73KF3TpQJHdwGpN38npfxfI7hoPplEAvAGnVNzZySZMF+GBBmz/g
         2W2XcO60Yg6VqBKEgE6c7DkqXuoS28mWYvDUhwm/TgOf5Cy3pwzkHVIJ+c5jgWRbDQGr
         FHtrBJzrkEca7uAg7nxZEZSo8gG0AL1TojG+I1v5GqgSbhu7AozFnniMQsnY4P80seW9
         3J4g0SFxqcD/oZk42yV2oGlUQ6H9n9ImPJ/nh7NJqr9pFbREHyanBzXtqIZKARUCTndv
         OFMPa526iFoHPN5kJfhCBPh8QDOICnn7SzqZ3sTTpMpiEHcDhPTUlCLUw9rIXxkp2ENn
         xjNA==
X-Gm-Message-State: AOAM530Uvru0+nMyCFTbDSpuv8By6aiLZtPiqEppky9xDfiL6tb/rut4
        xPqNbCMzu8C2v/fs4qUqKQ==
X-Google-Smtp-Source: ABdhPJw2/c9hvOCvmPL3xtMWamQugOcPTEH7IK/GU9FaJtJSa+90xaUuLZm6DsV+LDiNAcr17ndPVg==
X-Received: by 2002:aca:1011:: with SMTP id 17mr154742oiq.27.1644379570470;
        Tue, 08 Feb 2022 20:06:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i21sm6856720oao.35.2022.02.08.20.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:06:09 -0800 (PST)
Received: (nullmailer pid 3634884 invoked by uid 1000);
        Wed, 09 Feb 2022 04:06:08 -0000
Date:   Tue, 8 Feb 2022 22:06:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@nucleisys.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 06/12] dt-bindings: serial: add compatible string for
 Nuclei DemoSoC UART
Message-ID: <YgM9sDyF+dx9JwOG@robh.at.kernel.org>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
 <20220127151647.2375449-7-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127151647.2375449-7-icenowy@nucleisys.com>
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

On Thu, 27 Jan 2022 23:16:41 +0800, Icenowy Zheng wrote:
> Nuclei DemoSoC design integrates the UART controller from SiFive.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
> ---
>  Documentation/devicetree/bindings/serial/sifive-serial.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
