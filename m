Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7B4D0783
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245073AbiCGTUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245063AbiCGTUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:20:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D159580D7;
        Mon,  7 Mar 2022 11:19:56 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cx5so14931916pjb.1;
        Mon, 07 Mar 2022 11:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43yabkppNO1PYVoZMxx6aJIsWh5rjZqMAPLH7WugjRk=;
        b=gAB8T444wB7Mh38B4y1SkZReGMb4ut0xn15c48uhCW0o2oiqj5oLtAPPLgMWJWIfj2
         pw9CMnhGBZYICeKMka1rYLfdLaYpO5SyQbGSH4FwtgoLOaEf/WfOBqxawsv/76L2rAP5
         v78oIo00Mjvcvn3FHRAmDPVqerrQS6YFUZzGTNBN+0nmDuIA9Ow6PppXfmnZL2z4rSOe
         KH0MymGoRBsM3isOGizSiP4CAlYs7M21bhWWOU0bayZBm6UynoNj6ScieCXcktlC6bT7
         QMtWDLQ8EpohttZoj+azZJLFejmcXUMAsXKdDI01Mxq8uGMeJY90rZbDLlrzg/cMVWWg
         P+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43yabkppNO1PYVoZMxx6aJIsWh5rjZqMAPLH7WugjRk=;
        b=Ygl1CgJjzeOTSt+dBjaa0B0GpgtxIMY+ueLgiO39VUuYR2Fmo8OKtHXralU38Aa43f
         sGgqagvYC85uOd3CFauPpXj44RriwPcBrVPz7bnsCFVrL18zw4mtg3h24UGy2hjyxWcp
         eQgMm505/KFTkpaOv4joLXmD5dHnBXptpp78aRKZLG61E8ZG/7YY62vmsxNAqI7PmnJs
         ftXATw3F6QWUx7M8lEIILK3QNyUV3VFU6kpXB9/lok4jFKu5pbCzqX0VqO9hFRXFxnht
         /wnHHDeQugAyP0FQTVEtFGpoR+Z4cUWUwtd8MoISh9DAFwIhmzWFoEgkhcN4RXsOeKch
         7PHQ==
X-Gm-Message-State: AOAM530sunYtFFu79NLB5nfeg85FGSMWkCfBrX9+qW3b7Nx8DnSZmnWs
        cA0No8BqTpj8xy5iFYCmAUI=
X-Google-Smtp-Source: ABdhPJxTztg7pSgIOr+O567tI0a6HSEtde66cbpaHl3qywr4SQaWo6uWdOq+i1MwS/Asw5tS0VXZHQ==
X-Received: by 2002:a17:903:183:b0:151:af32:890d with SMTP id z3-20020a170903018300b00151af32890dmr13740248plg.0.1646680795806;
        Mon, 07 Mar 2022 11:19:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h2-20020a056a00218200b004f66d50f054sm16837209pfi.158.2022.03.07.11.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:19:55 -0800 (PST)
Subject: Re: [PATCH 3/3] arm64: dts: stingray: Fix spi clock name
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>
References: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
 <20220307182101.84730-3-singh.kuldeep87k@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a99fdd2b-96ee-df1a-6c56-632ad7334bc6@gmail.com>
Date:   Mon, 7 Mar 2022 11:19:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220307182101.84730-3-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 10:21 AM, Kuldeep Singh wrote:
> SPI clock name for pl022 is "sspclk" and not "spiclk".
> Also fix below dtc warning:
> clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Applied to deviceree-arm64/next
-- 
Florian
