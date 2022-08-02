Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53AF5880F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiHBRZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:25:57 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0A7DFB9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:25:55 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220802172551epoutp04bd77b4d8af5c7775eba7c861e394cf95~HlyAcC-Su0990809908epoutp04p
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:25:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220802172551epoutp04bd77b4d8af5c7775eba7c861e394cf95~HlyAcC-Su0990809908epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659461151;
        bh=YLb7pWndljbfx5ApVLL6I/h4x7wtbJs9ParLXoxeQWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XsKgsh/lz5gZzjKHOn4YO7xcSKp4III/pNe4RuofeIUXPOYFw4qlkcOIWMjapYbhY
         8TIpzDEq5TyoT9SSg4zz3EB0UHzQdQMaXUxci871ZY9yV3zwa4bxO+xHnKs91s4TAo
         FtT9qk6cdWU69TqJv6dXj6tpQSp5HjeIm+HyHpl0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220802172550epcas1p1c9c9f2bb798bd3106171b64f993f805d~Hlx-bDb2D1603416034epcas1p1Z;
        Tue,  2 Aug 2022 17:25:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.136]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Ly22P6Pdzz4x9Pt; Tue,  2 Aug
        2022 17:25:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.6A.09657.D1E59E26; Wed,  3 Aug 2022 02:25:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220802172549epcas1p16043bee1067cd7879e7bea9cbdc015b7~Hlx_SL7hX2086520865epcas1p1s;
        Tue,  2 Aug 2022 17:25:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220802172549epsmtrp2bb0aacf26be7be6e330dfacc117ce4e7~Hlx_P5nmx0656006560epsmtrp2M;
        Tue,  2 Aug 2022 17:25:49 +0000 (GMT)
X-AuditID: b6c32a35-733ff700000025b9-49-62e95e1d0825
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.EA.08905.D1E59E26; Wed,  3 Aug 2022 02:25:49 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220802172549epsmtip269e9ed4734eac6f9913bf4427278086f~Hlx_FeMgC0605906059epsmtip2T;
        Tue,  2 Aug 2022 17:25:49 +0000 (GMT)
Date:   Wed, 3 Aug 2022 02:25:49 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: New subsystem for acceleration devices
Message-Id: <20220803022549.cc12d4b82fb05974214f8b23@samsung.com>
In-Reply-To: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmvq5s3Mskg6UrDCz+TjrGbtG8eD2b
        xeVdc9gsLry4zWpx5XmAA6vH71+TGD12zrrL7rF/7hp2j1urjT0+b5ILYI3KtslITUxJLVJI
        zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWq2kUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTAt0CtOzC0uzUvXy0stsTI0MDAyBSpMyM74uvEga8FNnopb
        064yNjD+4Oxi5OSQEDCRWPV6PlsXIxeHkMAORoktp46wgCSEBD4xSnx7bQuR+MYosarrMiNM
        x7pf25kgEnsZJT7dOsEE0dHBJLFxrQeIzSKgInF6/SewBjYBVYmZM9awg9giAuoS1/b1gK1j
        FjjKKLFuUyNYs7CAscTZnb+BEhwcvAKOEh27weo5BQIl/m44wg6x2ELibs8KVogSQYm/O4RB
        wswC8hLb385hBhkpIfCRXWLh/d1MEPUuEqt3XIWyhSVeHd8CNUdK4vO7vWwQdrbElI5FLBB2
        gcS551uZQeZLAJ1zcUUKiMksoCmxfpc+RIWixM7fcxkh1vJJvPvawwpRzSvR0SYEUaIkseTP
        YahFEhJTZ3yDOsBDon3NX1ZIqC1hlHg/aRbjBEaFWQjPzELyzCyExQsYmVcxiqUWFOempxYb
        FhjCYzc5P3cTIzgZapnuYJz49oPeIUYmDsZDjBIczEoivHdcnicJ8aYkVlalFuXHF5XmpBYf
        YjQFxsxEZinR5HxgOs4riTc0sTQwMTMyNrEwNDNUEuddNe10opBAemJJanZqakFqEUwfEwen
        VAOTQ0u/1DcXH7GWrq1zLUWX/PnwOvL8zpjtH2zyZ5g8lZtzwsH3ZI7P7UdJhwoXc8b/WXBp
        9SSDFcKqDJfO81bMuS3eLLud90f8xk03drZ9XdVqG9bHURnOusDC7HnPiVAuvVdLldOiXXfc
        nvd5T/MNwV+Lw50/L/xtfi8356iM+q3mE3onJ/FMk91x+Mz2s28bJ01MV9o8/+6LB2KSUY9u
        bkislJrC/vlqwdy8wNkxJhqbz8goTVRJ/Dth8ccrr+b5LPhr72r/8O9+5evrneOXzZs4gd/i
        re/dnZFH5XZeOHySZ1Ps++PrVgRo+zcr/XlyzaxDVkyVM+XXg9WGm+aHfnA4tZhX6PW9GUbf
        p664sumjEktxRqKhFnNRcSIAhFcvdg8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvK5s3Mskg4m/pC3+TjrGbtG8eD2b
        xeVdc9gsLry4zWpx5XmAA6vH71+TGD12zrrL7rF/7hp2j1urjT0+b5ILYI3isklJzcksSy3S
        t0vgyvi68SBrwU2eilvTrjI2MP7g7GLk5JAQMJFY92s7UxcjF4eQwG5GiYW3bzFCJCQkNt1b
        ztzFyAFkC0scPlwMEhYSaGOS2Lg4D8RmEVCROL3+E1g5m4CqxMwZa9hBbBEBdYlr+3rYQGYy
        CxxllDj2+i8TSEJYwFji7M7fbCAzeQUcJTp2g9VzCgRK/N1whB3ihiWMEu8nzYK6wULibs8K
        Voh6QYm/O4RBwswCWhIPf91igbDlJba/ncM8gVFwFkLVLCRVs5BULWBkXsUomVpQnJueW2xY
        YJiXWq5XnJhbXJqXrpecn7uJERzoWpo7GLev+qB3iJGJg/EQowQHs5II7x2X50lCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MFnqfv7We6fR1eHc5qKP
        O93L7TY+9F71cFaNUPYS/8pH27XVj0h051tO3/Oqk/ur8lPD38f3rUoL/PnksH3tVMY9t2p/
        zf33dU/nRa7AqX+u6UmoyZqtfhW3elqAWN9j+x7X8yYb3pkub+/bOG3Pj2levzfkyD/8N+Hc
        s99i+zIWuvJNuxujkXDbSE9vreCRHQF8If+PrBWcd3+1ybqt32R3FrB+jM5U73YJ4oj5tl54
        blHJ45e2S/Wev1ecWuvyRGGb0ElFrQAnYaagddVHNCb53JvRotx7MipgitgFq4zy5Wcap7JW
        OOWd4u06MIlB1P/PyTWv5rDLC8/wXrq5Q+3O5me80y9YOBz4WWPeFPRfiaU4I9FQi7moOBEA
        UZdzqOMCAAA=
X-CMS-MailID: 20220802172549epcas1p16043bee1067cd7879e7bea9cbdc015b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220731114605epcas1p1afff6b948f542e2062b60d49a8023f6f
References: <CGME20220731114605epcas1p1afff6b948f542e2062b60d49a8023f6f@epcas1p1.samsung.com>
        <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 14:45:34 +0300
Oded Gabbay <oded.gabbay@gmail.com> wrote:

> Hi,
> Greg and I talked a couple of months ago about preparing a new accel
> subsystem for compute/acceleration devices that are not GPUs and I
> think your drivers that you are now trying to upstream fit it as well.
> 
> Would you be open/interested in migrating your drivers to this new subsystem ?
> 
> Because there were no outstanding candidates, I have done so far only
> a basic and partial implementation of the infrastructure for this
> subsystem, but if you are willing to join I believe I can finish it
> rather quickly.
> 
> At start, the new subsystem will provide only a common device
> character (e.g. /dev/acX) so everyone will do open/close/ioctl on the
> same device character. Also sysfs/debugfs entries will be under that
> device and maybe an IOCTL to retrieve information.
> 
> In the future I plan to move some of habanalabs driver's code into the
> subsystem itself, for common tasks such as memory management, dma
> memory allocation, etc.
> 
> Of course, you will be able to add your own IOCTLs as you see fit.
> There will be a range of IOCTLs which are device-specific (similar to
> drm).
> 
> wdyt ?
> 
> Thanks,
> Oded
> 

Hi, Oded.
Thanks for sharing your idea. And I'm really positive on the subsystem for ai acceleration devices.

Samsung NPU driver is trying to upstream now, so I wonder new subsystem can cover all of the operations.
I'll appreciate if you share the code when you ready, so I can figure out our driver can be migrated.

Sincerely,
Jiho Chu





