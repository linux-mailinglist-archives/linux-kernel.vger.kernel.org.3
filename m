Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7461F52A512
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349112AbiEQOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiEQOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:38:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A438DBD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:38:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m23so22048101ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=adr1JHVYZ1Sl6/EAXezCq4S8vGxWaNlDrui9XdLoHMw=;
        b=Q+YjFqOPjrvGujz8ipPpbE5e54u9p4f8wgh0+tu2M+62yxjtWF5TghHM/ES091X7f1
         O9tcf1c4gKh8eiMZ2uAJLQFSk3shO45j+fcz1psirzoVXZL1cC8ahLCMt9WigtaZMs9V
         eGFaPnafmVY5uKjVFEODiC8JiHLf4me5Q3fk3aywfAI1fFB/yfbCe8LGwzZsjdKawqNX
         6LDYvLn8Mz3sYGvMPsiUhtN2deUXk6Hwlc47vwdgH7vhe7fT77XhbMYsXQ5l42UbSQID
         yQJ5/XQyA8dMcCzh+gZriXJ2kX4K463YmeJrUaNhn9xkY81qEuZg5p9T52vGw6/3V8mp
         7VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=adr1JHVYZ1Sl6/EAXezCq4S8vGxWaNlDrui9XdLoHMw=;
        b=yqQEP2Q8VB0HFcBLhyMUsaZPak40Xsa0n1BU4/7X7LITG0UzsuHoBmCwP9ImmQ0K9h
         febXe+RTV5XMYi5WWUHyrBwqN9FCW14cM/WUszScgSkG14UryGfYBuaYFrh+UCo0qsTm
         90kgOq4MVaKVJZBlRjUsBT/Qe+XFUEQQ+/ZF1yZo12RWqNoIoSLUHftVB/G/1gxU6dPS
         3jVI7Yp76EzMmUXmzr2J2gtIdTHO7PwIno3aPM/U+9siFUHWggjcJb5M970WoEfTi3ky
         YqwJZqPu2b6irKibFIA4NV+GgUyImurg+DFMODe3heilhRJa6MoBmASN0M+QjSylVaRB
         jE0Q==
X-Gm-Message-State: AOAM5323MhTz2BRvxcVsKhJsAXDdUzxb40jHTKl7ZPg0XZ1Rhvw6tTTj
        1hvvDOinOVi9B8zQr2+ryztQlw==
X-Google-Smtp-Source: ABdhPJxLZV9G+/vbOKBuCv8p/snaDneIY3rE5qJYKhOrA7N4rHO5NtVGN7RuqQOYFUK6y8s53JV6Ng==
X-Received: by 2002:a2e:9019:0:b0:250:8205:dfb4 with SMTP id h25-20020a2e9019000000b002508205dfb4mr14152916ljg.396.1652798329316;
        Tue, 17 May 2022 07:38:49 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i2-20020a2e5402000000b0024f3d1dae91sm1887687ljb.25.2022.05.17.07.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:38:48 -0700 (PDT)
Message-ID: <03c0e4fa-ccfb-fd86-0899-92a1086cac09@linaro.org>
Date:   Tue, 17 May 2022 16:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517121423.8017-1-j-keerthy@ti.com>
 <20220517121423.8017-2-j-keerthy@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517121423.8017-2-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 14:14, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 J72XX supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

It seems I am repeating myself... Tags are still missing...

> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    wkup_vtm0: thermal-sensor@42040000 {
> +        compatible = "ti,j721e-vtm";
> +        reg = <0x42040000 0x350>,
> +            <0x42050000 0x350>,
> +            <0x43000300 0x10>;

Please align the continued entries with opening <.

> +        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    mpu_thermal: mpu-thermal {
> +        polling-delay-passive = <250>; /* milliseconds */
> +        polling-delay = <500>; /* milliseconds */
> +        thermal-sensors = <&wkup_vtm0 0>;
> +
> +        trips {
> +                mpu_crit: mpu-crit {

You still have here incorrect/inconsistent indentation. Entire DTS
example goes usually with 4 spaces.

> +                        temperature = <125000>; /* milliCelsius */
> +                        hysteresis = <2000>; /* milliCelsius */
> +                        type = "critical";
> +                };
> +        };
> +    };
> +...


Best regards,
Krzysztof
