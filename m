Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E900B539AE5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349022AbiFABpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFABpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:45:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A484A20;
        Tue, 31 May 2022 18:45:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i9so285355ioa.6;
        Tue, 31 May 2022 18:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pyuU9OeurkYsRLJ+IwC7kgyYcpKMo7tA+yLD820Bc3k=;
        b=UtH5dIWP/r0OJOmktGdxZzRIyaGG/xFKUaRYt8IExtMk+oBufMbkxkn136F7SkF3iq
         7zFiieWeZDgwOFDsZ9jGJTeH8Ji2R6v0k8UduPqS+rb4A0W0EASaeavQopb9S1MB8OFf
         cAvLBgBB3UYL97Y0lxVasUaKmnHfH8uYqxXM7uHEJ1K6msSFweAzlzxOxyCyYZXcAGSJ
         6pc58iiupxfG0jGUEin91MaByNcsr/AOnsx2T9aP3tP10L90xqTcpfq6V4ty7+5674lo
         rWOpF+D7I3AutlLVIkPWHBIdHhOCbQ5h6lodxb5nFpyQNJr0ohIFZ+bvv1IIjozyqwH0
         ZBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pyuU9OeurkYsRLJ+IwC7kgyYcpKMo7tA+yLD820Bc3k=;
        b=z1hVhU90fwF5F/zEeC+0HCfUwiT34uRadl2lBM2wxdGI/Ih3tTMUObTYBeP+MTbD4R
         yxdY7WnVs88kqWS8DeNC7TYJxrTo8aME/PDJr9R9u49IVpuCnOj6mLtqGJh4epXnTgBC
         nXzZqs4r6bkMPIgifF5NEbE/x3qpT7T5ITYaU5NtiufEG44WAnzcYci3WR0r7WW3doBY
         BUNZgM+En1ISZ2+TMDZbvsybQhvbnj9VFRS3WQ+hPrrzvXCz/R10i2YPbFO5C7XWO5TB
         6D0RS31yBK7vjGYD0QuHdm7z0LYfjQcyGtnf81/gs3QRlcskiMONbbo7j0wEV7vfOs9S
         tsTQ==
X-Gm-Message-State: AOAM530sV6A0r82dLlDz6374awNgLEX7c81zRwpYzM/+VyaUh6TFgou9
        as+YboK0sSlDW8OgRpcrDFCLRy+gJp8=
X-Google-Smtp-Source: ABdhPJwkl5MzkDc8hG0AeONzlpN6CLFnewxxBB96sU2/QjzEAYjO25L+e41HcpoWIfVSr7+/yCxIzQ==
X-Received: by 2002:a5e:c30b:0:b0:668:825c:8556 with SMTP id a11-20020a5ec30b000000b00668825c8556mr7400697iok.68.1654047931596;
        Tue, 31 May 2022 18:45:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:bd78:a862:1b9c:aef9? ([2600:1700:2442:6db0:bd78:a862:1b9c:aef9])
        by smtp.gmail.com with ESMTPSA id i41-20020a026029000000b0033155f242f0sm154414jac.23.2022.05.31.18.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 18:45:31 -0700 (PDT)
Message-ID: <7c6f0015-cf50-4c8b-060d-f6641d0aeb16@gmail.com>
Date:   Tue, 31 May 2022 20:45:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] scripts: dtc: fix a false alarm for
 node_name_chars_strict
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Qun-Wei Lin <qun-wei.lin@mediatek.com>, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, casper.li@mediatek.com,
        chinwen.chang@mediatek.com, kuan-ying.lee@mediatek.com
References: <20220531053358.19003-1-qun-wei.lin@mediatek.com>
 <8d4b8cc3-8433-24f9-1fc5-12d71e640952@gmail.com>
 <20220531214914.GA2388344-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220531214914.GA2388344-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 17:49, Rob Herring wrote:
> On Tue, May 31, 2022 at 04:43:18PM -0400, Frank Rowand wrote:
>> On 5/31/22 01:33, Qun-Wei Lin wrote:
>>> The function check_node_name_chars_strict issues a false alarm when
>>> compiling an overlay dts.
>>>
>>> /fragment@0/__overlay__: Character '_' not recommended in node name
>>>
>>> This workaround will fix it by skip checking for node named __overlay__.
>>
>> This is not a false alarm.
>>
>> Do not special case node name "__overlay__".  This node name should never
>> occur in a modern overlay source file.
> 
> A dtbo -> dts pass will give warnings, so handling these nodes is 
> worthwhile. Though thinking a bit more about it, I think this one is off 
> by default, but W=2 turns it on.

Yes, at least as of 5.18-rc1 the warning is only if
'-W node_name_chars_strict', so a dtbo -> dts pass will not give the
warning for node __overlay__ by default.

-Frank

> 
> Rob

