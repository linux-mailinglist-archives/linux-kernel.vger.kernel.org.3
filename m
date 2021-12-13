Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262614734AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbhLMTJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:09:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:35269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232609AbhLMTJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639422540;
        bh=xr2+8zEJrQ0Kv62kfx4Qp3etyzlONgujvySKJ7+ga/U=;
        h=X-UI-Sender-Class:Date:From:Subject:To;
        b=RpVxH7kwNJPmq9DSEc3a6035DEoTM5vB/Pnt9FdGkqB5HxlqvIDQnwRwSlAzczOgF
         nr+HxhK9ceYF5is9Ew7Tl/ftc1PUQ4alXjhHBh4z/Kg3Nmq6KZh5PQgL1GP+MvSliN
         U3wf03H9QQD5vXm6ByBc8KVd8L9dCZBkdjbk/O8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.100.20] ([46.142.33.167]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1mWPtM2Sxs-00zpwG for
 <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 20:09:00 +0100
Message-ID: <b9a7f523-e87e-c02f-cea8-db5b2d4d0ef1@gmx.de>
Date:   Mon, 13 Dec 2021 20:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Ronald Warsow <rwarsow@gmx.de>
Subject: RE: [PATCH 5.15 000/171] 5.15.8-rc1 review
To:     linux-kernel@vger.kernel.org
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:elDsbPY+anDf/DyrYMSLu/yYDMTUubQqdDY4Is4+mxLroQ3gKD9
 Jd68X7Cuaew5aHgOj+JWXgULScV7nVgTmk3JXerpbe+JRbHxDgEUAlTzZu8ge4XG00RWjL0
 tLvFEvose2QKg+mjiFLeU3epNunXlZPFRxpVX17g8S0LMM/TMCSUQNvcIvD447FA0STuDuA
 lUrxtm5ERPqQ7FSdi85kA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b51mlXftDEo=:fe7s9hUMmbV454rB2YtSLd
 rEvn9KffXCQOS1+FOq0xHqjKxx61ItbpPpY4mjCR4tLkMQ6iyIbq8fLvNKhW62JhSKr0J/amm
 /BvMMB6FeQj2wtBQgWK9HUUm/RAecstId/mjQM5wCBRvrOS631NWCsgFsPgGoe+T7VSULde+D
 bgKG4SKyUTv4umrYztNYqWBCPA0mHXo70PaM1nM+wEFgb+UBzLLz6EpFzLf15zgf2xYuAR0ZS
 T6kjftoAnOvJzHl5FDQxV9bG4XVfxjQIdueXrhSK3GVAUjhRZ+vQCdwXXqnBthOdO42awwGOn
 T99wnz+xmUo6M/3Qn+PO0kccSL612GM1FSEqyG59ZnbWM64Zf8/lk04/ODlweiwBWiKxpTBVg
 65eJyFof9r4Jjjr62GbZLa7OaUy9W0BgjUUAT86XfXsB2n5p9/odLHFbTolkQdTv2m4lni/RY
 OCuUBnSJAOju3wJTNO5tiUQl9o4o1i3pgaX6czRjIds9fKK3vgxeka/vpvpHtWtp8+vPDDHl7
 7fDJueOcvuwnTmfL7jiWUstToJJAUbx1EWCG1kO0AWO5HVjN/ZXc/Bxk1Eu32TW+Kc/OOUc9z
 gP0z6fZKAWv+5uT6QyZ+8v2jbcN+J8osbiLQg6kD39Te/+dM3zNCiglHPTv/0ehbmtDXAsRSb
 YJBT60R0Mz6pBb3+KKHxEkCw+CXHuffDb8XqKI93vS2J+9hqaqmE8UqQjZg3LKKVtCrzTsbbU
 SZmRMAQ1cpfxiQDEwHybZX0tcOpIgTDnCggH3ay0CLZ17qwcgTcze8Y1TslZM+yizPCR2zucn
 UcWuw/r/9VbnoUc9KFR9pDXlAMkn4EK4to2IQpQR+coxOVWHSx/iBvCGDwdAJrzplaGc3LVZj
 +db0p8qxOH9c6BkmG0sM0ryQKAlAc7BvrHLX8vGyYr5cUD2KxoKJMs7XqnFOzFFTA/aMnyE8y
 m/NlKTCVIKWCjRPfGVo2iVBOnivR+FMCDSRzRrZQYMv9MtABKIWJiu0l8oVg8siVbRXpRW5sH
 M7j5mT/aYdBckLzj3F84f0wabVvlI9/jVRy83mZyXlqI5bgbyBZr9z0FMHuQC86uygjsRHwqX
 EHEukZ+v5AcVUk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
5.15.8-rc1 successfully compiled, booted and suspended on an x86_64
(Intel i5-11400, Fedora 35)

Tested-by: Ronald Warsow <rwarsow@gmx.de>

thanks

Ronald

