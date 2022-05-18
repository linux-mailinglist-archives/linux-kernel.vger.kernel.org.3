Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F32A52AF71
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiERA5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiERA5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:57:09 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCC53E19;
        Tue, 17 May 2022 17:57:09 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w123so939855oiw.5;
        Tue, 17 May 2022 17:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJUEU3b8rb1nb3gZa5r/iKHGd0id+dL7Y9fATlK8SrU=;
        b=t/qV084n7aj2NcuaFVtKUry03lGyBSJn+MK2A99SlgKIPV1bwNR6rFAQk+BMDKmAZ2
         GOWTqYs0orcBcIJhf/gC/MTz9KI35h4lhVR+d2GIv87Psdup3FRKxelmdpSG599RarK/
         t0PhhnMhYJ4s6qnoc3UkHVxoqdFAp93kMa+/EEVvpa6nTrEx/NwMWC5szaGELD+tty0z
         lXTsTMYegkio+hIi7G67x6k+4HzliHyvS7PVRxfAl5j0g5DC2YmEsqP42oF5YxRvRRCT
         6V8lv4iLKv3faQJG3zJjqwafDyGVLCYbGVxKVXyRSs8fU215MFKLndGTqplaEfpjfdPw
         3aGQ==
X-Gm-Message-State: AOAM532QSZop/+ncDVbG2vCKx+7fSq0Ak2+Jkzjn2povxHCIrLYW1NfU
        sikPK6jjvbvLDDxkxo8arQ==
X-Google-Smtp-Source: ABdhPJwJFZmM7q7xAG1nA2AgUV70lHhLkxpkmH7nBSa5++5QxxPCmOloP6BqJdC26qLIpGQEKKV68A==
X-Received: by 2002:aca:4b87:0:b0:326:b2bf:b10a with SMTP id y129-20020aca4b87000000b00326b2bfb10amr17712773oia.213.1652835428557;
        Tue, 17 May 2022 17:57:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w66-20020acaad45000000b0032647f4e437sm308897oie.45.2022.05.17.17.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 17:57:07 -0700 (PDT)
Received: (nullmailer pid 1981029 invoked by uid 1000);
        Wed, 18 May 2022 00:57:06 -0000
Date:   Tue, 17 May 2022 19:57:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        max.krummenacher@toradex.com,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        devicetree@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v1 01/17] dt-bindings: arm: fsl: Add carrier for
 toradex,apalis-imx6q
Message-ID: <20220518005706.GA1980955-robh@kernel.org>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
 <20220516115846.58328-2-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516115846.58328-2-max.oss.09@gmail.com>
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

On Mon, 16 May 2022 13:58:29 +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Add binding for the Ixora V1.2 carrier board our Apalis iMX6D/Q
> may be mated with.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
