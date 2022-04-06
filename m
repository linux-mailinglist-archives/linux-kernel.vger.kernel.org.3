Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2784F6B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiDFUPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiDFUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:13:42 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560B14144F;
        Wed,  6 Apr 2022 10:32:48 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id kw18so3187563pjb.5;
        Wed, 06 Apr 2022 10:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1p8gUuneckKY8YLiEV5xhyLd1rkixdksic7T++BXSFo=;
        b=1FEsfjRlo0QfDUzwuwuNA5IhH0olWwSJftyKFQxGAImpRJ3r6cpGWZLRa9O84JAyLJ
         F279G0VKZzSYPUbjgtAEYgNamizRSDvdSMMbekzyeB3IK+7Zumi2dVlEesVMKenyNJYC
         x8xdh4E4/FZ4oSNz3u65wy0Yqtaotehlwnz9/Vq0phY2SRaAeTyG7kmqJny8Hlen8d+/
         7O9fLt5Ky+t3GSeOnve6KI08zUlmaeLxJtQUwCIv8ppni5MMxOn62deov3UTe7MiWAFD
         o35CCokAbRft1iVnKM26AmIPAX6wEkMiWs2PX2D0i8X42/0twcjQw2pi1mGpAk7U90ev
         zK6g==
X-Gm-Message-State: AOAM530pgtT//yc4DkmUe9milgOVAxzti/BdqtIrla5PZU3a3nJINO6G
        sNJid8+gBveFgnMB3trnkI4=
X-Google-Smtp-Source: ABdhPJxyL8mCwgcllhty9biVKtUpTHo4mXsfQpbuIBga5V0A8ZuzeKzBXeJfVylupuW8iUwBo0uotw==
X-Received: by 2002:a17:902:834a:b0:14f:3337:35de with SMTP id z10-20020a170902834a00b0014f333735demr9895533pln.8.1649266367475;
        Wed, 06 Apr 2022 10:32:47 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001c77e79531bsm6454716pjb.50.2022.04.06.10.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 10:32:46 -0700 (PDT)
Message-ID: <e72812a9-1e5b-a826-d490-62ed23d94116@acm.org>
Date:   Wed, 6 Apr 2022 10:32:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
 <87r16bk013.fsf@linaro.org>
 <aeb64d1c4bbddfd8463c07a40ab1fc78be0d158d.camel@gmail.com>
 <87ee2ajuky.fsf@linaro.org>
 <c18a2b359046a14250cafa5a619dbe53f2872b5a.camel@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c18a2b359046a14250cafa5a619dbe53f2872b5a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 10:19, Bean Huo wrote:
> On Wed, 2022-04-06 at 12:22 +0100, Alex Bennée wrote:
>>
>> Bean Huo <huobean@gmail.com> writes:
>>
>>> On Tue, 2022-04-05 at 16:43 +0100, Alex Bennée wrote:
>>>>
>>>> Bean Huo <huobean@gmail.com> writes:
>>>>
>>>>> Hi Alex,
>>>>>
>>>>> Thanks for this unified RPMB interface, I wanted to verify this
>>>>> on
>>>>> our
>>>>> UFS, it seems you didn't add the UFS access interface in this
>>>>> version
>>>>> from your userspace tools, right?
>>>>
>>>> No I didn't but it should be easy enough to add some function
>>>> pointer
>>>> redirection everywhere one of the op_* functions calls a vrpmb_*
>>>> function. Do you already have a UFS RPMB device driver?
>>>>
>>>
>>> Hi Alex,
>>> Thanks for your feedback.
>>>
>>> We now access UFS RPMB through the RPMB LUN BSG device, RPMB is a
>>> well-
>>> known LU and we have a userspace tool to access it.
>>>
>>> I see that if we're going to use your interface, "static struct
>>> rpmb_ops" should be registered from a lower-level driver, for
>>> example
>>> in a UFS driver, yes there should be no problem with this
>>> registration,
>>> but I don't know with the current way Compared, what are the
>>> advantages
>>> to add a driver. maybe the main advantage is that we will have an
>>> unified user space tool for RPMB. right?
>>
>> Pretty much. The main issue for virtio-rpmb is it doesn't really fit
>> neatly into the block stack because all it does is the RPMB part so a
>> non-block orientate API makes sense.
>>
>> Can you point be to where the UFS driver does it's current RPMB
>> stuff?
>>
> 
> It's the SCSI BSG driver, in fact, we don't have a dedicated UFS RPMB
> driver in the kernel. RPMB is a well known LU, we are using userspace
> tools to issue SCSI commands directly to the UFS RPMB LU via ioctl()
> from the BSG device node in the /dev/sg/ folder.
> 
> Here is the BSG part of the code in the userspace tools:
> 
>          io_hdr_v4.guard = 'Q';
>          io_hdr_v4.protocol = BSG_PROTOCOL_SCSI;
>          io_hdr_v4.subprotocol = BSG_SUB_PROTOCOL_SCSI_CMD;
>          io_hdr_v4.response = (__u64)sense_buffer;
>          io_hdr_v4.max_response_len = SENSE_BUFF_LEN;
>          io_hdr_v4.request_len = cmd_len;
>          io_hdr_v4.request = (__u64)cdb;
>                                                                                                                            
>                                                                                   
>          ioctl(fd, SG_IO, &io_hdr_v4))

Hi Bean,

I'm not sure where the above comes from? The Android RPMB client uses 
slightly different code. Additionally, the retry loop around the 
submission of SG/IO commands is very important. See also the 
check_sg_io_hdr() call in send_ufs_rpmb_req(). See also 
https://cs.android.com/android/platform/superproject/+/master:system/core/trusty/storage/proxy/rpmb.c

Thanks,

Bart.
