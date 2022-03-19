Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD964DE89D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbiCSOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbiCSOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:40:07 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E78D6B5;
        Sat, 19 Mar 2022 07:38:43 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id r22so1947917ejs.11;
        Sat, 19 Mar 2022 07:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YiSvu3h2MURJ52kikYps/FHyIHlianDqoRFaAApITKM=;
        b=j6xeKKl8VK0NBU5pvkFbOE7v5RrA05hCjkOUdLVD87KMcr6HPAxN+JJ4v4FU52D9rg
         rufVDymxJImYqUw+GW372OSqhzNJEmEEtfBdJaxgxRRN2e+TaefzOG5zcgV6NvZi5wr1
         KEyAg/EtudGaRVBQ2mXKa6Jfot5DPzDjzo7ecHjxn1wpNdSvmQ2zMVYe8RiO1q1cvMUh
         BeQW4sLjmRGOWCgrtNwnWhOuoW+Aqb4Fcpo++OHPeXkDlUc2RkSxJ8xFM5D53FWqCqhN
         6B8gT/nshUnB+K/Tx+bMC88WQQSMoFgh+mdCFAM66ORidi0KNYNFR05Eb9dNSmElO/mu
         VzMw==
X-Gm-Message-State: AOAM533a0zQkKXuV+liRn2bttNbkjjhqLuF8kZUzh4O3Hfj95w4aQxYB
        Er9KMM/I5ZllU9hMUEoMEcg=
X-Google-Smtp-Source: ABdhPJxy7389KsjdEcoBs8HFFkzqqnLzY5jKJNB7r2IHGvyjvSoasFsmc5rxbFJwLesRSh+gR9lAnA==
X-Received: by 2002:a17:907:7d93:b0:6da:8f57:68fa with SMTP id oz19-20020a1709077d9300b006da8f5768famr13695553ejc.42.1647700722186;
        Sat, 19 Mar 2022 07:38:42 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l12-20020a056402028c00b00418f7fc4bd8sm4198032edv.91.2022.03.19.07.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 07:38:41 -0700 (PDT)
Message-ID: <cc6a0a89-a096-e954-b245-1857e9f94c4e@kernel.org>
Date:   Sat, 19 Mar 2022 15:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible string
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318183004.858707-2-luca.weiss@fairphone.com>
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

On 18/03/2022 19:29, Luca Weiss wrote:
> Document the compatible for the UFS found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
