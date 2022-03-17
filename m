Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E64DC9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiCQPRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiCQPRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:17:46 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE513366E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:16:29 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B37A3F07E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647530187;
        bh=SfVY8hBTeV5QQndiPv96NqW12VeOymyYrpsKvO+Iim4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=nyp9m520tu0JhUVFk5oJVlHF6ogfckkScCnsfT3NVe2NaZYctJZ75OTHEdLKS4jo5
         WHGs4vOBMnkBigMIwZWje3zZq2eK90aX/lhE2SRi2Laen/oEFS26+SsO6nFMQ4DpjZ
         O68w3QzXsskNgVpirh3DxQh4p+cY8pza4CTwNAn9vl+oWn6JOUZL+vTw18PEIGfKEW
         3E9I28RbO8E4WkTn9vxPn6CdNCB/o8s6NVO7W4H/OfAlwS3Snn7hLW+cg/kVybBzGi
         s2tYNN86Nrchl+0/sWo9GKTv0GvBhmCuZifS7aach/CkvnCXMFIr/3FVF+6LUm6c0H
         RvAi3F7g9fLRQ==
Received: by mail-wm1-f72.google.com with SMTP id h127-20020a1c2185000000b0038c6f7e22a4so2409791wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SfVY8hBTeV5QQndiPv96NqW12VeOymyYrpsKvO+Iim4=;
        b=AkEaApprNlSVW7K41bb1fzN9YHBPIplSNTSEUug7rLyk1N8S3710OyfAYPXjrEGl9U
         3PCubHUDwRAGexetMFtiXHuLdnig8W5j0DQJlrnP5lDKwctAZ0snRvlH/W8PtEJ7nR7X
         g4qCfs4+5g0C2pSp52f4bddBSuG382csZNzkui9jUYYKJr3pGIATc/Vy/E+YkEBDKYvc
         3IsbCZINLgidez7hELyvDiUgzaAlxsMXhvAUgYMmbfWk/qzPw6cOb1IZbhBWrpOJ0MOa
         2Yhq2/hHQrjbWJXKRDPW3I5FLbvWjAOyhG8FMCYDcQJD4wFLS+sKjd8wGtI/cyKB+frh
         lj4w==
X-Gm-Message-State: AOAM531fn8sLsbKL4lAbjWzIeH13oYyvKnjiPjjOOLd3Jc2g4xjLZTjM
        f2Ab9JgMqEL+QcFPrFyZ6CWoEGQg3XSjY1eyGgA3ZcV7vZNfmjVUOwCvlA5h3ItU4imUN1U0gCg
        D12930XANXjsUsx4Odc7dk/1bBXGwtnBMltQNQ1LI7Q==
X-Received: by 2002:a05:600c:42d6:b0:389:868e:8638 with SMTP id j22-20020a05600c42d600b00389868e8638mr12466706wme.178.1647530186996;
        Thu, 17 Mar 2022 08:16:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzh994ZACGJIGGTR33UaTb+Ql5s8q357d3PN1fjyohVWd1lsnaDb3M6I5RQtPefhwooPdvAg==
X-Received: by 2002:a05:600c:42d6:b0:389:868e:8638 with SMTP id j22-20020a05600c42d600b00389868e8638mr12466692wme.178.1647530186807;
        Thu, 17 Mar 2022 08:16:26 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id r12-20020a5d6c6c000000b00203ec2b1255sm1820380wrz.60.2022.03.17.08.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 08:16:26 -0700 (PDT)
Message-ID: <9143a2b5-8d53-9767-ea3c-d2b3555333f2@canonical.com>
Date:   Thu, 17 Mar 2022 16:16:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/8] dt-bindings: pinctrl: mvebu: Document bindings for
 AC5
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-2-chris.packham@alliedtelesis.co.nz>
 <4e6df448-5562-8f50-6f46-91acb279bc1a@canonical.com>
 <7e73bba0-8b54-772c-2e94-8fca4e4e3294@alliedtelesis.co.nz>
 <cb0af80e-3e5a-fbd9-cd8b-7b252ebe33fe@canonical.com>
 <6d902e7d-b71f-9dcd-9175-cc706e3d60cc@alliedtelesis.co.nz>
 <4b1f4772-35f9-3e21-6429-b64c7427144a@canonical.com>
 <YjNCSENOP8EyWArw@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YjNCSENOP8EyWArw@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 15:14, Andrew Lunn wrote:
>> What do you mean "driver fails to load"? You control the driver, don't
>> you?
> 
> It is a thin wrapper around the mvebu driver, which does all the real
> work. So no, Chris does not really control what the core of the driver
> does.

This this design still require a pinctrl to be a child of some node?

> 
> The existing binding documentation says:
> 
>     * Marvell Armada 37xx SoC pin and gpio controller
> 
>     Each Armada 37xx SoC come with two pin and gpio controller one for
>     the south bridge and the other for the north bridge.
> 
>     Inside this set of register the gpio latch allows exposing some
>     configuration of the SoC and especially the clock frequency of the
>     xtal. Hence, this node is a represent as syscon allowing sharing
>     the register between multiple hardware block.
> 
> 
> So the syscon is there to allow the clock driver to share the register
> space.


This makes sense. Solution here would be to add syscon compatible to
pinctrl node. This parent simple-mfd+syscon node looks like a workaround
to share some registers in a highly flexible way. However isn't it
better to have more obvious owner of the register space (e.g. pinctrl)?
IOW, if there is only one child of syscon+simple-mfd node, why not
getting rid of it and making pinctrl owner of this address space? It's
also simpler code.


Best regards,
Krzysztof
