Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D005A3649
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiH0JXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiH0JXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:23:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F3DEDC
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:23:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k22so3631577ljg.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nhQRAKR4zHjEdCb0JVELtrGk2wyQLykl6TatRm0eanw=;
        b=FZ6G0Dbx+imj+WfEdZ5oIvV3nFXHxmMjXXxuZOnoiBTegvtYnT5zYj9chduYPwToA+
         lEaHcuAutIBJIcnG3aVaGE8nT7ejSTlQbAHTt6UZ4pC/Jf1XOOHbxXKwqegbTEg5rLNW
         IhEdCQgTxoOFnqWiVgDsU2NoDA7g+m7ErjvCReMo8ptaDwUUSmD60A9Y2PWBui7i6f4F
         CuPL+odQ0sJ+dXDK0cXkoL7kORkBzaVB3p2D/a3LOZlbXIOjee11HVv6C09L6yS+W6XX
         +9pl1gQ17c5H68VeQbCf+Otk3mAaEeG28PLFOzyEnvBTrOR4/KXMx3LtkA0pTxtJ8CQX
         ULWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nhQRAKR4zHjEdCb0JVELtrGk2wyQLykl6TatRm0eanw=;
        b=SmPVpbl4FRmogt1gA0cRwvN1eSmZWZal+n6BJHO9/2+ycZOf7WteBzJorTuSlROap3
         qasMSgHKjVBHDQ3J6oVfJLmictNDavQJR2mHQtMtJrrlOgoIOCtXH63/uMzVPTZrXC6s
         wKdUqx8MpHFd5v9ga0Lv6G85TIcZp2CZlGG5Xm/7XZOeSeVO3ikGahvfe0uge9WjjT2/
         EY55MocU28ZrSYwQgCik2meW9xj6E6qkGjDR6lkHbXkIXyBhR2o5id80Ex1xc0fovrQN
         cIBAaZpONErBuJ6Q1mUCVLMtQ3sVs1HqF3diJ/ygR7MFKOCaKek5sAuLLKauVpABBWBU
         5Mcw==
X-Gm-Message-State: ACgBeo0RL/QkgW84TTcsmGaT5YqigNQikCuqHRwHFaVM2zjHaeO7AUvX
        /1i07trOpRRwR34tOv1ZFwj+og==
X-Google-Smtp-Source: AA6agR4IOei6b7fi96xie1hkpHeN51u8OsJV5bD52jcUaGAHsunyWj3db6JHei0L9njsv+peuxbAwg==
X-Received: by 2002:a05:651c:1149:b0:25e:6918:22bf with SMTP id h9-20020a05651c114900b0025e691822bfmr3242922ljo.258.1661592189285;
        Sat, 27 Aug 2022 02:23:09 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id f14-20020a05651c02ce00b00261c30d71e5sm682410ljo.67.2022.08.27.02.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:23:08 -0700 (PDT)
Message-ID: <715c2639-c94c-259c-f6bb-cec80afa30ed@linaro.org>
Date:   Sat, 27 Aug 2022 12:23:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/9] dt-bindings: riscv: microchip: document the sev kit
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220826142806.3658434-1-conor.dooley@microchip.com>
 <20220826142806.3658434-4-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826142806.3658434-4-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 17:28, Conor Dooley wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Update devicetree bindings document with PolarFire SoC Video Kit, known
> by its "sev-kit" product code.
> 
> Link: https://onlinedocs.microchip.com/pr/GUID-404D3738-DC76-46BA-8683-6A77E837C2DD-en-US-1/index.html?GUID-065AEBEE-7B2C-4895-8579-B1D73D797F06
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
