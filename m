Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A10F59F3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiHXGdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiHXGdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:33:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9857F266
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F096151E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36DEC433C1;
        Wed, 24 Aug 2022 06:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661322829;
        bh=5ukWZHlA0Oo1CKJlK09u52B7HjbcxwqMWrvXafzsNx4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uOBQjM/OmDwZVVWr2AbVujK5zpIfVeu8IVV2ZFA77mhBOBwRKvqVoVJ1kR05dn/f4
         CXffDcgUNHokg6XftaQWE+VY0Q650I3wms56jYz44Q0a6a9f0s9ohDQbEvTIetWCsO
         ldjz9B2auAr4QlT32Kd5Ms45hlMSHj2sEg/PAH+/dTTCe6SxqlSDKQebB2tDIth6Rz
         LkW1/NqgprN5b0xBwowQrDFt6mf3zWOoX8NHlYHP8FIkHao44iRuBgEtB2YK0W5t0A
         H5IpqtKJVNUiv4Rj71MSAF8w2hgfvbTrTvcZCD2bOqhCM16jqd1zaTW1zlwAs5Tsyl
         N1RJpI7aj/4Eg==
Message-ID: <1dc5321e-96b6-d79d-a957-209ef2d9d502@kernel.org>
Date:   Wed, 24 Aug 2022 08:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next 2/2] rv/dot2K: add 'static' qualifier for local
 variable
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>, mingo@redhat.com,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
References: <20220824034357.2014202-1-zengheng4@huawei.com>
 <20220824034357.2014202-3-zengheng4@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220824034357.2014202-3-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 05:43, Zeng Heng wrote:
> Following Daniel's suggestion, fix similar warning
> in template files, which would prevent new monitors
> from such warning.
> 
> Fixes:	24bce201d798 ("tools/rv: Add dot2k")
> Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
