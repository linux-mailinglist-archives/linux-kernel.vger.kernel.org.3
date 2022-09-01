Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2D5A9416
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiIAKRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiIAKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:17:08 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 525D8133F08
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:17:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAAXDFGShhBjt9wJAA--.12852S2;
        Thu, 01 Sep 2022 18:16:52 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH v2 1/2] virt: vbox: Add check for device_create_file
Date:   Thu,  1 Sep 2022 18:16:49 +0800
Message-Id: <20220901101649.3499848-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXDFGShhBjt9wJAA--.12852S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKF1DKrWDCryDKry5CFyxGrg_yoW8JrW8pa
        95GFy5KF18W348Gw47ZF4DXwn8CrWUAayxZ347G3y7Wr13Ars3tay3AFy8ZrZxJFZxJF4a
        qa1UKrWku3y8KFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5pBTUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:39:46PM +0800, Greg KH wrote:
>> -	device_create_file(dev, &dev_attr_host_version);
>> -	device_create_file(dev, &dev_attr_host_features);
>> +
>> +	ret = device_create_file(gdev->dev, &dev_attr_host_features);
>> +	if (ret)
>> +		goto err_unregister_misc_device_user;
>> +	ret = device_create_file(gdev->dev, &dev_attr_host_version);
>> +	if (ret)
>> +		goto err_remove_file_features;
>>  
>>  	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
>>  		 gdev->misc_device.minor, pci->irq, gdev->io_port,
>> @@ -399,6 +404,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>>  
>>  	return 0;
>>  
>> +err_remove_file_features:
>> +	device_remove_file(gdev->dev, &dev_attr_host_features);
> Please make a patch series that is linked together, the one you just did
> was not properly threaded at all (hint, use git send-email).
> 
> And again, this is not the correct way to solve this issue, use a
> default attribute group for the driver instead.  No driver should ever
> be adding or removing files individually like this.

Need I use the group to replace the individually removal in
vbg_pci_remove() too?

Thanks,
Jiang

