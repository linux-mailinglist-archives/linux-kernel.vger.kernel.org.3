Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F953561E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347194AbiEZWmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEZWl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:41:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC669A9B5;
        Thu, 26 May 2022 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=t9V8ivaNhN/SJ/RRUI+LCheLSr6jqFHdYqB8gYqAS2w=; b=cBHXJjVkQaOwVaeHmogMSYcTkv
        vcMIMFWMqio/ti+IYV5n1zPl6OUe9+svgT/vexn5h1fEpvE/LyiVnwJ4pjxZSKimN5UQvFU0EgrcK
        Usi7/sNWDAbMLdJgnAy5b8G4lN/qXjAPVJ+SVUZOTgAR16uLt3SMfajam+5N97PxJ/2l6eyVaKtYO
        vTElQfxT56JDmOGAOEDT4Orti4r2Zz0CqY4z3bCRVcWHfZ84iPzvrVLxZXZKJH7WiiPYYEQZej/Gn
        rhyNxNYrzYCY1YpAKmb82e2N6ggSFPjtNfQ+Xlrmh6m0mB12tQu7LG3+xYq17emARwjY85711kwQS
        hFBD+LFw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuMAu-0021ay-9c; Thu, 26 May 2022 22:41:52 +0000
Message-ID: <96fccaa4-9416-65c3-2d6c-a7f5b9f13f1b@infradead.org>
Date:   Thu, 26 May 2022 15:41:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: iwlwifi keep crashing the kernel
Content-Language: en-US
To:     Tommy Zhang <va7tch@students.cs.ubc.ca>,
        linux-kernel@vger.kernel.org
References: <8322144e-db5b-e82d-a3f5-c09ace7a6340@students.cs.ubc.ca>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8322144e-db5b-e82d-a3f5-c09ace7a6340@students.cs.ubc.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add linux-wireless]

On 5/25/22 21:33, Tommy Zhang wrote:
> Hi folks,
> 
> I hope this email finds you well. I'm running ArchLinux with kernel
> 5.17.9-arch1-1 #1 SMP PREEMPT on ThinkPad T440 with product code
> 20B6002XCD. The OEM wireless adapter malfunctioned previously;
> therefore, I have upgraded it to Intel AC-7260, the latest FRU-capable
> wireless adapter I could find on the market. However, the iwlwifi module
> recently kept causing kernel panics which freezes the system incurring
> disruption and data loss. It reads from the kernel log that there is a
> kernel BUG at line 379 of mm/slub.c, which is attached to this email.
> Before filing a bug in Bugzilla, I'd like to hear advice and comments
> from Linux-wireless. Please feel free to reply to this thread if
> anything is worth sharing.
> 
> Sincerely,
> Tommy Zhang

-- 
~Randy
