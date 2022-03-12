Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA114D6F88
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiCLOVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 09:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCLOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 09:21:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C760CE0;
        Sat, 12 Mar 2022 06:20:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id w27so19801968lfa.5;
        Sat, 12 Mar 2022 06:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xxng1XACAuzas2FHe44rwKp6k4WnZM5V6/BhtW2iAeo=;
        b=OUHiPI/6v3cfddwCsDB3lBYPkJdhHyZHPPhxL6PKDCfaD2MiJfBr7F4D4dfN8/mjsl
         jyE8hTh19krEVng4t1IHEIb1+oIxs7n0XY3wG4VVAFvhc3JXt1xjONY2dd7tAZ+UdsEP
         zAcAfgpc7hJr83tqtx0qiSX1PeZL0xOmbD3nPc1cT/nN9a5m8H3JTaeSEDNF5BD6/rzT
         Ofxds2cX/nRwiMU32Hk2FwrZcLUYv7fyh4cYjNa4zU5rRZjIZOxEdpubHg7fBQrzZ745
         WhtYxDla3/KxtVTpF3rpsibWhxTPomoLlg6vdWrF3+ESzjCjR24pGoctrUxcRogwamlf
         4exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xxng1XACAuzas2FHe44rwKp6k4WnZM5V6/BhtW2iAeo=;
        b=3L2GWf1jBZpRIDRpc6Iui+MfKTc4rYrV8SKXgoXrIeUMcsvfMUsnEajMdzI+A09pGO
         mho+PAWPFqG+Na77342xGRstB4COvDlf4YLNR/ha8xGnFCJWq/I4IM52mdUauKFlYutZ
         FyNdtGQT2R74RfXH9FDghp9hEoNU4Ea0zMaHGpBHEWLUI3dmwVR8G84t+wXnCrkqUrJK
         XV6ydXkGrEy8hQFo3A+CCrE80QQI1Chj/HlNFIR+fZJuwTEv5hqzl/bH+tc2ejvZ5XWa
         1Gq22HdvqhuIOgn6h3gFlRWueBD4wkWCeTB6Cz9noF9mHNVHKovoyxIUJ/FOnhx0OzLk
         tP6Q==
X-Gm-Message-State: AOAM531z9L9EOFQpCFHB2+laSRQXj5kSv8h/wTJ/SkjBGKX56sVF7qo4
        IwYebHlsWUY8/iPgT6u+2doHNxx5y/o=
X-Google-Smtp-Source: ABdhPJy9BPEsaybUQe2QH186IbUf4hNodmexzlfLnvy/x2SmGsZPCpyHOmYdoWUR/gj1NlkKCitkRw==
X-Received: by 2002:ac2:529a:0:b0:448:2fc6:31b7 with SMTP id q26-20020ac2529a000000b004482fc631b7mr8745320lfm.177.1647094830252;
        Sat, 12 Mar 2022 06:20:30 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id t24-20020a19dc18000000b004433d7c87a6sm2220327lfg.72.2022.03.12.06.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 06:20:29 -0800 (PST)
Message-ID: <dac7104a-21ac-24f4-6132-e51960fa0b7e@gmail.com>
Date:   Sat, 12 Mar 2022 17:20:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
 <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
 <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
 <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com>
 <CAKFNMo=E8mMuY7Et0auH02fOzGKx04k2=LOj8mZJ6a-=J+sPzQ@mail.gmail.com>
 <CAD-N9QWt=d2Vj2bevSzOPL4AWF08_zTyq=hHOcOOROCazNY4_A@mail.gmail.com>
 <CAD-N9QWrBLygN24EC6QLRFF6uf7=PiTRdA4suKqEXJ7tk9aocA@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAD-N9QWrBLygN24EC6QLRFF6uf7=PiTRdA4suKqEXJ7tk9aocA@mail.gmail.com>
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

Hi Dongliang,

On 3/9/22 11:30, Dongliang Mu wrote:
>> Now I am checking the log and trying to find error injection in the
>> log file, as said by Pavel.
> 
> Attached is the report and log file.
> 
> @Pavel Skripkin I don't find any useful error injection in the log file.
> 
> In case I made some mistakes, I will clean up my local crash reports,
> update to the latest upstream kernel and restart the syzkaller. Let's
> see if the crash still occurs.

The execution path is clear from the logs. Quick grep for nilfs shows 
these lines

[  886.701044][T25972] NILFS (loop2): broken superblock, retrying with 
spare superblock (blocksize = 1024)
[  886.703251][T25972] NILFS (loop2): broken superblock, retrying with 
spare superblock (blocksize = 4096)
[  886.706454][T25972] NILFS (loop2): error -4 creating segctord thread

So here is calltrace:

nilfs_fill_super
   nilfs_attach_log_writer
     nilfs_segctor_start_thread <- failed


In case of nilfs_attach_log_writer() error code jumps to 
failed_checkpoint label and calls destroy_nilfs() which should call 
nilfs_sysfs_delete_device_group().


So I can really see how this leak is possible on top of current Linus' HEAD.


Also in the log there are onlyh 4 syz_mount_image$nilfs2 programs, so 
only one of them may be a reproducer. If you have spare time you can try 
to execute them using syz-execprog and see if it works :))



With regards,
Pavel Skripkin
