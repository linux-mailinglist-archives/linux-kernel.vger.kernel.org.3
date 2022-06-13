Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062454A171
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbiFMVbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiFMV36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:29:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A4D6409;
        Mon, 13 Jun 2022 14:28:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h1so6128232plf.11;
        Mon, 13 Jun 2022 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gxN/w1qcbqbye494uu3kK3mI9gmlkf76QjHUX/jq0jk=;
        b=BJ3FNM10ThOwKy5Kn0oFOLHkB770mLO87XRTWBD4hkj/4Xl/E3irXqGu9mORKR8g6/
         3DoeZCa42weHFaJiPHGkIBiUk5sH/uXqXajDrnpnGWsYxGeoKJTqVzLdJvGkhl/BuaYw
         bt2KaNj/6IXJUiLFppQYA/50oZ6udp/1YQSLNAyi8ku7IHQ9ERI6abdE4IuZzN0njnA0
         TtPQBTVKd8xyXCVETzdezlX5b+H+Iq9+SjJvvLF6XhaaS/YZX6/lTcjIPUVQHvLYfROf
         ol3Vry6HbkPpqogJrm2Ofkg90gCJNQSVPNJFY8KH2pOCRHxzCDLbwOaGiMyte9OYLk8E
         W0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gxN/w1qcbqbye494uu3kK3mI9gmlkf76QjHUX/jq0jk=;
        b=az+wKfyBMYcNXtqYve3ahFPzXKdqZOWXStJcyjm9H6mBCEWPaFTM8RMN/NOtM6BfpC
         yuhESyT0klZ3w9xY3sHK3txi2JuiJyRzwj+hC3WwHi9BWARV66DyYjjWj5wYmQHVi2Ea
         EvYgf75/MMe0z8CVwgsXebukSt6fEbFuy4717MLTHBLI3gT3LD41r+2+B7tvAD5JOFBj
         oQ8vG6ju7vK4L4zkUExerxeeUVVmRVO0IOXeH+8gzLPZ7/hKIEKo7tzpRN76+iyp4s/g
         ZVVCU3+u7QqOOAN6SvEhSYEIZph8Sq9MgELRhoWvbwa7+g7r2vUL6LQ3HsmIviaLQLX6
         uRKw==
X-Gm-Message-State: AJIora8apgPWY54jgqnEBQIGV1xXmj4Y8605A0zN2b5pU8JMV+JScFnw
        3NvQBpV5VEq55Kzlpu2oXtee1tU0DeI=
X-Google-Smtp-Source: AGRyM1s0FiY95llbjr94fqtXJiJblkRew/GKk/iyo4JZmvI86xxmNwdWHEsptrZb3ykeJmWWx46m2Q==
X-Received: by 2002:a17:90b:33c4:b0:1e8:6e2f:97a2 with SMTP id lk4-20020a17090b33c400b001e86e2f97a2mr740822pjb.165.1655155700326;
        Mon, 13 Jun 2022 14:28:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i17-20020a056a00225100b0051c04b1c89dsm5899252pfu.3.2022.06.13.14.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 14:28:19 -0700 (PDT)
Message-ID: <3f59aa12-1859-1833-1742-06c0411be4ef@gmail.com>
Date:   Mon, 13 Jun 2022 14:28:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] arm: bcmbca: Add BCM6856 SoC support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     samyon.furman@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        dan.beygelman@broadcom.com, tomer.yacoby@broadcom.com,
        philippe.reynes@softathome.com, kursad.oney@broadcom.com,
        f.fainelli@gmail.com, anand.gore@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220608180437.31971-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220608180437.31971-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 11:04, William Zhang wrote:
> This change adds the basic support for Broadcom's ARM64 based
> Broadband SoC BCM6856. The initial support includes a bare-bone DTS
> for dual core ARM A53 with a Broadcom uart. Linux kernel image can be
> build with the ARM64 defconfig.

Series applied, thanks William!
-- 
Florian
