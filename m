Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8697A5795BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiGSJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:02:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119D11834;
        Tue, 19 Jul 2022 02:02:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by8so12995340ljb.13;
        Tue, 19 Jul 2022 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p0E0Be3SRX+B6mBT6tjTQekPG7Azaelaf+cATs6Lt78=;
        b=VVxqLw1tjJ7lPfAnKCisYxU17cXqNVbli66rHN/ODqG4ndZNHyVjlrEUUoO5Mj//XC
         bmWerZaH8C+VVY8BJBsZybvBhVnkvzOTAgVlehrup0TQS0TsgXdNB/uYF6C5gg0clPoQ
         smZWNlP5fKgf/LYQNoutEFf8G9rpyZumKwG7OnOK0R/5UiHg86mNEg7uqmRnHt6GfiAz
         uXpfsVM/eYyrrp90TMHXZREhNZgCdvYwk+KY0QFH3rqnG2BHtH0Y+RYR2HDL6C3M935s
         23W8qmbpxzpkMnBDp7098mh0Hq52+iCjWRrGmKwbnSH6iI2DQkR2Da1J7wo657cnJlnN
         WFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p0E0Be3SRX+B6mBT6tjTQekPG7Azaelaf+cATs6Lt78=;
        b=Cmec76GyaZo8vfEvgTiSPsms4Wm58nFrbPeYjzEILwIaWgBHcdzOgu6ij8VUy8Wpro
         V9pNDEne2lH0/ICV9eff2jYYcP0wfN7WZBVr9PBkGjK2GV41mJvcyvghJIHrh+1Ivzhp
         mnLuFWdryitFk94iDtt4nAN158qZHmdWjctrxd+FWOMwrlK6iRFJ+IQXl4MI5bUfbqEl
         jbiRXkJ6jNJm2id5JUNfLDXlNZQLmQ/Qd/zhsimBbfYe14t68KwH2zYlAd3i8+ES8FaA
         an2PrpnVVb9eWFXxRuiBQ1UPJiuS50DOGe3qziABqaAHutwRLvuNTd3CP/w3QRV4ocIe
         SJ3g==
X-Gm-Message-State: AJIora9k5x/brEEFnzEALxOMdM4P6MFAC0k9t6OlrfqKPRXFlzjf1uso
        8LnXRmbPEHawl9vYiRedRmZHyYl9OV8=
X-Google-Smtp-Source: AGRyM1veFmVZByMri4R3nt9nhYkOmvwTAW8R1MT9BZa8BpAwtKBu0M6OcVOYLLzX9nx4we9I+TWtcQ==
X-Received: by 2002:a2e:92c6:0:b0:255:84cb:4eea with SMTP id k6-20020a2e92c6000000b0025584cb4eeamr14157626ljh.204.1658221336305;
        Tue, 19 Jul 2022 02:02:16 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.75.224])
        by smtp.gmail.com with ESMTPSA id o22-20020ac25e36000000b00482f206b087sm3123353lfg.39.2022.07.19.02.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 02:02:15 -0700 (PDT)
Subject: Re: [PATCH v2 03/25] usb: gadget: f_tcm: Increase stream count
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <79dbca4db65f676df37462b7a008198c81a3297e.1658192351.git.Thinh.Nguyen@synopsys.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <c54b0d7a-eb97-2ffe-7169-51151707d4ce@gmail.com>
Date:   Tue, 19 Jul 2022 12:02:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <79dbca4db65f676df37462b7a008198c81a3297e.1658192351.git.Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/19/22 4:26 AM, Thinh Nguyen wrote:

> Some old builds of Microsoft Windows 10 UASP class driver reject USAP

   UASP?

> device with stream count of 2^4. To keep compatibility with both Linux
> and Windows, let's increase the stream count to 2^5. Also, internal
> tests show that stream count of 2^5 increases performance slightly.
> 
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
[...]

MBR, Sergey
