Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2341A47754F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhLPPGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:06:03 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:56274 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235111AbhLPPGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:06:02 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowABHTJzEVbthx_SgAw--.56887S2;
        Thu, 16 Dec 2021 23:05:40 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH v3] serial: pch_uart: potential dereference of null pointer
Date:   Thu, 16 Dec 2021 23:05:39 +0800
Message-Id: <20211216150539.423387-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABHTJzEVbthx_SgAw--.56887S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1kXF18uryrCF1UuF13XFb_yoWfXwb_Gr
        97C34Du3yxXas29F4DJF15Ja42v3yfXrWYva9Yqa13XryUXr18W34Utrn5Zw4UAFZ2krsI
        9F9ayayay342vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_XrWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1uWlUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:36:35PM +0800, Greg KH wrote:
>> The return value of dma_alloc_coherent() needs to be checked.
>> To avoid dereference of null pointer in case of the failure of alloc.
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

>A blank line is always needed before the signed-off-by line.

>> ---
>> Changelog:
>> 
>> v2 -> v3
>> 
>> *Change 1. Remove dev_err.
>> *Change 2. Change the return type of pch_request_dma to int.
>> *Change 3. Return -ENOMEM when dma_alloc_coherent() failed and 0 the
>> others.
>> *Change 4. Check return value of dma_alloc_coherent().
>
> I see v3 here, not v4.  Where is v4?
>
> And how did you test this change?
>
> thanks,
>
> greg k-h

Sorry, I just have v3, maybe that is my fault. But I don't know why you think there is v4.

And I have no idea about the "test this change"? Please give me more detail. 

Sincerely thanks,

jiasheng jiang

