Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989C747B197
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhLTQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:48:10 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:35648 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbhLTQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:48:09 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 8BD0920E8DFE
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3] USB: host: Check for null res pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <ok@artecdesign.ee>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211220134244.930727-1-jiasheng@iscas.ac.cn>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <2f38e1cc-b245-9bd7-f3d6-2fafc470c215@omp.ru>
Date:   Mon, 20 Dec 2021 19:48:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211220134244.930727-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 4:42 PM, Jiasheng Jiang wrote:

> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case that there is no suitable resource.

   s/error/NULL/ -- platform_get_resource() doesn't return error pointers...

> Fixes: 4808a1c02611 ("[PATCH] USB: Add isp116x-hcd USB host controller driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
[...]

MBR, Sergey
