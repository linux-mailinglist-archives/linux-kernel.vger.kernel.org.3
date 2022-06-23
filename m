Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E5C5589A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiFWT7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFWT70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:59:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDC3585E;
        Thu, 23 Jun 2022 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=FSMg2Z7yO0AcWYQ2gWnef9GPN8JvwvL0049CciGXkhQ=; b=47o098vAIvp02jqSoWGX2uS/Cm
        10e9UlhtbQoMVH78coRqkO/K06s/40+49doNoAxwtWQnabRjgKC51GhrInqJyR/0Ih61BMbNgechN
        /GQp6Q+qRl4eYz796mv5wLVWpW02RYF8NosqID9MCcDDHHvaJ3II1/N+y3LXl0IqvbGIbje8Zzu1M
        /QVRCcIqwFhnX8YxWyjYGPsF/D5Y5V4nFr4pgoRECbfM8gAelCZ8vinMoWPSCaF0rY1M71GmvvoRw
        qyZwpf9m37ec4jXBkM/fz6k+QlmcHB/3MB1V6BGChKgez16N3p6aIw42vn/lZUQuCmwVvEn8oKvo+
        HuDR16sg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Sz4-00GeSN-Cy; Thu, 23 Jun 2022 19:59:22 +0000
Message-ID: <082d7355-819e-a1a3-7d41-0e642a302e35@infradead.org>
Date:   Thu, 23 Jun 2022 12:58:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: Tree for Jun 23
 [drivers/gpu/drm/amd/amdgpu/amdgpu.ko]
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20220623165724.42f9bf9b@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220623165724.42f9bf9b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/22 23:57, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220622:
> 
> 
> The amdgpu tree lost its build failure.
> The amdgpu tree gained a semantic conflict against the driver-core tree.
> 

on i386:

ERROR: modpost: "__umoddi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!


-- 
~Randy
