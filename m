Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586FA52D876
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiESPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiESPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:43:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CE5E769;
        Thu, 19 May 2022 08:43:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq30so9855683lfb.3;
        Thu, 19 May 2022 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m5kPAYHdYcAvP0y9XTgXwmB1ZQjwIlMax/gKQxOCPRk=;
        b=apT9tlxkaVfwr0nABaNIlf22EWq8+BlMG0XXnj6qRjSNqV1RxMYsV2cKb9qJxWV09r
         rimoXcrswkwegkBW96uy9gdqvVq5PPWifgSPvatfAukoulgHYI0XDQGimO2qjAYMhHkp
         jg8uvcr6GfYh0n8gTDq+GgnwNEvShlHYoXuvMEwj2cMnzSZOpjH6FufVMfNNKA72/P7h
         Ao8oJKQcvfFCoqMSJe2yrw68j3iANY3qdYY2bghLZzdsOfJP2mvNV9EytanGnWaa2HXV
         cqSFtXZujLThv3k081hxKCrsq04ULtXY9VsQOas/+LCWMVrk9JMFswryhiJqSGQd5fwq
         4YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m5kPAYHdYcAvP0y9XTgXwmB1ZQjwIlMax/gKQxOCPRk=;
        b=PtHdXeQF/AfLJWTOVEFgDFJ3dxtQAtqDl8LUX1Y1eJOoU9X6aTCJwVnISzOGKyNULX
         IIgKsB1OH6w/97QF+yktR4oiS7V7xvHQiXHSDSYSWFd5ko7oh4J7IpYcgiZn+oplFejl
         bBgFtESa5ASpaX7myEtm8WewCHSop0/wGD5Qtk0F2Oxgbi3mKt5GAQfyiFYHnSOejfQ5
         T2y3LPtuwiR8ReN6QW3U6Uw512IZNXcA3ACqaq3lmU/KWWJkT4RNI98SQsFQ/s5Jn3Qo
         wwsdTpK1kksDdFf4kp/K2lLtNsYVw+IotqCHsvDZ3hyRaYL2W2WntvGyFNlMvJvrwXQ6
         0LfQ==
X-Gm-Message-State: AOAM531rFz8iHT97w8mnb7TnjDjc1Yw3KZSfE0V4WRyMsnToKRPAAXLP
        hgPC2fZZ+uFm5WtomlW4ccjlFJ3LlvOfTzoz
X-Google-Smtp-Source: ABdhPJxl4SL3DRGmo4CMuax8LijL7oRpMQ8G4a0yUA745udxiALLACEvVsL1lFIOnhmPFTuJRTk4jA==
X-Received: by 2002:a19:4f04:0:b0:477:b6c7:9771 with SMTP id d4-20020a194f04000000b00477b6c79771mr3659233lfb.182.1652975031556;
        Thu, 19 May 2022 08:43:51 -0700 (PDT)
Received: from [10.0.0.2] (89-69-162-27.dynamic.chello.pl. [89.69.162.27])
        by smtp.gmail.com with ESMTPSA id g2-20020a19ee02000000b0047255d211a7sm321558lfb.214.2022.05.19.08.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:43:51 -0700 (PDT)
Message-ID: <f6bb01be-d55d-a2b1-2d21-9abb48f3c445@gmail.com>
Date:   Thu, 19 May 2022 17:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Alternatives after removal of ReiserFS
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org
References: <54db8933-f2f3-d31a-c71f-860285e25abf@gmail.com>
 <2631780.mvXUDI8C0e@natalenko.name>
 <20220519101652.iu5jbol2cjwr4y5c@quack3.lan>
From:   =?UTF-8?Q?Micha=c5=82_Dec?= <moog621@gmail.com>
In-Reply-To: <20220519101652.iu5jbol2cjwr4y5c@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan and Oleksandr,

I would prefer to avoid btrfs if possible. It ate my Gentoo root 
filesystem in 2017. This incident has been resolved by reinstalling the 
system because each attempt to fsck only made it even worse. I 
appreciate it for excellent transparent compression and for generally 
good support for Docker, but I can live without it.

 >But given how cheap the storage is these days, people don't care as much.

I don't like this kind of attitude because it encourages a decline in 
quality in general. We'll learn to appreciate what we have once it 
becomes scarce again.

Thank you Jan and Oleksandr very much for your knowledge on xfs and 
ext4. I'll make sure to put it to good use.

Bestest regards,

Michał Dec

W dniu 19.05.2022 o 12:16, Jan Kara pisze:
> On Thu 19-05-22 11:20:24, Oleksandr Natalenko wrote:
>> Hello.
>>
>> On středa 18. května 2022 14:10:25 CEST Michał Dec wrote:
>>> Does the Linux kernel actually offer any alternatives to users whose use
>>> cases are satisfied by ReiserFS? These users will probably be stuck with
>>> a much older kernel once ReiserFS is completely removed. I'm one of
>>> those users and I use ReiserFS to keep around large quantities of small
>>> files and quite ironically these are copies of the Linux kernel. I keep
>>> around 2, maybe 3 separate kernel trees to make sure the kernels I have
>>> on my devices can be rebuilt at any time.
>> I think the advantage of using reiserfs for small files faded away over
>> time and became an old tale that is being passed from one generation to
>> another without any modern adequate testing.
>>
>> XFS should serve you well.
> Yes, so the space savings of tail packing e.g. for the kernel tree are
> likely still noticeable (my tree here has around half of the files with
> size below 4k). But given how cheap the storage is these days, people don't
> care as much. If space efficiency is important, it could be improved by using
> 1k blocksize for xfs or ext4. Also btrfs does packing of small files so
> for lots of small files it may be more space-efficient. And btrfs also
> supports transparent compression so that can reduce space usage for larger
> files even further.
>
> 								Honza
