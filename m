Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D7A590AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiHLDfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHLDfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:35:06 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F79A4040;
        Thu, 11 Aug 2022 20:35:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M3q5m6f4XzlBjN;
        Fri, 12 Aug 2022 11:33:48 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
        by APP2 (Coremail) with SMTP id Syh0CgBnn7tjyvVitbH3AA--.33911S2;
        Fri, 12 Aug 2022 11:35:01 +0800 (CST)
Message-ID: <420a6c4a-e526-4e8b-d5bd-563c40aa94e1@huaweicloud.com>
Date:   Fri, 12 Aug 2022 11:34:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To:     lee.jones@linaro.org
Reply-To: zhangwensheng@huaweicloud.com
From:   "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
Subject: Question: consult patch
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnn7tjyvVitbH3AA--.33911S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1rKF15AF4DGF1rGFWUCFg_yoWkArb_X3
        ykJas7Ww4jkr4kWF17Jr13XanxK3ZYqrW8Xa1DZ3y5try0qrs8Gr4rWwn5Gr4Igw4Iqrs8
        tryDWrsIqw17WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: x2kd0wpzhq2xhhqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee ：
     I saw your patch because of CVE-2022-20158, the patch like below:

---
     mm: backing-dev: Take a reference to the bdi in use to prevent UAF

     KASAN reports a reproducible issue in the BDI handling code due to a
     dereference of a previously freed pointer to 'struct backing_dev_info'
     in bdi_unregister().

     Because of a distinct lack of locking and/or reference taking,
     blk_cleanup_queue() puts the final taken reference to the bdi, which
     is then promptly freed by release_bdi().  However, del_gendisk() calls
     bdi_unregister() after the fact, which then attempts to dereference
     it causing the kernel to panic.

     Bug: 182815710
     Signed-off-by: Lee Jones <lee.jones@linaro.org>
     Change-Id: Iaf3dadf3b983a4b7d74d4e273fc676350cfc387f
---

     I am sorry that I have some questions for this patch. According to
     my analysis, I failed to find the relevant process may lead to null
     pointer reference. can you show me "KASAN reports a reproducible issue"
     that what the problem is?  thank you very much!

