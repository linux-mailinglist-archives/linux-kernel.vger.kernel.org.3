Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30E352325C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiEKMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiEKMBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:01:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BDA4EDD6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:01:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ks9so3602510ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u0tXYiSeuXA4FVwlCLUjj/6hu6YWAxriDMO2+yxPWNc=;
        b=ZrTmlykHSj+S0huxirDYojqYGuVzHoCYaHH91i7yN0mM5h+M56A12TUvN8Skjs6vPm
         PwWe71+c7ULDUNOD5k6JxDhkDP7ruDyIHNcFPy2cy+YbEVlvQ671sN7JEdGqFGshdvwL
         ZvG2qjbPQ6u9wmSZmmlgezObYMdfJddPQqSxr7kiRcZnwewNpivHI8UF/mii8FdmHHmZ
         V04GU6Ti6LaRLCCcBtSanblCaOZ85U113K6kJeniqfcDhDiG/UIdaPzFqTiyOxS/mX3+
         arUQmzNrq7YdNOLjxrkJd3UeSqYa/Kui04hUX0kZOAR5lbYCo9ZNA+wXDrrx05AnpP/T
         il1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u0tXYiSeuXA4FVwlCLUjj/6hu6YWAxriDMO2+yxPWNc=;
        b=U3mUZ3jQ+7l774Ft1qV2fa1wmLdcYY6A9fcIW3soTqS6OZLZ2ojb3kH9quqyPqX59B
         I6VEcxbtvjAIaB6zJsVqeWboJG9179DF8tYu0+myAhYL8Sao1lDGA5mKdvPzygBZY/M9
         czBnePAwDY6Ue2jcVj7uu/g4L6Y56Asx4rvhiksKUFFN5cvaJchq2kLQg3VmcF2EKr1H
         cn8y8jJ7BMO0wYJNG3lCZbh5b/pnKsTIdFToJYOPo6qBrHa+21zSaIt1oFD2sK8Ppnhd
         x2qJXxfqmRZ8dAIiESJ9TQK0OqfE/fVfVzQKPbi8T4Oej+912s35xiykeu1TXWcMDehS
         CfeA==
X-Gm-Message-State: AOAM530XgaBrpI2Rwvj0//zteVX+xiaJb4zaes1PyE+tT6JdpU93WfTC
        Fyn65Qc7V0HJu8Y1CChF3qA=
X-Google-Smtp-Source: ABdhPJzAFZ+vxEQu3OHLMnECL3HYa9cUsTXIROH8hc9i7mPtTAEXu+GpE2VIzruTOuwuOMr6lj0rQw==
X-Received: by 2002:a17:907:6d94:b0:6f4:531d:742 with SMTP id sb20-20020a1709076d9400b006f4531d0742mr24195945ejc.202.1652270490073;
        Wed, 11 May 2022 05:01:30 -0700 (PDT)
Received: from [192.168.178.21] (p57b0be56.dip0.t-ipconnect.de. [87.176.190.86])
        by smtp.gmail.com with ESMTPSA id t9-20020a170906608900b006f3ef214e35sm918539ejj.155.2022.05.11.05.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:01:29 -0700 (PDT)
Message-ID: <8e54ec49-09da-f345-35cd-430712f5a6ad@gmail.com>
Date:   Wed, 11 May 2022 14:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
 <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
 <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
 <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
 <675a2d33-b286-d1d0-e4e7-05d6516026c0@gmail.com>
 <CABXGCsOqrB5zPFCeLw-VQjePikwDq4EKFQGc9hbOb5f7tGLDgg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsOqrB5zPFCeLw-VQjePikwDq4EKFQGc9hbOb5f7tGLDgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.05.22 um 11:05 schrieb Mikhail Gavrilov:
> On Fri, Apr 15, 2022 at 1:04 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> No, I just couldn't find time during all that bug fixing :)
>>
>> Sorry for the delay, going to take a look after the eastern holiday here.
>>
>> Christian.
> The message is just for history. The issue was fixed between
> b253435746d9a4a and 5.18rc4.

We have implemented a workaround, but still don't know the exact root cause.

If anybody wants to look into this it would be rather helpful to be able 
to reproduce the issue.

Regards,
Christian.
