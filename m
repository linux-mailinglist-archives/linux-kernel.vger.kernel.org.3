Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB994D5D31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiCKIXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCKIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:23:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C953E3E;
        Fri, 11 Mar 2022 00:22:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C538561E59;
        Fri, 11 Mar 2022 08:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970FAC340E9;
        Fri, 11 Mar 2022 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646986965;
        bh=e53sKv4/sgMFpOpcsVCcWxcvQgALDrGx04R8j5M2NDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TE9++wo/LoCYqL/K1eeBz9E2iczzxCqObmv7bbjlO6qJ6xPmONV2725LmVH6TlRvq
         9OAgaBrySe7rG/ylbo+VV2hfdqUillTiMozXS3mCIX6eGeohU/1aKgYPLTiyZo8mVB
         +W0wBqM63+vXlyz+whB0oT0864reB+jbKKqHK18EfimGtCyhD4KchrZvuQBY7gkUfj
         Ja20r1OMZ13JASbR+RDlKbDDkorHCkjFGeUiGEtkGXkdnYTAeESxiVJ6dg3Iudi+Yl
         OdQ8XpOdVrGGOEAuDyTWYL+UbJaaJnApx2sldcTCu2dnESnlknNax/FP3bHNw3F/G4
         tOaUljyoKZw5A==
Message-ID: <98f5a81d-23a5-4003-c7fd-d40d9ff46a1f@kernel.org>
Date:   Fri, 11 Mar 2022 16:22:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] Documentation/filesystem/dax: update DAX description on
 erofs
Content-Language: en-US
To:     Hongnan Li <hongnan.li@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org
References: <20220308034139.93748-1-hongnan.li@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220308034139.93748-1-hongnan.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/8 11:41, Hongnan Li wrote:
> From: lihongnan <hongnan.lhn@alibaba-inc.com>
> 
> Add missing erofs fsdax description since fsdax has been supported
> on erofs from Linux 5.15.
> 
> Signed-off-by: lihongnan <hongnan.lhn@alibaba-inc.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
