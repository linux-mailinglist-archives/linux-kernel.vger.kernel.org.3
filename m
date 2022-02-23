Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0F4C09FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiBWDKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiBWDKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:10:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E69953E1F;
        Tue, 22 Feb 2022 19:10:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m11so13880126pls.5;
        Tue, 22 Feb 2022 19:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=YxZ4j41JmC+V6gjDsQ+lfQY9qYMwYfwsv7btMLIHIMQ=;
        b=dbWFKvFAdKtl6X18CI+FH5+iGbfoh2mjlMUdi8fjEan29y6Yw82L8NVFsUTYr0UgJG
         p7wEy0Y7E37vXqCRf3iuZqQhXtIYmHcoFrXbOTxxC23CQLJoyypQ1lolsZTK5UeTYxnm
         ulsAhhl+PsOePsii0mN92V5YVZIQAKVnn2TfM5Bw+28l+6xNfBITGa7+ttT38rFrvQxf
         M76DMRTqzNqeCZbXmINmD7K+Si/tlWz44Z+5Tb881iJPXCjm4FMU+HeHYIKwykEU+2Rs
         0agC18q+va2QNhMjFvC3fyPP7PZeRhyPC77GFhF7CZt+BY9k8B4mLgOy+InBAANwT+ws
         Ew4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=YxZ4j41JmC+V6gjDsQ+lfQY9qYMwYfwsv7btMLIHIMQ=;
        b=e9Mo2Cusmvbx2kfLWWxhnzrOm3YWv74VbrkxRrBpwa7DWQ/p25vQB5zP2vhQeiE/oH
         pFHp4iq/faKj/NNKJb6G950nxvGKrmi8VamJDLx0dhoExyUHsOLCXKsNbcu83BGuVTSP
         mpwHLXL90Upl5WnA/XY4VUpfCc8HIugLpSSnviA6s6PuLLAtXkdAx0EWFBYJw0WFJibs
         ZNCF7GJFR4OI7JBmJSlI9vty9O2TPYTsr6Y+YPuX95+NXolEgjwp7Du3k3fmvdE/tAk/
         /U7ixPTVlQn7HY3j+DC9HY1QLWP73Yp34lMDlHPDzOh60gLF1RbvUkFU9BuE17O+xGpv
         KDuQ==
X-Gm-Message-State: AOAM532Qw+cbOxNg2/JIH7T5hYwmJxCWDNr4hXyPCEuZECn8GeVbMS0T
        l7H1vY/i+kUBzZk9Y9KsHAg=
X-Google-Smtp-Source: ABdhPJzgdlR4dkD4kwlx8q9vkOZZ4nbCOW1wkoxYhpUu3/H8fuZuK5axrZD2f01Oh0jrj89yYZ4k1g==
X-Received: by 2002:a17:902:e5ca:b0:14f:3a3d:44a5 with SMTP id u10-20020a170902e5ca00b0014f3a3d44a5mr25947253plf.139.1645585804770;
        Tue, 22 Feb 2022 19:10:04 -0800 (PST)
Received: from [172.20.119.15] ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id f19sm11672844pfc.110.2022.02.22.19.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 19:10:04 -0800 (PST)
Message-ID: <39db454d-ca30-fb42-3d72-899efa34fb78@gmail.com>
Date:   Wed, 23 Feb 2022 11:10:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Content-Language: en-US
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <YhUbCH+dhKkgMirE@slm.duckdns.org>
 <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
In-Reply-To: <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/23 11:08 上午, Wang Jianchao wrote:
> 
> 
> On 2022/2/23 1:19 上午, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Feb 17, 2022 at 11:13:44AM +0800, Wang Jianchao (Kuaishou) wrote:
>>> (3) Add /sys/block/x/queue/qos
>>>     We can use '+name' or "-name" to open or close the blk-rq-qos
>>>     policy.
>>
>> I don't understand why we're modularizing rq-qos in this non-standard way
>> instead of modprobing to enable a policy and rmmoding to disable. Why are we
>> building in qos names into the kernel and adding an extra module handling
>> interface?
> 
> Hi Tejun
> 
> We just want to provide the flexibility for the user to open/close a policy
> per device. If we need to the policy on a device, we needn't to waste cpu
sorry, it should be "If we don't need the policy on a device" ;)

Thanks
Jianchao
> cycles and memory for it.
> 
> Thanks
> Jianchao
