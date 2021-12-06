Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE5469902
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbhLFOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:34:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4212 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242092AbhLFOeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:34:05 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J75RG6kzyz67KsG;
        Mon,  6 Dec 2021 22:29:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 15:30:34 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 14:30:34 +0000
Subject: Re: [PATCH 3/3] scsi: hisi_sas: Use non-atomic bitmap functions when
 possible
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <4afa3f71e66c941c660627c7f5b0223b51968ebb.1637961191.git.christophe.jaillet@wanadoo.fr>
 <8ee33e463523db080e6a2c06f332e47abb69359b.1637961191.git.christophe.jaillet@wanadoo.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <18d004e8-fdfe-fb20-48a5-6e125b26ed0d@huawei.com>
Date:   Mon, 6 Dec 2021 14:30:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <8ee33e463523db080e6a2c06f332e47abb69359b.1637961191.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 21:18, Christophe JAILLET wrote:
> All uses of the 'hisi_hba->slot_index_tags' bitmap are protected with the
> 'hisi_hba->lock' spinlock.
> 
> So prefer the non-atomic '__[set|clear]_bit()' functions to save a few
> cycles.
> 
> Signed-off-by: Christophe JAILLET<christophe.jaillet@wanadoo.fr>

Acked-by: John Garry <john.garry@huawei.com>
