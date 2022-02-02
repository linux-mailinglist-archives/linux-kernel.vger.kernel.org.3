Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509854A76F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbiBBRkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:40:55 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:50189 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiBBRky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:40:54 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id FJcgnDQgMI46dFJcgnXDNE; Wed, 02 Feb 2022 18:40:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1643823652; bh=5qvPzN5AlRZmOFVpAhP0fgxJuLitO3mtkVyS5bHQlRg=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=FSpjRj370ENUVrXmFThK4YcfgShPKOB0BM/IvVGxt/kf7Pg99chMpfzoRkX+qgavI
         8l/eCgpbzU/lWb+4dePBo8dPsR2dvCcMcBT8pH2yLi5zAj+Y5PjaqWZ+e4NxnjQ8nA
         t6vo6lvb2fUu0R9dof5q48yY3hSBtq+PCoCOxM+dWStz0spEw49DEyj2XVWzCnEDul
         UV7KHpogNPtrk8cB3/JbN8F6qW7RDMukaRxAjL8kHIEZgYiNmv79+ElFHv5FyLkO9h
         sqpItvPNzInb+FjUWzXKyU7Nv6V6SzA+Btkdcmb5WhhPz6n+lnlAWFd74uLzELpDMH
         Cm8UNrMUdCw8w==
Subject: Re: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
To:     Robert Hancock <robert.hancock@calian.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rasm@fe.up.pt" <rasm@fe.up.pt>,
        "jamesnuss@nanometrics.ca" <jamesnuss@nanometrics.ca>
References: <20220112205214.2060954-1-robert.hancock@calian.com>
 <Yd9DDJ2HmptwIITA@smile.fi.intel.com>
 <d21aeae0-f75d-f8b9-032a-f4751696d467@enneenne.com>
 <f74e32552955b2293d814cfd14729ab190d8ddbe.camel@calian.com>
 <5178d655-a9f0-0a0e-866c-b85b7eda69f3@enneenne.com>
 <72a4b544d8ed7dc6ff809f21752dd56889185f65.camel@calian.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <7a68de3b-60db-c2b3-50a8-9ae0e93bd42f@enneenne.com>
Date:   Wed, 2 Feb 2022 18:40:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <72a4b544d8ed7dc6ff809f21752dd56889185f65.camel@calian.com>
Content-Type: multipart/mixed;
 boundary="------------5BEB4CACA972B36D4F12B57B"
Content-Language: en-US
X-CMAE-Envelope: MS4wfJw6/v0gFIkz4SRvTVz32D44LvGzr9H0GXtsydCvlnBQxOAfSTj/sFno/vljZJnn/7e+sKd+LfNURAhFEz1HlRPm09vqb30MRFdVONAwQbSnXfaas2UD
 P//OUpybDoewRp+Y/QamgcyqptMMnuskTG+TcHnQhE4Bo3n9Ym4FYZgunudsgkhrdRzdnI/Btq8Gi+hY0QS2NqRv3yakAmuinlTUqDskP1lLw12RbUzqCs7A
 GrM1CzVrv8eAELV4zBxdrBSRTEU9ntxIREc1qfpuXzRt8Ge5o6UoHEzslEg+rE/gx0kXWNiW11IFtAoJOLPHrfwijfWlq5Bd89D/+U238Q1hL/S/RyvtOfLu
 frhT6ohMZFnsvBa4yFPVQK7xfNMzaorhKbNjx/gmuTsvLENBZOClYNfXfUL3I4fOKEjPEtAR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5BEB4CACA972B36D4F12B57B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 02/02/22 18:04, Robert Hancock wrote:
> On Sun, 2022-01-30 at 10:35 +0100, Rodolfo Giometti wrote:
>> On 29/01/22 23:02, Robert Hancock wrote:
>>> On Thu, 2022-01-13 at 09:17 +0100, Rodolfo Giometti wrote:
>>>> On 12/01/22 22:07, Andy Shevchenko wrote:
>>>>> On Wed, Jan 12, 2022 at 02:52:14PM -0600, Robert Hancock wrote:
>>>>>> If the pps-gpio driver was probed prior to the GPIO device it uses,
>>>>>> the
>>>>>> devm_gpiod_get call returned an -EPROBE_DEFER error, but
>>>>>> pps_gpio_probe
>>>>>> replaced that error code with -EINVAL, causing the pps-gpio probe to
>>>>>> fail and not be retried later. Propagate the error return value so
>>>>>> that
>>>>>> deferred probe works properly.
>>>>>
>>>>> FWIW,
>>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>
>>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>>
>>> It's not entirely clear to me what tree PPS patches are supposed to go
>>> through.
>>> Seems like some recent ones have gone through char-misc? Not sure if
>>> someone
>>> has this in their queue?
>>
>> LinuxPPS has no its own tree. All related patches usually are sent to me to
>> be
>> acked and to Greg Kroah-Hartman for inclusion.
>>
>> Ciao,
>>
>> Rodolfo
>>
> 
> It looks like some MAINTAINERS links should maybe be updated for PPS - the
> referenced page at http://wiki.enneenne.com/index.php/LinuxPPS_support seems to
> be dead. There is http://linuxpps.org/doku.php which points to a new mailing
> list location as well,

Yeah. Attached is a patch to fix these.

> but that seems to have very little activity.

That's one of reasons why LunuxPPS doesn't have its own tree. :)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--------------5BEB4CACA972B36D4F12B57B
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-MAINTAINERS-update-LinuxPPS-s-resources.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-MAINTAINERS-update-LinuxPPS-s-resources.patch"

From ab95f9b0dcbd538eb43e09eb358c782404ddf024 Mon Sep 17 00:00:00 2001
From: Rodolfo Giometti <giometti@enneenne.com>
Date: Wed, 2 Feb 2022 18:37:20 +0100
Subject: [PATCH] MAINTAINERS: update LinuxPPS's resources

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..9176ba3093b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15490,9 +15490,9 @@ F:	drivers/net/ppp/ppp_*
 
 PPS SUPPORT
 M:	Rodolfo Giometti <giometti@enneenne.com>
-L:	linuxpps@ml.enneenne.com (subscribers-only)
+L:	discussions@linuxpps.org (subscribers-only)
 S:	Maintained
-W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
+W:	http://linuxpps.org/doku.php
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/devicetree/bindings/pps/pps-gpio.txt
 F:	Documentation/driver-api/pps.rst
-- 
2.25.1


--------------5BEB4CACA972B36D4F12B57B--
