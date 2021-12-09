Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4805F46E532
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhLIJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:13:51 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:34506 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhLIJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:13:49 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 846912243071
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <b77c0732-460f-cf30-c759-d51d37763894@omp.ru>
Date:   Thu, 9 Dec 2021 12:10:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/3] usb: mtu3: fix list_head check warning
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Yuwen Ng" <yuwen.ng@mediatek.com>
References: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
 <20211209031424.17842-3-chunfeng.yun@mediatek.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211209031424.17842-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 09.12.2021 6:14, Chunfeng Yun wrote:

> This is caused by uninitialization of list_head.

    No such word, suggesting to replace with "not initializing". :-)

> BUG: KASAN: use-after-free in __list_del_entry_valid+0x34/0xe4
> 
> Call trace:
> dump_backtrace+0x0/0x298
> show_stack+0x24/0x34
> dump_stack+0x130/0x1a8
> print_address_description+0x88/0x56c
> __kasan_report+0x1b8/0x2a0
> kasan_report+0x14/0x20
> __asan_load8+0x9c/0xa0
> __list_del_entry_valid+0x34/0xe4
> mtu3_req_complete+0x4c/0x300 [mtu3]
> mtu3_gadget_stop+0x168/0x448 [mtu3]
> usb_gadget_unregister_driver+0x204/0x3a0
> unregister_gadget_item+0x44/0xa4
> 
> Reported-by: Yuwen Ng <yuwen.ng@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergey
