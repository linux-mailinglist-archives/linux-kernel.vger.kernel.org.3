Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79132481CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbhL3OOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhL3OO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:14:29 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:14:29 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 6AEA758723348; Thu, 30 Dec 2021 15:14:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 5B24D60C26F18;
        Thu, 30 Dec 2021 15:14:26 +0100 (CET)
Date:   Thu, 30 Dec 2021 15:14:26 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     tkjos@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: use "menuconfig" menu entry type for
 CONFIG_ANDROID
In-Reply-To: <Yc2wsGmEe7lefB9h@kroah.com>
Message-ID: <5po21q10-20p8-5593-2npn-7n5718qsnq73@vanv.qr>
References: <20211228200634.18968-1-jengelh@inai.de> <Yc2wsGmEe7lefB9h@kroah.com>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 2021-12-30 14:14, Greg KH wrote:
>On Tue, Dec 28, 2021 at 09:06:34PM +0100, Jan Engelhardt wrote:
>> Allow disabling the Android driver section from within the Device
>> Drivers submenu, without having to descend into the Android drivers
>> submenu first.
>> 
>> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
>> ---
>>  drivers/android/Kconfig | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>> 
>> diff --git drivers/android/Kconfig drivers/android/Kconfig
>> index 53b22e26266c..dc0a373ab879 100644
>> --- drivers/android/Kconfig
>> +++ drivers/android/Kconfig
>
>You made this patch at one level too deep, it should look like:
>
>--- a/drivers/android/Kconfig
>+++ b/drivers/android/Kconfig
>
>As-is, this will not apply.
>
>A normal git diff will output the correct patch file, as will 'git
>format-patch', how did you create this?

Uh, I once again ran afoul of my default "diff.noprefix=true" in 
~/.gitconfig. Unless there is a magical barrier, `git am -p0`
should momentarily work for you as I edit my ~/linux/.git/config to 
set diff.noprefix=false.

(which of course breaks part of my workflow just like xkcd.com/1172 
predicts, but alas... -- I've already conveyed to the git list it's 
suboptimal for me,
https://lore.kernel.org/all/xmqqr1auvs7m.fsf@gitster.g/ )
