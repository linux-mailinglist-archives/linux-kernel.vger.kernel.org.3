Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD150EE06
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiDZBTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDZBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:19:40 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7510F2A23;
        Mon, 25 Apr 2022 18:16:33 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id n8so28874859plh.1;
        Mon, 25 Apr 2022 18:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oBhHtEy1UwAD7VJTZa2DJpdjf37l4LwuPNwSNpkwgXs=;
        b=ZgFlDg4uuIIzx+/sd3QjakOZGzRdtDxLqEqMXXa2VV4jTZyzS43p9SGpeRVv4j+JS6
         PhOefNaYOeL0xMavCxmP4Hes5TrsWFsJnIZt8SdVHOqkaP2n9JMmq8TT7xcHO8n4WJFh
         8yaSfuX7MGxFm3OD2PiaXRYmDDdVANIuntk8n8/nYvj3iew5P0zalAC9+xqSoZykqPBS
         xgACb3T8NFN8gos5VyAH+nDi00Y29xySo4mroAaREQeqtSEDBpq3PdL+TEGjdGJCaAys
         uGOEon94D5zwfJMl3n2/e7MuV75XYHp0x3FG6lSPgic96LYoOe1aAGfvpOeOX1ts95eD
         DA+g==
X-Gm-Message-State: AOAM5314etTEF8RJzOETT003FhZirTsYrP3TzXP8AJ2f5ARiCO1meyIs
        92j9Hov19uNeLfD2pJ2MMO0=
X-Google-Smtp-Source: ABdhPJzJ99tVtUyhYqDVy6U0E9xminu5CN/CGLD2izS21/CpDL5Xg08sCJ3RDB6FJbh5be3YsFIU9A==
X-Received: by 2002:a17:902:b092:b0:156:a40f:f716 with SMTP id p18-20020a170902b09200b00156a40ff716mr20901842plr.72.1650935792984;
        Mon, 25 Apr 2022 18:16:32 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id o64-20020a62cd43000000b0050d416200e6sm4285329pfg.5.2022.04.25.18.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 18:16:32 -0700 (PDT)
Message-ID: <aba8999d-276d-f9e8-96b4-5d1cc4e82c53@acm.org>
Date:   Mon, 25 Apr 2022 18:16:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 06:04, John Garry wrote:
> On 25/04/2022 10:22, Krzysztof Kozlowski wrote:
>> For example scsi_proc_hostdir_rm(): 'present' and 'proc_dir' members.
>> Where should they be stored? Should they be moved to the Scsi_Host?
>>
> 
> I don't think scsi_Host is appropriate as this is per-scsi host 
> template, unless you see a way to do it that way. Alternatively we could 
> keep a separate list of registered sht, like this:
> 
> struct sht_proc_dir {
>      int cnt;
>      struct list_head list;
>      struct proc_dir_entry *proc_dir;
>      struct scsi_host_template *sht;
> };
> static LIST_HEAD(sht_proc_dir_list);
> 
> void scsi_proc_hostdir_add(struct scsi_host_template *sht)
> {
>      struct sht_proc_dir *dir;
> 
>      if (!sht->show_info)
>          return;
> 
>      mutex_lock(&global_host_template_mutex);
>      list_for_each_entry(dir, &sht_proc_dir_list, list) {
>          if (dir->sht == sht) {
>              dir->cnt++;
>              goto out;
>          }
>      }
>      dir = kzalloc(sizeof(*dir), GFP_KERNEL);
>      if (!dir)
>          goto out;
> 
>      dir->proc_dir = proc_mkdir(sht->proc_name, proc_scsi);
>      if (!dir->proc_dir) {
>          printk(KERN_ERR "%s: proc_mkdir failed for %s\n",
>                     __func__, sht->proc_name);
>          kfree(dir);
>          goto out;
>      }
> 
>      dir->cnt++;
>      list_add_tail(&dir->list, &sht_proc_dir_list);
> out:
>      mutex_unlock(&global_host_template_mutex);
> }

How about removing scsi_proc_hostdir_add(), scsi_proc_hostdir_rm() and 
all other code that creates files or directories under /proc/scsi? There 
should be corresponding entries in sysfs for all /proc/scsi entries. 
Some tools in sg3_utils use that directory so sg3_utils will have to be 
updated.

Thanks,

Bart.
