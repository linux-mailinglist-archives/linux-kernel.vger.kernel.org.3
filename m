Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580B24BEC2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiBUVCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:02:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiBUVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:02:11 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A2DDA5;
        Mon, 21 Feb 2022 13:01:47 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id qk11so36386581ejb.2;
        Mon, 21 Feb 2022 13:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2974eKi5BdNp35gKs82/fhm6RumNbC6dF3NV48ttMrc=;
        b=1eqzCAudxjM9+/gdX6Jkrrb47saHKR/G8cMmnpDSSGRsltcbboNsnFGFNubNEHqI9x
         SyC902PaTUis3Vg2RQ0b7JKkYKoyiG/HL4WJwcon8g/P51E6immNKDB24ieBC3D7vo99
         BWbW3oFOmwKG/G1AX/qYNCgbZViQ2gX0J3H4ImiwoVfXhIbY2jEK3kRBcZI7QLmk0xt0
         87sPrgC/Bo69ztbKoSRvou4672H2gopBSXnkELT2AJPA/MpCZ6Z/fwL/9hNpkHch+sj/
         0pl++ZaPy/eZI/F0cAZ38/pGzsCehVNO2fHL38+d0ow8rCX14rbta75v5cFreS2fl69o
         a4wQ==
X-Gm-Message-State: AOAM531JrT61ywkzyNBn085gjyS6fq/lPJt4/S+Mz4PLIMK8Jk1bJN5H
        4x9N231HhYvrDthBHxdeBHsl3KIqrf4=
X-Google-Smtp-Source: ABdhPJzztwOaZSVTcKC2G5n99pioUT5+4mVtbjxwfaAkvFPqFPoLnSzgiO6qRNho1HaBDipNXAVWwA==
X-Received: by 2002:a17:906:3588:b0:6a7:7ac1:cac8 with SMTP id o8-20020a170906358800b006a77ac1cac8mr16443120ejb.342.1645477305493;
        Mon, 21 Feb 2022 13:01:45 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id m7sm4115951eds.104.2022.02.21.13.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 13:01:44 -0800 (PST)
Message-ID: <2546477f-4190-e838-3095-f47b31802445@kernel.org>
Date:   Mon, 21 Feb 2022 22:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <cover.1645460043.git.oleksii_moisieiev@epam.com>
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

On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> Introducing new parameter called scmi_devid to the device-tree bindings.
> This parameter should be set for the device nodes, which has
> clocks/power-domains/resets working through SCMI.
> Given parameter should set the device_id, needed to set device
> permissions in the Firmware. This feature will be extremely useful for
> the virtualized systems, which has more that one Guests running on the
> system at the same time or for the syestems, which require several
> agents with different permissions. Trusted agent will use scmi_devid to
> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> for details).
> Agents concept is described in Section 4.2.1 [0].
> 
> scmi_devid in Device-tree node example:
> usb@e6590000
> {
>     scmi_devid = <19>;
>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
>     power-domains = <&scmi_power 0>;
> };

And how do you prevent DT overlay adding such devid to any other node
thus allowing any other device to send requests with given devid?

Plus few technicalities:
1. Hyphen, not underscore in property name, so scmi-devid.
2. Your schema does is not selected by anything. How is it intended to
be used? Nothing is including it, either...

Best regards,
Krzysztof
