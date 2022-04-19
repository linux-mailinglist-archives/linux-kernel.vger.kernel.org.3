Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8F507932
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357356AbiDSSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357599AbiDSSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE702B27F;
        Tue, 19 Apr 2022 11:30:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a15so1503875pfv.11;
        Tue, 19 Apr 2022 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eKFioxOzghl9O19J5OuKB0d7mfsjViJLel8CE15qcbU=;
        b=pWkWXgBERKLNVtKHTDizwMCKyCLWw8LwbLgtgU7ZGopBv/QOh8u+OJgNm0sOIGoB+E
         lUqv8wbV5D05b1Tm51VCSB9bQg+tbnVQv+q5LUr8mSLFogleiK/OpPFp7HZTzgHw5FGZ
         0OB1HKaRKQSyCYmPi/71w51LTS0YEq478+io2fw4aiYVWdSWXnZox31ivr/GgQcljp9m
         2yvdjcWPlidRu+w+8njyrIymc5xJfxnT7LceAE9iSqcaOnloSNnDFj9u676N9JikMXgd
         pIaB/YxG3CZBhgeDQed1G5yXnoQyzQ2j8sWKNY67o+WHdo6V6rSMHlcaakywgZGu/5xI
         j4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eKFioxOzghl9O19J5OuKB0d7mfsjViJLel8CE15qcbU=;
        b=Nofc5y2V+CK5Eug3hDG428jxxZsAJAulO437VzFcmq8arxcvLWAKvurzsMVQZxA1Vv
         DAQfbsFcTX2Z6GmYgqb/FfsxEuwOUBoIrVXXk8u8tc5zt+mzMk9RoeUP0FL4JZNfbRIy
         7sO/J88jo837vVwdkHjXpJ9WJIC+ddtWqxPwHAMXeopcYVKSfwyArzbc/1VicS29RXLw
         XFoFwThU1SDIZskRxRW5yEhXr1YAHgy0QV8TmYEDWXetuQ0FoYw8vC8g1ZXoAU6AJULW
         8DfGJHwrPdA+ltIC6c/3FJbs4Fwf0hi5PYf9WRxI2ehro41WhK9iKZDwxVir/0BFB6aI
         ECZg==
X-Gm-Message-State: AOAM532+zCFAeFYLnE2d80IAnuqr8y5noVU/tUndll+s4o44jgi/qiDf
        0NTsNXtvW57XAUDDTyUpfUk=
X-Google-Smtp-Source: ABdhPJz7xRlqXEq+ldjZc5d9qGFyh22DlAaxSqMBK08X0bj/eXOK/7CFd+JUx3ana49zba0WkF/vXg==
X-Received: by 2002:a05:6a00:2408:b0:4f7:a8cb:9b63 with SMTP id z8-20020a056a00240800b004f7a8cb9b63mr19312824pfh.33.1650393009772;
        Tue, 19 Apr 2022 11:30:09 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm18351117pfl.15.2022.04.19.11.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 11:30:09 -0700 (PDT)
Message-ID: <9b68b674-b167-89c4-6b77-c3b50b3312dd@gmail.com>
Date:   Tue, 19 Apr 2022 11:30:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ARM: dts: BCM5301X: Disable gmac0 and enable port@8 on
 Asus RT-AC88U
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20220410094454.2788-1-arinc.unal@arinc9.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220410094454.2788-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2022 2:44 AM, Arınç ÜNAL wrote:
> Disable gmac0 which is not connected to any switch MAC. Enable port@8 of
> the Broadcom switch which is connected to gmac2.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, 
thanks!
-- 
Florian
