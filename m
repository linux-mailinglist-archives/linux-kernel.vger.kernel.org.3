Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C995B20A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiIHOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiIHOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:36:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDBCA50DC;
        Thu,  8 Sep 2022 07:35:59 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F064E6601F95;
        Thu,  8 Sep 2022 15:35:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662647757;
        bh=yxWthJQQFVyrsOLPbde9GuvBF4vIyWDhHqgg0BlNRAk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NtBdI5kJn9GypI1bNaHxCRe/R2YNffP8X2c0sCP9yx+FWWt/ukEaWS7En7VQA6dC8
         fza9h27A/mPIRJzU57eYPSITn/593dRZEzUH8qFW0sUjGLkDJE1iTWjbxvX77SSYen
         /U+4CUqzswlEi/nh0I29vdHaxdpxjR8JFA5jSFYBKY9fHE1YtqevvgzsISxOVPv221
         /+f7peI9RWaC8/XZ42sa6HSUntdlQEIgO299oe7t3bg9uyAv24tgStoM+B6MFiDEdS
         TDh94n0TEjjlTSrpyEDGXRW9S++Hda8k7uNk3vd/+Jcoml5KOccyVNlRC8StsARvZ2
         Btkbwm1r+gM2Q==
Message-ID: <958a72a9-9594-32d2-3a90-780cef92109e@collabora.com>
Date:   Thu, 8 Sep 2022 17:35:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/3] riscv: dts: starfive: Add common DT for JH7100
 based boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220902100806.2378543-1-cristian.ciocaltea@collabora.com>
 <20220902100806.2378543-3-cristian.ciocaltea@collabora.com>
 <8528d39e-c03a-7d83-d8e7-5191d3110015@linaro.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <8528d39e-c03a-7d83-d8e7-5191d3110015@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 14:33, Krzysztof Kozlowski wrote:
> On 02/09/2022 12:08, Cristian Ciocaltea wrote:
>> In preparation for adding initial device tree support for the StarFive
>> VisionFive board, which is similar with BeagleV Starlight, move most
>> of the content from jh7100-beaglev-starlight.dts to a new file, to be
>> shared between the two boards.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Use proper arguments to git format-patch, so that the copy is properly
> detected.

Right, handled this in v3:

https://lore.kernel.org/all/20220908142914.359777-1-cristian.ciocaltea@collabora.com/

Thanks for reviewing,
Cristian

> Best regards,
> Krzysztof
