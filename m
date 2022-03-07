Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE34CFC22
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiCGK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiCGK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:58:17 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31FB2503;
        Mon,  7 Mar 2022 02:21:42 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id qx21so30740003ejb.13;
        Mon, 07 Mar 2022 02:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jf/GD3lX9xWfe/iu177slIn/V/6kDkhTlXOWIbwA4xI=;
        b=BkfmmS09cND6UkGoVvLxWKstP+P9Gsdr1UNIDlfqPEDCCIawn6KeGMquMgz+lzEaLu
         91rFAlRClrHvuIK6abzwI+Lx0iFPtZdmUXqq1oAuKqAwgZbdg3fqhFDVu94DVxlVmMIA
         6RjrE8Dp2yw4oFZMg4A650VBdb5DK755utbo3AvScEbojRBmCWgXGXH18jJIBs+5uuIl
         lDWODmuFU3dfhbHW78dAtRL7SYqfeH5wr7ulP887hxyV3ULrOvCJ6lU161brdD51RUm4
         +NwEF72dSPJNxDIQjVHkhKWDfkYNnMNXxNwV1dGK/HDGEurlYiWFW9WY2A+rFCJnqgmP
         9Rrg==
X-Gm-Message-State: AOAM533uU604D+k9x6J4kDWAtwMvr5oabkmZ92MecTVfpGTgDxEY8ENe
        uFTULGpagoPCIBHbl3otH7c=
X-Google-Smtp-Source: ABdhPJy0CNXacgt9IOOvyUBsdxj7giOFyo3spCJGHyaJ6pzoypynhQGb7uRGTCATzEXtGc6BmNdwKQ==
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id m3-20020a170906160300b006ce0362c938mr8329497ejd.253.1646648500554;
        Mon, 07 Mar 2022 02:21:40 -0800 (PST)
Received: from [192.168.0.141] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id f26-20020a50ee9a000000b004160c295356sm4204640edr.5.2022.03.07.02.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:21:40 -0800 (PST)
Message-ID: <e89aefad-4742-4e29-23d9-4beacd59aa29@kernel.org>
Date:   Mon, 7 Mar 2022 11:21:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: Document MA35D1 clock controller
 bindings
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
 <20220307091923.9909-3-ychuang3@nuvoton.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220307091923.9909-3-ychuang3@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 10:19, Jacky Huang wrote:
> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---

(...)

> 
> ________________________________
> ________________________________
>  The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.

NAK.

Best regards,
Krzysztof
