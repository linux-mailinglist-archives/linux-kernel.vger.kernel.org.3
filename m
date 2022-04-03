Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22684F0CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376672AbiDCXgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 19:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDCXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:36:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC663252B4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=J0RmHt1jywPLa70dwARilJrmRwZ+RLEOsnsVOAoSk7k=; b=NZO0mL3FGPPEsSO0bwj9+LPiej
        PKAYzSYkF9v5XYryWDtYzw5xsrkWaRZKPd2y+7no0+AkrOb/8P0hkHvK2SFGIqAby1uR7JjOcymAD
        +5RT1+WSE5a6Qmsnc9SVSEhsEjb1whj7ePYnV/KCLYUGzW/UWOUofJvkj9LWiWEDuleUOkBi5g7Wy
        e4fZvrKrc6U5fSAvLmn5n8M4cGCnYjOPB1MNB84USL5jfFW6t4oI/fnwbdAaINwwghRvSpvbSudIe
        TJEmZMVLYEFPHGs3s+9EY3Pf/KN0XoYJdevV/JeHXVMZ+UqtBEA+RCPMdvVuJIo3AHX9W2n1LCdc4
        RvGeq2qw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nb9js-001Khv-Uf; Sun, 03 Apr 2022 23:34:33 +0000
Message-ID: <f1120b5b-9193-46bf-1382-a9a4ef271ded@infradead.org>
Date:   Sun, 3 Apr 2022 16:34:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v10 0/3] drivers: ddcci: add drivers for DDCCI
Content-Language: en-US
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
References: <20220403230850.2986-1-yusisamerican@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220403230850.2986-1-yusisamerican@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/3/22 16:08, Yusuf Khan wrote:
> This patch adds the DDCCI driver by Christoph Grenz into the kernel.
> The original gitlab page is loacted at https://gitlab.com/ddcci-driv
> er-linux/ddcci-driver-linux/-/tree/master.
> 
...

> 
> v10: Change patch title to "drivers: ddcci: add drivers for DDCCI
> and change" and change patch descriptions to add more detailed
> explanations of function.

Greg KH recently said [1] that the Subject: for each patch should not
be the same, yet they still are the same. This is not good.


[1] https://lore.kernel.org/lkml/YkANDAyCMBBBWEs0@kroah.com/

-- 
~Randy
