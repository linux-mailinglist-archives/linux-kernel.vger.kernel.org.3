Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938E3554D85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358744AbiFVOg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358734AbiFVOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:36:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA19C3CA48;
        Wed, 22 Jun 2022 07:36:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p5so10380845pjt.2;
        Wed, 22 Jun 2022 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QPTQnnGMAlX9DR/Wnzz/rHtvgybIf6uKNn+Efoudg+A=;
        b=hfCoQxsSr1AiUPED+rApz5o3D8pO/hGhEKqz4/3wZPQix+70o879IgeDEGHilYZGL6
         HWj1U9BXuM0FK3F/sYqVWRloIUHVtXKz1DdaEaM1rATOLyK0uFm7qEi/C56CZiQoZf8j
         jWG3lft0SgAJuAM4sqOQIBEVsj8A2HEokzEWTLARyhki2+zb/w3ccxPGPBwv+OeFHbDI
         A8XkpMuMz2cJpWJdNxTzZfbI+1gG6vqpS5lTh6Ur4kuznKKm8pMpUoB2YjH30Aa193Zo
         MiRrndHiDJz/C29k6Q/pt/pJrS3J2rGFNbg+jsKPQc/y1Hp98+iCv2psxMTWsQvBboCF
         d/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QPTQnnGMAlX9DR/Wnzz/rHtvgybIf6uKNn+Efoudg+A=;
        b=H+vssoRVmpAKqA+INo9F7irndXWCYANdojnICpclu3nCNDWe4Wi80GztehxxRJ9BX4
         S9s0GgUwjtW5z9zRImTks4J3Zw/clW+WKoe5NZCclftUQjATs9yVfp/EFh3vQUkj9Cas
         iSDjcPj2Ppn8VbiWxh0OIH1gtcEe2ReraIbILSF809fuF+MR6uWcUWzMG6nDbeNUH+Y0
         8Jf/ljP2kPMx44U2K1a91L7BUBzCNFXOWAqL+r1RZicS75SnRVo0AKRDcha48VogV5sZ
         s+P6GYxUMcUFCJ4lO7Pu8+P5nW/xKJLABHx/t+dm2hIkzHnKCgeMpif685DsFZanlDCw
         ldyA==
X-Gm-Message-State: AJIora+ph7rRLuz8uDLQapGffqq7EOvcJYRFO1YXIXx9xt+HpaSOx0Nz
        Tcu62efZxKc+qQT7S5yDqo0X0cQyc8I=
X-Google-Smtp-Source: AGRyM1uLC611EYbwN9PQLKue9M+LWR2/yK9A7/CK60EWV+8yg7Fw2xjQsRI0T++TJXXz0BWWXwB1EQ==
X-Received: by 2002:a17:90b:33c8:b0:1ea:c199:9794 with SMTP id lk8-20020a17090b33c800b001eac1999794mr4104778pjb.224.1655908613363;
        Wed, 22 Jun 2022 07:36:53 -0700 (PDT)
Received: from [192.168.1.24] (1-162-200-193.dynamic-ip.hinet.net. [1.162.200.193])
        by smtp.gmail.com with ESMTPSA id x15-20020a63b34f000000b0040d027e1f0fsm3232444pgt.25.2022.06.22.07.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:36:52 -0700 (PDT)
Message-ID: <eda3f331-6df4-c4d3-33e5-a872fecd6024@gmail.com>
Date:   Wed, 22 Jun 2022 22:36:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] Update Facebook Bletchley BMC DTS
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
 <Yqdr1ZS6d71QeACd@heinlein.stwcx.org.github.beta.tailscale.net>
From:   Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <Yqdr1ZS6d71QeACd@heinlein.stwcx.org.github.beta.tailscale.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Patrick Williams 於 6/14/2022 12:54 AM 寫道:
> On Mon, Jun 13, 2022 at 05:51:46PM +0800, Potin Lai wrote:
>> Update below items for Facebook Bletchley BMC devicetree.
>>
>> Potin Lai (4):
>>   ARM: dts: aspeed: bletchley: change LED sys_log_id to active low
>>   ARM: dts: aspeed: bletchley: disable GPIOV2 pull-down
>>   ARM: dts: aspeed: bletchley: bind presence-sledX pins via gpio-keys
>>   ARM: dts: aspeed: bletchley: update fusb302 nodes
>>
>>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 197 +++++++++++++-----
>>  1 file changed, 148 insertions(+), 49 deletions(-)
Hi Joel,
Could you help me review this patch series?
Could you also backport this to linux-aspeed 5.15 if everything looks good to you?
Thank you.

Potin
> The whole patch set looks good to me as the closest domain expert to the
> Bletchley system after Potin.
>
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
>
