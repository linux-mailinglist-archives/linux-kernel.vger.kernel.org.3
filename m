Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE84DE8B5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbiCSOn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243280AbiCSOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:43:19 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC7185463;
        Sat, 19 Mar 2022 07:41:57 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id o10so3257843ejd.1;
        Sat, 19 Mar 2022 07:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=DyX7vCd2VCaj5+Brf9GyX0DqxHD406xqpPn1xF+9QSs=;
        b=lGdJeow1ms0Ju3eTkwr8K4b6lixHy9bltSqlc34Csk11Fq/R7DyLqgtiW0zUKDr0Ge
         o96uM0WYURd8l9CKbyfAqWPm5sOMBeuTUOHu2D7+W8ECSvL3wahuPSjcoT/q4KF2oR7h
         hbGNrnk3SRDJuFvWWEGUGP6rsqS0Cbtd5m4wVHwuV/vnhgfz1Xa0i1N2Ulu8rOIjn/tj
         VRvZY8LZD3JVg+/lLuJMO74yvcgEk7Uh1XnOkTEPDvK4k4UVdfnuwprRrkAPxeXh40Vr
         TyHX+WtpHmeIKhkkSdyyyvtY9+m4MTk7GM34S1zQfwizvXoUB1vqECC4yhP8daCL158/
         n9tA==
X-Gm-Message-State: AOAM5304/TYIcDT7BkfhaO6IhwKgk8s3h/oqCghkmKyniN8LJ7HRnvQj
        3TBfHkSv4lxbVz7AzaW3Qk4=
X-Google-Smtp-Source: ABdhPJwKUZEZpQdfxPmGox4nRgfvtbg8LWjstfZ/LPtgOApSVkWAL9XD6XVW1MPF3m9No9uaLAJ4/Q==
X-Received: by 2002:a17:907:2d93:b0:6db:ab5e:7e0b with SMTP id gt19-20020a1709072d9300b006dbab5e7e0bmr13331335ejc.262.1647700915680;
        Sat, 19 Mar 2022 07:41:55 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm5557875edb.14.2022.03.19.07.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 07:41:55 -0700 (PDT)
Message-ID: <4f7d4387-558f-d865-8cec-6c9c999cb6f7@kernel.org>
Date:   Sat, 19 Mar 2022 15:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible string
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
 <20220318183004.858707-2-luca.weiss@fairphone.com>
 <cc6a0a89-a096-e954-b245-1857e9f94c4e@kernel.org>
In-Reply-To: <cc6a0a89-a096-e954-b245-1857e9f94c4e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2022 15:38, Krzysztof Kozlowski wrote:
> On 18/03/2022 19:29, Luca Weiss wrote:
>> Document the compatible for the UFS found on SM6350.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

No, I revoke it. You also missed the constraints in if:then.


Best regards,
Krzysztof
