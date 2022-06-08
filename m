Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B8542A08
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiFHIyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiFHIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:53:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13452E6EF6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:13:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so19942783pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zhqNi0mmyF2oibV12PPYEhQLWhwGEdgnowsThwyzWDo=;
        b=Bd1c07hR4eRQICc1kkbXLmhrRl2d1VU18OCZwuGew5rwPpU03+san7l43p8WoFWwT4
         zQCoG1U7K/amVCDknjIfp0zvBFjhwyy6rggP1Zrjs9jDXTkc2o7Q4Tdyxkp8Hv/W/HXN
         xtFIwKYC2KSY/LEd9ffPkEKnibnkp9RcZNXHuh8TOjrXg14kjvkNnnvfRbU15cWTIxTv
         6A7cJHnQww65R4tlzzpoKC8rQ0KcGgjVOvrVDCumDPg6AdBivJX+RMU4Ujv3TC9L8En2
         VNkqJ0q6DAMXscBXytjQGMHPTylIXYPoySLHu2Tlu5OkFLEjTO8Xo5fBfMIkLu3C520/
         v48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zhqNi0mmyF2oibV12PPYEhQLWhwGEdgnowsThwyzWDo=;
        b=GRnUsgg0h9UdU5OwGu7FcqFLdfDH9ApBtukGBFfjb+6RVdbJjAuZ4J9geekIXdjQjo
         BxQD56rcoGWFYoLurvf2EDbxyqrW7fyNNn6aMGXsI6PfIRqcvQptwggmRy5y5WEQipDD
         xHJhj+ApsnzDdtdeU5cl76fLIsUQ3toTyBT3KqIqjSLg7eOIzPqt2d1NfSOLX/wnXI21
         7Vu7v3/lzmX0NO0Rt6e35tJJYNv4vw5VlIMMkC9IeGFMcbWaaKBqd2I0d3YGEuKLPp48
         RQkYiDk1uaM1o8ujHQINA8gpaV1HnawnbpTI0+gImbn43CKRkQTEvB8gfi6etrLBLckH
         Bo+w==
X-Gm-Message-State: AOAM532G1iqzHQJfLCpdpz8gnzjx2CJWLswKQDkZE0JapVFWrOD/sxo0
        YbXDAejLaJBa6xlwLN6QRfk2pGxn3vGCtAMM
X-Google-Smtp-Source: ABdhPJzUdpp7HMym6KMErPT60L4JAfo1QrYzkqtez52OGjc3S3NPIR6Ir7j+BQVFdQSU9LX+2blK2Q==
X-Received: by 2002:a17:902:7282:b0:164:17f6:e36a with SMTP id d2-20020a170902728200b0016417f6e36amr32295758pll.139.1654676036437;
        Wed, 08 Jun 2022 01:13:56 -0700 (PDT)
Received: from [192.168.0.24] ([88.126.57.132])
        by smtp.gmail.com with ESMTPSA id 72-20020a62144b000000b0051b416c065esm14178098pfu.8.2022.06.08.01.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:13:55 -0700 (PDT)
Message-ID: <c27074d5-17a9-94ba-4a22-65d165de457f@gmail.com>
Date:   Wed, 8 Jun 2022 10:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/5] arm64: bcmbca: add arch bcmbca machine entry
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        anand.gore@broadcom.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20220601225654.18519-1-william.zhang@broadcom.com>
 <20220601225654.18519-3-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220601225654.18519-3-william.zhang@broadcom.com>
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



On 6/2/2022 12:56 AM, William Zhang wrote:
> Add ARCH_BCMBCA config for Broadcom Broadband SoC chipsets
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to https://github.com/Broadcom/stblinux/commits/soc-arm64/next, 
thanks!
-- 
Florian
