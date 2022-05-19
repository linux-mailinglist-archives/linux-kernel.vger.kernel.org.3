Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD852D830
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbiESPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241109AbiESPkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:40:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558EA2607
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:40:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w200so5465418pfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=YC/TQekEQMw0NH762DTjCurcW9GINdVnwHMeh2s+uw4=;
        b=kuiu9oZhvF54Qzcfg9cySrjvEvn6zYrznGInC2+X0DDWCWSzgy1boVUSxL4zJypQQc
         Xblzle8ep5i6Y8lk/LWC3AFDdb/axse/zAXNyuHzOTA6RbQ2m0Xe68eX8ngSHG2ZENmI
         vZVVcGClmI30cAotMo4DKshGm6YVt9TIhB5tLLAUzLnArcKRIn5JgAsL/EW5Qu1SwWPz
         +lP2y+cZGWngs8vC8S1XaXH87O0nJk0OgCO/FjjO2gqbAIX+YV9R48Xmgl7F35QxpxLB
         k5uHTP9EDXFJvsWWzEvYYNByZ5eXKtlDY6h/V1lPFu3S6PaOTYmTLuBYbZ0SzBtbYjMJ
         /N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=YC/TQekEQMw0NH762DTjCurcW9GINdVnwHMeh2s+uw4=;
        b=mKvaiI0l9zmIfleWsNV56U8KACL0EOo0LNzyOzgJTbGFcbsCA09apHZp9eXMIOfG7j
         yiYeK0AJc2wUziY9XPOECLAMW343OaCTfk+D6xZD1cYvha+T21WFP7bxKb4FPn+f7heP
         1SJa9Ac5C1n8EIyrP8EjDJIQLsCoMAxJBAORf/MwN8HDMSOTwW519Kv38SMNf1HcFaWR
         +u2ZaMHpLzPuzQN0KEYuz4eXIQ4Q7yjsmETEZM292zDXHDtauo+0hXPuPC5B+sP7+yZY
         dx66MToxXe3EuJy90U3glb1OJh9H5P/lKYJS237r9uRtkBYDbx6UgWYOeS22FUx891K+
         JWFA==
X-Gm-Message-State: AOAM5302l0JhwZJUTE7/ifrYgSKte3PJPTraB9+6yTFniL+QYVBbK+Rj
        Px1rH+hKwgsgE982WI65RcfpRQ==
X-Google-Smtp-Source: ABdhPJxwqa2CA1D4Nh6u/HrWw9OSWEpCsDZsU2aDMDHxcRKH/2bYYMwZEs5/QkB8zRpMnH+RprFljQ==
X-Received: by 2002:a63:343:0:b0:3f6:52e5:edbe with SMTP id 64-20020a630343000000b003f652e5edbemr1682179pgd.272.1652974849844;
        Thu, 19 May 2022 08:40:49 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a7f8b00b001cd4989fee6sm5721035pjl.50.2022.05.19.08.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:40:49 -0700 (PDT)
Message-ID: <bcad7602-890c-d7ce-1b01-2b3ef82674d9@linaro.org>
Date:   Thu, 19 May 2022 08:40:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <49ac1697-5235-ca2e-2738-f0399c26d718@linaro.org>
 <20220519122353.eqpnxiaybvobfszb@quack3.lan>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: kernel BUG in ext4_writepages
In-Reply-To: <20220519122353.eqpnxiaybvobfszb@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 05:23, Jan Kara wrote:
> Hi!
> 
> On Tue 10-05-22 15:28:38, Tadeusz Struk wrote:
>> Syzbot found another BUG in ext4_writepages [1].
>> This time it complains about inode with inline data.
>> C reproducer can be found here [2]
>> I was able to trigger it on 5.18.0-rc6
>>
>> [1] https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
>> [2] https://syzkaller.appspot.com/text?tag=ReproC&x=129da6caf00000
> 
> Thanks for report. This should be fixed by:
> 
> https://lore.kernel.org/all/20220516012752.17241-1-yebin10@huawei.com/

Hi,
Thanks for info. I tested the patch, but it doesn't fix the issue.
In this case it doesn't even call ext4_convert_inline_data()

-- 
Thanks,
Tadeusz
