Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6FA4B9108
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiBPTNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:13:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiBPTNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:13:30 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E52604CE;
        Wed, 16 Feb 2022 11:13:18 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso2118507otv.13;
        Wed, 16 Feb 2022 11:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=khjBXMu8Pmp2XyrKsmJgjMOcblNVmXnA/K3N7hZ/TF4=;
        b=NT4yE1nf85Ho5AKu6IhOl+ZPxNcBEBuiH2t2b7S/4GsKrRGC+zvnGYPt/8QhHoVkEU
         VoWxktblqusdrlOdHHlT4M9dob6Pu4psbX5l0cyY6NAquczVS4rBQ1iP5P/ca+0zKzTJ
         Zvj4I7dcji+w5RkXwuf7KCr5TgTRQ8RDjIRE0TPVQTNPMUkjgaYLYVPh1WJW6fcgtUG1
         S26N01UcLCaiQti9haVLDL1f0+f/wCsETRuFWXKOIQn/boc0nviJHFAtbvq+PRirNycV
         /MoDFG8Dkt8GaBCEXPtUOdX7p7/wDBjou+Rv9yBSQxvwsYI+dh6ZlhJGJbAiLQq52OjU
         HdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=khjBXMu8Pmp2XyrKsmJgjMOcblNVmXnA/K3N7hZ/TF4=;
        b=UQ45r7QZM2mFQTo+bl4pLa4gPhvVjXdSxXoNldhk3mEKP5eEEXFKqy2TIA1lRTtnXg
         0qrEyEZOAQASj7Wl76rM/uMjomHBKbrRB/xgATNYERw97clKWGIvmbps4OWeMVe4x3C6
         z+j2MF4GaSQpHlm/XAxRUU/M8sxfQcdbXTokRyu/GCQkQPi6RSG0HY5j6sgVugZi1e+R
         iTKrrHId4Q98+9h1PpiJiMuIhG9WlyXteJhg1FtjdmShj1WRWYP7U4Ob6BrU7pveU5V3
         30KoTFA+3bbH0nZJaWn9irRvlvC65I0LxJVOcAQzbsRsUAAqQVU5VTxKXjiurHaLEhpR
         m1Rg==
X-Gm-Message-State: AOAM530uppJNt9A5yqqW4tM7g5F40DIwvded7aqWAkXk5cTszjFjIg7w
        qa+4urXVNmxyMezgn6mgYiE=
X-Google-Smtp-Source: ABdhPJwU8/E4sWE9N418+UcGFq3Qcg5di4cFRmR62Yi0BpWdBLo59dvQt3RFgMeRj+7tGdk9qBWNhg==
X-Received: by 2002:a9d:6288:0:b0:5ac:1ccf:ac2f with SMTP id x8-20020a9d6288000000b005ac1ccfac2fmr1383899otk.94.1645038797672;
        Wed, 16 Feb 2022 11:13:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z4sm221486ooi.0.2022.02.16.11.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:13:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9e14486b-36c0-5869-a368-98b90b4dcd14@roeck-us.net>
Date:   Wed, 16 Feb 2022 11:13:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] hwmon: (asus-ec-sensors) merge setup functions
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220216180822.GA3300192@roeck-us.net>
 <CAB95QASWWMvSSuuwQU=TwZX-QcU=hRPCJVQ0E6Bh29sc4d66Ug@mail.gmail.com>
 <7f3fc06f-cf4e-2dc6-e68a-917117fe8895@roeck-us.net>
 <CAB95QARa=XQ0LEEqM0R6YvBDrK1GRn=R+jszagMuzBKdo3pBZw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QARa=XQ0LEEqM0R6YvBDrK1GRn=R+jszagMuzBKdo3pBZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 11:00, Eugene Shalygin wrote:
> On Wed, 16 Feb 2022 at 19:49, Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> * If your patch generates checkpatch errors, warnings, or check messages,
>>     please refrain from explanations such as "I prefer that coding style".
>>     Keep in mind that each unnecessary message helps hiding a real problem,
>>     and a consistent coding style makes it easier for others to understand
>>     and review the code.
> 
> Yes, of course. My question is what do I do with 6 other braces single
> statement if's now?
> 

Nothing as part of this patch. My fault for not bringing this up earlier,
but that is no reason to not clean up the code while touching it.

You _could_ submit a separate patch fixing everything reported by
checkpatch, but that is up to you.

Thanks,
Guenter
