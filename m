Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294651A336
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351885AbiEDPLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351893AbiEDPLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:11:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCD2222A3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:07:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id be20so2014889edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mYhHc3io7+EcnhLKfT5KHQo9CUo/I52V7+vAalDTDrc=;
        b=Pry1zIOhMcROdxNXGEJVcdAcgDOuaV5OGaAkCvZDv17g4fuJyui/y6CYLUIb6VBgVi
         gL0OF2zlO+uF0xoBDkzxd5tWoaJC84c9R+8TbvTK8j3F0UrGyb16hT228bylx8qDkF5e
         xuwWtsBzwpyICd9IHxKxZBGmoPfKvQjqGwORlFKxZ/0RlZNHpXYoot2EaaGMEumhVc0y
         p4Jbd2T+vjX5Cd4fEr3FruB9EmrJTTvZKzWiKl5bTLUtlnwsuwdEIjMx8vN0xg8FhLQb
         Lhi5Sxo7LVNOg2kUwU6NuxmlPV0TRB51ub6HeW6T3/8liyo19cpVpsgcTrIx517bHW1S
         ZuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mYhHc3io7+EcnhLKfT5KHQo9CUo/I52V7+vAalDTDrc=;
        b=1zOIEI0Ga+YQRibd91rQjQJGr+MqM/wJLVUH2eGAr9BJNJQAohgai4rclH+JOS4asz
         xVl9/Jnx/CX0sZOrLWGM9wbmUuWWid4nnanFoTKjXDZqyJptFpBlZDULux5fFWjLgAnS
         Ffpdll8i3bDFDJQgpglrRTf3aG6TxzKZYj00SC6hssMWGMl7fnmkk3FBscaGkju4XvlT
         MOb5POOhH8k+0t5q3VAvxSg0hCSVWcei34LEj8Vu0URkHOW2rY40CUVADpyjFP4RJFAa
         gTbT84w9uLMk49BhKsjuyp+JVGx90jA1DsKM3BswnJHq2tGIm13Je6VjteVF59ewkQaE
         35+w==
X-Gm-Message-State: AOAM5325uIYdEr7jtwa2e4q84N3T7sMscZ6zpqHErvPd1pNpDMnyPmsI
        Q7XsNyNnxhMeYZHH+BHNXmj9pw==
X-Google-Smtp-Source: ABdhPJzRgmmHymU7jVZH1CKHjC7GjVaif3hOtBorH2duyoZJ9xUDy8vVdQtDPpGjbQsN3vH3LqEBNQ==
X-Received: by 2002:a05:6402:2788:b0:426:18e3:b6f9 with SMTP id b8-20020a056402278800b0042618e3b6f9mr23780128ede.81.1651676876667;
        Wed, 04 May 2022 08:07:56 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv8-20020a1709072bc800b006f3ef214e5csm5810250ejc.194.2022.05.04.08.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 08:07:56 -0700 (PDT)
Message-ID: <5a6ab3be-1d76-76f0-b5da-eecf5c551bdc@linaro.org>
Date:   Wed, 4 May 2022 17:07:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: partitions: Extend
 fixed-partitions binding
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>
References: <20220503154254.2339744-1-csharper2005@gmail.com>
 <20220503155007.2339847-1-csharper2005@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503155007.2339847-1-csharper2005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 17:50, Mikhail Zhilkin wrote:
> Extend fixed-partitions binding for support of Sercomm partition parser
> (add "sercomm,sc-partitions" compatible).
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
