Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6DF49EFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiA1Acp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbiA1Acn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643329963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxwT0p8jQCZb+gDYDDAwQr1KnfSYAuazHgIfPZ6mp0Y=;
        b=LD3rPnW4RqKgEJpLIhn/9HW4Yjw1qhIdGAtAKh1j+of7L/PAmtfnfjv9yQYG5L2jSEWHz4
        W4KxHPY0n0ieW3QuX4dWiulb+Md9IJBcx3DjGbwg27MQXpBhXjOIbZCxMyoIZtEUu8M//a
        nt8l8excJ9N8t3AI2go3DqshAJDLgns=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-bxqzAHFSNjOz__AQ-eV27g-1; Thu, 27 Jan 2022 19:32:41 -0500
X-MC-Unique: bxqzAHFSNjOz__AQ-eV27g-1
Received: by mail-ot1-f72.google.com with SMTP id y20-20020a0568302a1400b0059ea94f86eeso2429475otu.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QxwT0p8jQCZb+gDYDDAwQr1KnfSYAuazHgIfPZ6mp0Y=;
        b=FKBBheDo7nr2PqmHzrXLZm7u+ryalyzUcLzB/3bzPRGtx8PkmyESW/D/km4sG9yFMr
         VjUmF7saV3w99uK1QXKZUZ5XazQ5GMAfZor9stROrQ8fnyoS+glp9wM+I94cKPl5+N6L
         bGlw+y0LGtDvCN5bfEEmM86jiozBFF8El5JgkVA6zexuRyXuKLGqNLFie9b5OUo1x98y
         QsCyhDH3dJLGLC5H5aZOIn78WNCT6CnI2KcN1HsB3d4kejxYbmX3wgpOyWA9ZSMVb8Ei
         SF1iitae6S1IwrBTtvfChg8aVl3SH4lTXiGPD6en0q6DPKkDY4V19V7Dapiqv0CqIMD8
         aUwQ==
X-Gm-Message-State: AOAM533+7FI6trLFbp3hPeo8Wc7MOrpE57p7w+Tuo0J/n9wPo43F+/zb
        +QSiUrDZwaNeLZQv3ORXXFSVois1A4VpuIw/QNVba0mym20MoSynYeBU94pajct9WYYyEgdy7JP
        JBuThCRxG9cya81xdaVwFcrsF
X-Received: by 2002:a4a:b787:: with SMTP id a7mr3106245oop.85.1643329960830;
        Thu, 27 Jan 2022 16:32:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF4iZ8xzJp9ZMKoGlSFxuWfDOTK7MBV3+iSOO5oBeoOMi/8a1yzMEOflCdZN68H6r2hM3ikw==
X-Received: by 2002:a4a:b787:: with SMTP id a7mr3106237oop.85.1643329960607;
        Thu, 27 Jan 2022 16:32:40 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o22sm9333917oor.34.2022.01.27.16.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 16:32:40 -0800 (PST)
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Joe Perches <joe@perches.com>
References: <20220127151945.1244439-1-trix@redhat.com>
 <953eb015-4b78-f7b-5dc1-6491c6bf27e@linux-m68k.org>
 <CAKwvOdnWHVV+3s8SO=Q8FfZ7hVekRVDL5q+7CwAk_z44xaex8w@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fb308f51-f16b-3d9b-80c2-180940236b00@redhat.com>
Date:   Thu, 27 Jan 2022 16:32:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnWHVV+3s8SO=Q8FfZ7hVekRVDL5q+7CwAk_z44xaex8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/27/22 2:47 PM, Nick Desaulniers wrote:
> + Miguel (the clang-format maintainer), Joe (checkpatch maintainer)
> These criticisms are worth reviewing.
>
> On Thu, Jan 27, 2022 at 2:38 PM Finn Thain <fthain@linux-m68k.org> wrote:
>>
>> On Thu, 27 Jan 2022, trix@redhat.com wrote:
>>
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> checkpatch reports several hundred formatting errors. Run these files
>>> through clang-format and knock off some of them.
>>>
>> That method seems like a good recipe for endless churn unless checkpatch
>> and clang-format really agree about these style rules.
>>
>> Why use checkpatch to assess code style, if we could simply diff the
>> existing source with the output from clang-format... but it seems that
>> clang-format harms readability, makes indentation errors and uses
>> inconsistent style rules. Some examples:

Problems with clang-format should be fixed, I'll take a look.

I was reviewing this file for another issue and could not get past how 
horredously bad it was and really did not want to manually fix the 400+ 
formatting errors.  I will drop this patch and use the use these files 
to verify the .clang-format .

Tom

>>
>>>   static unsigned short int max_sectors_per_io = MAX_SECTORS_PER_IO;
>>>   module_param(max_sectors_per_io, ushort, 0);
>>> -MODULE_PARM_DESC(max_sectors_per_io, "Maximum number of sectors per I/O request (default=MAX_SECTORS_PER_IO=128)");
>>> -
>>> +MODULE_PARM_DESC(
>>> +     max_sectors_per_io,
>>> +     "Maximum number of sectors per I/O request (default=MAX_SECTORS_PER_IO=128)");
>>>
>>>   static unsigned short int max_mbox_busy_wait = MBOX_BUSY_WAIT;
>>>   module_param(max_mbox_busy_wait, ushort, 0);
>>> -MODULE_PARM_DESC(max_mbox_busy_wait, "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
>>> +MODULE_PARM_DESC(
>>> +     max_mbox_busy_wait,
>>> +     "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
>>>
>> This code is longer for no real improvement.
>>
>>>   /*
>>>    * The File Operations structure for the serial/ioctl interface of the driver
>>>    */
>>>   static const struct file_operations megadev_fops = {
>>> -     .owner          = THIS_MODULE,
>>> -     .unlocked_ioctl = megadev_unlocked_ioctl,
>>> -     .open           = megadev_open,
>>> -     .llseek         = noop_llseek,
>>> +     .owner = THIS_MODULE,
>>> +     .unlocked_ioctl = megadev_unlocked_ioctl,
>>> +     .open = megadev_open,
>>> +     .llseek = noop_llseek,
>>>   };
>>>
>>>   /*
>> Readability loss.
>>
>>> -             prod_info_dma_handle = dma_map_single(&adapter->dev->dev,
>>> -                                                   (void *)&adapter->product_info,
>>> -                                                   sizeof(mega_product_info),
>>> -                                                   DMA_FROM_DEVICE);
>>> +             prod_info_dma_handle = dma_map_single(
>>> +                     &adapter->dev->dev, (void *)&adapter->product_info,
>>> +                     sizeof(mega_product_info), DMA_FROM_DEVICE);
>>>
>> Note the orphaned first parameter and odd indentation.
>>
>>>   static DEF_SCSI_QCMD(megaraid_queue)
>>>
>>> -/**
>>> +     /**
>>>    * mega_allocate_scb()
>>>    * @adapter: pointer to our soft state
>>>    * @cmd: scsi command from the mid-layer
>> Indentation error.
>>
>>> @@ -418,15 +409,14 @@ static DEF_SCSI_QCMD(megaraid_queue)
>>>    * Allocate a SCB structure. This is the central structure for controller
>>>    * commands.
>>>    */
>>> -static inline scb_t *
>>> -mega_allocate_scb(adapter_t *adapter, struct scsi_cmnd *cmd)
>>> +     static inline scb_t *mega_allocate_scb(adapter_t *adapter,
>>> +                                            struct scsi_cmnd *cmd)
>>>   {
>>>        struct list_head *head = &adapter->free_list;
>> Same.
>>
>>> @@ -586,26 +568,25 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
>>>
>>>                ldrv_num = mega_get_ldrv_num(adapter, cmd, channel);
>>>
>>> -
>>>                max_ldrv_num = (adapter->flag & BOARD_40LD) ?
>>> -                     MAX_LOGICAL_DRIVES_40LD : MAX_LOGICAL_DRIVES_8LD;
>>> +                                    MAX_LOGICAL_DRIVES_40LD :
>>> +                                          MAX_LOGICAL_DRIVES_8LD;
>>>
>> Churn, if not readability loss. Note the indentation change here is
>> inconsistent with the indentation change noted above.
>>
>>>                         * 6-byte READ(0x08) or WRITE(0x0A) cdb
>>>                         */
>>> -                     if( cmd->cmd_len == 6 ) {
>>> -                             mbox->m_out.numsectors = (u32) cmd->cmnd[4];
>>> -                             mbox->m_out.lba =
>>> -                                     ((u32)cmd->cmnd[1] << 16) |
>>> -                                     ((u32)cmd->cmnd[2] << 8) |
>>> -                                     (u32)cmd->cmnd[3];
>>> +                     if (cmd->cmd_len == 6) {
>>> +                             mbox->m_out.numsectors = (u32)cmd->cmnd[4];
>>> +                             mbox->m_out.lba = ((u32)cmd->cmnd[1] << 16) |
>>> +                                               ((u32)cmd->cmnd[2] << 8) |
>>> +                                               (u32)cmd->cmnd[3];
>>>
>>>                                mbox->m_out.lba &= 0x1FFFFF;
>>>
>> Here, the orphaned term is moved up, next to the =. And yet,
>>
>>>                        /* Calculate Scatter-Gather info */
>>> -                     mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
>>> -                                     (u32 *)&mbox->m_out.xferaddr, &seg);
>>> +                     mbox->m_out.numsgelements =
>>> +                             mega_build_sglist(adapter, scb,
>>> +                                               (u32 *)&mbox->m_out.xferaddr,
>>> +                                               &seg);
>>>
>>>                        return scb;
>>>
>> ... here the first term is moved down and orphaned, which is another
>> inconsistency.
>
>

