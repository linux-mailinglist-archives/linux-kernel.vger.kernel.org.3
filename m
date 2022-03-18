Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F864DDAFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiCRNzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiCRNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:55:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A11905A5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:53:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so6699051wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b7mi92NL1Au3kNjhkOmUgX0hQow1JPh6u+4eSDIWQIc=;
        b=ews3bommJQ0hcnjr0GmzZZsrJ9edQDWYNB7s1dAbprwYyCqVFkbq0B4fgr4MeMqQiT
         8GKO27fK4hQOCZ1xPeLJOCXLMn2J4CyerFzfkU7YysLinkc2TfjJ2uONrhMjroLpMXOD
         xnbC3eOToR1FeHhpEat9Pej0r6Li/PE1paGlYuBYmuXI9M1PQB5w+gPM0P7BJsTjKDx0
         /NbU2o7b1Sv9CAQiKZsckUnTLb+mCwgeM7uNnw8wNixPotUFMLGYSkkyk3WqPKCQ4aA0
         e8chTqjYbPjm5auPYnB/5tpp5P4VqKfcYsAJ+n5pS652kItbDYZdP/zlA/HoYRMv75KV
         +1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b7mi92NL1Au3kNjhkOmUgX0hQow1JPh6u+4eSDIWQIc=;
        b=yapIq76anUX5MXY5C7kDP7iGG7o6XyMKGz5HIrMGcrBUsm6J/f4GX8Ap4SLXlq4h2M
         43uCMW8hnc+D27SUaHnnR6o/7QGyPGoSnPXJ6I6zg4NBBXqKziSA6rKNntq8j+iI7VfH
         qjUox493Bj74EuvX0FwAqU0OSR9a/m8epo6GvEmuhHyD1v5ibNvgMrpXtjW6Qd5TN0Y7
         WtKqzY86XFqONxBCG1jcjMWsZy+uh3ofPH2UpBqXwZKnkTqp5ZDFE6I8b2+JVmXuLfxf
         V1He0hUqnzZVLSq7koxJFwgYXNXrxLT57JmUjVTqe1OKX8H3mWlhBFe0XqXHNoxRR1yD
         mlNA==
X-Gm-Message-State: AOAM530AWvdumj2ppVoxX+3ZGTiqIBHVBgLZQVdjYAiVD9QL0LOM4YIg
        Nl3/mY93HH8npjeg3hlOuLc4sYIT0Tn8ig==
X-Google-Smtp-Source: ABdhPJzbNwQi18YYbbmjFbq5mvgLobh+pg7PjXQ2Tq3BPsBF8eSR7ZTyQpPBTqXupvpWSH7bJsmHlg==
X-Received: by 2002:a05:600c:35ce:b0:389:ec57:1d7f with SMTP id r14-20020a05600c35ce00b00389ec571d7fmr15752827wmq.149.1647611619732;
        Fri, 18 Mar 2022 06:53:39 -0700 (PDT)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b001f07772457csm6252032wrp.101.2022.03.18.06.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:53:39 -0700 (PDT)
Message-ID: <a5b9e66c-235b-51dd-234c-b543dbacc464@gmail.com>
Date:   Fri, 18 Mar 2022 14:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
References: <20220318103423.286410-1-coxu@redhat.com>
 <c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com>
 <20220318122110.7qjrnrduwytjle3w@Rk>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20220318122110.7qjrnrduwytjle3w@Rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 18/03/2022 13:21, Coiby Xu wrote:
...
>> Why is it not done through keyring and forcing kdump to retain key there
>> (under the same keyring key name as dm-crypt used)?
>> Kernel dm-crypt supports this already; LUKS2 uses keyring by default too.
>> That's all you need, or not? Why do you need to add another "kdump:" thing?
>> IOW why kdump cannot copy the key to keyring under the name dm-crypt
>> has in the mapping table and let dm-crypt activate the device almost without
>> code changes?
> 
> Sorry, I haven't explained how kdump works. Once the 1st kernel crashes and
> the system boots into the kdump kernel, the kdump kernel only have direct
> access to the memory exclusively reserved for it i.e. the kdump kernel
> loses the direct access to the keyring constructed in the 1st kernel. In
> theory, the kdump kernel could do some "hacking" to find out the key
> stored in the memory directly managed by the 1st kernel but I imagine
> this would be difficult task (imagine I present the memory dump of my
> computer to you and ask you to rebuild all the relevant kernel data
> structures and find the key). Besides, it's not reliable to read the
> memory directly managed by the first kernel for example the memory could
> be corrupt. So we have to pass the master key from the 1st kernel to the kdump
> kernel.

OK, then why you cannot store it to the (2nd) kdump kernel keyring?
(From the kdump area copy, then you do not need to patch anything else
in dm-crypt than that one line storing the key to the kdump area.)

A clear approach would be to store the key in the 2nd kernel kdump keyring
and allow userspace to read it.
Then cryptsetup can just validate the key (LUKS key digest does not use Argon)
and activates it without asking for a passphrase.
Perhaps this will need some new cryptsetup option (or API call), but I think
it can be done.

Or, you can actually simulate it with
   cryptsetup open ... --master-key-file <file>
where this keyfile contains directly the volume key, not a passphrase.
The key digest is verified in this case only; no costly PBKDF is needed.

If you have a way to retrieve the kdump stored key to kdump userspace, this
is perhaps a much simpler solution.

All this is against all countermeasures to not expose encryption key
directly - but if kdump is debugging environment, just saying...

Milan
