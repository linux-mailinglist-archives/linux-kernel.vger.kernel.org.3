Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B12531C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiEWTWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiEWTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:21:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8CA1084
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:00:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a13so3391749plh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=qHQRWZlwoGdU6ErLuvWwml1oIPtHMNgZBkNaf39Pttc=;
        b=FbNXo+LPE0KG9Vjin2ENCUx+ZWqjd4ldDj/qAZEAYVpiphL2DMX3v6vce9afabzjzu
         GMo/8spdJjJhSA3UhWf4YOxg2yO0d5ub3rmpnOg5yo23NKY4fLO7eOEKoPdRG/vIlt7w
         wbDQiwkGA3ZMF+h2eac9ZaqgWJtOxzXkjtdeKzggrGUeIBwdKf0ovKLmhWMnfLrkdkcb
         tyi5PmB/yvaaiAojn48DrGj2ZkkKa3c2jnPLUgIXQAv/pJPuU1S17QEVcoXpQ/5ePIFu
         YChC3fPNAsKFkJDmtNmgnTKJsFmTHaIVKHt34/kN9qjk0tQ/D0pTBX3QSL73mI59pR2c
         JpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=qHQRWZlwoGdU6ErLuvWwml1oIPtHMNgZBkNaf39Pttc=;
        b=xsQH7G/ElMmxnx8SRFEj12cu+Va9vzvk69Nt2G1cL4R2m0Tvvfapda2ZslofmQ3x2j
         UshNuYS5+++xMNog5elKkTE42asa+U0TnXP/9Lo69qIP53GROwJSRfwjIjxSX9z9AIVe
         mm6c46EFmd/ELxufChEEucRqzIKdS8mq65xLE0qxFrTyYxkU3GCiaa21csPne0JpXQ/5
         pZGY2SQWMAIMZUZVKqIEqmbVmgAyfUmfwKU4jhhV85S3B6ln3f9ExoE/+LafHveHXikp
         rR4V2PUifIFSMJdhaNLxvD8ejcbb+sKTCkeAZaBAQ2Ce2cP+Ks+c9TUddOhvF+uxv9NU
         EfEQ==
X-Gm-Message-State: AOAM532Yw/mBGUUnof4d3yadZEUb8lHYn3APoreFSFQ2DBl7xZYUoyTv
        RHKk7tQtJWWo/TTGG18AZhMNYg==
X-Google-Smtp-Source: ABdhPJyYFIHlR3rSrGu04Wy/eyHyWZWBnhW8nj1/UxMh9uz+nOCDIJ3y/IGdqu5e7koIeu2X6K3/VQ==
X-Received: by 2002:a17:902:ab1d:b0:161:527e:277 with SMTP id ik29-20020a170902ab1d00b00161527e0277mr24044794plb.73.1653332407430;
        Mon, 23 May 2022 12:00:07 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090aeb0400b001df54d74adbsm43200pjz.25.2022.05.23.12.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:00:06 -0700 (PDT)
Message-ID: <6ac66e89-2063-c5e8-df15-f77b76befc05@linaro.org>
Date:   Mon, 23 May 2022 12:00:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz> <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
 <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
 <YodNu2C5iHKW3UeZ@slm.duckdns.org>
 <489592f6-b783-7bdb-2cc8-0c8e35ebc674@linaro.org>
 <20220520164255.GB17335@blackbody.suse.cz>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
In-Reply-To: <20220520164255.GB17335@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 09:42, Michal Koutný wrote:
> On Fri, May 20, 2022 at 09:38:12AM -0700, Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
>> as this is a result of enqueuing the same css->destroy_work onto the same WQ,
>> one on the rcu path and one on the css_release path.
>> I will prototype it today and test with syzbot.
> 
> In my understanding, you'd need two independent work_structs in a css,
> not two separate workqueues to put the single entry on.

Yes, separating the css_killed_ref and css_release paths with two separate work_structs
fixes the two syzbot list corruption issues [1]&[2].
I tested it on mainline v5.18.0 and v5.10.117
In case of [2] the mainline triggers an issue, but it is unrelated to list corruption.

[1] https://syzkaller.appspot.com/bug?id=e26e54d6eac9d9fb50b221ec3e4627b327465dbd
[2] https://syzkaller.appspot.com/bug?id=3c7ff113ccb695e839b859da3fc481c36eb1cfd5

I will send a patch soon.

-- 
Thanks,
Tadeusz
