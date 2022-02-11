Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F8A4B29B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350345AbiBKQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:09:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbiBKQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:09:12 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052EA188;
        Fri, 11 Feb 2022 08:09:11 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso10862903oon.5;
        Fri, 11 Feb 2022 08:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UsoFMOUmyD3/19vqiSJa1ovHqD6HuTwko4NFjoImuak=;
        b=ELqqxq7bTdFkn/3Kux6m0KwWSkakgdEMeHv0SkTti4ZD1JgrgYXE+CFS9F4j+iOMSy
         Wb4zj3QVFDUyOWAViFtJcAbSCJnYs3gRuglMsnFtvjwyINvRRh7M+0xl+KK+5ECKp54e
         cW+JOSHxFMkykLNYFKIBcoVM399Sq/h/naI/HxDpELZhbapH7AAPZbny1XY+6DhyxhoO
         Cl1Mxvklg/Uq1Gz/XZx89Mslj2zwwAPjdKcZ7Or0Rv6AwtNaKhdptV1AOJTU7Ff8isEt
         9cxT2Li04AlMWnBhammdTEoK0vRi4LHQV/gbEl9UDUAnURkgJaSC5wMYNP4sMamd0nkt
         rYbQ==
X-Gm-Message-State: AOAM5312ix2GCVf/v90saohQv8oGlrjyRM5qwo1K1G61ROP6lcW9s9Cs
        nqXpHwHiAjFbcvInZx22hg==
X-Google-Smtp-Source: ABdhPJybCMTCupvu4ShRchADwgm07GIoL8sNNVWj2IJOihePiTSfTIUTJ7KX/WJ3F4nfjgcsWoYQdw==
X-Received: by 2002:a05:6870:7734:: with SMTP id dw52mr370319oab.185.1644595750312;
        Fri, 11 Feb 2022 08:09:10 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id bb16sm10059876oob.42.2022.02.11.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:09:09 -0800 (PST)
Received: (nullmailer pid 443201 invoked by uid 1000);
        Fri, 11 Feb 2022 16:09:06 -0000
Date:   Fri, 11 Feb 2022 10:09:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, lars@metafoo.de,
        devicetree@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        sst@poczta.fm
Subject: Re: [PATCH 1/2] dt-bindings: iio: potentiometer: Add Maxim DS3502 in
 trivial-devices
Message-ID: <YgaKInKZ5gK1N3wr@robh.at.kernel.org>
References: <20220207040408.4273-1-jagathjog1996@gmail.com>
 <20220207040408.4273-2-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207040408.4273-2-jagathjog1996@gmail.com>
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

On Mon, 07 Feb 2022 09:34:07 +0530, Jagath Jog J wrote:
> Maxim DS3502 is a 7 bit nonvolatile digital potentiometer.
> Add DS3502 binding into trivial-devices.yaml
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
