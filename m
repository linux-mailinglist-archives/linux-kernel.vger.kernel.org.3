Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3BC49EFC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiA1Adl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:33:41 -0500
Received: from cmo-0001.xspmail.jp ([202.238.198.168]:22867 "EHLO
        cmo-0001.xspmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiA1Adh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:33:37 -0500
Received: from cmr-0002.xspmail.jp ([202.238.198.119])
        by cmo with ESMTP
        id DFB5ni7ZPjQ2kDFCqnSbhd; Fri, 28 Jan 2022 09:33:36 +0900
Received: from elitebook830 ([IPv6:2409:12:b80:1600:39e1:fc73:9e8c:f6df])
        by cmr with ESMTPA
        id DFCpn71a2zwgpDFCpnVw8g; Fri, 28 Jan 2022 09:33:36
 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iijmio-mail.jp;
        s=x01; t=1643330016; i=henrich@iijmio-mail.jp;
        bh=HNeSzMVAUaNiiJoH7URdxUkclgFnyNQju8Hjdp8dI/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=oLdCnCYxY5g8ISzz1c5qq0fcmqqaBvboiHXlKJyRVBJD433Ahw9E4RZqAn7znMUMS
         OYjtl+0rvbuVt6IWUj9sKVKNn+tulHdaC2+Z3xkTSAK273gE/f1PVcy+hfr5PO5XVk
         tfKsqAzKaEzBT+9gT/CcVg2Fib4shb0RrPhBWagqjDmVuny0x1aGG4uVllhI1Xla2U
         UdUM8m+6sUjmBqfJREGcaaz0XnJxmbR1yOSAwDzCsOv8LphFUTGCuEEXUgfFuVpvfY
         u8bckRt2qSyspIvwafLwGbG8f9JhhwIrxe6iRwckl4Cb9PpuNyYgTWxj5r8uW+vkGd
         jEnG7k0Bfv9SA==
Date:   Fri, 28 Jan 2022 09:33:35 +0900
From:   Hideki Yamane <henrich@iijmio-mail.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] firmware: Add ZSTD-compressed file support
Message-Id: <20220128093335.e8d01f21c4b930c30f77e08a@iijmio-mail.jp>
In-Reply-To: <YfLnTm7L3m6jEB+4@kroah.com>
References: <20210127154939.13288-1-tiwai@suse.de>
        <YBGeXDTEy8myghot@kroah.com>
        <20220128032213.c93b56aa2ea1c77e34b28290@iijmio-mail.jp>
        <YfLnTm7L3m6jEB+4@kroah.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 19:41:18 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> What is "this"?  You are responding to a year-old email message :)

 Oh, yes, sorry.

 What's the status for adding "ZSTD-compressed file support" for loading
 firmware feature config FW_LOADER_COMPRESS in drivers/base/firmware_loader/Kconfig
 has still XZ_DEC only, where should I check to know its progress?


-- 
Hideki Yamane <henrich@iijmio-mail.jp>
