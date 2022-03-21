Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EF4E21C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbiCUIM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiCUIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:12:19 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2D4473A2;
        Mon, 21 Mar 2022 01:10:54 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id g20so16847293edw.6;
        Mon, 21 Mar 2022 01:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VR9e0iZWt0FeO56LbwGYfT7tfmrE93+bIcYs8f42zMU=;
        b=mF943hlck2JLyQClEYB3q58HKQ0Mqwi0hM3lS9sUwpT4kKOz9LGXZA2JrFdyeXsh8L
         wjJ48UcS+cAHiu9E5Xyiee7mRniALo5ug4cTW/R62wHNcH9iY57Fd1yGpnuEAt5rERTI
         zRq3LtQO/DnEJ+EhATLXbUFkxta4unfQtLETtI8Yp1Ov7o45zP5S2zRdrcZVK+2pRaDV
         csrhKh0FMQqyEdKnezxRDCizOjcbHzjrpjYRgc9n0YFkpEcS0B63jeUpmqNpw4t+fUJ/
         NEpmxgfqjzYvEazI5eUUAy2NnM1FfFy+oyr4PDBtWs/rjA2792O/VtiQ32D9tFSbsjW9
         9U5A==
X-Gm-Message-State: AOAM530SSnDLojMO/2lDf8qVzstGYhiH4xNcoEWiCeYEMttGbDovXpuI
        bdna/R9AcLInRotfq7LAKXQ=
X-Google-Smtp-Source: ABdhPJwHgX6IH7vB0Gk5yvtqOiL8MQs5vJyBbAFANw6q6SoJGAjf1/czso+3H830kxaAO5wpyYl1SQ==
X-Received: by 2002:a05:6402:1d4f:b0:416:6450:e1b4 with SMTP id dz15-20020a0564021d4f00b004166450e1b4mr21510894edb.79.1647850252705;
        Mon, 21 Mar 2022 01:10:52 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id og49-20020a1709071df100b006db0dcf673esm6688688ejc.27.2022.03.21.01.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:10:52 -0700 (PDT)
Message-ID: <3f9605e5-16e4-e982-73d6-ab116155d2d7@kernel.org>
Date:   Mon, 21 Mar 2022 09:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 1/2] dt-bindings: memory: snps,ddrc-3.80a compatible
 also need interrupts
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        manish.narani@xilinx.com, michal.simek@xilinx.com,
        dinguyen@kernel.org, bp@suse.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20220321075131.17811-1-sherry.sun@nxp.com>
 <20220321075131.17811-2-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321075131.17811-2-sherry.sun@nxp.com>
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

On 21/03/2022 08:51, Sherry Sun wrote:
> For the snps,ddrc-3.80a compatible, the interrupts property is also
> required, also order the compatibles by name (s goes before x).
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  .../bindings/memory-controllers/synopsys,ddrc-ecc.yaml      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Fixes: a9e6b3819b36 ("dt-bindings: memory: Add entry for version 3.80a")


Looks good, I will take it after merge window. Somehow I was not cc-ed
on previous memory controllers patch. :(

Best regards,
Krzysztof
