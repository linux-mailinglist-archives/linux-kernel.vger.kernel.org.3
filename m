Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C4F55FBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiF2JVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiF2JVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:21:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D2369CF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:21:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so21266838edm.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pnMRKilWNlAu7873VFaFlK0hNBIHlTBOyKkOKC5rhcg=;
        b=RHgCCOWVYiUr4mFZYHlJl3xoQlwmsZleH4Rn+4lQHL85R+wedzxgBEXinM7ZKrpNxp
         S1J64FLsZQj11uL1G8rrUKj5ghgyZGUlWfyaknhgHYS19sokZlSbH+bTM2j0EbstjXVA
         7NmYWYAj8+hH51Lxp2/mXT1th0tyyI7tC+HvHe7s8BSD+c3NRr31vHNu03lBlDBljFEE
         VYjGfvEgvXBlvfBkxBGkJl4hjC6xfDlxa1oZdxGUt0DVXArRebuD+OYXrCRHoekuAb45
         ZHWHsk7lOMSKQKDhL3ZWuacU3f1NFVxqxX+1afaYYdfKxLnf+hVxeOaNUje9ncqkNKnn
         dMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pnMRKilWNlAu7873VFaFlK0hNBIHlTBOyKkOKC5rhcg=;
        b=aBR0ADRocGOV0u+4VU0N2H0s0u8HMJ4uSxxPmk8tOARDEzbT/RyzasMSwv5Wng+Jgk
         TFL6e26TlEQ7g5nOZXSxf4xO2U7ZGmKg9wDtI8fT88JRksegONsZzLjerOcWG/30C+Cy
         F7bEcQaKA3OtIef57m+zvnybXeYMTUhQ0D01YjKleroZOTNoW1FDvfJoGOCE0w6CQzcy
         sFPP/rOa1aBMh3jQriscPu9v8PYpm8MPEuF01xg6zSd7cw94kxAdEX0ABnP2yDUCmNAM
         XdATF4oyANVlAQ3u6kCer2uAMlZN+JOtagOdNEb7mEs7CjX/oNmOBGVu0uIzotjfcE1K
         R6FA==
X-Gm-Message-State: AJIora/SnpHG/MDePg8w6puYDqgz3ahtw+ztJFW/7eyFWUsHndW3fpZG
        F5k1fWCW9cNyztNSPHHOmz+9NA==
X-Google-Smtp-Source: AGRyM1uhhoawHmkEy8UOafBQlOcWUDgmphxib0zUjuNZ/HcZ5Eu7QMkJt4f6rtk8lrnS8fgVD513fw==
X-Received: by 2002:a50:ce4a:0:b0:435:c543:87e8 with SMTP id k10-20020a50ce4a000000b00435c54387e8mr2886466edj.295.1656494491708;
        Wed, 29 Jun 2022 02:21:31 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i21-20020a508715000000b004357558a243sm11077558edb.55.2022.06.29.02.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:21:30 -0700 (PDT)
Message-ID: <33def8ba-2ca3-c2a3-57ff-9b20dbc2337c@linaro.org>
Date:   Wed, 29 Jun 2022 11:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] NFC: nxp-nci: don't print header length mismatch
 on i2c error
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     =?UTF-8?Q?Cl=c3=a9ment_Perrochaud?= <clement.perrochaud@nxp.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220627170643.98239-1-michael@walle.cc>
 <20220627170643.98239-2-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627170643.98239-2-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 19:06, Michael Walle wrote:
> Don't print a misleading header length mismatch error if the i2c call
> returns an error. Instead just return the error code without any error
> message.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - reworded commit message
>  - removed fixes tag
>  - removed nfc_err() call, as it is done elsewhere in this driver
>  - nxp_nci_i2c_fw_read() has the same issue. also handle it there
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
