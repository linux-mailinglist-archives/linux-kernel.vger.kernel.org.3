Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FFB4C12AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiBWMXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiBWMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:23:08 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5509AE4E;
        Wed, 23 Feb 2022 04:22:39 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4819F22247;
        Wed, 23 Feb 2022 13:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645618957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/v/ob3j7CFTOeneTUJXiDczC4fyDRPdARdepXg2BXQ=;
        b=jmDXKC04r4mEmRgvnMeuHII2cZJWavo/wBoupyMiLIYBUZ7L+efgGmKnkF8sGi7bKQ8RqZ
        j2j3wgRgdUqk48TlVsqWXPYUnALIGNYUAn48nQ/gj1hlFmiemFsPBIt4sjMl7mYGapWj0S
        5mWrYdsS3jnmi2kEfB7k+4N/byjDQ5E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Feb 2022 13:22:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        heiko.thiery@gmail.com
Subject: Re: [PATCH] dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
In-Reply-To: <96f7a28b-81b9-a05f-e8f5-a4fb377476fc@canonical.com>
References: <20220222151357.1710503-1-michael@walle.cc>
 <96f7a28b-81b9-a05f-e8f5-a4fb377476fc@canonical.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <e45e6fd29b5c91e1413247aa50d6d809@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-23 12:32, schrieb Krzysztof Kozlowski:
> On 22/02/2022 16:13, Michael Walle wrote:
>> Add a new compatible string for that eval board. It features an IMX8MN
>> UltraLite and has DDR3L RAM. The product part number is 8MNANOD3L-EVK.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml 
>> b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index 23e678232451..e11ffaa8721e 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -834,6 +834,7 @@ properties:
>>                - bsh,imx8mn-bsh-smm-s2     # i.MX8MN BSH SystemMaster 
>> S2
>>                - bsh,imx8mn-bsh-smm-s2pro  # i.MX8MN BSH SystemMaster 
>> S2 PRO
>>                - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
>> +              - fsl,imx8mn-ddr3l-evk      # i.MX8MN DDR3L EVK Board
> 
> Looks good, just please put it in alphabetical order, so before ddr4,
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> 
> Best regards,
> Krzysztof

Thanks, I actually forgot to put Anson on CC as he has added the
other entries. Doing that now, also adding Peng Fan. Maybe they
have an opinion on the choosen name.

-michael
