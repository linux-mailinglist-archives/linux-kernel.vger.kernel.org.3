Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A1C4DC290
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiCQJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCQJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:25:16 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8F13EFAE;
        Thu, 17 Mar 2022 02:24:00 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so4564781wme.5;
        Thu, 17 Mar 2022 02:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RKYv39Dz6kpsbqvNDiuEP28ERy33QsF4e6gcs7JiHOM=;
        b=6YrfeHC3Nc0krZmm5yqRh27TVwtIh7vUXVZJ2ZExaSplOk8fgKVN5h77UwSmVzx4Xd
         NuyJoLeEH8SGrBz2gsVlpx7KgZ1vnyGpx1VNMC0t2kq8goceBOyzIUnflyaWgu7dy9LP
         wNR7cii5/aFxiNg9c5ZiviMYyOOKQifd0jh4gCNk1TpUtk0bLJlWpJ6s/m+GafMeEaYJ
         E9Zroziltxl+vXN96aqqAhWv6T1kfYz4lQ0RTQu4llvjvihLfpYdywLf/kcCRQfcSc9k
         2mV5BGj2zA9Pv/ZhG/5vtmmutb02nc5y/ed5w4Ie0vVP3zrH4l09UD1xKuNXjyukuE68
         L0WQ==
X-Gm-Message-State: AOAM532gsh1HriTuiIIonvIJso8otTZZrrHOF3mc3vr19DOgaCIT4aO6
        M2rgZdNiBT7z1i78lxKiKBs=
X-Google-Smtp-Source: ABdhPJzhyiiwvo2SSiFiEF0/qXF7GuGh2tYwpapsxhJcGaoaDIimLViYPpX1jf/eOTjJYQf6rwtraw==
X-Received: by 2002:a05:600c:21d1:b0:381:4fed:159a with SMTP id x17-20020a05600c21d100b003814fed159amr3057114wmj.143.1647509038800;
        Thu, 17 Mar 2022 02:23:58 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f4-20020a5d4dc4000000b001d8e67e5214sm3609644wru.48.2022.03.17.02.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 02:23:56 -0700 (PDT)
Message-ID: <e95a3743-3285-1d36-9f27-3504beaf176a@kernel.org>
Date:   Thu, 17 Mar 2022 10:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Document adt7475 pin-function
 properties
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220316234134.290492-1-chris.packham@alliedtelesis.co.nz>
 <20220316234134.290492-2-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220316234134.290492-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 00:41, Chris Packham wrote:
> The adt7473, adt7475, adt7476 and adt7490 have pins that can be used for
> different functions. Add bindings so that it is possible to describe
> what pin functions are intended by the hardware design.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
