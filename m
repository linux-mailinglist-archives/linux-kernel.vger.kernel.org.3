Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90446F1FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbhLIRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbhLIRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:36:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24EC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:33:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id CAA421F46C1F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639071193; bh=wuwsSBE8TALMjoFp0fnAvQOLgCfW8pvbDy/Y0BZpBu8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LoED0+xIzdTiOx+ePmMM9bgeM+H4/rY6Y9kHuGQoDGhUj/dFNr4gKRsnMkURvco0I
         V43Dzyjm9MxPd8V34ZinZRtyUMU6F0ANralSO4IfZYdT+psc60cWFRnTtIX1E8E/ep
         L5CF8JoAY3oPRvL5y2/Cn1GipKIbjDr4WQpi6O5B7G30azuE6tS19IN3zgIb0oRnAo
         LWhuN+HSsm38BqjC+BQ+sCLDFE4pEzy7c1GmjCSj8OSrp+lDkI3QYLkxmJyTftK+Lm
         rq6kb+vMARiTfZiBCGcUTkc6M12Ql2QQV7PlfTd3rt6jjc93AVd0LXNgGYPD0D6PPc
         HzGdP/NQCMejQ==
Message-ID: <620060df-c8df-6095-a1b9-cae3a598cabe@collabora.com>
Date:   Thu, 9 Dec 2021 14:33:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5] futex: Clarify comment at futex_wait_multiple_setup()
Content-Language: en-US
To:     6812skiii@gmail.com, tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
References: <20211209173141.877-1-6812skiii@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20211209173141.877-1-6812skiii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 14:31 de 09/12/21, 6812skiii@gmail.com escreveu:
> From: Jangwoong Kim <6812skiii@gmail.com>
> 
> Clarify that multiple futexes might have been woken.
> 
> Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>

Thanks!

Reviewed-by: André Almeida <andrealmeid@collabora.com>
