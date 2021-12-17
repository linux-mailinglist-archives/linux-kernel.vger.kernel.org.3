Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D04794DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbhLQTdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:33:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhLQTdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:33:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id BAF2B1F4733D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639769588; bh=KrnOUAIPOi7q0Qlr6MnB41M+auYvt6kDtqVNTxI/rvs=;
        h=Cc:Subject:To:References:From:Date:In-Reply-To:From;
        b=BTNP3d6HOs2i+XKHOJP8N/iA7MPFiiueRpd+/UBIb7l3KPRFStTBvIOe22/grns4j
         GfOViALk8rEGyuWdoAGCbuEMEhdF8xTt2B+PbwhjZWeOAt04EF84gJZ7YliF83g4Lq
         ZgRTxgXBGfTCj3FqKfDO7oQ8gMzydBYBqfnr0La3CsWBTA2BK3kNvoCPGoY3/fzmC5
         J9MplW9+iJe/Pdg7py/hdOlS1+1dkW93+IdOUhdhXxuoHOoFXHBknpcCoAJLhRrJzt
         NvUoYU+IMROTgotnTj6Yg+G9+zWJxHzLK9zeDl81BS1WGECkcCb6rGbyBuYY15e56D
         tGqcbyhJm9bKQ==
Cc:     usama.anjum@collabora.com, Kroah-Hartman <greg@kroah.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org,
        Norbert Manthey <nmanthey@amazon.de>
Subject: Re: Coverity Scan model file, license, public access
To:     Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Dave Jones <davej@codemonkey.org.uk>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
 <YOSKuEcPoy/dw0st@kroah.com> <a41221c8-86e5-494d-68fd-0a0b87c99e83@amazon.de>
 <202107151111.23BA48F99@keescook>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Message-ID: <1bce95f4-ddf8-2081-57c8-67cd9d4dd3d4@collabora.com>
Date:   Sat, 18 Dec 2021 00:32:59 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <202107151111.23BA48F99@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I know, the model was written originally by Dave Jones, with
> further changes from myself and, I think, Colin Ian King.
> 
> I thought it was visible through the Coverity dashboard, once you're
> logged in:
> https://scan.coverity.com/projects/linux-next-weekly-scan?tab=analysis_settings
> (See 'Modeling file loaded [View]')
> 
I've sent the request to join the dashboard. Who is the maintainer of
this free Coverity dashboard? Can anyone use these results to fix the
bugs without the permission of anyone?
