Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22557E77A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiGVTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiGVTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:35:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC1D13FBA;
        Fri, 22 Jul 2022 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZKWhIcTjjDkCKE0uu1WuJZU2sm3otMhe7wLNA0ixMbY=; b=Vn9sqaulaf5aOuf2PdhO6cATnR
        +DnMvipPl3YfEyB6Wa2PmzOvHb/fJoDbPVU4qQZWeEK/K7bdCQG3+aU/KwWZRtuRh3ScD/c6+5i/U
        JWUd8gmMpalC8T87QyC1oNsz749sGV2R2kazBndIfaishgNnh1a2Pwf9Wo9P5AUgUOi/y0RBYnjKa
        fbjBWWOQa8LDgjAWBJdFf8OjfuKmU9e+THPQdGm+ZxXpSGl0DCZflcUPCPXNe4fdl+/YJVxn56+Xi
        3DE9mCrK1iQYK4kJvBy/IdOWRdGtf1xn0eUZ/F6cDwvmVpWP0Aue0Vm+OLATzVoXBWOBeJoKGwhf6
        VSliJOww==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEyQb-009RfF-8q; Fri, 22 Jul 2022 19:35:13 +0000
Message-ID: <92ed10f9-2c84-ad42-20d1-f8a101f78f08@infradead.org>
Date:   Fri, 22 Jul 2022 12:35:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Tree for Jul 22
 (drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        linux-input@vger.kernel.org
References: <20220722204335.478b1598@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220722204335.478b1598@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/22 03:43, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220721:

on i386:

../drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c: In function ‘amd_stop_sensor’:
../drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c:48:9: error: implicit declaration of function ‘writeq’; did you mean ‘writel’? [-Werror=implicit-function-declaration]
   48 |         writeq(0x0, privdata->mmio + AMD_C2P_MSG(1));
      |         ^~~~~~
      |         writel



-- 
~Randy
