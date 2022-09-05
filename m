Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6D5AD53D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiIEOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiIEOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:41:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2D455BE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:39:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bt10so13447046lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tID80rmfXboEY0nkAsXNz4rnLGrX/qCh1tfz6rehgxY=;
        b=WwXef97mUawTtzmR9iyVDjDGMi+nFQ/SEEnRJyNHMSbghCjDQaWyJhNd/UdJN7AKi/
         LezE8iduLJ+7I5B8IUmaZ66naDox3nvdGS38RCXTPMxnjuya5lpp0Vw4L3PY+JJfWqpk
         pICyE58d/ccJEQ9lATZjeihXP0UNL5QYkZ4FnhkocU45YEoIrZpOcITH5Mkh45MmHsq5
         Sr1/bZedk8xLU/8eRDufgQJ22KRGUFxmWichkBTmM28Oc3I/Ac7SFi9K1vv10p0hgKmh
         sukMV/1RnsPYZAnmsbquZRxtDlVd53Tjpe1ICBZ18VLK4Qh0Xn9zU5dDatLEZn6JaKvG
         klDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tID80rmfXboEY0nkAsXNz4rnLGrX/qCh1tfz6rehgxY=;
        b=2YMnvrw3gRsMDprwxDrBvKCOrO1DNNzFZ7M7k5zb66pwBjQDAejTxbHB5Q51c1uPJK
         pPGvaz0s8GBKY6dTjFF2jySiZ0lQVPC10WrMU1cSXDpSBdbKe2x2UQSCQDjPk1EttKyI
         I6rcvxn/EDp01NhNTVZDVuIeKeuhWwEY5adbeeSTdYstIdubf5q+J4DqGDlij5qsl8nu
         s0uZXbdt0i/Nu7BhWcIdoXllfUVX/uQb9leEKhSLq/IeZngsSBZ2jsAT3ir8vAz1AKwU
         gvzJWK4L5D47b8cX7xDlMC3mlzHpI+GdMr/UKWSRRE246Wx2AHtpOzbriG//BQ9QdHmi
         WhMw==
X-Gm-Message-State: ACgBeo284KojjOlf5f8IO3AHxYKA36MewvfCE3PCypKh3+z97KH4SZ2w
        cKUzU38WpqHPq6BfZDKj7SlU3A==
X-Google-Smtp-Source: AA6agR7QPtm8qJXa3e1Bgk8soaNrbQf1IIU0Hc5uhjFfqbQzzffyQAzHKJNouMN0oW/bSamk5XkwwA==
X-Received: by 2002:a05:6512:10c6:b0:496:d3c7:68c3 with SMTP id k6-20020a05651210c600b00496d3c768c3mr25458lfg.628.1662388762876;
        Mon, 05 Sep 2022 07:39:22 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f17-20020a056512361100b00494adf8ac1fsm1064144lfs.165.2022.09.05.07.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 07:39:22 -0700 (PDT)
Message-ID: <80cd242a-2ea6-e30b-d437-54c977910d7a@linaro.org>
Date:   Mon, 5 Sep 2022 16:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 2/2] MAINTAINERS: Update fastrpc documentation file
 from txt to yaml
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220905103715.955786-1-abel.vesa@linaro.org>
 <20220905103715.955786-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905103715.955786-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 12:37, Abel Vesa wrote:
> The documentation for fastrpc bingings is now YAML. So update the
> MAINTAINERS file.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

This should be squashed because otherwise your patchset is not 100%
bisectable (after applying patch #1, old path is still present).

Best regards,
Krzysztof
