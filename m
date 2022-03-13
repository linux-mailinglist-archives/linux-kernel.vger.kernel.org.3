Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A05F4D774A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 18:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiCMRbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiCMRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:31:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B616B08E;
        Sun, 13 Mar 2022 10:29:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b28so11606866lfc.4;
        Sun, 13 Mar 2022 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=rUnMIgCeQG8VWW8PCEtLSBxfUsQtzoFCWsB4QStSooU=;
        b=m61u63mtle5PSGm5EstJOqXIZELDP1+b+ZPQiHOw9FOeXOO9pgsWcS6ApY52Wid+IB
         7itULzszBYuOQYQaD+PrCa9/7ot+BIbAHddXl1/mRgSgj2S7pn+peaSdM7CXwcz0cHLj
         6L+14PKvVCKxb4IAnYE9GSskD9S3OwUWxXMy79L4h5iZdqjzJPv2TvkDT/fC+Zt5cIjw
         +aJ6PeHu1r/ns8i4I/BIgd2CP6/CTDPjEL4aLEdPrOKWKX0zqYrnsgA+CVB5mbPS93Iu
         Av+K2/a4Kf3b670ByS8n2DWSbx9Rhfcu8MMchp27JwSzW0soAiSPFBs74G4iD/Zl34tJ
         XRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=rUnMIgCeQG8VWW8PCEtLSBxfUsQtzoFCWsB4QStSooU=;
        b=QX3SWRjfJTSYVJIwM1C/xBuRmpO1AWiS4M+iFj2Ck5mfxPVgAVxW4kLJfmLPcOn4JB
         gv7A5e4RgYFRZJnzI2NdfjJdwzlUcWqxtivyHihkBUpA64AI6srbuYp6S8oCzc1ozbll
         g0AqcjFjlIKAOHEDVE24yMJN3JakO0t8ht5Cb8QDd30eIhMSMQnXOGkOQ0q957FWgUHt
         l5AUeNpXHsJC7qyq5uxjCR+kdn2i0Z/jbdn2z/zQZeySUBAVSP+CVcaeyFC8W49uFaX+
         iA3eJatUs84xFjTzy+sEg+ibew8pSj2RwwmwJnXB6udq+Ku8MgofZZnXKJgBtR+iVt6S
         QY9w==
X-Gm-Message-State: AOAM53248rwwx+tTf4R3Za+AFj08ZOUW76ge1exmwpcisZBiGy0EvrYd
        /cPc//TJQeR+rTI0v95iBZY=
X-Google-Smtp-Source: ABdhPJyeUampciUzYtHM4eIBkXXT7nlNEDPafLh5VqJehdInoZRREzZCyoHWmXJdcjyIy93gvxqRUQ==
X-Received: by 2002:ac2:5de4:0:b0:448:2daf:b98c with SMTP id z4-20020ac25de4000000b004482dafb98cmr11023550lfq.641.1647192592170;
        Sun, 13 Mar 2022 10:29:52 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id z16-20020a19e210000000b00448837e47a8sm956624lfg.97.2022.03.13.10.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 10:29:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ZdmL9ZYS3FXWarNbmyPF6XlR"
Message-ID: <bc933e26-92f3-cfa6-9500-609c2d1015a2@gmail.com>
Date:   Sun, 13 Mar 2022 20:29:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [syzbot] general protection fault in __pm_runtime_resume (2)
Content-Language: en-US
To:     syzbot <syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rafael@kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000093a3f805da1ce2f7@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <00000000000093a3f805da1ce2f7@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ZdmL9ZYS3FXWarNbmyPF6XlR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/22 20:27, syzbot wrote:
>> On 3/13/22 08:35, syzbot wrote:
>>> Hello,
>>> 
>>> syzbot found the following issue on:
>>> 
>>> HEAD commit:    92f90cc9fe0e Merge tag 'fuse-fixes-5.17-rc8' of git://git...
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=118cd3be700000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd12fbed3485a3e51f
>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b64e79700000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1652811a700000
>>> 
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
>>> 
>>
>> hu->serdev should be checked before passing to pm functions
>>
>> #syz test:
> 
> want 2 args (repo, branch), got 3
> 

Woops

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master



With regards,
Pavel Skripkin
--------------ZdmL9ZYS3FXWarNbmyPF6XlR
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9oNS5jIGIvZHJpdmVycy9ibHVl
dG9vdGgvaGNpX2g1LmMKaW5kZXggMzQyODZmZmUwNTY4Li43YWM2OTA4YTRkZmIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9oNS5jCisrKyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2hjaV9oNS5jCkBAIC02MjksOSArNjI5LDExIEBAIHN0YXRpYyBpbnQgaDVfZW5xdWV1
ZShzdHJ1Y3QgaGNpX3VhcnQgKmh1LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogCQlicmVhazsK
IAl9CiAKLQlwbV9ydW50aW1lX2dldF9zeW5jKCZodS0+c2VyZGV2LT5kZXYpOwotCXBtX3J1
bnRpbWVfbWFya19sYXN0X2J1c3koJmh1LT5zZXJkZXYtPmRldik7Ci0JcG1fcnVudGltZV9w
dXRfYXV0b3N1c3BlbmQoJmh1LT5zZXJkZXYtPmRldik7CisJaWYgKGh1LT5zZXJkZXYpIHsK
KwkJcG1fcnVudGltZV9nZXRfc3luYygmaHUtPnNlcmRldi0+ZGV2KTsKKwkJcG1fcnVudGlt
ZV9tYXJrX2xhc3RfYnVzeSgmaHUtPnNlcmRldi0+ZGV2KTsKKwkJcG1fcnVudGltZV9wdXRf
YXV0b3N1c3BlbmQoJmh1LT5zZXJkZXYtPmRldik7CisJfQogCiAJcmV0dXJuIDA7CiB9Cg==


--------------ZdmL9ZYS3FXWarNbmyPF6XlR--
