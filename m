Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD5446370D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbhK3Out (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbhK3Ouq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:50:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0906C061746;
        Tue, 30 Nov 2021 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eHhKSyL/4thAp4K3/sUisnskskOvl3DA3fO/Wtajc2s=; b=esjXI+Iiw0pPNhwbJKJHv6J0Rp
        RmBOscYHwtzepBoumVo8v0EyjL/Rf+zCZunGodZkdHgePu+PciPO2Krftl4eRjDoYcCQrGdp3BpR3
        xJefidFxx6ulnq5xlwzlt15Urm9DOwy7lAmCYlMnDEBY7L6jNqYGZGAcrrW4LAaUYPHhoYYm81Asb
        prMvF1WqSfbqk1Cj4OWblGh1t03oIBISYo+TOqH9H5rFYhuqUH3SppPFaw241FfQ11jJE4QVFsT3a
        meZAMjzs9fV+mhLSAi9cxODO+wuAI8PJo1SvJYq43PzCIK7/yo9fp4KNxTQnrtRV7xBIqXxnQ4XHs
        D4fScMUw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms4Pj-001Svp-Ks; Tue, 30 Nov 2021 14:47:24 +0000
Message-ID: <3f1c5518-d31e-48cf-ab75-1266a85b7aa4@infradead.org>
Date:   Tue, 30 Nov 2021 06:47:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: linux-next: Tree for Nov 30
 [drivers/base/firmware_loader/firmware_class.ko]
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211130185102.2c280cab@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211130185102.2c280cab@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/21 23:51, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20211129:
> 

on x86_64:
when CONFIG_FW_LOADER=m:

ERROR: modpost: "unregister_firmware_config_sysctl" [drivers/base/firmware_loader/firmware_class.ko] undefined!
ERROR: modpost: "register_firmware_config_sysctl" [drivers/base/firmware_loader/firmware_class.ko] undefined!


Just export those 2 symbols, please.

-- 
~Randy
