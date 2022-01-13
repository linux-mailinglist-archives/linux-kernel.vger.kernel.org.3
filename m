Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F2B48D70D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiAMMCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:02:08 -0500
Received: from phobos.denx.de ([85.214.62.61]:43820 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232725AbiAMMCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:02:07 -0500
Received: from [192.168.1.107] (91-82-25-109.pool.digikabel.hu [91.82.25.109])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 765DA830EA;
        Thu, 13 Jan 2022 13:02:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1642075326;
        bh=arm8PkFrmPzmdiojhk3EnDHMB4znORMQ+KrfI1SH7ZY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HjflkBIoQ7W7/vWz2JFhH+2dWoYij9PMAV7nCDKActDz8fTPM0sC/C3IC0jPCYpwh
         KR91yBijjH6vJ3/xf2bl7DrSJvinkVEPjzAhTxUps+HdFyEV/MXt52oXyBnBXRs5KB
         WFnmGoEsE7VccQol0F5tTCU1fH/wRkSp47i7yq6nHaTpyOjJ7HcwXb3nN23Kk9FyWI
         5ZijkmyhiPTBt6y0kX3zUD8Ozqf7+aHacgYCyg8llsZSKJ8RDjbfwPN1XuKTgvyeUm
         1McmNh/W45Qv/qjCJVBkrFg6KQTYEU9mNaqSTKQQU7dnzW4gZiPjRy0qEInsvlLoqJ
         FK9zgcSrmPzvA==
Reply-To: hs@denx.de
Subject: Re: [PATCH] net: fastboot: make UDP port net: configurable
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Joe Hershberger <joe.hershberger@ni.com>,
        Ramon Fried <rfried.dev@gmail.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>,
        Michal Simek <michal.simek@xilinx.com>, u-boot@lists.denx.de
References: <20220113074016.15163-1-christian.gmeiner@gmail.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <c88a1dc4-afbd-bc52-1320-8f3d0e951121@denx.de>
Date:   Thu, 13 Jan 2022 13:02:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220113074016.15163-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian,

On 13.01.22 08:40, Christian Gmeiner wrote:
> The fastboot protocol uses per default the UDP port 5554. In some cases
> it might be needed to change the used port. The fastboot utility provides
> a way to specifiy an other port number to use already.
> 
>   fastboot -s udp:192.168.1.76:1234 boot fastboot.img
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/fastboot/Kconfig | 7 +++++++
>  net/fastboot.c           | 5 +----
>  2 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
