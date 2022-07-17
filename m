Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C269D5774F4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 09:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiGQHX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 03:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiGQHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 03:23:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835EAE5C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6A66B80D1D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F6CC3411E;
        Sun, 17 Jul 2022 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658042631;
        bh=kPTHNrNqEviF+AHppXmwwaB1/kGOB9DjJGpsj32sTtc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LsfsvyN3+Q4RP10WX0b6g9iiPrV52lVF84xF7HgqJLwaFlSwl3N926Z0b1CtEPMdy
         2cE1yuiHW3rORZd7AVNmAZt9OIQxgarTG+dH4S3F7jWyTjLyn82Xltqb/eoblSMmpS
         Dmxq+WQO8sKZrY0xSCq1tFlIPBmUW6xnQ2KcnlvhePE+BQhLGeD3cajXOViIjbCPsQ
         w7xqzIOhnbIarZbiYK98zGp0UzWop0bz44a7V1lLKSweXO0UhGSuxAp+m/JEQ0fhEu
         XF+c0OSzeZXfCABHf1rC9c+Ed6ocmV3XALrh3+ZzEZltqE1oNRgDeiXiXatyLSNYB8
         XfmJj/TiSbnIg==
Message-ID: <c265cef1-de1d-5077-6727-d965ecd10fa9@kernel.org>
Date:   Sun, 17 Jul 2022 15:23:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: add a sysfs entry to show zone
 capacity
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220628234733.3330502-1-jaegeuk@kernel.org>
 <20220628234733.3330502-3-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220628234733.3330502-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/29 7:47, Jaegeuk Kim wrote:
> This patch adds a sysfs entry showing the unusable space in a section
> made by zone capacity.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
