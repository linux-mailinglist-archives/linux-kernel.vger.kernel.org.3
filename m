Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250F44E78AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355420AbiCYQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiCYQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:10:20 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89571C93D;
        Fri, 25 Mar 2022 09:08:45 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id lr4so7879766ejb.11;
        Fri, 25 Mar 2022 09:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E8h9Vcx1r3+TYbLDyB3dNi5M3emlCFoMC1PIDWwowIg=;
        b=Z9h1VSD/jdPTSAKaHZ6bWwpPJJyE8444MImDckwj56OUMCIwepMBXz72xLtDADmxj6
         MS2416KOJMsIHTCkGGyGapxkdUlHU+Lb1aVu08kGgCw2sH1kvRbV8SrZ38NaSphrWyZQ
         lTN3oGl0IhiMiVYKZZthGZdWeIqiMNXIUCDJLky99hH6yvNpEOGE8otsoGgnPaz1kkDT
         5MdcRmGdk4MwiE4W2H35zG1wlKeVxFDa3As1L/6AurtsEr1BfA59hSbTWVpJXbt51h5C
         uZCqJuEAFGPi9MTLCu1eFHA2Tyqqhd4Qx/HZb/yxRus5T6lv3HWT3piud7/ERa8nHs9U
         LO/Q==
X-Gm-Message-State: AOAM532HbT75hM9CrFMBE22nBttGQvGUnQn+FJlNxdOi4pjcN2484f7z
        wrmiSTtWDhqyC/G0Cxn/CRlBnwhdIvY=
X-Google-Smtp-Source: ABdhPJySZU8DrN3ybcQC7IsQJ9q4cgJMasOskvk6TqCIczzHHuDx8NCUQ69DvxGKH8kg7GC8JsxqpQ==
X-Received: by 2002:a17:907:6e04:b0:6e0:736b:d786 with SMTP id sd4-20020a1709076e0400b006e0736bd786mr11914606ejc.667.1648224524085;
        Fri, 25 Mar 2022 09:08:44 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id c12-20020a05640227cc00b004192114e521sm3125418ede.60.2022.03.25.09.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:08:43 -0700 (PDT)
Message-ID: <d2f220ae-c62c-a7f7-23cc-c33956c2eeaf@kernel.org>
Date:   Fri, 25 Mar 2022 17:08:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <u0084500@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com>
 <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
 <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org>
 <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
 <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org>
 <Yj3oXuijuZY1gG9X@sirena.org.uk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Yj3oXuijuZY1gG9X@sirena.org.uk>
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

On 25/03/2022 17:05, Mark Brown wrote:
> On Fri, Mar 25, 2022 at 04:55:25PM +0100, Krzysztof Kozlowski wrote:
> 
>> You mention board, some of_device_get_match_data() so you talk about
>> runtime. maybe_unused is not about runtime. It is about build time.
> 
>> The code you sent cannot have this structure unused. If you think
>> otherwise, please provide argument, but not about runtime (again). You
>> can for example build it without OF and see...
> 
> If you use of_match_ptr() in the struct device (which is good practice,
> didn't check if this driver does it) then that causes the ID table to be
> unreferenced as of_match_ptr() compiles to NULL when !OF.

Yep, then the case is obvious, but the driver does not use it.

+static struct i2c_driver rt5759_driver = {
+	.driver = {
+		.name = "rt5759",
+		.of_match_table = rt5759_device_table,

Therefore the of_device_id cannot be unused, so __maybe_unused is not
correct. This can be fixed in two different ways, which we did not
discuss yet...

Best regards,
Krzysztof
