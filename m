Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B7B548449
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiFMJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiFMJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:46:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13D41928B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:46:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e5so2642424wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hs5EQNjyVVeQgXbgcD/B6aTCezXJTyIP0AIWYJHWpT8=;
        b=APbJeV+X+PShWtNWFgeKdVAH4z8gKsM3NXzCEkGB0F+Z3FSuGHnfa2rj0pN4SOQmgT
         5lTxfRhUt7zM7rS3b7yzn0i/q4OcNO8uZsOIkIBdV+91P1nsnz+5557Nz9tnONj/aLS7
         1SmeZ7qWfY9SfQHCK3t8IQGioargGycbNr9htQW4erzcnjVccfbTycyNCGHHxCWmNVDx
         NTIh0oDFXthjekUXjk4gOWYQITYml+0AutQvOsp3oNvl+62fewDnQGoJ4/5Cs7lC16Ph
         Qgqc0dSEIGtvGz57YfjvIQ5wZHdUQmrqNOoITxyj/TMm7hCjWQu7D3+5fr3D5Lfh9HBy
         XwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hs5EQNjyVVeQgXbgcD/B6aTCezXJTyIP0AIWYJHWpT8=;
        b=MKFADYAkQL1FZZ2nFnoBaFPoUZoTD1nWDLpWZqBB0BB5m5+sYtd4buk1a8UASsowtZ
         ZS1NCEHyOEDJMXSowxm9T5uaO2jKWfBt2NLW4JCa1yBc4Bh0wchOuPm/GDfq0quxCOMB
         Sk0ykqaJG/avmiJOt+oGLXYZKWqLtjSmtHolfbj2UFuQr9i05fpi5dil6fWLI7EUDhH8
         lxHoY/mEiuOYSpAxOhjrCPK8qp1jwdCEhSvaMjbb+qTW17Gud9YRnrkThOBhZg+xdY++
         r+/UZ3UlEbWLjYrU2T/uw0Mu5ImncRgRQSVlJlcrywGqkqp8uqIirtVJTwklmi7OgsJh
         Q7cA==
X-Gm-Message-State: AOAM531X0zBTobaOPeZ4BGwHmASXWjJzlV/65zBo5LiCvtULJXILMZKM
        Et+9agL7oUKq7b/u96zkFKe7xw==
X-Google-Smtp-Source: ABdhPJzUy6r3Wybk2hiKuA1ZAmjOCgeGwtQMYQTkR3vSuIE82HPoMqu5t6274YLEzIG5fwsAwO99RQ==
X-Received: by 2002:a1c:f317:0:b0:39c:831c:bd43 with SMTP id q23-20020a1cf317000000b0039c831cbd43mr12255305wmq.139.1655113574279;
        Mon, 13 Jun 2022 02:46:14 -0700 (PDT)
Received: from [10.227.148.193] (80-254-69-65.dynamic.monzoon.net. [80.254.69.65])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b0039c362311d2sm11578741wmq.9.2022.06.13.02.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 02:46:13 -0700 (PDT)
Message-ID: <db1e29a4-3138-4a0f-2582-a2614a68cd22@linaro.org>
Date:   Mon, 13 Jun 2022 11:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/6] phy: samsung-ufs: move cdr offset to drvdata
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Bharat Uppal <bharat.uppal@samsung.com>
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
 <CGME20220610104346epcas5p4f59c073d15b3cd8fbc99de03d9cd1c41@epcas5p4.samsung.com>
 <20220610104119.66401-3-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220610104119.66401-3-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 12:41, Alim Akhtar wrote:
> Move CDR lock offset to drv data so that it can be extended for other SoCs
> which are having CDR lock at different register offset.
> 
> Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
