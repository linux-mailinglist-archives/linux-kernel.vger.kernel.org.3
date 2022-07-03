Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C2E56479E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiGCN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiGCNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:55:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AE92AC4;
        Sun,  3 Jul 2022 06:55:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g7so1967055pfb.10;
        Sun, 03 Jul 2022 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GhTF+nRQIcV9gsjYBeN6guR0acy2VBXoBQhRoxTOx7M=;
        b=GhHWrBpBExdLhV0vrS27nNC4Nc7fTg98y7uqU4ehoaHkXPerzzdoD7QtfLW7Vk4ozW
         ZXAiwfW/ZBaqZaL1EpCFLbNa7604XqWgmgXUqIR3OU+QbnIDgRRnKqfML51d//IHSTsM
         a3IQUvNVnCPPqnRu/vOGm6sOPzer+N6F2Al9R9c3Rxd0/K+GT09Qlk5p/H9rOf34ATNr
         1aPk9VOZYRgo6dxh9vGhrYWgo1PsEe5VRew51OYUa7aHiJ05mCJcAt/49jV3qNJ93Dxs
         U9K4xdBZq9zDPT1L+P1gMhWu/Ifw0zUZbmO9cBOq99ConrkiYljc3l2ptU3zdUQIz02h
         OHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GhTF+nRQIcV9gsjYBeN6guR0acy2VBXoBQhRoxTOx7M=;
        b=WJeSeg1+2f/gUGxIT5Jd+u3ErnTWWivEhERYCcVm3bjL/RL92WXBQLnjCwf2qI5dRW
         qd2A+JKg4RUHLjTZ66zGPLnHF6iqeCZ2Lr66BvZ2zb2B0mLDVnw3ShZLcG6AjE0ZrTKV
         EifpB5qbR9kX1WWMvI6VFaqrl+BNenbl1/Zwi9EkV5fEpWiZr23bsALyGSzwqwqHI5Cf
         E4zFN0RE4aACgriUhjx8IcVOzaPID4aEO4cHGF/G8ax6wXjXfYWindd+sWIUgWp90QS6
         ULXwLKtwBk2e7rpJb1i6LFuSTEG3O7lZl+8MR1NVviOo7/W7KLazCcCIjWdy2Hb78T5T
         eWzw==
X-Gm-Message-State: AJIora/cDVBf1mO5k0AXWr2Pgm5WYJD2BizQ50L9diejDhK2h/0MLNr2
        jyud1nkuCetop2sg09zuiBU=
X-Google-Smtp-Source: AGRyM1vUkO/5aK0OinzEDH7Jhq+Yt/1wowhTRMS+xhfrjlAbcLF4PE2abQ3gwttZ9VChGDmABFlCbg==
X-Received: by 2002:a63:3713:0:b0:40c:b98c:5e4b with SMTP id e19-20020a633713000000b0040cb98c5e4bmr20698478pga.8.1656856558312;
        Sun, 03 Jul 2022 06:55:58 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ea8600b0016a18ee30b5sm19055746plb.293.2022.07.03.06.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 06:55:57 -0700 (PDT)
Message-ID: <2d912f49-f9bd-2020-a7ce-faca0a2b11a3@gmail.com>
Date:   Sun, 3 Jul 2022 22:55:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 01/10] dt-bindings: interconnect: imx8m: Add bindings
 for imx8mp noc
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
 <20220703091132.1412063-2-peng.fan@oss.nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220703091132.1412063-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 7. 3. 18:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP features same NoC/NIC as i.MX8MM/N/Q, and use two compatible
> strings.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> index b8204ed22dd5..09c8948b5e25 100644
> --- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> @@ -26,14 +26,16 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - fsl,imx8mn-nic
>                - fsl,imx8mm-nic
> +              - fsl,imx8mn-nic
> +              - fsl,imx8mp-nic
>                - fsl,imx8mq-nic
>            - const: fsl,imx8m-nic
>        - items:
>            - enum:
> -              - fsl,imx8mn-noc
>                - fsl,imx8mm-noc
> +              - fsl,imx8mn-noc
> +              - fsl,imx8mp-noc
>                - fsl,imx8mq-noc
>            - const: fsl,imx8m-noc
>        - const: fsl,imx8m-nic

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
