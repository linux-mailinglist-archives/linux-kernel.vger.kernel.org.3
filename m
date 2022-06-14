Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7CA54BDFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357222AbiFNW6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357081AbiFNW54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:57:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD5506D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:57:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g186so9829129pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=WJNpSIYR/9s22Wn3d3/L4DBNmqNhP8xVuMFI6AJHT/Y=;
        b=lwCMuiUoIK0Ls70DUr0kVbSp+W0gzKoF9dcFa5NJb/2pc3EpENoWyhFk/dEs1c3R7e
         RMRaB2THWn185Olx2CGqaadbTzrg3b6fuT1YpFHUBSgNq2hnw2LeQ4NbL5vI0D/MSlis
         PRGrMxoaHsGSaM/gQNaNnR3nID92gp9k3U0j4ThTch44vIDXLoAq/uAdkiwU1cVJ2kig
         DqZ2IFPumDm3jpv+/MNHmhi/kGAr5WEX2sLBriLxyV4BO2wz7OdkAOSHcblpMfED5MIA
         yF7B2fpfoYyX8rUJZioo0KkJ/HryibZPY/X0mxAFMziPICG2tD4JLFJhImUyJvcyTaFs
         K57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=WJNpSIYR/9s22Wn3d3/L4DBNmqNhP8xVuMFI6AJHT/Y=;
        b=NoZMYr9omCrItlxmYZoPHezbAEUGKP/evQYXDvgHCoEPDDrpvxYgaIpQ59dhdze0FR
         x94k8b/27NMkI9qj05e/dAl51IZetuj2zVJNH5jANS42ggNUHYk7uyLNOFGGsRRutICG
         rR2gILSeOok3+n1CRjNnEGwNRr8mIgXOIi2SVBxWAi8ayE+RcV5DH+2m4Z/O7WREb0Iw
         IcS6cSgnp/G2hkrFegE+KG7HIboydPbDv3o0hd49L10JH9qELOQPJpk7Jq3rXOPzptnC
         HPwq/+y77p85xGlOr152XrAq4OkLz2MIGVK0kgw2dWsdt/Q9vDXgV6YwG7CDmFgFiGpw
         1gIw==
X-Gm-Message-State: AOAM532KWy7MJp7hhjRwJlerLnOyyXq/ySdWqOk/HOZfQxUbywOi2bjK
        X/0bAWiXypFCjl6ATiESlc028g==
X-Google-Smtp-Source: ABdhPJzHS9YDyRXhE9pWit2j5Gr2IScY9RTSun0Q/PCJvoAbkdw1ywdvgNQHQV72pZ7dZZbrVYc0aw==
X-Received: by 2002:a05:6a00:2918:b0:512:e4b5:60fb with SMTP id cg24-20020a056a00291800b00512e4b560fbmr6847795pfb.50.1655247471880;
        Tue, 14 Jun 2022 15:57:51 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id l13-20020a637c4d000000b003fc5fd21752sm8374673pgn.50.2022.06.14.15.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 15:57:51 -0700 (PDT)
Message-ID: <25fe27c8-7048-28ee-8c5a-ac26ed080fca@linaro.org>
Date:   Tue, 14 Jun 2022 15:57:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 net-next] dt-bindings: net: xilinx: document xilinx
 emaclite driver binding
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Katakam, Harini" <harini.katakam@amd.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <1654793615-21290-1-git-send-email-radhey.shyam.pandey@amd.com>
 <5e5580c4d3f84b9e9ae43e1e4ae43ac0a2162a75.camel@redhat.com>
 <MN0PR12MB5953590F8098E46C02943AFEB7AA9@MN0PR12MB5953.namprd12.prod.outlook.com>
 <1ae6dce1-0c5c-64f0-c6a4-b0f11a82f315@linaro.org>
In-Reply-To: <1ae6dce1-0c5c-64f0-c6a4-b0f11a82f315@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2022 15:48, Krzysztof Kozlowski wrote:
> On 14/06/2022 14:09, Pandey, Radhey Shyam wrote:
>> [AMD Official Use Only - General]
>>
>>> -----Original Message-----
>>> From: Paolo Abeni <pabeni@redhat.com>
>>> Sent: Tuesday, June 14, 2022 2:40 PM
>>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
>>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; Katakam, Harini
>>> <harini.katakam@amd.com>
>>> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
>>> Subject: Re: [PATCH v2 net-next] dt-bindings: net: xilinx: document xilinx
>>> emaclite driver binding
>>>
>>> On Thu, 2022-06-09 at 22:23 +0530, Radhey Shyam Pandey wrote:
>>>> Add basic description for the xilinx emaclite driver DT bindings.
>>>>
>>>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>>>
>>> Even if marked for 'net-next', my understanding is that should go via the
>>> device tree repo. I'm dropping from the netdev patchwork, please correct me if
>>> I'm wrong, thanks!
>>
>> I have seen a mixed set of the convention for dts patches. They are following
>> both routes i.e device tree or subsystem repos provided acked from device
>> tree maintainer.  If there is preference for device tree repo then I can drop
>> net-next from subject prefix and resend it for the dt repo.
> 
> If you got Ack from Devicetree bindings maintainer (Rob Herring or me),
> then feel free to take it via net-next. I think, it is actually
> preferred, unless this is some fix which needs to go via DT (Rob's) tree.
> 
> If you don't have these acks, then better don't take it :) unless it's
> really waiting too long on the lists. I hope it's not that case.

I got this reply in my mailbox but I cannot find at all the original
patch, which might explain why it was not acked. I found it on lore,
though. Rob had here questions but I think you resolved/answered them,
so from my side:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
