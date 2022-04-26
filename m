Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FAD50EE73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiDZCGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiDZCF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:05:57 -0400
X-Greylist: delayed 496 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 19:02:51 PDT
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB38CDB6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:02:50 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id 1FC94E0DD9;
        Tue, 26 Apr 2022 01:54:34 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id E8F2961542;
        Tue, 26 Apr 2022 01:54:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id kfGYxcQ-hi_E; Tue, 26 Apr 2022 01:54:33 +0000 (UTC)
Received: from [192.168.48.23] (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id EE3E46046A;
        Tue, 26 Apr 2022 01:54:31 +0000 (UTC)
Message-ID: <5485f529-e99a-0bdd-07bd-b5b559da91e6@interlog.com>
Date:   Mon, 25 Apr 2022 21:54:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Content-Language: en-CA
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.smart@broadcom.com
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
 <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
 <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
 <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
 <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
 <Yl+wJ7xSHzWmR+bR@infradead.org>
 <d09faf74-a52e-8d93-cf26-08b43b12c564@huawei.com>
 <24bfb681-faec-3567-3089-9cd5ee182710@linaro.org>
 <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
 <aba8999d-276d-f9e8-96b4-5d1cc4e82c53@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <aba8999d-276d-f9e8-96b4-5d1cc4e82c53@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-25 21:16, Bart Van Assche wrote:
> On 4/25/22 06:04, John Garry wrote:
>> On 25/04/2022 10:22, Krzysztof Kozlowski wrote:
>>> For example scsi_proc_hostdir_rm(): 'present' and 'proc_dir' members.
>>> Where should they be stored? Should they be moved to the Scsi_Host?
>>>
>>
>> I don't think scsi_Host is appropriate as this is per-scsi host template, 
>> unless you see a way to do it that way. Alternatively we could keep a separate 
>> list of registered sht, like this:
>>
>> struct sht_proc_dir {
>>      int cnt;
>>      struct list_head list;
>>      struct proc_dir_entry *proc_dir;
>>      struct scsi_host_template *sht;
>> };
>> static LIST_HEAD(sht_proc_dir_list);
>>
>> void scsi_proc_hostdir_add(struct scsi_host_template *sht)
>> {
>>      struct sht_proc_dir *dir;
>>
>>      if (!sht->show_info)
>>          return;
>>
>>      mutex_lock(&global_host_template_mutex);
>>      list_for_each_entry(dir, &sht_proc_dir_list, list) {
>>          if (dir->sht == sht) {
>>              dir->cnt++;
>>              goto out;
>>          }
>>      }
>>      dir = kzalloc(sizeof(*dir), GFP_KERNEL);
>>      if (!dir)
>>          goto out;
>>
>>      dir->proc_dir = proc_mkdir(sht->proc_name, proc_scsi);
>>      if (!dir->proc_dir) {
>>          printk(KERN_ERR "%s: proc_mkdir failed for %s\n",
>>                     __func__, sht->proc_name);
>>          kfree(dir);
>>          goto out;
>>      }
>>
>>      dir->cnt++;
>>      list_add_tail(&dir->list, &sht_proc_dir_list);
>> out:
>>      mutex_unlock(&global_host_template_mutex);
>> }
> 
> How about removing scsi_proc_hostdir_add(), scsi_proc_hostdir_rm() and all other 
> code that creates files or directories under /proc/scsi? There should be 
> corresponding entries in sysfs for all /proc/scsi entries. Some tools in 
> sg3_utils use that directory so sg3_utils will have to be updated.

... breaking this:

~$ cat /proc/scsi/scsi

Attached devices:

Host: scsi3 Channel: 00 Id: 00 Lun: 00

   Vendor: IBM-207x Model: HUSMM8020ASS20   Rev: J4B6

   Type:   Direct-Access                    ANSI  SCSI revision: 06

Host: scsi3 Channel: 00 Id: 01 Lun: 00

   Vendor: IBM-207x Model: HUSMM8020ASS20   Rev: J4B6

   Type:   Direct-Access                    ANSI  SCSI revision: 06

Host: scsi3 Channel: 00 Id: 02 Lun: 00

   Vendor: SEAGATE  Model: ST200FM0073      Rev: 0007

   Type:   Direct-Access                    ANSI  SCSI revision: 06
...

A deprecation notice would be helpful, then removal after a few kernel
cycles. Yes, lsscsi can give that output:

$ lsscsi -c

Attached devices:

Host: scsi2 Channel: 00 Target: 00 Lun: 00

   Vendor: SEAGATE  Model: ST200FM0073      Rev: 0007

   Type:   Direct-Access                    ANSI SCSI revision: 06

Host: scsi2 Channel: 00 Target: 01 Lun: 00

   Vendor: WDC      Model: WSH722020AL5204  Rev: C421

   Type:   Zoned Block                      ANSI SCSI revision: 07

Host: scsi2 Channel: 00 Target: 02 Lun: 00

   Vendor: Areca Te Model: ARC-802801.37.69 Rev: 0137

   Type:   Enclosure                        ANSI SCSI revision: 05
...

[Hmmm, in a different order.]

However no distribution that I'm aware of includes lsscsi in its installation.
[Most recent example: Ubuntu 22.04]
Linux is not alone ... in FreeBSD how do you list SCSI devices in your
system? Answer: as root you invoke 'camcontrol devlist', it's so obvious.

Perhaps the Linux kernel could have a deprecation process which uses inotify
or similar to notice accesses to /proc/scsi/scsi (say) and print out
a helpful response along the lines" "this is no longer supported, try using
the lsscsi utility".

Doug Gilbert



