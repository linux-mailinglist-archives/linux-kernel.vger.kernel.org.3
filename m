Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC644480533
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 23:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhL0W4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 17:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhL0W4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:56:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90487C06173E;
        Mon, 27 Dec 2021 14:56:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so34802412wrw.10;
        Mon, 27 Dec 2021 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=URhz0YsteZlx1hDMRx5/texcvutOxraW5DqUGA1+YcI=;
        b=oUrTIqoWBLZ/jYR9iGh+rFnFzFlLYOlxA7gGIO12p7G84l2MnjgS7drovNOFpLwxd1
         slxtGrXIYbybDRlfktTlefHq/B1ycFhYOeRqe52/f9gU5MJ4+1eDIzfRGeM3w3jTQ8oQ
         haaQx+WRkjmiI6Phr8rARLI2/dA8Y4ZdxARIVgmxY/g0sUA5+qU7DKic20QhHVV8wPGL
         uGCeToOoO2UxwmE4m825z9EQ/3dnhJPWBnil7itdAXWTyGklqucCsuc2YkxVG7szDaEI
         qxs9sRQENdDYCk68Ah5eMgqS9sYw5KVyT7QflJyIjjaykqE05pes+ZvHJDUyD4ukU007
         I/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=URhz0YsteZlx1hDMRx5/texcvutOxraW5DqUGA1+YcI=;
        b=UThKUGNMlGAXSzN0cZ525cgd6voH0gtCYXCOUzAht6w70rICrbsJBtheR45lum31QO
         4VzxlA/n402YaXeNjp20KvZiKLl1y574SLXCVUVyl8zVtvT77kI44PkRAKpI02i7z7X7
         +ZJQFOd9qA3Ag2IOmpxFb4+/ScGVdLKhaEsEFI25hUs/MpfeorFxh8L1TKIvGXmcUmIl
         4vXHLa+lybqed+S11GwxImFeFD4gYm+n7QHIkBRtZOQzgMYJXsCQzImYR6ZzbtVAIBZD
         j7WMF9VZULLErJKmBr9yg1VscguW6AMwovWPJNOjaE0Tuc7H4zw5VEhV90xWdXEGskW5
         AP0g==
X-Gm-Message-State: AOAM532s+hhhl/93yTm/+jEQxx34W+l1z8KP1UpNt6XHwR95DzmDX+Vw
        aAShceobAdJV3tZDYDt0hDg=
X-Google-Smtp-Source: ABdhPJxLoJhhXfJSvF2baLGQq2xFCFNF57ccLafHmsZporC0gskHyW2nEL2jZjnZKAP7ZEXf18pd2g==
X-Received: by 2002:adf:ec85:: with SMTP id z5mr14013781wrn.568.1640645793730;
        Mon, 27 Dec 2021 14:56:33 -0800 (PST)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id u12sm16244849wrf.60.2021.12.27.14.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 14:56:33 -0800 (PST)
Message-ID: <c27a4f9b-e468-93a2-c14d-20f45a5a103b@gmail.com>
Date:   Mon, 27 Dec 2021 22:56:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Xiang Chen <chenxiang66@hisilicon.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: scsi: hisi_sas: Fix some issues related to,
 asd_sas_port->phy_list
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with clang-scan has found a dereference of an 
uninitialized pointer in drivers/scsi/hisi_sas/hisi_sas_main.c 
introduced by the following recent commit:

commit 29e2bac87421c613782ccb510c76c5efbecac0cf
Author: Xiang Chen <chenxiang66@hisilicon.com>
Date:   Mon Dec 20 19:21:28 2021 +0800

     scsi: hisi_sas: Fix some issues related to asd_sas_port->phy_list

The issue is as follows:

static void hisi_sas_send_ata_reset_each_phy(struct hisi_hba *hisi_hba,
                                              struct asd_sas_port *sas_port,
                                              struct domain_device *device)
{
         struct hisi_sas_tmf_task tmf_task = { .force_phy = 1 };
         struct ata_port *ap = device->sata_dev.ap;
         struct device *dev = hisi_hba->dev;
         int s = sizeof(struct host_to_dev_fis);
         int rc = TMF_RESP_FUNC_FAILED;
         struct asd_sas_phy *sas_phy;

sas_phy is not initialized ^

         struct ata_link *link;
         u8 fis[20] = {0};
         u32 state;
         int i;

         state = hisi_hba->hw->get_phys_state(hisi_hba);
         for (i = 0; i < hisi_hba->n_phy; i++) {
                 if (!(state & BIT(sas_phy->id)))
                         continue;

sas_phy is being dereferenced

The commit referenced above removed the statement:

    list_for_each_entry(sas_phy, &sas_port->phy_list, port_phy_el)


..that set sas_phy. Now we don't have this, so sas_phy is not initialized.

Colin
