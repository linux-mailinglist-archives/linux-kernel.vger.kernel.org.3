Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1CB4C35D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiBXTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiBXTZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:25:32 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EB22465C8;
        Thu, 24 Feb 2022 11:25:02 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 12so4363113oix.12;
        Thu, 24 Feb 2022 11:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vP2xKeCsORmMtAW2DgHTh/5I0mgPHdrCnA1D3ZoaL+E=;
        b=TfvbR1hTGY9d21xx4NBbtasn8vIqQO6Eq6w3H00Y2dhCu2yQ0vjk5+PlUUFn0TVlBl
         1Xxe49orXUmxeTIoCbF0XlAOCO3pLvxMIQ52Ec7mrpcHmXChGHnQ8vDsZDBe5npHYbVF
         3PnfGas5HCnqB3fMfePxSwJNkvLwMLvT8wc0chVmZlsfKY1IRAHMMiafRZSW+drbi4iQ
         y08CTle2K3qM8m8dzvhQ39mVpLknkf+vnDNyIg5hMq1+7DWqY60zoGD7Zk33VBtle8v1
         iS6VOvem6AP9qQer2B8BamlTdzwX9mJPQ1bwaP2t1uqJcxde7lybR8JoHc0WEIVD/aGe
         WY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vP2xKeCsORmMtAW2DgHTh/5I0mgPHdrCnA1D3ZoaL+E=;
        b=LE6/erBHR0KeV9giTEPq75+qf25oSrutAxsb9Up3gwJF2mQls3DRLyaxg/ZmmiAaf8
         4Mpt+q0tv1FRLL/usIc2780UsahuVHy4Zc+5pl/7DAXKNhTdRqzWD7twFRzI+w9hD+rB
         qTq8002tZkjFVN3c6MFUH4ReZu8zKitDGyHu/Qc05ITvHVlszbTB7DtkNw+9nsvBfapT
         AxMaMxVlCnGZxY5UkN78vACdNEzg2zvnCzJW3/2yGwEjVW4tPvQHUt2Zz4YddBgnXxKs
         VrZ0RI5e0tqEGIGvgWjZ1P2F/Wod26koyu3pruF8CUL9YVNbXcD3iqVu1BVvCV3cpDdx
         eGEg==
X-Gm-Message-State: AOAM5335MoVSYi1UTmBCys6HXShv67qI0SJdD/3qTuFLucqKy+4wEajf
        bHbCnwTyMKAg4xaEmsKbIeU=
X-Google-Smtp-Source: ABdhPJxyyKLH2WhuX64EZoK63S8MYtuPm9ktSotyRHHh4i8keiox1wQFUQeu2xE8pAqtTvIBC0wErg==
X-Received: by 2002:a05:6808:3091:b0:2d4:c180:d586 with SMTP id bl17-20020a056808309100b002d4c180d586mr2274873oib.120.1645730701604;
        Thu, 24 Feb 2022 11:25:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j1-20020a4aea41000000b002e140d2d96esm118404ooe.13.2022.02.24.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:25:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Feb 2022 11:24:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: vendor-prefixes: add Vicor
 Corporation
Message-ID: <20220224192459.GA1942646@roeck-us.net>
References: <cover.1645435888.git.sylv@sylv.io>
 <5b487a0b68d58b64022662f1e527ac80a6ad81ef.1645435888.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b487a0b68d58b64022662f1e527ac80a6ad81ef.1645435888.git.sylv@sylv.io>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:42:04AM +0100, Marcello Sylvester Bauer wrote:
> Add vendor prefix for Vicor Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 294093d45a23..047a83a089ce 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1298,6 +1298,8 @@ patternProperties:
>      description: Vertexcom Technologies, Inc.
>    "^via,.*":
>      description: VIA Technologies, Inc.
> +  "^vicor,.*":
> +    description: Vicor Corporation
>    "^videostrong,.*":
>      description: Videostrong Technology Co., Ltd.
>    "^virtio,.*":
