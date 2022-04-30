Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F284515C71
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiD3Lns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 07:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiD3Lnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 07:43:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EBA7643
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:40:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kq17so19857630ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=37IZKYMhQSNg4t1jdanquzuzImuToF3uqBKV1QSoGwI=;
        b=gbvxq1yYiDoaisR85HzGtsvG7lGu9kbT8uLnZc8etRsQliGN5hvvP+tVA0tkb2fVso
         D5Z3vc/E5WLiSJt27kDTmCO+8KInOv+AqKmsNNf/gWVeis0TkxZecBRAvBjlhZ34a6qt
         vFwkAST2rq/LeFg/BAL/BDe4eF9EGj+ayZ9Uu0ioZO1uJTV94qhriMOGRyiEuHYgelrO
         47GZ+MNiVyN/yfs0lsGzkQ2HzQpwwCDshS87c7y4vZnAeN2Oa0OjmiDdUCgPeHzGMbIp
         ft9lG6rMfHrKpoQ1dkZdH/DXpCb0qChFEk5iDCRFINXhF1CCNDiyvgKtYAyX0y9Xk8Ry
         qhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=37IZKYMhQSNg4t1jdanquzuzImuToF3uqBKV1QSoGwI=;
        b=kPvYTsDl1dYkyBPqJoRslAQNdbVrJA/O9u7nQH6Bx/iHRGY9duX9FpbvjZMhPgsoeN
         gLqBtupRcGPhNJg/9kgg7RgzI/b5KxMs+hwq+TQ85P+ob9MhVanp/efmXmmjGyax87aS
         fWV8iGyZvW/7iFIOyLPbUfabflYLzQ49JytM/u+9muaZUIU/zckliR8cEb4Mt9NG6qw5
         68/r6jT1uMunr0pHYfN17g1pKUmkOKgYbNcox0slIMbmCJeGDKB9Cpk5aPzswgi47mxn
         UsVCMK8SDPvQtsXj5/FgR9HX7gsUP7vw23gNBIKSoPjkRKuCFwGJQDAnl8xaxxe6knV+
         mWQA==
X-Gm-Message-State: AOAM533yTCrITFmXoFRtPLKTBYbEabFS5XbsnBUXc38a5MvOfKc6sHsU
        XF8P54DqEOXq3crDWvzyzRP2Y20R/MiIfg==
X-Google-Smtp-Source: ABdhPJxqvU+aueMbCCnCL1KZngADRZdQAAqgBioEW7uSV5Ga8AA/zvEd5BhlYdaXnzQ+KVNnCL5TCw==
X-Received: by 2002:a17:907:1b1c:b0:6f0:10e2:7a9b with SMTP id mp28-20020a1709071b1c00b006f010e27a9bmr3662004ejc.58.1651318819017;
        Sat, 30 Apr 2022 04:40:19 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eo9-20020a1709069b0900b006f3ef214e02sm1536835ejc.104.2022.04.30.04.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 04:40:18 -0700 (PDT)
Message-ID: <b5c2c497-c053-5d74-823b-73ad3e709ee4@linaro.org>
Date:   Sat, 30 Apr 2022 13:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 02/11] arch: arm: configs: multi_v7_defconfig
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-3-nick.hawkins@hpe.com>
 <b5a549c0-c3f8-3c39-c4ca-a960fb748814@linaro.org>
 <PH0PR84MB1718FC5AC7FFF0D5509337A888FC9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR84MB1718FC5AC7FFF0D5509337A888FC9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 22:34, Hawkins, Nick wrote:
> I have moved CONFIG_GXP_WATCHDOG between CONFIG_PM8916_WATCHDOG=m and CONFIG_BCM47XX_WDT=y. How do I run savedefconfig to make sure it is in the right place for this file?

make savedefconfig

Best regards,
Krzysztof
