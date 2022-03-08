Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E74D1FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbiCHSGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCHSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:06:00 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D361355201
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:05:01 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A77D33F621
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646762700;
        bh=eGfr/Gi+1TNrE/Evd9NiuKAxgUTxUS7szQhSnGLVsuU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Fi8cbzVSFiPyUrOB1HnC1iIe9PxtbYedVF3hdTHeFjoMTyP85WDWWz3gRLRwZ4U6c
         JHe7wmpl/GTFeaolsPW1UIB1LA6yCfFSDL3CvpPyCK7vhvt4iQCWMIB24ayYTWCEiK
         PHE24GTCkpfdFNWDO46pS5rJZwZvSrqGDR8M2+r6bcjcq2qrL3zNk0GxzVDZM1NHvt
         PiJa9+S5OZWMMnA3cEcLmFEHHXRYEHxZ/5v5lwp/9MRhqKpD6F+/oDcfCSWPdnZLKa
         fJGaX+9cwVmqvmDU+HtAEVxR5WmJsBgx7e/zXIKggDQWIyBm780tm598X624VHegua
         3RAtaIg9Kk6xg==
Received: by mail-ed1-f71.google.com with SMTP id cf6-20020a0564020b8600b00415e9b35c81so1676284edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eGfr/Gi+1TNrE/Evd9NiuKAxgUTxUS7szQhSnGLVsuU=;
        b=casAIfIhJegd9CvWC76Hr19u+8iHQnX9eauA/cmbyxnt++GfAJMRP7RwBvum6XA0rJ
         SWXncxAg+jK99fiKsOsiA971KUOUtow6CUM+0/KIlF20ipNvq9frYDudfX5w345pc1cZ
         toD0w3QgB7Ny5FUZYZH0GsVXIZmezoiDUma8sXVrosl47egZPY6/rV6cpxxqTyWdnNWp
         Xp0PAVkOwPGT4odoruEb4BHMDbt6ugZCz6IUh+MkOZC6nS7SLN4QNBLnzflaZT20LxlI
         3qB76wWCHwbGbu3CW3NIwLLrbOMBTGEgXDn2lYHLIPhDluodJOclyf/UO8nmoQZaaGj4
         XdVg==
X-Gm-Message-State: AOAM531VWoOkdjkoaLcsGFjbPhdNw2+w8HJGKnp8rquJaOLGJs5k/Pk0
        tl3Qr/xtbgLAMFD7Lqm0jYGXxW+xf0G4UIWvEWlexzk1DjdLJFpEAggU9nnzPBALP/5nNcQTa9c
        hs/TPy/U3zw9g0np1+6PpwL3FQCh4QxMo+Paa82VMQA==
X-Received: by 2002:a17:906:b893:b0:6da:ab5e:ea34 with SMTP id hb19-20020a170906b89300b006daab5eea34mr14373919ejb.657.1646762700252;
        Tue, 08 Mar 2022 10:05:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR9N4OFXwg11cFMOkm0NAH6N8FDdi1Yzof7ATeNr8EXvzHvnUdqOqBP2nsfgHZhcV6rY0lcA==
X-Received: by 2002:a17:906:b893:b0:6da:ab5e:ea34 with SMTP id hb19-20020a170906b89300b006daab5eea34mr14373891ejb.657.1646762699994;
        Tue, 08 Mar 2022 10:04:59 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id o10-20020a056402438a00b00415bc425022sm8205522edc.33.2022.03.08.10.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:04:59 -0800 (PST)
Message-ID: <df7999e3-53ea-c3b4-45a6-1fe34b50caf0@canonical.com>
Date:   Tue, 8 Mar 2022 19:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 02/15] dt-bindings: devfreq: rk3399_dmc: Deprecate
 unused/redundant properties
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
 <20220307160918.v3.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307160918.v3.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 01:09, Brian Norris wrote:
> These DRAM configuration properties are all handled in ARM Trusted
> Firmware (and have been since the early days of this SoC), and there are
> no in-tree users of the DMC binding yet. It's better to just defer to
> firmware instead of maintaining this large list of properties.
> 
> There's also some confusion about units: many of these are specified in
> MHz, but the downstream users and driver code are treating them as Hz, I
> believe. Rather than straighten all that out, I just drop them.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
>  * Add Reviewed-by tags

Messed up commit msg.

> 
> ---
> 
> Changes in v3:
>  * Add Reviewed-by
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 42 +++++++++----------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
