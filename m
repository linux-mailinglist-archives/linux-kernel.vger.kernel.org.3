Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71500525E12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378762AbiEMI46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378750AbiEMI4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:56:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CF5F8C5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:56:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j25so9484160wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9LZPjNhuvRomocP2/C/cikB/ZwgE3e5tXIGq6A9Dd3U=;
        b=qHMJFfDHWXgRe9cj8rwpJ9r0DdwUvJDrktJiIrvLfjKRutQVzpGaNRC1lIzLXlNUkS
         IQqFJaVM8oVcsmyvdf75GewbHOgM9ZrrQMCC0wg9lt5ak7htqw6/3J8eibSD+KB/yk64
         k1OJWvR1yYc2xYDMUvPAmuRjbeZn+aH2H94NPlCDh8Ghm0mnHbJzoXWiaiowbDxZH1J2
         nqwKSEEwwzrT1ZSbxaZC1pt1IhxrzJwrCqolbfhc2mMee4g9FHZme78zR21Np7JIAG++
         4M1AI+65hU/SvWfS7OjJgBTM0fpaMd7s+yLJmOdwEEGnVkoxX3+RpLeaVYcGFmsP+VBF
         tY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9LZPjNhuvRomocP2/C/cikB/ZwgE3e5tXIGq6A9Dd3U=;
        b=OJhoP4k+IvUWDxnxGbCoJTMxEIoh59tZDKmuFsNrzQnhZDiK/jYhlRrMe03q7QZYDD
         0tnGNv7Dkbyu5KjSngM0CKV6kwX9XrtT1eLv3fwvcv/kj29hminrlGVlAsPlXxQ0qo+9
         +jVzGlhrhGhQy6QEAvLhpNfqgdqGlfWy+62sM6hK9krYPpQ5QGmZnLketlat4xt0iQz2
         dIgtlAireEvsygjiy4F2W+J+2TtPaWfwCufzJPXRihu90oWQoF+CKs8u9EcbjoJOH05z
         qWwC7j2gYfKsJMaLiV6xthJUNQcFhW6na0PNLaNDpHaDsrbYxEsvGc1Vs28kV7/Qg8eZ
         hcNw==
X-Gm-Message-State: AOAM532FOoFQjjos8/iKEHk30VWDnMKNS0/5NKe+acilKnpPiG6hJ0ct
        1XoBpApdih/iQOv8hUxpzCJKBQ==
X-Google-Smtp-Source: ABdhPJzMCmIw70cxsQMEoBTBP7pBJdUhXTnr3+T1ukoLP9UrfKIWuPKOQ/eCTJs6c499Mm4I0cCJ+g==
X-Received: by 2002:adf:ecc7:0:b0:20a:dba3:a516 with SMTP id s7-20020adfecc7000000b0020adba3a516mr2989066wro.143.1652432212121;
        Fri, 13 May 2022 01:56:52 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l12-20020adfbd8c000000b0020c547f75easm1527915wrh.101.2022.05.13.01.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:56:51 -0700 (PDT)
Message-ID: <f5ec4fd9-b9d7-10fa-1c27-2f268466274f@linaro.org>
Date:   Fri, 13 May 2022 10:56:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/5] dt-bindings: proximity: vl53l0x: Document optional
 supply and GPIO properties
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220512191334.61804-1-markuss.broks@gmail.com>
 <20220512191334.61804-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512191334.61804-2-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 21:13, Markuss Broks wrote:
> This patch adds the optional properties for the VL53L0X ToF sensor to the
> device-tree binding.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

Wait, two days and three versions? Please give some time before
resending entire patchset.

Same comments apply as for v2 and v3...


Best regards,
Krzysztof
