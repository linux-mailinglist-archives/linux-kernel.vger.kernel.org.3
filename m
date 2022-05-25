Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC79533514
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbiEYB6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiEYB6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:58:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ABC56C0F;
        Tue, 24 May 2022 18:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8233EB81BB1;
        Wed, 25 May 2022 01:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3000CC34100;
        Wed, 25 May 2022 01:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653443929;
        bh=/P/06pwVl3LpvLvoYehq9XNijhbUGzEXnLH8Tdsg7w8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QZBFbe0wspHl8L3/VAZObdJABwRTrC1Zj2nBxqvbLyNZcXzSc20x46zZh1ZFq3PD5
         IEtQFui6xLzDZ1b8rZD9BAYfKui+boVNgsgctE3AdbIA/iYBpR3+TNMQvGOKLdK0t/
         pOM6uZMJrsLm7+lVREE8yFZ6TFvhqAg5YCRkWCl8doANQrnyRkIH8P9XcQrAGiXl2v
         09c5MYNRT9fgqeuC/3qmZZZsEmDfQPa+oZzkv2mtkfF7TMotAtXErNozZRXibZ05B1
         P1CEXP4aKjKlHZa+78b1f+ZnWVdoWZWDPD6/t+QA817FsZ1dD/Py2j52ZwXjrtRDBZ
         /Fn2sqa+RzHjA==
Message-ID: <97c0192d-a8fc-5160-bf90-d3a63a0ecfb0@kernel.org>
Date:   Wed, 25 May 2022 09:58:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220521113259.3953757-1-chao@kernel.org>
 <138141eb-6bb9-88bc-cdb0-85f6df8b18cb@kernel.org>
 <yq1v8tue6ex.fsf@ca-mkp.ca.oracle.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <yq1v8tue6ex.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 9:42, Martin K. Petersen wrote:
> 
> Chao,
> 
>> Any comments?
> 
> It's on my list of things to look at for 5.20.

Martin, thanks!

Thanks,

> 
