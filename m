Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702F4E568E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiCWQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiCWQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:34:59 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16B6D878;
        Wed, 23 Mar 2022 09:33:28 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id bg10so3973859ejb.4;
        Wed, 23 Mar 2022 09:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AmVgTlbcCGpaJY5+f0ndtkFM+2xqsSqz9dKnnJoXM68=;
        b=V2MuWK+DLvtog3xo9xU82nAGB/GKYcN9uzn6w3JVa9DsKsdx0FvwMJaGgM9YOvXJ8F
         fMiKyjCXJfs0kbd66DHXmpzycuOeXgObPj6v8gDwYtxU4+AQPCm/o8YkRa8MSbTFeUng
         bkDxQHJ0cWzz+zvkXdzYskHiC7f6ixADqygD4bF9mAGaFTfx9zbDS+VG65n6WW334tYb
         bXvm/UK6qOcqHJ6kkgIW9PtD6KoQKzZ6r8y4ZZgsFjRPiWTEPJjte7T70iOJnjcRgf8l
         2NKVfZebymEsQpxOqcc0g6CDDh2u33vbZxY1AcWs6wuLHmjvn/80EKRL1a/rxeE27b/w
         x6BQ==
X-Gm-Message-State: AOAM532Hwr61WD65l3MTIlTkXNZ0yFKiERGYUfG+Op2uMErxF/pg+wbL
        LSvlqFyBuI2RgLN8MMufWmU=
X-Google-Smtp-Source: ABdhPJwci87XkVBGRHAq3VzztETqA5juKYZRya9qGtP3rDPYhhr2JxnX3m1WMC/ggggLtuocYq5/tw==
X-Received: by 2002:a17:907:3e1a:b0:6e0:5ba8:8e0f with SMTP id hp26-20020a1709073e1a00b006e05ba88e0fmr854816ejc.581.1648053206705;
        Wed, 23 Mar 2022 09:33:26 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id z2-20020a1709063a0200b006e05b7ce3efsm130811eje.107.2022.03.23.09.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:33:26 -0700 (PDT)
Message-ID: <87c0dcf9-29cd-8786-c82b-0599463e702d@kernel.org>
Date:   Wed, 23 Mar 2022 17:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: marvell: Update sdhci node names to match
 schema
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220321212007.2961581-1-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321212007.2961581-1-chris.packham@alliedtelesis.co.nz>
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

On 21/03/2022 22:20, Chris Packham wrote:
> Update the node names of the sdhci@ interfaces to be mmc@ to match the
> node name enforced by the mmc-controller.yaml schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     This was spun off from converting the dt-binding to JSON schema but I
>     think this change can stand on it's own.
> 

Ah, I see the patches now. Better to keep them with previous patchset.


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
