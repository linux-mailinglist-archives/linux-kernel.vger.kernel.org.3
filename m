Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BCE57F182
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiGWUry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiGWUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:47:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEAD1D0EC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:47:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b21so2006994ljk.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TAkExxjHWlLSRtDt/pw+jNl7bth5wAujirM+RilZDvA=;
        b=UAtOS7UQJTmGJhH92HmutVhYJidfYG8WfIo+1hUAv/iE1cU2cgxwtjomFKhXYVBfwd
         xVU+eRom5LryoCTXw7Yygy9oYReD+ay+q1qChObhro5+y2Ijw6Q3Swnq0aoMGjGloMAL
         JJYQE3HhaBxWQ11J9j/LTffP55DWxHAt7wqW4yeEdDD+c17NFxmb7KFHMbZe5IyA7Aoo
         OEtGU54msktq85y3Du++HbpNg2QL0y+WUtFB0LPxhF7HupVULEMb+pVZ05+rBOEJkROw
         n8vF0VYDwYEoeADoR4mHOCiSIVEvhKpAmYqzHKAGUHLooH5lh36bJxQW5CUFeHCBwSfW
         4NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TAkExxjHWlLSRtDt/pw+jNl7bth5wAujirM+RilZDvA=;
        b=ZFuMYrxfcWSEyHr1KDtBX7NPoopsW2/LUdPzumpzoZYHycgld13092SAsl++cJW+qb
         rVbnxqAzcbIBd6rHn7Hq8XBZPJ9UxeMaD0Vvq2f8YQca36AlaVsd+sPFGDYU7xvMFYEa
         BMvDwfxGJYfsW+pKYQo7mUdyIAVWszZagtI6svY82liAXqE+SxgLQDG+b/5C2h+/tG28
         e4naz09p0q2MYcV26Ayo5Rk8MVkYI47SCYhpLcI7jhBlh857ta3ODID4J2XAZX1H+nlp
         gb2YUZe4NsoNy2U7XusIz03gZRfBuAlIC2ByZ5YCNdDxZkv7bert5Za1mbSbMI7HbNDv
         ycEg==
X-Gm-Message-State: AJIora97Fhwbas1/Tf7ooZgRCfJOpHGSBdRjeHSRrymL1scPJ9wROFnZ
        CU7d5sIl+peU1E2kbxaSIPwFTQ==
X-Google-Smtp-Source: AGRyM1t8Bl7436BvuSHzBI7z7HUrAyfn0R80y3BREf/ceP2a9vJuAOPGHcKTNpDH0jBiQwKNglzAoQ==
X-Received: by 2002:a2e:97d9:0:b0:25d:bd11:3c1d with SMTP id m25-20020a2e97d9000000b0025dbd113c1dmr1882943ljj.378.1658609270070;
        Sat, 23 Jul 2022 13:47:50 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id t17-20020a056512209100b00489c639f3dasm1831556lfr.22.2022.07.23.13.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 13:47:49 -0700 (PDT)
Message-ID: <5c9f12ce-2ac4-4487-4ca5-edfafe0a089d@linaro.org>
Date:   Sat, 23 Jul 2022 22:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 4/8] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
 <20220722125730.3428017-5-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722125730.3428017-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 14:57, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
> the i.MX8MM VPU blk ctrl yaml file. And add description for the items.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
