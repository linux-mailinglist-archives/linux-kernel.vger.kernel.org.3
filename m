Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5D55F1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiF1XXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiF1XXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:23:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C44D2C1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD2C1B82062
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3C9C341C8;
        Tue, 28 Jun 2022 23:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656458580;
        bh=C4XVqKX6nYgK4/WINsdaI8AuFkuEamK8zK/f6A+N0kI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jg7od/nsfZnv3Sry6ovqwlpqcf2XyA2kWISM7seeDdf4QHm9b4c0ToQvWtdGlChCn
         QoeyfAMEjQ0n/uklN3VUZ+LKzJcYDq+VuMpuMyHk9/nhlu0SC2QbqmutM1zcSZzPV+
         AtitUqEfEjeJEv7z+JEMjUn+uPVVBPMFLKaeAMiBZwFY/4ZCpyGJY5NJwaO2r2UMkP
         agmBB3nP+bx6jaaJXcLktyMujUtmT8X+35ItRuQlXrJD6cwoq63HDG5vsWjhhXj9LR
         dJXpDz79PWxWOGvEVNoNbFehuPqPqkcdrfJTT7ydV6tQSJJOH+oBvzILoH2tDUmD9g
         aDrGjKBwEdFaA==
Message-ID: <53296bc3-d220-dfe5-514b-bba2496ef4b3@kernel.org>
Date:   Tue, 28 Jun 2022 16:22:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/8] x86 signal code cleanups
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
References: <20220606203802.158958-1-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220606203802.158958-1-brgerst@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 13:37, Brian Gerst wrote:
> The 32-bit signal code has significant differences from 64-bit, and
> those are duplicated for native and compat modes.  This patch series
> merges the 32-bit code into one file, and does some general cleanups
> in the x86 signal code.  There should be no functional changes.
> 

This looks generally sane.  What kind of testing have you done?

--Andy
