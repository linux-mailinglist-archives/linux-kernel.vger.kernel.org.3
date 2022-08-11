Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1F958FBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiHKMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiHKMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:01:07 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F95B74E07
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:01:04 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10d845dcf92so21187584fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JCztoRdXYQ6qDq2BlZ6MlrFgM9S8PbihK7TObhhKOYA=;
        b=OpIA7b661j+rVkNRpcVDvPoLKmhM8Go+jyvqU80Sddv+yVx7V7/eXXBPUtTlETr/OG
         O4en2/V3gJ7SdxY/8wOdFXhxH6FEIMoj5fB0D2pXfZXcJnrZ8IDlepU3CUDDfdrqet4p
         LNYL91b18Bht2ZnBikqP8A5AFXJhwbt38wDJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JCztoRdXYQ6qDq2BlZ6MlrFgM9S8PbihK7TObhhKOYA=;
        b=QXGLM2IJwFTPh0vCQdTlxoqnY1DbgbzZwB+XGyb3zkenluMZj8wr5F9iDMAHVSQVEU
         yDrA/cWrWeQiSA1kd649GSuX9i2z8qG23KNufGU7qZZZBl63T4MOzj53BqsW/XcE2I7V
         HfIbt2O7ygGYC476KoblsLIqhJvLn18Bb+g+Ti+KM6xIGs0e/QUmb1OnGNZo7NLUL1V6
         vu83dHto578fWQUZrldsbgSF6nukjobDm7F9D0iBVD/6W4OE8qDsK6YXqfcoA2Gz4V6K
         87GblEARW4zFJQuYNWXljwy2Ww0/cAKoheE+tF/4uKpa4FdrXRWYERbXYYB6xTIpB4Fn
         bcvA==
X-Gm-Message-State: ACgBeo2dMipz9EFQWCUhwEmz+bUW4S06qYwhaKzwBWSizzWBJkVWTHKp
        rzmCxAyEJ8ey5Wia12PPlsUj6w==
X-Google-Smtp-Source: AA6agR4n2ysKOUzhj2lL7UXo6mjwS8nnZt0pi+5x5wLFhzoJTL80LC7+DkTbWGmCNC2xcZqpoIjxMw==
X-Received: by 2002:a05:6870:c186:b0:101:f97d:eff4 with SMTP id h6-20020a056870c18600b00101f97deff4mr3306204oad.289.1660219262081;
        Thu, 11 Aug 2022 05:01:02 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 12-20020aca0d0c000000b0033b15465357sm1045138oin.5.2022.08.11.05.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 05:01:01 -0700 (PDT)
Message-ID: <5939d440-9940-a123-9297-ea0e2a41fd7d@ieee.org>
Date:   Thu, 11 Aug 2022 07:01:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] net: ipa: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>, edumazet@google.com
Cc:     elder@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220811115259.64225-1-wangborong@cdjrlc.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20220811115259.64225-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 6:52 AM, Jason Wang wrote:
> The double `is' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

I  know this is not the only instance of a duplicate word in
the comments in this driver.  I (and others) keep finding them.
It might be nice if someone tried to take care of as many as
can be found in a single patch.

In any case, this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/net/ipa/ipa_reg.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
> index a5b355384d4a..6f35438cda89 100644
> --- a/drivers/net/ipa/ipa_reg.h
> +++ b/drivers/net/ipa/ipa_reg.h
> @@ -48,7 +48,7 @@ struct ipa;
>    *
>    * The offset of registers related to resource types is computed by a macro
>    * that is supplied a parameter "rt".  The "rt" represents a resource type,
> - * which is is a member of the ipa_resource_type_src enumerated type for
> + * which is a member of the ipa_resource_type_src enumerated type for
>    * source endpoint resources or the ipa_resource_type_dst enumerated type
>    * for destination endpoint resources.
>    *

