Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4683B554C39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357975AbiFVOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357922AbiFVOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:08:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65B29C8F;
        Wed, 22 Jun 2022 07:08:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so9308614wmn.4;
        Wed, 22 Jun 2022 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZeIhb3fqnfUnJd59yfyLJJmoBp7Kjl/67o9t6auf+NQ=;
        b=bg1rYK3aOnpstgV5X8JCVaDxfceJZZ+RnGbdMAR3z0JOQaj8FAvyLlvsXswGx4zP2f
         +pwmfDO1TCJP9j1hgOBk3MKDRWQidXRKiOsmPR9To+Lplruhu6v/Ic07mVynXLabvHdH
         oR5ypF0BUqVcSQ2L3Yjdy8y02iYsYrxPGwmo1ruYebDXAKzlKFhx5p2ECB+PFTjjac+Q
         Z1iPJJeIsX84zpy21pYvTcI2BIj8zML4PVMwdyL7oP91c1wjx3HFibDfmqri6XA6pl2/
         6MAogt3P2Fxc0r702Kp911Tdx81yozjSlrJ4bV5a59mVLgbpfh9yuKaKhUn2e54L7T7y
         3ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZeIhb3fqnfUnJd59yfyLJJmoBp7Kjl/67o9t6auf+NQ=;
        b=OWcrgp65YTeQEZtd9BgwxPYbRBEdYyw1KOqc9M4Ss+Oapxjw5PUtiSYEYwezuqHQLv
         S16gs9FDhG1th/TggY5wEcDIvRGncJCboIu4/zfyWRFJLa+WfYgimLdICU+WdljIhyxr
         gcDrZ2XSZ4vahr2MRYhG4PkPfOWJdDh0E03EV4QpXF0RHlimsPX8w2+e7pRBqEyFbxwy
         9vQLcHN4fmrhiE+JyQ6Yem5UT3Jbsmo/kkxBFJyoIRe9gTTB2fYkpakL5q/fPmLPn2/I
         v1NqHeeQhJtHycwGHDEA4RYWxxdsXyOJSInwBT9hmcrq8jWvF3bzwKscPwiZa8gkF8L7
         vSzg==
X-Gm-Message-State: AJIora+O6PlaHj9GiSxypO5WnWPdp3WuLn6hGNFYdQUNXi8sRME22A/z
        5Mk+B00kcxudecGlOn4mk4Q=
X-Google-Smtp-Source: AGRyM1vgoX0sI0/GRhToJAs8ji8QUFOvvt8sJNBlMLAEP22kjBbSxxSrn5djZK1qdK3AMGl1UgmRpg==
X-Received: by 2002:a05:600c:3505:b0:39c:93d4:5eec with SMTP id h5-20020a05600c350500b0039c93d45eecmr4138902wmq.179.1655906899095;
        Wed, 22 Jun 2022 07:08:19 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b0021b9416fa13sm8265850wrx.90.2022.06.22.07.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:08:18 -0700 (PDT)
Message-ID: <3de83337-389e-4fd0-b6a5-c9deed31ef19@gmail.com>
Date:   Wed, 22 Jun 2022 16:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/2] dtbs_check warning fixes for idle-states nodes in
 mt8192.dtsi
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        James Liao <jamesjj.liao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220617233150.2466344-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220617233150.2466344-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 18/06/2022 01:31, Nícolas F. R. A. Prado wrote:
> 
> A couple of simple changes to get rid of dtbs_check warnings on
> idle-states nodes in mt8192.dtsi.
> 
> 
> Nícolas F. R. A. Prado (2):
>    arm64: dts: mt8192: Fix idle-states nodes naming scheme
>    arm64: dts: mt8192: Fix idle-states entry-method

Both applied, thanks!

> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 26 ++++++++++++------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
