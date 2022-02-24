Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF054C35D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiBXTZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiBXTZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:25:49 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F93824CCD2;
        Thu, 24 Feb 2022 11:25:19 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso2024840ots.7;
        Thu, 24 Feb 2022 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CbzwLEAWru/8T3swz8gX9A5NfjeetCsfXd107oDjvrw=;
        b=DQUrWGwa+ZECQ2uvhhkPPNxZbUIs32JbaLwRcdIVUmf8RIFiDVbCBEdWxo71SVKQHC
         R1//pswsYNQmBX+E9zFMrAvLuGJDPTO2KqCNP+IA9pnElrjCpVxjA7sMqQGPBv+lFuRU
         geEB9X//+VPBFlWX2B2IDE0ZQI2E99JuG7dM6yqJ53Tzih3qrl61PQl9o9cCyK+sFcpX
         BRex2wFLOTG4mt6NOVVagZprXYma/ne2Nbk9OVCD3zDniZVQFGiyfy7Liick7ZuLdwlX
         5SaB8Nh5uGOZO6qW64/0JwSgrSd+4pSHeQWPzYFW9C9SyNeJrpJV434RsRR5zsawghPD
         26gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CbzwLEAWru/8T3swz8gX9A5NfjeetCsfXd107oDjvrw=;
        b=s7YWJoBg8gePcLW7r0qf14G8Erx5/+1DwLt+mqXZ2eeepwRNG4zTDwhkujFsEwYsYa
         1PwMEmaOW3qUwwZFsfgCrLbq4+SKv65xk+ohgYH4Ntwy6yrL59MK6E34/77hqhEFUIql
         DT7CcST/t3Zm+hMA1mk1f2MicBNU2iYLg4LuHMnRwJt7Y9z24o+x+Cz2BgbnlPWkpbbo
         7Xhl8Rd09hJKSHKdEcY03kdQMBOYYv7nJNbr0zHg8GKoqLOGLbGB9cg6QJJ19z38aaew
         bbL7Z+t2i0Pv0ypb6rbWF7HdX4a0J4g7AWvx1hi6HZw5Zl0aPRj3vJ8Y7QCIzG6F+5jK
         Gedg==
X-Gm-Message-State: AOAM533tuhTbBMEkVrhnwkDAQNmS8yyYEnip785ON9qFTu2/U/Sv9JBw
        MNTHXFfI7agzNhCrujBdu28=
X-Google-Smtp-Source: ABdhPJwOMDsQ4/l6HLf3AcqW9hiu+SygICXgyeHsoMzzmBk/9HilTwXbowzJvzni+nyhmwBU6eNHuw==
X-Received: by 2002:a9d:6e01:0:b0:5af:5d9d:4039 with SMTP id e1-20020a9d6e01000000b005af5d9d4039mr1470622otr.280.1645730718499;
        Thu, 24 Feb 2022 11:25:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l26-20020a05683004ba00b005af665739e0sm124752otd.30.2022.02.24.11.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:25:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Feb 2022 11:25:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings:trivial-devices: Add pli1209bc
Message-ID: <20220224192516.GA1942677@roeck-us.net>
References: <cover.1645435888.git.sylv@sylv.io>
 <15a9fcfb5b9592c6d87f12c2a4c77fd069f5cfff.1645435888.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a9fcfb5b9592c6d87f12c2a4c77fd069f5cfff.1645435888.git.sylv@sylv.io>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:42:05AM +0100, Marcello Sylvester Bauer wrote:
> Add trivial device entry for PLI1209BC Digital Supervisor from Vicor
> Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 091792ba993e..d03d90360aa0 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -354,6 +354,8 @@ properties:
>            - ti,tps544c25
>              # Winbond/Nuvoton H/W Monitor
>            - winbond,w83793
> +            # Vicor Corporation Digital Supervisor
> +          - vicor,pli1209bc
>              # i2c trusted platform module (TPM)
>            - winbond,wpct301
>  
