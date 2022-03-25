Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99D64E6EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353378AbiCYHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353861AbiCYHdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:33:02 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C7C4E16;
        Fri, 25 Mar 2022 00:31:28 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so8466990wmb.4;
        Fri, 25 Mar 2022 00:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GuILc5kRDriiMUiIXV7yGyzOLFCBv5MwLQdIg/dr7Gg=;
        b=2MwnyaHIDCeOMjlyuMw16yPfLLAiMAkijo9erxkIgOLDmoQso8QIpt4W29MN6HH4aN
         HHwAZYkbNQVVYhjAbnWIDfRTjr4Nj3ZBLbgdHwVLmOveclYAVgj5xYaOoCUtEK2xwqtj
         LknRocmXioSGWxQuMUZ0VjF4IRW8e+LzwDtLiBvLOPAXLpApjFRto4LsUc9ydN7wDue2
         R+cwCdTW6plVHnr3SGvyWtqkvZnyEfNTish0zHeDZSxJ/t2BuGssK4DTBrgDPVrcSAbX
         m4yhNEC7jUNIOCUawlP0tPBICJmFTh3l8/DXSAs7uvAYpedvst0fZRcptIbauwuBUtLE
         +HRg==
X-Gm-Message-State: AOAM533+xmho4XDp4AnucDNHcUIm7vwMomv1SSvv3izFohKuKZbJHJ+e
        rtgPfayOGg1r/uuxkIygesw=
X-Google-Smtp-Source: ABdhPJxX9+mei/tkczYkXDnJ8Ea8iol1WorIaCdEFNkBNxZcDCKU/ZfZR2wP0DOrgOPfGrPat8W3eA==
X-Received: by 2002:a05:600c:3b86:b0:38c:afdf:66cd with SMTP id n6-20020a05600c3b8600b0038cafdf66cdmr17701222wms.198.1648193487331;
        Fri, 25 Mar 2022 00:31:27 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm5199505wrs.73.2022.03.25.00.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 00:31:26 -0700 (PDT)
Message-ID: <bf438af8-5969-73e4-009d-cb7d93095a5e@kernel.org>
Date:   Fri, 25 Mar 2022 08:31:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3188-cru.txt to
 YAML
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220324133229.24035-1-jbx6244@gmail.com>
 <f7493d93-6c8a-efa9-1f2c-a0003a6d43b2@kernel.org>
 <bf62ad40-6bcf-62ae-f56a-cdc8d17456ec@gmail.com>
 <20220325005130.C45A3C340EC@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325005130.C45A3C340EC@smtp.kernel.org>
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

On 25/03/2022 01:51, Stephen Boyd wrote:
> Quoting Johan Jonker (2022-03-24 12:51:36)
>> Hi Heiko, Krzysztof,
>>
>> Question for the Rockchip clock maintainer:
>> What clock should be used here and other SoCs with several clock parents
>> in the tree?
>>
>> The clock.yaml produces a lot off notifications like:
>>
>> /arch/arm/boot/dts/rk3036-evb.dtb: clock-controller@20000000: 'clocks'
>> is a dependency of 'assigned-clocks'
> 
> 'clocks' is not a dependency of 'assigned-clocks'. The dt-schema should
> be fixed to remove that requirement.

If the driver does not have any clock inputs ("clocks" property), why
does it care about some clock frequencies and parents?

The clocks is the logical dependency of assigned-clocks, because
otherwise hardware description is not complete.

What should be here for Rockhip? We had similar cases like this for many
drivers, I was fixing some of Exynos as well. In my case usually the
root/external clock was missing, so I supplied is as input clock to the
clock controller.


Best regards,
Krzysztof
