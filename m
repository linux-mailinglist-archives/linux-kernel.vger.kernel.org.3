Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B352A74D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbiEQPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbiEQPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:45:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6958C532F4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B46A2CE1AFF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E4AC34116;
        Tue, 17 May 2022 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652802231;
        bh=Izy6TZfGaIzRY1Pn79tgD0UhJ4xSdDmIRaB4G29KIh0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oHYpg1eIXlXWIxkNISi8Q7gkc/zKuqBeSbJdtRoeIk4ByEIwPH3C7yZHEqXgzbTlS
         BEP9Bufmhpyj2rHhnwPJbmjde4BVNpHGUTFKd15O4BDWpMUyc4gKZIR9CxuT2D3fo5
         XJ6fsJ5lFo7wmenRyebOSS+ISW0r1VNLJGhM+PlhymPYNu/x5TlsYAGPpF41Iy9JJ1
         khjFILpzL7rYRVfixsWLTGLgioLiUmsjp6r44Jon5ifS78+NlZKNnBvZ61oDnUNzpf
         WkBAdeKNrFaVYgaWdAHjEwe870dDhFGv3R5ccoM8JVT5rhtkGzrtkPGnNlsee8XpuA
         nUD6DWnyQKEIA==
Message-ID: <14e765db-5e51-9c17-3aa1-bddc1ba5bbb2@kernel.org>
Date:   Tue, 17 May 2022 23:43:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 resend] erofs: make filesystem exportable
Content-Language: en-US
To:     Hongnan Li <hongnan.li@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
 <20220425040712.91685-1-hongnan.li@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220425040712.91685-1-hongnan.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/25 12:07, Hongnan Li wrote:
> Implement export operations in order to make EROFS support accessing
> inodes with filehandles so that it can be exported via NFS and used
> by overlayfs.
> 
> Without this patch, 'exportfs -rv' will report:
> exportfs: /root/erofs_mp does not support NFS export
> 
> Also tested with unionmount-testsuite and the testcase below passes now:
> ./run --ov --erofs --verify hard-link
> 
> For more details about the testcase, see:
> https://github.com/amir73il/unionmount-testsuite/pull/6
> 
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
