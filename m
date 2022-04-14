Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D885006F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiDNHf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiDNHfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:35:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E9056204
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:32:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so8357029ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rkD4Wf92TMGep0/30NQKr7VRz7II9sGrZbor54Q/xRk=;
        b=iN9ypiMERw5LppW8cGKW2C4wiIosRgrFUgiAzntqy98BwV3KiLvz8YHWdXEPfbAWR0
         T2zV42oKntNo1RlRC+y9adviLE60XYLhRW4vd62wUizmPmRT7P/qj0+nDUejLIm3xvpB
         GWtD+janBmy2XM0vMj5SVD598QN1RbL8sv3536IoiomAjFkNn3U0z2sq3xYBtbllse3M
         qcyTVxGdH7hGJq99xeA4TH0oUmPoeWWmJ3vZKoK2bhpHn/XyCv15Lx3IS2HWFD4HX2kP
         k7gZSHoas+NooDlufDv95yksWuL3Nv5Nn4TE+W+WdHoDLQUSGIyd3s+6C/NaKPrIzKFK
         VoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rkD4Wf92TMGep0/30NQKr7VRz7II9sGrZbor54Q/xRk=;
        b=aQ3xR6x5/ij2s5qqcqBECoqY/l8RNpzB+CTg/p9h46zgzAMBUqlk1Xtb9TJHMCVUUh
         RW56jlufujIU3hIeHPgY1qxg5rWNXRKn7uj0+RW56jR/PcW9muziV/3vmWak44w/X2LF
         vBpK4Y2M5w8y9dHwh33/SjEp6HZRlmQoOaDip3QrNwCkxmASckz8C7yAPoiIozxHOIWb
         58tMX5pUQH9J7lFWhEM55yvKMJXBNZSCJvp8w0Q6jgCbv/1frFh0OmUxF9NAGmFUo0Lk
         6dxHwf737AS2DvmG10g2wD42o9SslMmG+ntr/LdD4uWPi0J8XrqYGpC87DKviPkYobTB
         /ckQ==
X-Gm-Message-State: AOAM533jKvlKPTceaCreC+8lOQeCRH7VSLAJgytqVGPjgziN9HU7cCSb
        xWm+r6bEXaKJfCBcNVJ5M4BZyw==
X-Google-Smtp-Source: ABdhPJyIhl5iB1oiTjY3Q/tXc13WAFkiAsoQlqVDVD1KjollmUpxx3kXZwJP7vY5xYASFKFZXckXwg==
X-Received: by 2002:a17:907:a427:b0:6db:572b:df24 with SMTP id sg39-20020a170907a42700b006db572bdf24mr1233433ejc.193.1649921577860;
        Thu, 14 Apr 2022 00:32:57 -0700 (PDT)
Received: from [192.168.0.209] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709061d0500b006e87591ca21sm364707ejh.192.2022.04.14.00.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:32:57 -0700 (PDT)
Message-ID: <76ea346b-0645-97b5-f8fb-5b46b4bcc80b@linaro.org>
Date:   Thu, 14 Apr 2022 09:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hminas@synopsys.com, Rob Herring <robh+dt@kernel.org>,
        linux-usb@vger.kernel.org, linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, dragancecavac@yahoo.com,
        dongsheng.qiu@ingenic.com, qipengzhen <aric.pzqi@ingenic.com>,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1649788201-87620-2-git-send-email-zhouyanjie@wanyeetech.com>
 <6F03670F-9040-4560-AD78-CC7A03EC678F@goldelico.com>
 <c79a8ff7-7a3f-9627-f910-dbbf942e34cb@wanyeetech.com>
 <0AE74BF9-46F1-44EC-8E5F-40EA12851AD0@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0AE74BF9-46F1-44EC-8E5F-40EA12851AD0@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 21:30, H. Nikolaus Schaller wrote:
> So we need "snps,dwc2" to get any driver match and I thought the "ingenic,jz4780-otg" is redundant.
> 
> But maintainers convinced me to keep it as a dummy compatible in the .dtsi for potential future
> specialization (which does not exist and seems not to be necessary). 

Isn't exactly the next patch 2/2 using such specialization?

> Unless I can convince them 
> that this is never ever needed. Which is beyond my knowledge and almost everyone.
> 
> So we can't remove the "snps,dwc2" here.
> 
> Well, we can with more work elsewhere.
> You have to extend the dwc2_of_match_table to include all ingenic devices.
> 
> Therefore we now know 3 potential solutions:
> a) remove "ingenic,jz4780-otg" from jz4780.dtsi (my proposal)
> b) add "ingenic,jz4780-otg" to dwc2.yaml together with "snps,dwc2" (your proposal + my suggestion here)
> c) add only "ingenic,jz4780-otg" to dwc2.yaml and extend the match table in drivers//usb/dwc2/params.c (new proposals)
> 
> From consistency point of view I think variant b) is the right one. a) was rejected and c) only adds redundant code.

c) was already proposed by Zhou, so if you think the code is not correct
(the params for jz4780) maybe nack it there, so we will know that driver
needs fixes.

Best regards,
Krzysztof
