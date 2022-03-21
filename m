Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49204E27E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348020AbiCUNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348004AbiCUNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:42:27 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A10A74630;
        Mon, 21 Mar 2022 06:41:02 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id q8so9386164wrc.0;
        Mon, 21 Mar 2022 06:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9vMt+hX5zS+6WtuXH1LjsjcqPrroHsDgeG/H9EBbOj0=;
        b=VW/c6Hh40d3QPB+ixM5WfemxoZK7q1oyz2WLdIy/3LCR88cFmN+9WFjgtEk5OH9A6b
         H7IQGh2LFBYdzlC0qP5MDg/0fJqEeX3RK3ap3jZB8sorcHXUeSpe0Qtp4iGgoVm+bB3Z
         CgPzFb2vQQq4W3sZCgmddgGNgQZosVtQss2uzQCvvIpo+FOH+UcMlXDxi6a3TJQkjzob
         EAlYsBJFzOnOsV4aBg0tUHLLRCOPa9JnBFzJIqFmCx3NDnLJP3nwRFr49GMR2MADHFfG
         g40bs0Nfb+SugonRR3aDOi4B19wlSWKQPJt3ylHDpw+Rlmu1BVMqL/a58AtRrY3k/CYE
         QdpA==
X-Gm-Message-State: AOAM532w5As2mIq2fFvKMt3AcfBU48/crtnEfV1UB+dGir8WsNRmZcDy
        kwdIkfnNAmAC45SQDy+sXlM=
X-Google-Smtp-Source: ABdhPJxTBRXSwZa5Hgbdytx3UhsHjpCQShJv0x20dGfBhjxWjqfKvLc85bU5Nw7kbDtVsAU0SKnPPw==
X-Received: by 2002:a5d:52ca:0:b0:203:db2f:2a47 with SMTP id r10-20020a5d52ca000000b00203db2f2a47mr18658989wrv.580.1647870060324;
        Mon, 21 Mar 2022 06:41:00 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id n23-20020a05600c3b9700b0038b7c4c0803sm17157114wms.30.2022.03.21.06.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 06:40:59 -0700 (PDT)
Message-ID: <221c38f0-4eb2-18d4-ef18-ec35437d1163@kernel.org>
Date:   Mon, 21 Mar 2022 14:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible
 string
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
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-2-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321133318.99406-2-luca.weiss@fairphone.com>
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

On 21/03/2022 14:33, Luca Weiss wrote:
> Document the compatible for the UFS found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> - add second hunk for clock validation
> 
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
